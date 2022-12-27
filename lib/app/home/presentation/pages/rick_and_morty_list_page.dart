import 'package:clean_arc_bloc/app/home/presentation/widgets/rick_and_morty_list_tile.dart';

import '../bloc/rick_and_morty_bloc_event.dart';
import '../bloc/rick_and_morty_bloc_state.dart';
import '../widgets/bottom_tile_loader.dart';
import '../../../../dependency_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/rick_and_morty_bloc.dart';

class RickAndMortyListPage extends StatefulWidget {
  @override
  State<RickAndMortyListPage> createState() => _RickAndMortyListPageState();
}

class _RickAndMortyListPageState extends State<RickAndMortyListPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RickAndMortyBLOC, RickAndMoryBlocState>(
      builder: ((context, state) {
        switch (state.status) {
          case RickAndMortyBlocStatus.initial:
          case RickAndMortyBlocStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RickAndMortyBlocStatus.success:
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                  'no records found',
                ),
              );
            }
            return ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.data.length
                  : state.data.length + 1,
              controller: _scrollController,
              itemBuilder: ((context, index) {
                if (index >= state.data.length) return const BottomLoader();
                return RickAndMortyListTile(
                  data: state.data[index],
                );
              }),
            );
          case RickAndMortyBlocStatus.failure:
            return const Center(
              child: Text("Something went wrong"),
            );
          default:
            return const Center(
              child: Text("Something went wrong"),
            );
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      serviceLocator<RickAndMortyBLOC>().add(
        RickAndMortyBlocEventNextDataEvent(),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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