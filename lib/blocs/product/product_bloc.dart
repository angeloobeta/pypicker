import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pypicker/model/product.dart';
import 'package:pypicker/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository? repository;

  ProductBloc({this.repository}) : super(ProductInitial()) {
    on<GetProductEvent>(_mapGetProductToState);
    on<GetFavouriteProductEvent>(_mapGetFavouriteProductEventToState);
  }

  FutureOr<void> _mapGetProductToState(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      List<Product> products = await repository!.getProducts();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapGetFavouriteProductEventToState(
      GetFavouriteProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      List<Product> products = await repository!.getFavouriteProduct();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
