import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_web_v2/pages/view_pager.dart';
import 'package:quran_web_v2/services/blocs/surahBloc.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer(
        builder: (context, watch, child) {
          final surahBloc = watch.watch(surahBlocProvider)
            ..suras()
            ..getRewayat()
            ..surahNames();
          return const ViewerPage();
        },
      ),
    );
  }
}
