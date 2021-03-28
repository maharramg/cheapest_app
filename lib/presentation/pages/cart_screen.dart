import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cheapest_app/infrastructure/blocs/order/order_bloc.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/models/order_product_model.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/infrastructure/services/hive_service.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/presentation/widgets/items/cart_item.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OrderBloc _bloc;
  double totalAmount = 0;

  @override
  void initState() {
    _bloc = BlocProvider.of<OrderBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Result> products = locator<HiveService>().cartBox.values.toList();

    return Scaffold(
      appBar: _builAppBar(),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderSuccess) {
              AwesomeDialog(
                  context: context,
                  animType: AnimType.LEFTSLIDE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.SUCCES,
                  title: 'Order Succes',
                  desc: 'Order status: ${state.orderStatus}',
                  btnOkOnPress: () {
                    debugPrint('OnClcik');
                  },
                  btnOkIcon: Icons.check_circle,
                  onDissmissCallback: () {
                    debugPrint('Dialog Dissmiss from callback');
                  })
                ..show();
            }
            if (state is OrderDisplayMessage) {
              Snack.display(context: context, message: state.message);
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (products.isEmpty)
                return _buildEmptyCart();
              else
                return _buildBody(products: products);
            },
          ),
        ),
      ),
    );
  }

  Widget _builAppBar() {
    return AppBar(
      title: Text("Cart"),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }

  Widget _buildBody({List<Result> products}) {
    List<OrderProductModel> food = List<OrderProductModel>();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.elementAt(index);
                totalAmount += product.count * product.price;
                food.add(OrderProductModel(
                  foodType: product.id,
                  foodName: product.name,
                  restaurantId: product.restaurant,
                  count: product.count,
                  amount: (product.count * product.price).floor(),
                ));
                return CartItem(
                  onRemove: () {
                    locator<HiveService>().cartBox.deleteAt(index);
                    setState(() {
                      totalAmount -= product.count * product.price;
                    });
                  },
                  product: product,
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                color: primaryColor,
                title: "ORDER",
                onTap: () {
                  print(totalAmount);
                  _bloc.add(
                    SendOrder(
                      totalAmount: totalAmount,
                      food: food,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(child: Text("Cart is empty"));
  }
}
