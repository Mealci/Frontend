import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mealci/components/big_button_text_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ToiletMapPage extends StatefulWidget {
  const ToiletMapPage({super.key});

  @override
  State<ToiletMapPage> createState() => _ToiletMapPageState();
}

class _ToiletMapPageState extends State<ToiletMapPage> {
  late GoogleMapController _mapController;
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0.0, 0.0), // Default initial position
    zoom: 2.0, // Default zoom level
  );
  final List<Marker> _markers = [];
  late String apiKey;
  bool _isRequestingPermission = false;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _initializeLocation();
  }

  // Load the API key from .env
  void _loadApiKey() {
    apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      debugPrint(
          "API key not found. Please add GOOGLE_MAPS_API_KEY to your .env file.");
    }
  }

  Future<void> _initializeLocation() async {
    try {
      final position = await _getCurrentLocation();
      _setCameraPosition(position);
      _fetchNearbyToilets(position);
    } catch (e) {
      debugPrint("Error getting current location: $e");
    }
  }

  Future<void> _checkPermissions() async {
    if (_isRequestingPermission) return; // Prevent multiple permission requests
    _isRequestingPermission = true;

    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        final requestedPermission = await Geolocator.requestPermission();
        if (requestedPermission == LocationPermission.denied ||
            requestedPermission == LocationPermission.deniedForever) {
          throw Exception("Location permission denied");
        }
      }
    } finally {
      _isRequestingPermission = false;
    }
  }

  Future<Position> _getCurrentLocation() async {
    await _checkPermissions();
    return Geolocator.getCurrentPosition();
  }

  Future<void> _fetchNearbyToilets(Position position) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=toilet&location=${position.latitude},${position.longitude}&radius=1500&type=toilet&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];
        _addMarkers(results);
      } else {
        debugPrint('Failed to load toilets: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint("Error fetching nearby toilets: $e");
    }
  }

  void _addMarkers(List<dynamic> toilets) {
    if (!mounted) return;

    if (toilets.isEmpty) return;

    // Trouver le toilette le plus proche
    toilets.sort((a, b) {
      final latA = a['geometry']['location']['lat'];
      final lngA = a['geometry']['location']['lng'];
      final latB = b['geometry']['location']['lat'];
      final lngB = b['geometry']['location']['lng'];
      final distanceA = Geolocator.distanceBetween(
        _initialPosition.target.latitude,
        _initialPosition.target.longitude,
        latA,
        lngA,
      );
      final distanceB = Geolocator.distanceBetween(
        _initialPosition.target.latitude,
        _initialPosition.target.longitude,
        latB,
        lngB,
      );
      return distanceA.compareTo(distanceB);
    });

    final closestToilet = toilets.first;

    setState(() {
      for (var toilet in toilets) {
        final lat = toilet['geometry']['location']['lat'];
        final lng = toilet['geometry']['location']['lng'];
        final name = toilet['name'];
        final vicinity = toilet['vicinity'];

        final isClosest = toilet == closestToilet;

        _markers.add(
          Marker(
            markerId: MarkerId(name),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: name,
              snippet: vicinity,
            ),
            icon: isClosest
                ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
                : BitmapDescriptor.defaultMarker,
            onTap: () => _showToiletDetails(toilet),
          ),
        );
      }
    });
  }


  Future<void> openGoogleMapsApp(double lat, double lng) async {
    final Uri googleMapsUri = Uri.parse('google.navigation:q=$lat,$lng&mode=d');

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      // Si Google Maps n'est pas installé, fallback sur le navigateur
      final Uri webUri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }



  void _setCameraPosition(Position position) {
    if (!mounted) return;

    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
    });

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(_initialPosition),
    );
  }

  void _showToiletDetails(Map<String, dynamic> toilet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    toilet['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('📍 Adresse:', toilet['vicinity']),
                const SizedBox(height: 10),
                _buildDetailRow('⭐ Note:', toilet['rating']?.toString() ?? 'Pas disponible'),
                const SizedBox(height: 10),
                _buildDetailRow(
                    '⏰ Ouvert maintenant:',
                    toilet['opening_hours']?['open_now'] == true ? 'Oui' : 'Non'),
                const SizedBox(height: 20),
                BigTextAndIconButton(
                  label: 'Itinéraire',
                  map: {
                    'Itinéraire': 'Itinéraire',
                  },
                  icon: Icons.navigation,
                  onPressed: () {
                    final lat = toilet['geometry']['location']['lat'];
                    final lng = toilet['geometry']['location']['lng'];
                    openGoogleMapsApp(lat, lng);
                  },
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Fermer'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
