// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/models/disease.dart';
import 'package:get/get.dart';

var dio = d.Dio();

class DiseaseController extends GetxController {
  var disease = DiseaseModel().obs;
  var isLoading = false.obs;

  // Ensure flaskAPIURL is defined
  final String flaskAPIURL =
      'http://your.api.url'; // Replace with your actual API URL

  Future<void> getDisease(File image, BuildContext context) async {
    if (!image.existsSync()) {
      showSnackBar(context, 'Image file does not exist.');
      return;
    }

    try {
      isLoading.value = true;
      d.FormData formData = d.FormData.fromMap({
        'file':
            await d.MultipartFile.fromFile(image.path, filename: 'image.jpg'),
      });

      d.Response response =
          await dio.post('$flaskAPIURL/upload', data: formData);
      disease.value = DiseaseModel.fromJson(response.data);
    } catch (e) {
      print(e);
      showSnackBar(context,
          'Error: ${e.toString()}'); // Provide more context on the error
    } finally {
      isLoading.value = false;
    }
  }
}
