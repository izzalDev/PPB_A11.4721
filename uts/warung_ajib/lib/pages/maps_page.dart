import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;

  final LatLng _agentLocation = LatLng(-6.200000, 106.816666); // Ganti dengan koordinat lokasi agen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Agen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'UMKM Warung Ajib\nBandungrejo, Mranggen, Demak',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _agentLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('agent_location'),
                  position: _agentLocation,
                  infoWindow: InfoWindow(
                    title: 'Agen',
                    snippet: 'Lokasi Agen',
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
