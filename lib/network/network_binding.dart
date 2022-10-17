
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'network_controller.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
