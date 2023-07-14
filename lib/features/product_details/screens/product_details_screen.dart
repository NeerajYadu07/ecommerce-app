import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  bool isInWishList = false;
  double fiveStar = 0;
  double fourStar = 0;
  double threeStar = 0;
  double twoStar = 0;
  double oneStar = 0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.ratings![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
    checkWishlist(widget.product.id!);
    setRating();
  }

  setRating() {
    fiveStar = 0;
    fourStar = 0;
    threeStar = 0;
    twoStar = 0;
    oneStar = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      int rating = widget.product.ratings![i].rating.round();
      switch (rating) {
        case 5:
          fiveStar++;
          break;
        case 4:
          fourStar++;
          break;
        case 3:
          threeStar++;
          break;
        case 2:
          twoStar++;
          break;
        case 1:
          oneStar++;
          break;
      }
    }
    fiveStar = (fiveStar * 100) / widget.product.ratings!.length;
    fourStar = (fourStar * 100) / widget.product.ratings!.length;
    threeStar = (threeStar * 100) / widget.product.ratings!.length;
    twoStar = (twoStar * 100) / widget.product.ratings!.length;
    oneStar = (oneStar * 100) / widget.product.ratings!.length;
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
  }

  void checkWishlist(String id) {
    List<dynamic> wishList =
        Provider.of<UserProvider>(context, listen: false).user.wishList;
    for (int i = 0; i < wishList.length; i++) {
      if (id == wishList[i].id) {
        setState(() {
          isInWishList = true;
        });
        return;
      }
    }
  }

  // var oldscreen = Scaffold(
  //     appBar: PreferredSize(
  //       preferredSize: const Size.fromHeight(60),
  //       child: AppBar(
  //         flexibleSpace: Container(
  //           decoration: const BoxDecoration(
  //             gradient: GlobalVariables.appBarGradient,
  //           ),
  //         ),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 margin: const EdgeInsets.only(left: 15),
  //                 height: 42,
  //                 child: Material(
  //                   borderRadius: BorderRadius.circular(7),
  //                   elevation: 1,
  //                   child: TextFormField(
  //                     onFieldSubmitted: navigateToSearchScreen,
  //                     decoration: InputDecoration(
  //                       prefixIcon: InkWell(
  //                         onTap: () {},
  //                         child: const Padding(
  //                           padding: EdgeInsets.only(
  //                             left: 6,
  //                           ),
  //                           child: Icon(
  //                             Icons.search,
  //                             color: Colors.black,
  //                             size: 23,
  //                           ),
  //                         ),
  //                       ),
  //                       hintText: 'Search Amazon.in',
  //                       hintStyle: const TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 17,
  //                       ),
  //                       filled: true,
  //                       fillColor: Colors.white,
  //                       contentPadding: const EdgeInsets.only(top: 10),
  //                       border: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(7)),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(7)),
  //                         borderSide:
  //                             BorderSide(color: Colors.black38, width: 1),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               color: Colors.transparent,
  //               height: 42,
  //               margin: const EdgeInsets.only(left: 10, right: 10),
  //               child: const Icon(
  //                 Icons.mic,
  //                 color: Colors.black,
  //                 size: 25,
  //               ),
  //             ),
  //             Container(
  //               color: Colors.transparent,
  //               height: 42,
  //               margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
  //               child: GestureDetector(
  //                 onTap: () =>
  //                     Navigator.pushNamed(context, CartScreen.routeName),
  //                 child: badges.Badge(
  //                     badgeContent: Text(userCartLength.toString()),
  //                     badgeStyle:
  //                         const badges.BadgeStyle(badgeColor: Colors.white),
  //                     child: const Icon(
  //                       Icons.shopping_cart_outlined,
  //                       size: 25,
  //                     )),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(widget.product.id!),
  //                 Stars(rating: avgRating),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   widget.product.name,
  //                   style: const TextStyle(
  //                     fontSize: 15,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     if (!isInWishList) {
  //                       productDetailsServices.addToWishList(
  //                           context: context, product: widget.product);
  //                       isInWishList=!isInWishList;
  //                     } else {
  //                       productDetailsServices.removeFromWishList(
  //                           context: context, product: widget.product);
  //                           isInWishList=!isInWishList;
  //                     }
  //                     setState(() {

  //                     });
  //                   },
  //                   icon: isInWishList
  //                       ? const Icon(
  //                           Icons.favorite,
  //                           color: Colors.red,
  //                         )
  //                       : const Icon(
  //                           Icons.favorite_border_outlined,
  //                           color: Colors.red,
  //                         ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           CarouselSlider(
  //             items: widget.product.images.map((i) {
  //               return Builder(
  //                 builder: (BuildContext context) => Image.network(
  //                   i,
  //                   fit: BoxFit.contain,
  //                   height: 200,
  //                 ),
  //               );
  //             }).toList(),
  //             options: CarouselOptions(
  //               viewportFraction: 1,
  //               height: 300,
  //             ),
  //           ),
  //           Container(
  //             color: Colors.black12,
  //             height: 5,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: RichText(
  //               text: TextSpan(
  //                 text: 'Deal Price: ',
  //                 style: const TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold),
  //                 children: [
  //                   TextSpan(
  //                       text: '\$${widget.product.price}',
  //                       style: const TextStyle(
  //                           fontSize: 22,
  //                           color: Colors.red,
  //                           fontWeight: FontWeight.w500)),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(widget.product.description),
  //           ),
  //           Container(
  //             color: Colors.black12,
  //             height: 5,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: CustomButton(text: 'Buy Now', onTap: () {}),
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: CustomButton(
  //               text: 'Add to Cart',
  //               color: const Color.fromRGBO(254, 216, 19, 1),
  //               onTap: addToCart,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           Container(
  //             color: Colors.black12,
  //             height: 5,
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Text(
  //               'Rate the Product',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //     RatingBar.builder(
  //         initialRating: myRating,
  //         minRating: 1,
  //         direction: Axis.horizontal,
  //         allowHalfRating: true,
  //         itemCount: 5,
  //         itemPadding: const EdgeInsets.symmetric(horizontal: 4),
  //         itemBuilder: (context, _) => const Icon(
  //               Icons.star,
  //               color: GlobalVariables.secondaryColor,
  //             ),
  //         onRatingUpdate: (rating) {
  //           productDetailsServices.rateProduct(
  //               context: context,
  //               product: widget.product,
  //               rating: rating);
  //         })
  //   ],
  // ),
  //     ),
  //   );
  Widget reviewText(rating, {size = 15.0, fontSize = 18}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(rating.toString()),
        Icon(Icons.star, color: Colors.amber, size: size),
      ],
    );
  }

  Widget ratingProgress(value, color) {
    return Expanded(
      child: LinearPercentIndicator(
        lineHeight: 10.0,
        percent: value / 100,
        backgroundColor: Colors.grey.withOpacity(0.2),
        progressColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sliderImages = CarouselSlider(
      items: widget.product.images.map((i) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            i,
            fit: BoxFit.contain,
            height: 200,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 300,
      ),
    );

    var productInfo = Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.name,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 3,
              ),
              Stars(rating: avgRating)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: 'Deal Price: ',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    var descriptionTab = SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Text(widget.product.description),
                ],
              ),
            ]),
      ),
    );

    var reviewsTab = SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 60),
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 20, right: 16),
        child: Column(
          children: [
            avgRating !=0?Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1)),
                    child: reviewText(avgRating.toStringAsFixed(2),
                        size: 28.0, fontSize: 30.0),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            reviewText(5),
                            ratingProgress(fiveStar, Colors.green)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            reviewText(4),
                            ratingProgress(fourStar, Colors.green)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            reviewText(3),
                            ratingProgress(threeStar, Colors.amber)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            reviewText(2),
                            ratingProgress(twoStar, Colors.amber)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            reviewText(1),
                            ratingProgress(oneStar, Colors.red)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ):const Text('No Reviews for this product yet'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Your Ratings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailsServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                })
          ],
        ),
      ),
    );

    var bottomButtons = Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(3, 1))
      ], color: GlobalVariables.backgroundColor),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: addToCart,
              child: Container(
                color: Colors.yellow,
                alignment: Alignment.center,
                height: double.infinity,
                child: const Text('Add to Cart'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: double.infinity,
              child: const Text('Buy now'),
            ),
          )
        ],
      ),
    );
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 375,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.teal,
                    titleSpacing: 0,
                    actions: <Widget>[
                      Container(
                          width: 35,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.1)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (!isInWishList) {
                                  productDetailsServices.addToWishList(
                                      context: context,
                                      product: widget.product);
                                  isInWishList = !isInWishList;
                                } else {
                                  productDetailsServices.removeFromWishList(
                                      context: context,
                                      product: widget.product);
                                  isInWishList = !isInWishList;
                                }
                                setState(() {});
                              },
                              child: isInWishList
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                            ),
                          )),
                      Container(
                        width: 35,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.1)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, CartScreen.routeName),
                            child: userCartLength == 0
                                ? const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 20,
                                  )
                                : badges.Badge(
                                    badgeContent:
                                        Text(userCartLength.toString()),
                                    badgeStyle: const badges.BadgeStyle(
                                        badgeColor: Colors.red),
                                    child: const Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 20,
                                    )),
                          ),
                        ),
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: GlobalVariables.backgroundColor,
                        child: Column(
                          children: <Widget>[
                            sliderImages,
                            productInfo,
                          ],
                        ),
                      ),
                      collapseMode: CollapseMode.pin,
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      const TabBar(
                        labelColor: Colors.teal,
                        indicatorColor: Colors.teal,
                        unselectedLabelColor:
                            GlobalVariables.unselectedNavBarColor,
                        tabs: [
                          Tab(text: 'Description'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  descriptionTab,
                  // moreInfoTab,
                  reviewsTab,
                ],
              ),
            ),
          ),
          bottomButtons
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      color: GlobalVariables.backgroundColor,
      child: Container(child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
