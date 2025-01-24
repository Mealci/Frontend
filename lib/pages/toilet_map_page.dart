import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  // Get current location and set the camera position
  Future<void> _initializeLocation() async {
    try {
      final position = await _getCurrentLocation();
      _setCameraPosition(position);
    } catch (e) {
      debugPrint("Error getting current location: $e");
    }
  }

  Future<void> _checkPermissions() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      final requestedPermission = await Geolocator.requestPermission();

      if (requestedPermission == LocationPermission.denied ||
          requestedPermission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }
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

    setState(() {
      _markers.clear();
      for (var toilet in toilets) {
        final lat = toilet['geometry']['location']['lat'];
        final lng = toilet['geometry']['location']['lng'];
        final name = toilet['name'];
        final vicinity = toilet['vicinity'];

        _markers.add(
          Marker(
            markerId: MarkerId(name),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: name,
              snippet: vicinity,
            ),
            onTap: () => _showToiletDetails(toilet),
          ),
        );
      }
    });
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
        return AlertDialog(
          title: Text(
            toilet['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Address:', toilet['vicinity']),
              const SizedBox(height: 8),
              _buildDetailRow(
                  'Rating:', toilet['rating']?.toString() ?? 'Not available'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
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
          _initializeLocation().then((_) {
            _getCurrentLocation().then((position) {
              _fetchNearbyToilets(position);
            });
          });
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
