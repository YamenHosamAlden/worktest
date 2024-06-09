// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:worktest/Data/Models/product_model.dart';
import 'package:worktest/Screens/Products/Widgets/product_card_widget.dart';

class ProductsListWidget extends StatelessWidget {
  final List<ProductModel> productModelList;
  const ProductsListWidget({
    super.key,
    required this.productModelList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: productModelList.length,
      physics: const  NeverScrollableScrollPhysics(),

      shrinkWrap: true,
      itemBuilder: (context, index) => ProductCardWidget(
        productModel: productModelList[index],
      ),
    );
  }
}
