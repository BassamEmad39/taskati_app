import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/themes.dart';
import 'package:taskati/features/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');
  LocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalStorage.userBox.listenable(),
      builder: (context, value, child) {
        bool isDarkMode =
            LocalStorage.getData(LocalStorage.isDarkMode) ?? false;
        return MaterialApp(
          darkTheme: AppThemes.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemes.lightTheme,

          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
