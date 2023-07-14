import 'package:amazon_clone/features/account/screens/wishlist_screen.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onPressed: () {}),
            AccountButton(text: 'Turn Seller', onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Log Out',
                onPressed: () => AccountServices().logOut(context)),
            AccountButton(
              text: 'Your Wish list',
              onPressed: (() => Navigator.pushNamed(
                  context, WishlistedProductScreen.routeName)),
            )
          ],
        ),
      ],
    );
  }
}
