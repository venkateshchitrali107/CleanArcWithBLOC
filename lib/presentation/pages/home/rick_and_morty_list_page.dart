import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../dependency_container.dart';
import '../../bloc/rick_and_morty_bloc_state_manage.dart';
import '../../widgets/bottom_tile_loader.dart';
import '../../widgets/rick_and_morty_list_tile.dart';

// ignore: use_key_in_widget_constructors
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
    Future.delayed(
      const Duration(seconds: 2),
    ).then(
      (_) => serviceLocator<RickAndMortyBLOC>().add(
        RickAndMortyBlocEventInitialDataEvent(),
      ),
    );
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
                  Center(
                    child: Text(
                      'No records found',
                      style: Theme.of(context).textTheme.bodyText1,
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
                      Text(
                        'Something went wrong',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: OutlinedButton(
                            onPressed: (() {
                              serviceLocator<RickAndMortyBLOC>()
                                  .add(RickAndMortyBlocResetEvent());
                            }),
                            child: Text(
                              'Re-Try',
                              style: Theme.of(context).textTheme.bodyText1,
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
                      Text(
                        'Something went wrong',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: OutlinedButton(
                            onPressed: (() {
                              serviceLocator<RickAndMortyBLOC>()
                                  .add(RickAndMortyBlocResetEvent());
                            }),
                            child: Text(
                              'Re-Try',
                              style: Theme.of(context).textTheme.bodyText1,
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

  // ignore: non_constant_identifier_names
  SizedBox SearchBar(RickAndMoryBlocState state) {
    return SizedBox(
      height: 70,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          color: Colors.white,
        ),
        child: TextField(
          controller: filterController,
          cursorColor: Colors.grey,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.bottom,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.grey,
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
                        style: Theme.of(context).textTheme.bodyText1,
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
              child: Text(
                'Apply',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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
