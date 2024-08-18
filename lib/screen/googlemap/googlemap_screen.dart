// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({Key? key}) : super(key: key);

//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   String address = '';
//   final Completer<GoogleMapController> _controller = Completer();
//   List<Marker> _markers = <Marker>[];
//   static const CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(
//         33.6844, 73.0479), // Set initial camera position to a default location
//     zoom: 14,
//   );

//   BitmapDescriptor? _redMarkerIcon;

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomMarker();
//     _loadData();
//   }

//   // Load custom marker icon for hospitals
//   Future<void> _loadCustomMarker() async {
//     _redMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(48, 48)),
//       'assets/hospital.png', // Ensure this asset is included in your pubspec.yaml
//     );
//   }

//   // Get user's current location
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   // Fetch nearby hospitals from Google Places API
//   Future<void> _fetchNearbyHospitals(Position position) async {
//     final String apiKey =
//         'AIzaSyC9Vi8HJ2C_HxVUmd_V8gmTevYUxxn3he8'; // Replace with your API key
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
//         '?location=${position.latitude},${position.longitude}&radius=2000&type=pharmacy&key=$apiKey';

//     try {
//       final response = await http.get(Uri.parse(url));
//       print("url $url");

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['results'] != null) {
//           setState(() {
//             _markers.clear();
//             _markers.add(
//               Marker(
//                 markerId: const MarkerId('currentLocation'),
//                 position: LatLng(position.latitude, position.longitude),
//                 infoWindow: const InfoWindow(title: 'Current Location'),
//               ),
//             );
//             for (var result in data['results']) {
//               _markers.add(
//                 Marker(
//                   markerId: MarkerId(result['place_id']),
//                   position: LatLng(
//                     result['geometry']['location']['lat'],
//                     result['geometry']['location']['lng'],
//                   ),
//                   icon: _redMarkerIcon!, // Set the custom red marker icon
//                   infoWindow: InfoWindow(
//                     title: result['name'],
//                     snippet: result['vicinity'],
//                   ),
//                 ),
//               );
//             }
//           });
//         } else {
//           print('No results found');
//         }
//       } else {
//         print('Failed to load nearby hospitals: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching nearby hospitals: $e');
//     }
//   }

//   // Load data including current location and nearby hospitals
//   Future<void> _loadData() async {
//     try {
//       Position position = await _getCurrentLocation();
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       final placemark = placemarks.first;
//       address =
//           "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

//       final GoogleMapController controller = await _controller.future;
//       CameraPosition cameraPosition = CameraPosition(
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 14,
//       );
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//       await _fetchNearbyHospitals(position);

//       setState(() {});
//     } catch (e) {
//       setState(() {
//         address = 'Failed to get location';
//       });
//       print('Error in _loadData: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.purple,
//         title: const Text('Nearby Hospitals'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             GoogleMap(
//               initialCameraPosition: _initialCameraPosition,
//               mapType: MapType.normal,
//               myLocationButtonEnabled: true,
//               myLocationEnabled: true,
//               markers: Set<Marker>.of(_markers),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * .2,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         address = 'Loading...';
//                       });
//                       _loadData();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 20),
//                       child: Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.purple,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'Current Location',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(address),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
