import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_project/providers/location_provider.dart';
import 'package:provider/provider.dart';

class MapExample extends StatefulWidget {
  const MapExample({Key? key}) : super(key: key);

  @override
  State<MapExample> createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).getUserCordinates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationProvider>(
        builder: (context, value, child) {
          return value.position == null
              ? const Center(child: Text("Location Address not fetch"))
              : FlutterMap(
                  options: MapOptions(
                    center: LatLng(51.5, -0.09),
                    zoom: 17.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(51.5, -0.09),
                          builder: (ctx) => Container(
                            child: const Icon(Icons.abc_outlined),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
