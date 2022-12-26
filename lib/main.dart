import 'package:flutter/material.dart';

import 'app/home/presentation/pages/rick_and_morty_list_page.dart';
import 'dependency_container.dart' as dc;

void main() {
  dc.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const RickAndMortyListPage(),
    );
  }
}
