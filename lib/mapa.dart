import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-23.562436, -46.655005),
      zoom: 18
  );
  Set<Marker> _markers = {};

  _onMapCreated( GoogleMapController controller){
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng)async {
    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if(listaEnderecos != null && listaEnderecos.length > 0){
      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;

    Marker marcador = Marker(
      markerId: MarkerId("marcador"),
      position: latLng,
      infoWindow: InfoWindow(
        title: rua,
      )
    );
      setState(() {
        _markers.add(marcador);
      });
    }
  }

  _movimentaCamera() async{
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
          _posicaoCamera)
    );
  }

  _adicionarListaLocalizacao(){
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);
    geolocator.getPositionStream(locationOptions).listen(
    (Position position){
      setState(() {
        _posicaoCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude)
        );
        _movimentaCamera();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adicionarListaLocalizacao();
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
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
