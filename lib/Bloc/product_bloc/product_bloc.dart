import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:worktest/Data/Models/product_model.dart';
import 'package:worktest/Data/Repository/product_repository.dart';
import 'package:worktest/Services/Helper/api_result.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository = ProductRepository();

  List<ProductModel>? productModelList;
  ProductModel? productModel;
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsListEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.getAllProducts();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        List<dynamic> res = apiResult.response!.data;

        productModelList =
            res.map((product) => ProductModel.fromJson(product)).toList();

        // ProductModel.fromJson(apiResult.response!.data);

        emit(GetProductListSuccesfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<GetProductEvent>((event, emit) async {
      emit(GetProductLoadingState());

      ApiResult apiResult =
          await productRepository.getProduct(productId: event.productId);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productModel = ProductModel.fromJson(apiResult.response!.data);

        emit(GetProductSuccesfulState());
      } else {
        emit(GetProductErrorState(message: apiResult.error));
      }
    });
  }
}
