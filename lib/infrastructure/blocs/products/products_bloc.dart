import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/products_provider.dart';
import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/subjects.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial());

  final BehaviorSubject<String> _searchTextController = BehaviorSubject<String>.seeded("");
  final BehaviorSubject<String> _priceController = BehaviorSubject<String>.seeded("");

  String get searchText => _searchTextController.value;
  String get price => _priceController.value;

  udpdateSearchText(value) => _searchTextController.add(value);
  updatePrice(value) => _priceController.add(value);

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is FetchProducts) {
      yield* _mapProductsToState(event);
    }
  }

  Stream<ProductsState> _mapProductsToState(FetchProducts event) async* {
    try {
      yield ProductsLoading();
      final result = await ProductsProvider.fetchProducts(price: price, searchText: searchText);
      yield ProductsLoaded(
        products: result.results,
        startItem: event.startItem,
        endItem: event.endItem,
      );
    } catch (e) {
      yield ProductsDisplayMessage(message: "$e");
    }
  }
}
