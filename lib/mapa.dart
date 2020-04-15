import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

  _onMapCreated( GoogleMapController controller){
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng){
    Marker marcador = Marker(
      markerId: MarkerId("marcador"),
      position: latLng,
      infoWindow: InfoWindow(
        title: "Marcador"
      )
    );
    setState(() {
      _markers.add(marcador);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa")
      ),
      body: Container(
        child: GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 18
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}
