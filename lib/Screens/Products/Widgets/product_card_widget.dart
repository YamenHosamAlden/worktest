import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Core/Constants/app_colors.dart';
import 'package:worktest/Data/Models/product_model.dart';
import 'package:worktest/Screens/Products/product_details_screen.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductCardWidget({super.key, required this.productModel});

  String displayText({required String text, required int length}) {
    if (text.length > length) {
      return "${text.substring(0, length)}...";
    } else {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Card(
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
        child: InkWell(
          borderRadius: BorderRadius.circular(4.w),
          onTap: () {
            GeneralRoute.navigatorPushWithContext(
                context,
                ProductDetails(
                  productId: productModel.id!,
                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Shimmer.fromColors(
                          baseColor: AppColors.greyColor.withOpacity(0.5),
                          highlightColor: AppColors.greyLightColor,
                          child: Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 20.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                      fadeInDuration: const Duration(milliseconds: 4),
                      fadeOutDuration: const Duration(milliseconds: 4),
                      imageUrl: productModel.image!,
                      errorWidget: (context, url, error) => Container(
                        height: 20.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.greyLightColor,
                          borderRadius: BorderRadius.circular(4.w),
                          border:
                              Border.all(width: 1, color: AppColors.greyColor),
                        ),
                        child: Image(
                          image: const AssetImage(AppAssets.fallImage),
                          color: Theme.of(context).primaryColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 4.h,
                              width: 8.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(0.5)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: const AssetImage(
                                        AppAssets.heartOutIcon),
                                    color: AppColors.redColor,
                                    height: 2.h,
                                    width: 4.w,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 4.h,
                              width: 9.w,
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).iconTheme.color),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: const AssetImage(AppAssets.cartIcon),
                                    color: Theme.of(context).primaryColor,
                                    height: 2.h,
                                    width: 4.w,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              textData: displayText(
                                  text: productModel.title!, length: 10),
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          StarRating(
                            rating: productModel.rating!.rate!,
                            color: Theme.of(context).primaryColor,
                            size: 3.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          CustomText(
                            textData: productModel.rating!.rate.toString(),
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          CustomText(
                            textData: "(${productModel.rating!.count!})",
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              textData: displayText(
                                  text: productModel.description!, length: 20),
                                  textOverflow: TextOverflow.ellipsis,
                              textStyle: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              textAlign: TextAlign.start,
                              textData: "${productModel.price}\$",
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
