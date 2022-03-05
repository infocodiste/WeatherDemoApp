import 'package:get/get.dart';

import 'map_screen_logic.dart';

class MapScreenBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MapScreenLogic());
  }
}
