import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-23.562436, -46.655005), zoom: 18.0);

  void _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  void _displayBookmark(LatLng latLng) {
    Marker marker = Marker(
      markerId: MarkerId("marker-${latLng.latitude}-${latLng.longitude}"),
      position: latLng,
      infoWindow: InfoWindow(title: "Marker"),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  Future<void> _moveCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition),
    );
  }

  void _addLocationListener() {
    var geolocator =
        Geolocator.getPositionStream().listen((Position position) {
          setState(() {
            _cameraPosition = CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0
            );
            _moveCamera();
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _addLocationListener();
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
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          onLongPress: _displayBookmark,

        ),
      ),
    );
  }
}
