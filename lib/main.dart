import 'package:dema/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) {
  runApp(const DemaDashboard());
}

class DemaDashboard extends StatelessWidget {
  const DemaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 👇 اللغة الافتراضية عربية (السعودية)
      locale: const Locale('ar', 'SA'),

      // 👇 اللغات المدعومة
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],

      // 👇 باكدجات الترجمة الجاهزة لفلاتر
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 👈 بتخلي الاتجاه حسب اللغة (عربي = RTL، انجليزي = LTR)
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(body: HomeView()),
      ),
    );
  }
}
