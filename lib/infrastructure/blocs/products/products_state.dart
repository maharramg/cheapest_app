part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Result> products;
  final int startItem;
  final int endItem;

  ProductsLoaded({this.products, this.startItem, this.endItem});

  @override
  List<Object> get props => [products, startItem, endItem];
}

class ProductsDisplayMessage extends ProductsState {
  final String message;

  ProductsDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
