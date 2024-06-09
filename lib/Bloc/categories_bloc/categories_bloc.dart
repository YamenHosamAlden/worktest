import 'package:bloc/bloc.dart';
import 'package:worktest/Data/Repository/categories_repository.dart';
import 'package:worktest/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();

  List<String>? categories;

  CategoriesBloc() : super(CategoriesInitial()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(GetAllCategoriesLoadingState());

      ApiResult apiResult = await categoriesRepository.getAllCategories();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        categories = List<String>.from(apiResult.response!.data);

        emit(GetAllCategoriesSuccesfulState());
      } else {
        emit(GetAllCategoriesErrorState(message: apiResult.error));
      }
    });
  }
}
