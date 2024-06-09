import 'package:dio/dio.dart';
import 'package:worktest/Services/Helper/api_result.dart';
import 'package:worktest/Services/Helper/error_api_handler.dart';
import 'package:worktest/Services/Network/dio_api_service.dart';
import 'package:worktest/Services/Network/urls_api.dart';

class CategoriesRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getAllCategories() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.categoryApi,
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }


}
