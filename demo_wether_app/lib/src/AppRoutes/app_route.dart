import 'package:demo_wether_app/src/ui/home/home_binding.dart';
import 'package:demo_wether_app/src/ui/home/home_screen.dart';
import 'package:demo_wether_app/src/ui/map_screen/map_screen_binding.dart';
import 'package:demo_wether_app/src/ui/map_screen/map_screen_view.dart';
import 'package:get/get.dart';


class AppRoutes {

  static String homeScreen = '/home_Screen';
  static String mapScreen = '/map_Screen';


  static List<GetPage> pages = [
    GetPage(
      name: '/',
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: mapScreen,
      page: () => MapScreenPage(),
      binding: MapScreenBinding(),
    )
  ];
}
