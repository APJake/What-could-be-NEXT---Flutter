import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:what_could_be_next/box/animal_item_box.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/ui/route/app_routes.dart';
import 'package:what_could_be_next/utils/analytics_observer.dart';
import 'package:what_could_be_next/utils/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Adapter
  AnimalItemBox.registerAdapters();
  await Hive.openBox<AnimalItem>(AnimalItemBox.boxName);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Could be NEXT?',
      theme: GlobalThemData.lightThemeData,
      darkTheme: GlobalThemData.darkThemeData,
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.generateRoutes,
      navigatorObservers: [AnalyticsObserver()],
    );
  }
}
