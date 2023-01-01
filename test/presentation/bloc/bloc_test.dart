import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arc_bloc/core/network/network_info.dart';
import 'package:clean_arc_bloc/data/model/rick_and_morty_model.dart';
import 'package:clean_arc_bloc/domain/usecases/get_rick_and_morty_list.dart';
import 'package:clean_arc_bloc/presentation/bloc/rick_and_morty_bloc_state_manage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([
  GetRickAndMortyList,
  NetworkInfoImpl,
])
void main() {
  final list = MockGetRickAndMortyList();
  final net = MockNetworkInfoImpl();
  final modelData = RickAndMortyModel(
    id: "1",
    name: "Rick",
    status: "Alive",
    species: "Human",
  );

  blocTest<RickAndMortyBLOC, RickAndMoryBlocState>(
    'initial without data',
    setUp: () {
      when(
        list.call(
          any,
        ),
      ).thenAnswer(
        (realInvocation) async => Future.value(
          const Right(
            [],
          ),
        ),
      );
    },
    build: () => RickAndMortyBLOC(
      listUseCase: list,
      networkInfo: net,
    ),
    act: (bloc) => bloc.add(
      RickAndMortyBlocEventInitialDataEvent(),
    ),
    expect: () => <RickAndMoryBlocState>[
      const RickAndMoryBlocState(
        status: RickAndMortyBlocStatus.loading,
      ),
      const RickAndMoryBlocState(
        status: RickAndMortyBlocStatus.success,
        hasReachedMax: true,
      )
    ],
  );

  blocTest<RickAndMortyBLOC, RickAndMoryBlocState>(
    'initial with data',
    setUp: () {
      when(
        list.call(
          any,
        ),
      ).thenAnswer(
        (realInvocation) async => Future.value(
          Right(
            [modelData],
          ),
        ),
      );
    },
    build: () => RickAndMortyBLOC(
      listUseCase: list,
      networkInfo: net,
    ),
    act: (bloc) => bloc.add(
      RickAndMortyBlocEventInitialDataEvent(),
    ),
    expect: () => <RickAndMoryBlocState>[
      const RickAndMoryBlocState(
        status: RickAndMortyBlocStatus.loading,
      ),
      RickAndMoryBlocState(
          status: RickAndMortyBlocStatus.success,
          hasReachedMax: false,
          data: [modelData])
    ],
  );
}
