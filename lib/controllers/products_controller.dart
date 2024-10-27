// ignore_for_file: avoid_print

import 'package:dio/dio.dart' as d;
// ignore: unused_import
import 'package:frontend/config.dart';
import 'package:get/get.dart';
import 'package:frontend/models/productmodel.dart';

var dio = d.Dio();

class ProductController extends GetxController {
  final products = [].obs;
  final filteredProducts = [].obs;
  var isDataLoading = false.obs;

  get monngoAPIURL => null;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  void getAllProducts() async {
    try {
      isDataLoading.value = true;
      String apiUrl = '$monngoAPIURL/products';
      var response = await dio.get(apiUrl);
      print(response);
      products.value =
          response.data.map((e) => ProductModel.fromJson(e)).toList();
      filteredProducts.value = List.from(products);
      isDataLoading.value = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  void searchProducts(String query) {
    filteredProducts.value = products.where((product) {
      return product.title!.toLowerCase().contains(query.toLowerCase()) ||
          product.description!.toLowerCase().contains(query.toLowerCase()) ||
          product.brand!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    update();
  }

  void sortProducts(String sortOption) {
    switch (sortOption) {
      case 'Price':
        // ignore: invalid_use_of_protected_member
        filteredProducts.value
            .sort((a, b) => int.parse(a.price!).compareTo(int.parse(b.price!)));
        break;
      case 'Name':
        // ignore: invalid_use_of_protected_member
        filteredProducts.value.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      default:
        // ignore: invalid_use_of_protected_member
        filteredProducts.value.sort((a, b) => a.title!.compareTo(b.title!));
        break;
    }
    update();
  }
}
