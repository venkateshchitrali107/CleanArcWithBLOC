import 'dart:async';
import '../../../../core/network/network_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecases.dart';
import '../../../../dependency_container.dart';
import '../../domain/usecases/get_rick_and_morty_list.dart';
import 'rick_and_morty_bloc_event.dart';
import 'rick_and_morty_bloc_state.dart';

class RickAndMortyBLOC
    extends Bloc<RickAndMortyBlocEvent, RickAndMoryBlocState> {
  final GetRickAndMortyList listUseCase;
  final NetworkInfoImpl networkInfo;
  int currentPage = 1;
  bool isLoading = false;
  late StreamSubscription networkSub;

  RickAndMortyBLOC({
    required this.listUseCase,
    required this.networkInfo,
  }) : super(
          const RickAndMoryBlocState(),
        ) {
    on<RickAndMortyBlocEvent>((
      event,
      emit,
    ) async {
      if (kDebugMode) print(state.status.toString());
      if (isLoading) return;
      isLoading = true;
      if (event is RickAndMortyBlocEventNextDataEvent) {
        if (state.hasReachedMax) return;
        currentPage++;
        await getData(emit);
      } else if (event is RickAndMortyBlocEventInitialDataEvent) {
        emit(
          state.copyWith(
            status: RickAndMortyBlocStatus.loading,
          ),
        );
        currentPage = 1;
        await getData(emit);
      } else if (event is RickAndMortyBlocNetworkStatusUpdateEvent) {
        emit(
          state.copyWith(
            status: RickAndMortyBlocStatus.loading,
            data: [],
            hasReachedMax: false,
          ),
        );
        currentPage = 1;
        await getData(emit);
      } else if (event is RickAndMortyBlocFilterUpdateEvent) {
        isLoading = false;
        emit(
          state.copyWith(
            status: state.enableSearch
                ? RickAndMortyBlocStatus.disableSearch
                : RickAndMortyBlocStatus.enableSearch,
            enableSearch: !state.enableSearch,
            searchedKey: "",
          ),
        );
      }
    });
    networkSub = networkInfo.onNewDataStream.listen((updatedStatus) async {
      isLoading = false;
      serviceLocator<RickAndMortyBLOC>().add(
        RickAndMortyBlocNetworkStatusUpdateEvent(),
      );
    });
  }

  Future<void> getData(Emitter<RickAndMoryBlocState> emit) async {
    var receivedData = await listUseCase.call(
      Params(
        pageNumber: currentPage,
      ),
    );
    isLoading = false;
    receivedData.fold((l) {
      emit(
        state.copyWith(
          status: RickAndMortyBlocStatus.failure,
        ),
      );
    }, (r) {
      emit(
        state.copyWith(
          status: RickAndMortyBlocStatus.success,
          data: state.data + r,
          hasReachedMax: r.isEmpty,
        ),
      );
    });
  }
}
