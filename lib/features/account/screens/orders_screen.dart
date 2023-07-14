import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../order_details/screens/order_details_screen.dart';
import '../services/account_services.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = 'orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
            body: orders!.isEmpty
                ? const Center(child: Text('Place your first order'))
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.builder(
                            itemCount: orders!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              final orderData = orders![index];
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, OrderDetailsScreen.routeName,
                                    arguments: orders![index]),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 140,
                                      child: SingleProduct(
                                          image: orderData.products[0].images[0]),
                                    ),
                                    Positioned(
                                      bottom: 60,
                                      right: 20,
                                      child: badges.Badge(
                                        badgeContent: Text(
                                          '+${orderData.products.length - 1}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        badgeStyle: const badges.BadgeStyle(
                                            badgeColor: Colors.transparent),
                                        showBadge:
                                            (orderData.products.length - 1) == 0
                                                ? false
                                                : true,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
          );
  }
}
