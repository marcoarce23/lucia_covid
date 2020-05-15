import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPositionModule extends StatefulWidget {
  MapPositionModule({Key key}) : super(key: key);

  @override
  _MapPositionModuleState createState() => _MapPositionModuleState();
}

class _MapPositionModuleState extends State<MapPositionModule> {
   BitmapDescriptor customIcon;
  Set<Marker> markers;
  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/fd.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
       body: Stack(
         children: <Widget>[

            GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(-18.5115, -68.1239), zoom: 12.0),
            mapType: MapType.hybrid,
           // markers: Set.from(allMarkers),
                
          //  markers: Set.from(allMarkers),
            onMapCreated: onMapCreated,
          ),

          //  GoogleMap(
          //    onMapCreated: onMapCreated,
          //                 options: GoogleMapOptions(
          //                   cameraPosition: CameraPosition(
          //                     target: LatLng(21.1193733, -86.809402),
          //                     zoom: 15.0)
          //                 ),
          //               ),
          /*
                        Positioned(
                          top: 30.0,
                          right: 15.0,
                          left: 15.0,
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ingrese Direccion a Buscar',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: IconButton(
                                  icon: IconButton(
                                    icon: Icon(Icons.search),
                                   // onPressed: barraBusqueda,
                                    iconSize: 30.0,
                                  ), onPressed: () {},
                                ),                                
                              ),
                              onChanged: (val) {
                                setState(() {
                                 buscarDireccion = val; 
                                });
                              }
                            ),
                          ),
                        )*/
                      ],
                    ),
                 );
               }

/*
          //Funcion que creamos para busqueda por direccion
          barraBusqueda() {
            Geolocator().placemarkFromAddress(buscarDireccion).then((result) {
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target:
                      LatLng(result[0].position.latitude, result[0].position.longitude),
                  zoom: 10.0)));
            });
          }
          */
             
               void onMapCreated(controller) {
                 setState(() {
               //   mapController = controller; 
                 });
  }
/*
   _crearMark() {
    allMarkers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        icon: BitmapDescriptor.defaultMarker,

        draggable: true,
        onTap: () {
          //  print('Es mica saaa: ${_location.latitude} -- ${_location.longitude}');
          Text('Es pararaaa');
        },
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition:
            CameraPosition(target: LatLng(36.98, -121.99), zoom: 18),
      ),
    );
  }*/
}