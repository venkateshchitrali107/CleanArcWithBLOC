import 'package:clean_arc_bloc/app/home/domain/entity/rick_and_morty.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_rick_and_morty_list.dart';
import 'rick_and_morty_bloc_event.dart';
import 'rick_and_morty_bloc_state.dart';
import '../../../../core/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RickAndMortyBLOC
    extends Bloc<RickAndMortyBlocEvent, RickAndMoryBlocState> {
  final GetRickAndMortyList listUseCase;
  int currentPage = 1;
  bool isLoading = false;
  RickAndMortyBLOC(
    this.listUseCase,
  ) : super(
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
      }
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
