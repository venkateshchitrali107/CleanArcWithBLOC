import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_info.dart';
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
    on<RickAndMortyBlocEvent>(
      (
        event,
        emit,
      ) async {
        if (kDebugMode) print(state.status.toString());
        if (isLoading) return;
        isLoading = true;
        if (event is RickAndMortyBlocEventNextDataEvent) {
          if (state.hasReachedMax) return;
          currentPage++;
          await getData(
            emit,
            Params(
              pageNumber: currentPage,
            ),
          );
        } else if (event is RickAndMortyBlocEventInitialDataEvent) {
          emit(
            state.copyWith(
              status: RickAndMortyBlocStatus.loading,
            ),
          );
          currentPage = 1;
          await getData(
            emit,
            Params(
              pageNumber: currentPage,
            ),
          );
        } else if (event is RickAndMortyBlocNetworkStatusUpdateEvent) {
          emit(
            const RickAndMoryBlocState(),
          );
          currentPage = 1;
          await getData(
            emit,
            Params(
              pageNumber: currentPage,
            ),
          );
        } else if (event is RickAndMortyBlocFilterUpdateEvent) {
          isLoading = false;
          if (state.enableSearch) {
            emit(
              state.copyWith(
                status: RickAndMortyBlocStatus.disableSearch,
              ),
            );
            emit(
              const RickAndMoryBlocState(),
            );
            currentPage = 1;
            await getData(
              emit,
              Params(
                pageNumber: currentPage,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: RickAndMortyBlocStatus.enableSearch,
                enableSearch: true,
                searchedKey: "",
              ),
            );
          }
        } else if (event is RickAndMortyBlocGetFilterDataEvent) {
          emit(
            state.copyWith(
              status: RickAndMortyBlocStatus.loading,
              data: [],
              hasReachedMax: true,
            ),
          );
          currentPage = 1;
          await getData(
            emit,
            Params(
              pageNumber: 0,
              searchKey: event.searchKey,
              filterType: event.type,
            ),
          );
        } else if (event is RickAndMortyBlocResetEvent) {
          emit(
            const RickAndMoryBlocState(),
          );
          currentPage = 1;
          await getData(
            emit,
            Params(
              pageNumber: currentPage,
            ),
          );
        }
      },
    );
    networkSub = networkInfo.onNewDataStream.listen(
      (updatedStatus) async {
        isLoading = false;
        serviceLocator<RickAndMortyBLOC>().add(
          RickAndMortyBlocNetworkStatusUpdateEvent(),
        );
      },
    );
  }

  Future<void> getData(
    Emitter<RickAndMoryBlocState> emit,
    Params params,
  ) async {
    var receivedData = await listUseCase.call(params);
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
          hasReachedMax: params.pageNumber == 0 ? true : r.isEmpty,
        ),
      );
    });
  }
}
