import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../dependency_container.dart';
import '../../../presentation/bloc/rick_and_morty_bloc_state_manage.dart';
import 'home_view.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Rick And Morty"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt,
            ),
            onPressed: () {
              serviceLocator<RickAndMortyBLOC>().isLoading = false;
              serviceLocator<RickAndMortyBLOC>()
                  .add(RickAndMortyBlocFilterUpdateEvent());
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<RickAndMortyBLOC>(),
        child: RickAndMortyListPage(),
      ),
    );
  }
}
