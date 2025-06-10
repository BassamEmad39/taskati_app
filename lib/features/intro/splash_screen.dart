import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/home_screen.dart';
import 'package:taskati/features/intro/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String? isFirstTime = LocalStorage.getData(LocalStorage.name);
    ;
    Future.delayed(Duration(seconds: 3), () {
      context.pushReplacementTo(
        isFirstTime == null ? UploadScreen() : HomeScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logo, width: 200, height: 200),
            Text('Taskati', style: TextStyles.getBodyTextStyle(context, fontSize: 30, fontWeight: FontWeight.bold)),
            Gap(15),
            Text(
              'It\'s time to get organized',
              style: TextStyles.getSmallTextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
