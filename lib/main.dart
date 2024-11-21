import 'package:candy/src/pages/commons/binding_builder.dart';
import 'package:candy/src/pages/commons/routers.dart';
import 'package:candy/src/pages/commons/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '캔디',
      theme: mainTheme(),
      initialRoute: '/login',
      initialBinding: BindingBuilder(),
      getPages: Routes.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ko')],
      locale: const Locale('ko'),
    );
  }
}
