import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/screens/orders_screen.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../order_details/screens/order_details_screen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  orders!.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, OrdersScreen.routeName),
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    debugPrint(orders![index].products[0].images[0]);
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, OrderDetailsScreen.routeName,
                          arguments: orders![index]),
                      child: Stack(
                        children: [
                          SingleProduct(
                              image: orders![index].products[0].images[0]),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: badges.Badge(
                              badgeContent: Text(
                                '+${orders![index].products.length - 1}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Colors.transparent),
                              showBadge:
                                  (orders![index].products.length - 1) == 0
                                      ? false
                                      : true,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
  }
}
