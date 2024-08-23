import 'package:apibloc/service/apiservice.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/Products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsLoadedEvent, ProductsState> {
  ProductsBloc() : super(ProductLoading()) {
    on<ProductsLoadedEvent>((event, emit) async {
      emit(ProductLoading());
      Apiservice apiservice=Apiservice();
      try
      {
        var plist=await apiservice.fetchdata();
        emit(ProductLoaded(plist!));
      }catch(e)
      {
        emit(ProductLoadingError("$e"));
      }
    });
  }
}
