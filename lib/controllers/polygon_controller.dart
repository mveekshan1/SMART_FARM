// ignore_for_file: unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:frontend/models/polygon.dart';
import 'package:frontend/models/polystats.dart';
import 'package:frontend/models/soilmoisture.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonController extends GetxController {
  var polygonData = PolygonModel().obs;
  var soilMoisture = SoilMoistureModel().obs;
  var isLoading = false.obs;
  var uvIndex = 0.0.obs;
  var polygonImage = ''.obs;
  var ndvi = PolyStatsModel().obs;
  var evi = PolyStatsModel().obs;
  var evi2 = PolyStatsModel().obs;
  var nri = PolyStatsModel().obs;
  var dswi = PolyStatsModel().obs;
  var ndwi = PolyStatsModel().obs;

  get agroMonitoringAPIKey => null;

  // Create a new polygon with the given coordinates
  Future<void> createPolygon(List<LatLng> coordinates) async {
    try {
      final response = await Dio().post(
        'http://api.agromonitoring.com/agro/1.0/polygons?appid=$agroMonitoringAPIKey',
        data: {
          "name": "Polygon 1",
          "geo_json": {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                coordinates.map((e) => [e.longitude, e.latitude]).toList()
              ],
            }
          }
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        polygonData.value = PolygonModel.fromMap(response.data);
        print("Polygon created with ID: ${polygonData.value.id}");
      } else {
        print("Error creating polygon: ${response.data}");
      }
    } catch (e) {
      print("Exception in createPolygon: $e");
    }
  }

  // Fetch the image for the given polygon ID
  Future<void> getImage(String polygonId) async {
    try {
      final response = await Dio().get(
          'http://api.agromonitoring.com/agro/1.0/image/search?start=1614556800&end=1705800584&polyid=$polygonId&appid=$agroMonitoringAPIKey');

      if (response.data.isNotEmpty) {
        polygonImage.value = response.data[0]['image'];
      } else {
        print("No images found for polygon ID: $polygonId");
      }
    } catch (e) {
      print("Exception in getImage: $e");
    }
  }

  // Fetch various data for the given polygon ID
  Future<void> getData(String polygonId) async {
    print("Fetching data for Polygon ID: $polygonId");
    await Future.wait([
      getSoilMoisture(polygonId),
      getUVIndex(polygonId),
      getSatelliteImagery(polygonId),
      getImage(polygonId),
    ]);
  }

  // Fetch soil moisture data for the given polygon ID
  Future<void> getSoilMoisture(String polygonId) async {
    try {
      final response = await Dio().get(
          'http://api.agromonitoring.com/agro/1.0/soil?polyid=$polygonId&appid=$agroMonitoringAPIKey');
      soilMoisture.value = SoilMoistureModel.fromJson(response.data);
    } catch (e) {
      print("Exception in getSoilMoisture: $e");
    }
  }

  // Fetch UV index for the given polygon ID
  Future<void> getUVIndex(String polygonId) async {
    try {
      final response = await Dio().get(
          'http://api.agromonitoring.com/agro/1.0/uvi?polyid=$polygonId&appid=$agroMonitoringAPIKey');
      uvIndex.value = response.data['uvi'];
    } catch (e) {
      print("Exception in getUVIndex: $e");
    }
  }

  // Fetch satellite imagery data for the given polygon ID
  Future<void> getSatelliteImagery(String polygonId) async {
    final DateTime now = DateTime.now();
    final DateTime start = now.subtract(const Duration(days: 16));
    final int startTimestamp = start.millisecondsSinceEpoch ~/ 1000;
    final int endTimestamp = now.millisecondsSinceEpoch ~/ 1000;
  }
}
