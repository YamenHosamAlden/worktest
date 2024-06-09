import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worktest/Bloc/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktest/Screens/Home/Widgets/products_list_widget.dart';
import 'package:worktest/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:worktest/Widgets/error_message_widget.dart';
import 'package:worktest/Widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late ProductBloc productBloc;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //  backgroundColor:   Theme.of(context).colorScheme.background,

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is GetProductListErrorState) {
            return ErrorMessageWidget(
              message: state.message,
              onPressed: () {
                productBloc.add(GetProductsListEvent());
              },
            );
          }
          if (state is GetProductListLoadingState || state is ProductInitial) {
            return const LoadingWidget();
          }
          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () {
              productBloc.add(GetProductsListEvent());
              refreshController.refreshCompleted();
            },
            header: const CustomSmartRefrecherHeaderWidget(),
            child: ProductsListWidget(
              productModelList: productBloc.productModelList!,
            ),
          );
        },
      ),
    );
  }
}
