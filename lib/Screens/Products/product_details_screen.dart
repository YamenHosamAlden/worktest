// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/product_bloc/product_bloc.dart';
import 'package:worktest/Core/Constants/app_colors.dart';
import 'package:worktest/Util/GeneralRoute.dart';

import 'package:worktest/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Widgets/app_bar_widget.dart';
import 'package:worktest/Widgets/error_message_widget.dart';
import 'package:worktest/Widgets/loading_widget.dart';
import 'package:worktest/Widgets/view_images_widget.dart';

class ProductDetails extends StatelessWidget {
  final int productId;
  ProductDetails({
    super.key,
    required this.productId,
  });

  final ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          productBloc..add(GetProductEvent(productId: productId)),
      child: Scaffold(
        appBar: appBarWidget(context, title: "Details".tr(context)),
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: [
              CustomText(
                textData: "Add to cart".tr(context),
                textStyle: TextStyle(
                    color: Theme.of(context).textTheme.headlineLarge!.color!,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 2.w,
              ),
              Image(
                image: const AssetImage(AppAssets.cartIcon),
                color: Theme.of(context).iconTheme.color,
                height: 4.h,
                width: 8.w,
              ),
            ],
          ),
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is GetProductErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    productBloc.add(GetProductEvent(productId: productId));
                  });
            }
            if (state is GetProductLoadingState || state is ProductInitial) {
              return const LoadingWidget();
            }
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      CachedNetworkImage(
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.greyColor.withOpacity(0.5),
                          highlightColor: AppColors.greyLightColor,
                          child: Container(
                            height: 30.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .border!
                                      .borderSide
                                      .color),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => InkWell(
                          onTap: () {
                            GeneralRoute.navigatorPushWithContext(
                              type: PageTransitionType.fade,
                              context,
                              ViewImagesWidget(
                                image: productBloc.productModel!.image!,
                              ),
                            );
                          },
                          child: Container(
                            height: 30.h,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .border!
                                        .borderSide
                                        .color),
                                borderRadius: BorderRadius.circular(4.w)),
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 4),
                        fadeOutDuration: const Duration(milliseconds: 4),
                        imageUrl: productBloc.productModel!.image!,
                        errorWidget: (context, url, error) => Container(
                          height: 30.h,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .border!
                                    .borderSide
                                    .color),
                          ),
                          child: Image(
                            image: const AssetImage(AppAssets.fallImage),
                            color: Theme.of(context).primaryColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.5.w,
                                  vertical: 0.5.h,
                                ),
                                child: CustomText(
                                  textData:
                                      "${productBloc.productModel!.price} \$",
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color),
                                ),
                              ),
                            ),
                            // RateWidget(numberOfStar: 0.7),
                            // SizedBox(
                            //   width: 1.w,
                            // ),
                            Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.5.w,
                                  vertical: 0.5.h,
                                ),
                                child: Row(
                                  children: [
                                    StarRating(
                                      rating: productBloc
                                          .productModel!.rating!.rate!,
                                      color: Theme.of(context).primaryColor,
                                      size: 4.w,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    CustomText(
                                      textData: productBloc
                                          .productModel!.rating!.rate
                                          .toString(),
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    CustomText(
                                      textData:
                                          "(${productBloc.productModel!.rating!.count})",
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                textData: productBloc.productModel!.title,
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            CustomText(
                              textData: "Category".tr(context),
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      // SelectColorWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            CustomText(
                              textData: productBloc.productModel!.category,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      // SelectSizeWidget()
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            CustomText(
                              textData: "Description".tr(context),
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Column(
                          children: [
                            CustomText(
                              textData: productBloc.productModel!.description!,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
