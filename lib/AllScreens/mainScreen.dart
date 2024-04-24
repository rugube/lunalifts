// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MainScreen extends StatefulWidget {
  MainScreen({super.key, required String title});
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  late GoogleMapController newGoogleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen "),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;


            },
            mapType: MapType.normal,
            myLocationButtonEnabled: true,),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 245.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),

                    )
                  ] ),
                  child: Column(
                    children: [
                      SizedBox(height: 6.0,),
                      Text("Hello there", style: TextStyle(fontSize: 12.0),),
                      Text("Where to?", style: TextStyle(fontSize: 12.0),),
                    ],),

              ),
            ),
        ],
      ),
    );
  }
}
