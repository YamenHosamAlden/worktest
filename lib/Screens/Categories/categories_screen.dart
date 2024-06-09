import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktest/Bloc/categories_bloc/categories_bloc.dart';
import 'package:worktest/Screens/Categories/Widgets/card_category.dart';

import 'package:flutter/material.dart';
import 'package:worktest/Widgets/error_message_widget.dart';
import 'package:worktest/Widgets/loading_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesBloc categoriesBloc;

  @override
  void initState() {
    super.initState();
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    categoriesBloc.add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is GetAllCategoriesErrorState) {
              return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  categoriesBloc.add(GetAllCategoriesEvent());
                },
              );
            }
            if (state is GetAllCategoriesLoadingState ||
                state is CategoriesInitial) {
              return const LoadingWidget();
            }
            return Center(
              child: ListView.builder(
                itemCount: categoriesBloc.categories!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CardCategoryWidget(
                      category: categoriesBloc.categories![index]);
                },

                // shrinkWrap: true,
              ),
            );
          },
        ));
  }
}
