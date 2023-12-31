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
        List<Location> locations = await locationFromAddress(locationName);
        LatLng coordinates = LatLng(locations.first.latitude, locations.first.longitude);

        
        mapController!.addSymbol(SymbolOptions(
          geometry: coordinates,
          iconImage: 'assets/images/logo.png', 
          textField: locationName, 
        ));
      } catch (e) {
        print('Error geocoding location: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: MapboxMap(
        accessToken: 'pk.eyJ1IjoibWFhZHl5eXl5eXl5eSIsImEiOiJjbHB4N2U0d24wam5xMm1wdG9vNnFtOXB4In0.k9l3Tay6JnfNzum4bXdj2w',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), 
          zoom: 10.0,
        ),
      ),
    );
  }
}
