part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductsEvent {
  final int startItem;
  final int endItem;

  FetchProducts({
    this.startItem,
    this.endItem,
  });

  @override
  List<Object> get props => [startItem, endItem];
}
