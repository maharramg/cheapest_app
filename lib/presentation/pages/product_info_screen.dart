import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/infrastructure/services/hive_service.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';

class ProductInfoScreen extends StatefulWidget {
  final Result product;

  ProductInfoScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  HiveService get _hiveService => locator<HiveService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Builder(builder: (context) => _buildBody(context: context)),
    );
  }

  Widget _buildBody({BuildContext context}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: "${widget.product.img}",
              fadeInCurve: Curves.easeInBack,
              placeholder: (BuildContext context, String url) {
                return Center(child: CircularProgressIndicator());
              },
              errorWidget: (BuildContext context, String url, error) {
                return Icon(Icons.error);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.product.name}',
              textAlign: TextAlign.center,
              style: bodyText1Bold.copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
          widget.product.price != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Price: ${widget.product.price} AZN',
                    style: bodyText2.copyWith(color: Colors.grey[600], fontSize: 15),
                  ),
                )
              : SizedBox.shrink(),
          widget.product.portion != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Portion: ${widget.product.portion}',
                    style: bodyText2.copyWith(color: Colors.grey[600], fontSize: 15),
                  ),
                )
              : SizedBox.shrink(),
          widget.product.description.length > 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Description: ${widget.product.description}',
                    style: bodyText2.copyWith(color: Colors.grey[600], fontSize: 15),
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton(
              color: primaryColor,
              title: "Add to cart",
              onTap: () async {
                Snack.display(context: context, message: "Added to cart");
                await _hiveService.persistProduct(widget.product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        "${widget.product.name}",
        style: appBarTitle,
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
