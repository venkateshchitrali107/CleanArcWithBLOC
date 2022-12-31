import 'package:clean_arc_bloc/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([NetworkInfoImpl])
void main() {
  late MockNetworkInfoImpl SUT;
  setUp(() {
    SUT = MockNetworkInfoImpl();
  });

  test(
    "Checking the initial data setup",
    () {
      when(
        SUT.isConnected,
      ).thenAnswer(
        (_) => ConnectivityResult.none,
      );
      expect(
        SUT.isConnected,
        ConnectivityResult.none,
      );
    },
  );
}
