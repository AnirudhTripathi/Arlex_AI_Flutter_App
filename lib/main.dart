import 'package:arlex_getx/firebase_options.dart';
import 'package:arlex_getx/services/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
import 'helper/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase initialized successfully");
    } else {
      print("Firebase was already initialized");
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Consider how you want to handle this error. You might want to show a user-friendly message or exit the app.
  }


  await dep.init();
  final apiService = Get.find<ApiService>();
  await apiService.onInit();
  Gemini.init(
      apiKey: Get.find<ApiService>().apiModel[0].geminiApi,
      safetySettings: [
        SafetySetting(
            category: SafetyCategory.dangerous,
            threshold: SafetyThreshold.blockNone),
        SafetySetting(
            category: SafetyCategory.hateSpeech,
            threshold: SafetyThreshold.blockNone),
        SafetySetting(
            category: SafetyCategory.sexuallyExplicit,
            threshold: SafetyThreshold.blockNone),
        SafetySetting(
            category: SafetyCategory.harassment,
            threshold: SafetyThreshold.blockNone)
      ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 873),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Alrex',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
            fontFamily: 'Quicksand',
            useMaterial3: true,
          ),
          initialRoute: RouteHelper.getSplashScreen(),
          getPages: RouteHelper.routes,
        );
      },
    );
  }
}
