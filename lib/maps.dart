import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  void _displayBookmark(LatLng latLng){
    Marker marker = Marker(
      markerId: MarkerId("marker-${latLng.latitude}-${latLng.longitude}"),
      position: latLng,
      infoWindow: InfoWindow(
        title: "Marker"
      ),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: Container(
        child: GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 18.0
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _displayBookmark,
        ),
      ),
    );
  }
}
