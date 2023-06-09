import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
    VoidCallback? onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response resp = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            debugPrint(resp.body);
            User user =
                userProvider.user.copyWith(cart: jsonDecode(resp.body)['cart']);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-wishlist'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void addToWishList({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> wishLists=[];
    try {
      http.Response resp = await http.post(
        Uri.parse('$uri/api/add-to-wishlist'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(resp.body)['wishList'].length; i++) {
              wishLists.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(resp.body)['wishList'][i],
                  ),
                ),
              );
            }
            User user =
                userProvider.user.copyWith(wishList: wishLists);
            userProvider.setUserFromModel(user);

          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void removeFromWishList({
    required BuildContext context,
    required Product product,
    VoidCallback? onSuccess,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> wishLists=[];
    try {
      http.Response resp = await http.delete(
        Uri.parse('$uri/api/remove-from-wishlist/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );


      if (context.mounted) {
        httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            onSuccess!();
            for (int i = 0; i < jsonDecode(resp.body)['wishList'].length; i++) {
              wishLists.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(resp.body)['wishList'][i],
                  ),
                ),
              );
            }
            User user =
                userProvider.user.copyWith(wishList: wishLists);
            userProvider.setUserFromModel(user);

          
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response resp = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(response: resp, context: context, onSuccess: () {});
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
