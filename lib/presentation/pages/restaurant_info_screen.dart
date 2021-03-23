import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheapest_app/infrastructure/models/restaurant_model.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';

class RestaurantInfoScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  RestaurantInfoScreen({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantInfoScreenState createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
              imageUrl: "${widget.restaurant.logo}",
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${widget.restaurant.name}',
              style: bodyText1Bold.copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${widget.restaurant.foodType}',
              style: bodyText2.copyWith(color: Colors.grey[600], fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        "${widget.restaurant.name}",
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
