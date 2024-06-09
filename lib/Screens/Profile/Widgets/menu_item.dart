import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:worktest/Widgets/custom_text.dart';

class MenuItemm extends StatefulWidget {
  final String title;
  final String image;

 final void Function()? onPressed;

  const MenuItemm({
    super.key,
    required this.title,
     this.onPressed,
    required this.image,
  });

  @override
  State<MenuItemm> createState() => _MenuItemmState();
}

class _MenuItemmState extends State<MenuItemm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        color:    Theme.of(context).colorScheme.secondary
                            ))),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image(
                            image:   AssetImage( widget.image),
                            color: Theme.of(context).primaryColor,
                         
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          CustomText(
                            textData: widget.title,

                            textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ],
                  )),
            ])),
      ),
    );
  }
}
