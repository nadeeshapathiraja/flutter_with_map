import 'package:flutter/material.dart';
import 'package:map_project/providers/location_provider.dart';
import 'package:provider/provider.dart';

class LocationExample extends StatefulWidget {
  const LocationExample({Key? key}) : super(key: key);

  @override
  State<LocationExample> createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Center(
                  child: ElevatedButton(
                    child: const Text("Get Current Location"),
                    onPressed: () async {
                      value.getUserCordinates();
                    },
                  ),
                ),
                if (value.position != null)
                  Text(
                      "Current Location Cordinates are :- \n ${value.position}"),
                const SizedBox(height: 20),
                if (value.placeMark.isNotEmpty)
                  Text(
                      "Current Location Cordinates are :- \n ${value.getAddress}"),
                Center(
                  child: ElevatedButton(
                    child: const Text("Get Current Distance"),
                    onPressed: () async {
                      value.getDistance();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    "Current Location Distance  are :- \n ${value.distanceInMeters}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
