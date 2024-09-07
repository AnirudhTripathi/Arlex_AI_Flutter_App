import 'package:arlex_getx/controller/auth_controller.dart';
import 'package:arlex_getx/controller/home_screen_controller.dart';
import 'package:arlex_getx/services/api_service.dart';
import 'package:arlex_getx/services/auth_service.dart';
import 'package:arlex_getx/services/home_screen_service.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.put<ApiService>(ApiService(), permanent: true);
  Get.put(HomeScreenController(homeScreenService: HomeScreenService()));
  Get.lazyPut(() => AuthService());
  Get.put<AuthController>(AuthController(authService: Get.find<AuthService>()));
}


// {
//   "project_info": {
//     "project_number": "835075196472",
//     "project_id": "alrex-8602f",
//     "storage_bucket": "alrex-8602f.appspot.com"
//   },
//   "client": [
//     {
//       "client_info": {
//         "mobilesdk_app_id": "1:835075196472:android:6305c5b4ef1ce7534d48cd",
//         "android_client_info": {
//           "package_name": "com.example.arlex_getx"
//         }
//       },
//       "oauth_client": [],
//       "api_key": [
//         {
//           "current_key": "AIzaSyDv4BzBsKEGNmBpyHs5YVk-iNmHS58xnV8"
//         }
//       ],
//       "services": {
//         "appinvite_service": {
//           "other_platform_oauth_client": []
//         }
//       }
//     }
//   ],
//   "configuration_version": "1"
// }

// current : https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyBddUCGLF0iYo3_F6U8uwiGqYUHKJu0xPQ