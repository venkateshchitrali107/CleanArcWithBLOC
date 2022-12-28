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
  TextEditingController filterController = TextEditingController();
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.enableSearch) SearchBar(state),
                const Spacer(),
                const Center(child: CircularProgressIndicator()),
                const Spacer(),
              ],
            );
          case RickAndMortyBlocStatus.success:
          case RickAndMortyBlocStatus.enableSearch:
          case RickAndMortyBlocStatus.disableSearch:
            if (state.data.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state.enableSearch) SearchBar(state),
                  const Spacer(),
                  const Center(
                    child: Text(
                      'No records found',
                    ),
                  ),
                  const Spacer(),
                ],
              );
            }
            if (!state.enableSearch) {
              selectedValue = "Name";
              filterController.clear();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.enableSearch) SearchBar(state),
                const Spacer(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Something went wrong',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: OutlinedButton(
                            onPressed: (() {
                              serviceLocator<RickAndMortyBLOC>()
                                  .add(RickAndMortyBlocResetEvent());
                            }),
                            child: const Text(
                              'Re-Try',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            );
          default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.enableSearch) SearchBar(state),
                const Spacer(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Something went wrong',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: OutlinedButton(
                            onPressed: (() {
                              serviceLocator<RickAndMortyBLOC>()
                                  .add(RickAndMortyBlocResetEvent());
                            }),
                            child: const Text(
                              'Re-Try',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
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
          controller: filterController,
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
                    'Species',
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
              onPressed: () {
                if (filterController.text.isNotEmpty) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  serviceLocator<RickAndMortyBLOC>().isLoading = false;
                  serviceLocator<RickAndMortyBLOC>().add(
                    RickAndMortyBlocGetFilterDataEvent(
                      searchKey: filterController.text,
                      type: selectedValue,
                    ),
                  );
                }
              },
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
