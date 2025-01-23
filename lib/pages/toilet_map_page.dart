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
  late CameraPosition _initialPosition;
  final List<Marker> _markers = [];
  late String apiKey; // La clé API sera chargée ici

  // Initialiser la position de la caméra
  @override
  void initState() {
    super.initState();
    _initialPosition = const CameraPosition(
      target: LatLng(0.0, 0.0), // Position initiale par défaut
      zoom: 2.0, // Zoom de la carte pour voir la vue mondiale
    );

    // Charger la clé API depuis le fichier .env
    apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ??
        ''; // Charger la clé à partir du fichier .env
    if (apiKey.isEmpty) {
      print(
          "La clé API n'a pas été trouvée. Veuillez vérifier votre fichier .env.");
    }
  }

  // Obtenir la position actuelle de l'utilisateur
  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Requête pour obtenir les toilettes proches
  Future<void> _fetchNearbyToilets(Position position) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=toilet&location=${position.latitude},${position.longitude}&radius=1500&type=toilet&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      _addMarkers(results);
    } else {
      throw Exception('Failed to load toilets');
    }
  }

  // Ajouter des marqueurs sur la carte à partir des données
  void _addMarkers(List<dynamic> toilets) {
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
            onTap: () => _showToiletDetails(
                toilet), // Afficher les détails lorsqu'on clique
          ),
        );
      }
    });
  }

  // Configurer la position de la caméra
  void _setCameraPosition(Position position) {
    _initialPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
  }

  // Afficher les détails de la toilette dans un dialogue ou une nouvelle page
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
            mainAxisSize: MainAxisSize
                .min, // Ensure the column takes only necessary space
            children: [
              _buildDetailRow('Address:', toilet['vicinity']),
              const SizedBox(height: 8), // Add spacing between rows
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

// Helper widget to display details in a row format
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
          _getCurrentLocation().then((position) {
            _setCameraPosition(position);
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialPosition),
            );
            // Appel pour obtenir les toilettes proches
            _fetchNearbyToilets(position);
          });
        },
      ),
    );
  }
}
