import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final Function onRemove;
  final Result product;

  const CartItem({Key key, this.onRemove, this.product}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Material(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    buildImage(),
                    SizedBox(width: 10.0),
                    buildInfo(context),
                    buildRemoveButton(context),
                    SizedBox(width: 10.0),
                  ],
                ),
                // buildIncreaseDecreaseButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRemoveButton(BuildContext context) {
    return GestureDetector(
      onTap: widget.onRemove,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(Icons.clear, color: Colors.white),
      ),
    );
  }

  Widget buildInfo(BuildContext context) {
    return Expanded(
      child: Container(
        height: 170.0,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.product.name}", textAlign: TextAlign.center, style: bodyText2),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.product.price} AZN", style: bodyText3Bold),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.product.count} x", style: bodyText3Bold),
                Text("TOTAL: ${((widget.product.count) * (widget.product.price))}", style: bodyText3Bold),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      width: 115.0,
      height: 150.0,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: widget.product?.img ?? '',
        fadeInCurve: Curves.easeInBack,
        placeholder: (_, __) => Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => Icon(Icons.error),
      ),
    );
  }
}
