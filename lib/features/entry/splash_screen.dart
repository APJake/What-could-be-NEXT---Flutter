import 'package:flutter/material.dart';
import 'package:what_could_be_next/ui/route/app_routes.dart';
import 'package:what_could_be_next/utils/context_extensions.dart';
import 'package:what_could_be_next/utils/nav_extensions.dart';
import 'package:what_could_be_next/utils/number_extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (!context.mounted) return;
      context.navigateReplace(AppRoute.home);
    });
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 120,
            //   height: 120,
            //   child: Image.asset(AppConstants.mainLogo),
            // ),
            Text("🧐", style: context.theme.textTheme.displayLarge),
            50.verticle(),
            Text(
              "What could be next?",
              style: context.theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
