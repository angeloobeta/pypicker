part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetFavouriteProductEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
