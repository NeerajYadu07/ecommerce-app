import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/loader.dart';
import '../../../models/order.dart';
import '../../order_details/screens/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                itemCount: orders!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final orderData = orders![index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, OrderDetailsScreen.routeName,
                        arguments: orderData),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SizedBox(
                        height: 140,
                        child: SingleProduct(
                            image: orderData.products[0].images[0]),
                      ),
                    ),
                  );
                }),
          );
  }
}
