import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  final List<dynamic> reservations;

  MapScreen({required this.reservations});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: MapboxMap(
        accessToken:
            'pk.eyJ1IjoibWFhZHl5eXl5eXl5eSIsImEiOiJjbHB4N2U0d24wam5xMm1wdG9vNnFtOXB4In0.k9l3Tay6JnfNzum4bXdj2w',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(40.7128, -74.0060),
          zoom: 10.0,
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;

    _addMarkers();
  }

  Future<void> _addMarkers() async {
    if (mapController == null || widget.reservations.isEmpty) {
      return;
    }

    for (var reservation in widget.reservations) {
      final locationName = reservation['location'] as String;

      try {
        LatLng coordinates = await geocodeLocation(locationName);

        print(
            'Adding marker at $coordinates for $locationName'); // Debug statement

        mapController!.addCircle(CircleOptions(
          geometry: coordinates,
          circleColor: '#FF0000', // Red color (replace with your desired color)
          circleRadius: 10.0, // Adjust the radius as needed
        ));
      } catch (e) {
        print('Error geocoding location: $e');
      }
    }

    // Add a default circle marker specifically for New York
    try {
      LatLng newYorkCoordinates =
          LatLng(40.7128, -74.0060); // New York coordinates
      mapController!.addCircle(CircleOptions(
        geometry: newYorkCoordinates,
        circleColor: '#00FF00', // Green color (replace with your desired color)
        circleRadius: 15.0, // Adjust the radius as needed
      ));
      print('Adding New York marker at $newYorkCoordinates'); // Debug statement
    } catch (e) {
      print('Error adding New York marker: $e');
    }
  }

  Future<LatLng> geocodeLocation(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      return LatLng(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      throw Exception('Error geocoding location: $e');
    }
  }
}
