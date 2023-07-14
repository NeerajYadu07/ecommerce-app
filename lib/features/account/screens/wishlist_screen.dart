
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_products_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class WishlistedProductScreen extends StatefulWidget {
  static const String routeName = 'wishlist-screen';
  const WishlistedProductScreen({super.key});

  @override
  State<WishlistedProductScreen> createState() =>
      _WishlistedProductScreenState();
}

class _WishlistedProductScreenState extends State<WishlistedProductScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await productDetailsServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    productDetailsServices.removeFromWishList(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
    products = Provider.of<UserProvider>(context, listen: false).user.wishList;
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/amazon_in.png',
                        width: 120,
                        height: 45,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(Icons.notifications_outlined),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: products!.isEmpty
                ? const Center(child: Text('Add products to your wishlist!'))
                : GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 140,
                            child: SingleProduct(image: productData.images[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData, index),
                                    icon: const Icon(Icons.delete_outline)),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
          );
  }
}
