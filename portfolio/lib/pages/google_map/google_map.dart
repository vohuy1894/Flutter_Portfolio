import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/search.dart';
import 'package:portfolio/widgets/menu_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;

  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/car.png');
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/json/day_mode_map_style.json');
    _mapController.setMapStyle(style);
    // if (_showMapStyle) {
    //   _mapController.setMapStyle(style);
    // } else {
    //   _mapController.setMapStyle(null);
    // }
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = [];
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78693, -122.41942));
    polygonLatLongs.add(LatLng(37.78923, -122.41542));
    polygonLatLongs.add(LatLng(37.78923, -122.42582));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = [];
    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController =  controller;
    _toggleMapStyle();
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(37.77483, -122.41942),
            infoWindow: InfoWindow(
              title: "San Francsico",
              snippet: "An Interesting city",
            ),
            icon: _markerIcon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MenuDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset(
                  "assets/icons/menu_icon.svg",
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.77483, -122.41942),
          zoom: 12,
        ),
        markers: _markers,
        polygons: _polygons,
        polylines: _polylines,
        circles: _circles,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
        
      ),
      
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: Icon(Icons.map),
      //   onPressed: () {
      //     setState(() {
      //       _showMapStyle = !_showMapStyle;
      //     });

      //     _toggleMapStyle();
      //   },
      // ),
    );
  }

  
}
