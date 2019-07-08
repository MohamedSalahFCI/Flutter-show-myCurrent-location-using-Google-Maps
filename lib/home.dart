import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/location.dart';

class ShowCurrentLocation extends StatefulWidget {
  @override
  _ShowCurrentLocationState createState() => _ShowCurrentLocationState();
}

class _ShowCurrentLocationState extends State<ShowCurrentLocation> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider =
      new StaticMapProvider("AIzaSyDIcMiC8ddzMXceRVPWlEB15Rher_YHSJs");
  Uri staticMapUri;
  List<Marker> markers = <Marker>[
    new Marker("1", "Momo Home", 30.56710, 32.26014, color: Colors.amber)
  ];

  showMap() {
    mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition:
          new CameraPosition(new Location(30.56710, 32.26014), 2.0),
      showUserLocation: true,
      title: "Recent Location",
    ));
    var sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
      mapView.zoomToFit(padding: 100);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //cameraPosition=new CameraPosition(Location(latitude, longitude), zoom)
    cameraPosition = new CameraPosition(new Location(30.56710, 32.26014), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(
        new Location(30.56710, 32.26014), 12,
        height: 400, width: 900, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Show Flutter Google maps"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: 300.0,
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: new Container(
                    child: new Text(
                      "Maps Shoud show Here",
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
                new InkWell(
                  child: new Center(
                    child: new Image.network(staticMapUri.toString()),
                  ),
                  onTap: () {
                    showMap();
                  },
                )
              ],
            ),
          ),
          new Container(
            padding: new EdgeInsets.only(top: 10.0),
            child: new Text(
              "tap to map to interAct",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(top: 25.0),
            child: new Text(
                "camera Position : \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
          )
        ],
      ),
    );
  }
}
