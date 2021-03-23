import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheapest_app/infrastructure/blocs/order/order_bloc.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoScreen extends StatefulWidget {
  final Result product;

  ProductInfoScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  final _bloc = OrderBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
              return _buildBody();
            },
          ),
        ),
      ),
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${widget.product.name}',
              style: bodyText1Bold.copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
          // widget.product.restaurant.length > 0
          //     ? Padding(
          //         padding: const EdgeInsets.only(bottom: 8.0),
          //         child: Text(
          //           'Restaurant: ${widget.product.restaurant}',
          //           style: bodyText2.copyWith(color: Colors.grey[600], fontSize: 15),
          //         ),
          //       )
          //     : SizedBox.shrink(),
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
              title: "Order",
              onTap: () => _bloc.add(
                SendOrder(
                  totalAmount: widget.product.price,
                  foodType: widget.product.id,
                  restaurantId: widget.product.restaurant,
                  count: 1,
                  amount: widget.product.price,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton(
              color: primaryColor,
              title: "Order",
              onTap: () {

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
