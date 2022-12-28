import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_container.dart';
import '../bloc/rick_and_morty_bloc.dart';
import '../bloc/rick_and_morty_bloc_event.dart';
import '../bloc/rick_and_morty_bloc_state.dart';
import '../widgets/bottom_tile_loader.dart';
import '../widgets/rick_and_morty_list_tile.dart';

class RickAndMortyListPage extends StatefulWidget {
  @override
  State<RickAndMortyListPage> createState() => _RickAndMortyListPageState();
}

class _RickAndMortyListPageState extends State<RickAndMortyListPage> {
  final _scrollController = ScrollController();
  String selectedValue = "Name";

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
          case RickAndMortyBlocStatus.enableSearch:
          case RickAndMortyBlocStatus.disableSearch:
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                  'No records found',
                ),
              );
            }
            if (state.status == RickAndMortyBlocStatus.disableSearch)
              selectedValue = "Name";

            return Column(
              children: [
                if (state.enableSearch) SearchBar(state),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.hasReachedMax
                        ? state.data.length
                        : state.data.length + 1,
                    controller: _scrollController,
                    itemBuilder: ((context, index) {
                      if (index >= state.data.length) {
                        return const BottomLoader();
                      }
                      return RickAndMortyListTile(
                        data: state.data[index],
                      );
                    }),
                  ),
                ),
              ],
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

  SizedBox SearchBar(RickAndMoryBlocState state) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 80,
                child: DropdownButton<String>(
                  underline: Container(),
                  value: selectedValue,
                  items: <String>[
                    'Name',
                    'Status',
                    'Speices',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        selectedValue = newValue ?? "Name";
                      },
                    );
                  },
                ),
              ),
            ),
            suffixIcon: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: const Text(
                'Apply',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    serviceLocator<RickAndMortyBLOC>().networkSub.cancel();
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
