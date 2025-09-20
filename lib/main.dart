// import 'package:dema/views/home_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// void main(List<String> args) {
//   runApp(const DemaDashboard());
// }

// class DemaDashboard extends StatelessWidget {
//   const DemaDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,

//       // 👇 اللغة الافتراضية عربية (السعودية)
//       locale: const Locale('ar', 'SA'),

//       // 👇 اللغات المدعومة
//       supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],

//       // 👇 باكدجات الترجمة الجاهزة لفلاتر
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],

//       // 👈 بتخلي الاتجاه حسب اللغة (عربي = RTL، انجليزي = LTR)
//       home: const Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(body: HomeView()),
//       ),
//     );
//   }
// }

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

      home: const ResponsiveWrapper(),
    );
  }
}

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // اعتبر ان:
    // أقل من 600 بكسل → موبايل
    // بين 600 و 1024 → تابلت
    // أكبر من 1024 → ديسكتوب
    if (width < 600) {
      return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Text(
              "غير مسموح بالعرض على الموبايل في هذه النسخة التجريبية",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (width < 1110) {
      return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Text(
              "غير مسموح بالعرض حالياً على التابلت في هذه النسخة التجريبية",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      // ديسكتوب
      return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(body: HomeView()),
      );
    }
  }
}
