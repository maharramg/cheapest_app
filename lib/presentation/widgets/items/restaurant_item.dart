import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheapest_app/infrastructure/models/restaurant_model.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final Function onTap;
  final RestaurantModel restaurant;

  const RestaurantItem({
    Key key,
    this.onTap,
    this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 35,
              child: _productImage(context),
            ),
            Expanded(
              flex: 12,
              child: _bottomPart(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage(context) {
    return Container(
      height: 175.0,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: "${restaurant.logo}",
        fadeInCurve: Curves.easeInBack,
        fit: BoxFit.contain,
        placeholder: (_, __) => Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => Icon(Icons.error),
      ),
    );
  }

  Widget _bottomPart(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${restaurant.name}",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: bodyText3Bold,
          ),
        ],
      ),
    );
  }
}
