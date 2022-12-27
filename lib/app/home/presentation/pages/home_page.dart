import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_container.dart';
import '../bloc/rick_and_morty_bloc.dart';
import '../bloc/rick_and_morty_bloc_event.dart';
import 'rick_and_morty_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Rick And Morty"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<RickAndMortyBLOC>()
          ..add(RickAndMortyBlocEventInitialDataEvent()),
        child: RickAndMortyListPage(),
      ),
    );
  }
}
