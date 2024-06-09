import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktest/Bloc/main_bloc/main_bloc.dart';
import 'package:worktest/Bloc/product_bloc/product_bloc.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Screens/Categories/categories_screen.dart';
import 'package:worktest/Screens/Home/Widgets/app_bar_home_screen.dart';
import 'package:worktest/Screens/Home/home_screen.dart';
import 'package:worktest/Screens/Profile/profile_screen.dart';
import 'package:worktest/Util/Dialogs/confirm_dialog.dart';
import 'package:worktest/Screens/Main/Widgets/bottom_navigationbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktest/Util/environment.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> screens;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {}
    if (state == AppLifecycleState.resumed) {}
  }

  late ProductBloc productBloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(GetProductsListEvent());

    screens = [
      const HomeScreen(),
      const CategoriesScreen(),
     
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        DateTime now = DateTime.now();
        if (didPop) {
          return;
        }
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          // Fluttertoast.showToast(msg: "Press again to leave app".tr(context));
        } else {
          showConfirmDialog(context,
              title: "Are you sure you want to leave app?".tr(context),
              onPressed: () {
            SystemNavigator.pop();
          });
        }
      },
      child: BlocListener<ConnectivityBloc, ConnectedState>(
        listener: (context, state) {
          if (state.message == "Connecting To Wifi") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Connecting To Mobile Data") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Lost Internet Connection") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
        },
        child: BlocBuilder<MainBloc, BottomNavigationBarState>(
          builder: (context, state) {
            return Scaffold(
                   appBar: appBarHomeScreenWidget(
        context,
        scaffoldKey: scaffoldKey,
        title: Environment.appName,
      ),

                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                key: scaffoldKey,
                body: BlocListener<ConnectivityBloc, ConnectedState>(
                    listener: (context, state) {},
                    child: screens[context.read<MainBloc>().currentIndex]),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).iconTheme.color,
                  unselectedItemColor:
                      Theme.of(context).textTheme.labelMedium!.color,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  currentIndex: context.read<MainBloc>().currentIndex,
                  useLegacyColorScheme: true,
                  onTap: (index) {
                    context
                        .read<MainBloc>()
                        .add(SelectBottomNavigationBarItem(index: index));
                  },
                  items: [
                    bottomNavigationBarItem(context,
                        currentIndex: context.read<MainBloc>().currentIndex,
                        index: 0,
                        imageIcon: AppAssets.homeIcon,
                        navBarName: "Shop".tr(context)),
                    bottomNavigationBarItem(context,
                        currentIndex: context.read<MainBloc>().currentIndex,
                        index: 1,
                        navBarName: "Categories".tr(context),
                        imageIcon: AppAssets.categoriesIcon),
                  
                    bottomNavigationBarItem(context,
                        currentIndex: context.read<MainBloc>().currentIndex,
                        index: 2,
                        imageIcon: AppAssets.profileIcon,
                        navBarName: "Profile".tr(context)),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
