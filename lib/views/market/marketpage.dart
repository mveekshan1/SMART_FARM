// ignore_for_file: unused_import, invalid_use_of_protected_member, unused_element, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:frontend/controllers/cart_controller.dart';
import 'package:frontend/controllers/products_controller.dart';
import 'package:frontend/models/productmodel.dart';
import 'package:frontend/pallete.dart';
import 'package:get/get.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:line_icons/line_icons.dart';

class ProductListing extends StatefulWidget {
  // ignore: use_super_parameters
  const ProductListing({Key? key}) : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  TextEditingController searchController = TextEditingController();
  String selectedSortOption = 'Default'; // Default is just a placeholder

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    var size = MediaQuery.of(context).size;
    final ProductController product = Get.put(ProductController());

    @override
    void initState() {
      product.getAllProducts();
      super.initState();
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Product Listing'),
          actions: [
            IconButton(
              onPressed: () {
                // Implement search functionality here
                // You may need to update your ProductController to handle search
              },
              icon: Stack(
                children: [
                  //add numer of items
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Obx(() => Text(
                          cartController.cartItems.length.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.shopping_cart_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: (product.isDataLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    FlutterCarousel.builder(
                      options: CarouselOptions(
                        // padEnds: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                      ),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                              child: Card(
                        child: Obx(
                          () => Container(
                            width: size.width * 0.9,
                            height: size.height * 0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(product
                                        .products
                                        .value[product.products.value.length -
                                            itemIndex -
                                            5]
                                        .imageURL ??
                                    ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ),
                    // Sorting dropdown button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: const Icon(Icons.sort)),
                          DropdownButton<String>(
                            hint: const Text('Sort by: '),
                            icon: const Icon(Icons.arrow_drop_down),
                            value: selectedSortOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSortOption = newValue!;
                              });
                              // Implement sorting here
                              // You may need to update your ProductController to handle sorting
                              product.sortProducts(selectedSortOption);
                            },
                            items: <String>[
                              'Default',
                              'Price: Low to High',
                              'Price: High to Low',
                              'Brand: A to Z',
                              'Brand: Z to A',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    // Product grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: product.products.value.length,
                        itemBuilder: (context, index) {
                          ProductModel productItem =
                              product.products.value[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                // ignore: deprecated_member_use
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: size.height * 0.2,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              productItem.imageURL ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.24,
                                              child: Text(
                                                productItem.title ?? '',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Text(
                                                    '₹ ${productItem.price?.substring(0, productItem.price!.length - 3)}')),
                                            Container(
                                                child: Text(
                                                    productItem.brand ?? '')),
                                          ],
                                        ),
                                        Obx(() => (cartController.cartItems
                                                .where((item) =>
                                                    item.title ==
                                                    productItem.title)
                                                .isNotEmpty)
                                            ? IconButton(
                                                onPressed: () {
                                                  cartController
                                                      .addOrRemovefromCart(
                                                          productItem);
                                                },
                                                icon: const Icon(
                                                  LineIcons.trash,
                                                  color: Color.fromARGB(
                                                      255, 219, 215, 215),
                                                ))
                                            : IconButton(
                                                onPressed: () {
                                                  cartController
                                                      .addOrRemovefromCart(
                                                          productItem);
                                                },
                                                icon: const Icon(
                                                    LineIcons.addToShoppingCart,
                                                    color: Pallete.greenColor)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
