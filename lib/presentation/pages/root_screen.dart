import 'package:cheapest_app/infrastructure/global_view_model.dart';
import 'package:cheapest_app/presentation/pages/account_screen.dart';
import 'package:cheapest_app/presentation/pages/products_screen.dart';
import 'package:cheapest_app/presentation/pages/restaurants_screen.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var _scaffoldKey;
  int _currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    RestaurantsScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _scaffoldKey = Provider.of<GlobalViewModel>(context, listen: false).generateScaffoldKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Restaurants",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: _currentIndex == 0
          ? Text(
              "Shop",
              style: appBarTitle,
            )
          : _currentIndex == 1
              ? Text(
                  "Restaurants",
                  style: appBarTitle,
                )
              : _currentIndex == 2
                  ? Text(
                      "Account",
                      style: appBarTitle,
                    )
                  : null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
    );
  }
}
