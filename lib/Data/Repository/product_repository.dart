import 'package:dio/dio.dart';
import 'package:worktest/Services/Helper/api_result.dart';
import 'package:worktest/Services/Helper/error_api_handler.dart';
import 'package:worktest/Services/Network/dio_api_service.dart';
import 'package:worktest/Services/Network/urls_api.dart';

class ProductRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getAllProducts() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.productsApi,
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }
   Future<ApiResult> getProduct({required int productId}) async {
    try {
      Response response = await dioApiService.getData(
        "${UrlsApi.productsApi}/$productId",
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }
}
