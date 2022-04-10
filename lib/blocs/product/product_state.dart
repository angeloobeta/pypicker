part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class FavouriteProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductSavedState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);
  @override
  List<Object?> get props => [];
}

class FavouriteProductLoadedState extends ProductState {
  final List<Product> products;

  const FavouriteProductLoadedState(this.products);
  @override
  List<Object?> get props => [];
}

class ProductErrorState extends ProductState {
  final String errorMessage;

  const ProductErrorState(this.errorMessage);
  @override
  List<Object?> get props => [];
}

class FavouriteProductErrorState extends ProductState {
  final String errorMessage;

  const FavouriteProductErrorState(this.errorMessage);
  @override
  List<Object?> get props => [];
}
