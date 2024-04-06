// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapCord extends StatefulWidget {
//   @override
//   _MapCordState createState() => _MapCordState();
// }

// class _MapCordState extends State<MapCord> {
//   GoogleMapController? _controller;
//   final LatLng _center =
//       const LatLng(40.7128, -74.0060); // New York coordinates

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//       ),
//     );
//   }
// }
