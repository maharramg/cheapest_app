import 'package:cheapest_app/infrastructure/blocs/products/products_bloc.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/presentation/pages/product_info_screen.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_text_field.dart';
import 'package:cheapest_app/presentation/widgets/items/products_item.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _bloc = ProductsBloc();
  final TextEditingController _searchTextController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int startItem = 0;
  int endItem = 100;

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchProducts(startItem: startItem, endItem: endItem));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _searchTextController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsDisplayMessage) {
              Snack.display(context: context, message: state.message);
            }
          },
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoaded) {
                return _buildBody(
                  products: state.products,
                  startItem: state.startItem,
                  endItem: state.endItem,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody({List<Result> products, int startItem, int endItem}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          _buildSearch(),
          GridView.count(
            padding: const EdgeInsets.all(10.0),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.66,
            children: products.getRange(startItem, endItem > products.length ? products.length : endItem).map((product) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.0,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ProductItem(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ProductInfoScreen(product: product)),
                  ),
                  product: product,
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (startItem != 0)
                  ? FlatButton(
                      color: primaryColor,
                      height: 50,
                      minWidth: 100,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        print("FROM: ${startItem - 100}");
                        print("TO: ${endItem - 100}");
                        if (startItem != 0 && endItem != 100)
                          _bloc.add(
                            FetchProducts(
                              startItem: startItem - 100,
                              endItem: endItem - 100,
                            ),
                          );
                      },
                    )
                  : SizedBox.shrink(),
              (products.length >= 100 && endItem <= products.length)
                  ? FlatButton(
                      color: primaryColor,
                      height: 50,
                      minWidth: 100,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        print("FROM: ${startItem + 100}");
                        print("TO: ${endItem + 100}");
                        _bloc.add(
                          FetchProducts(
                            startItem: startItem + 100,
                            endItem: endItem + 100,
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: FlatButton(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 10),
            Text("Search", style: TextStyle(color: Colors.white)),
          ],
        ),
        color: primaryColor,
        onPressed: () {
          return showModalBottomSheet(
            context: context,
            enableDrag: true,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            controller: _searchTextController,
                            fieldText: "Search text",
                            prefixIcon: Icons.search,
                            onChanged: (value) => _bloc.udpdateSearchText(value),
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: _priceController,
                            fieldText: "Price",
                            prefixIcon: Icons.money,
                            onChanged: (value) => _bloc.updatePrice(value),
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            color: primaryColor,
                            title: "Search",
                            onTap: () {
                              _bloc.add(FetchProducts(startItem: startItem, endItem: endItem));
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
