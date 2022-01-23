import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';
import 'package:weather_app/service_locator.dart';

import '../../mocks/cubits/commons/mock_commons.dart';
import '../../mocks/repositories/mock_repository.dart';
import '../../mocks/repositories/mock_repository.mocks.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  group('loadWeatherDetails', () {
    test('loadWeatherDetails success will change state to WeatherDetailsLoaded', () async {
      final _openWeatherRestClient = mockOpenWeatherRestClient(response: buildWeatherDetailsResponseFromTemplate());

      final _cubit = _getCubit(openWeatherRestClient: _openWeatherRestClient);
      await _cubit.loadWeatherDetails(lat: 12.0, lng: 23.0);

      expect(_cubit.state, isA<WeatherDetailsLoaded>());

      verify(_openWeatherRestClient.getWeatherByCoordinates(
        any,
        any,
        appid: anyNamed('appid'),
        lang: anyNamed('lang'),
        units: anyNamed('units'),
        exclude: anyNamed('exclude'),
      )).called(1);
    });

    test('loadWeatherDetails change state in expected sequence', () async {
      final _openWeatherRestClient = mockOpenWeatherRestClient(response: buildWeatherDetailsResponseFromTemplate());

      final _cubit = _getCubit(openWeatherRestClient: _openWeatherRestClient);

      unawaited(
        expectLater(
          _cubit.stream,
          emitsInOrder(
            [
              isA<WeatherDetailsLoading>(),
              isA<WeatherDetailsLoaded>(),
            ],
          ),
        ),
      );
      await _cubit.loadWeatherDetails(lat: 12.0, lng: 23.0);
    });

    test('loadWeatherDetails failed will change state to WeatherDetailsLoadFailed', () async {
      final _openWeatherRestClient = mockOpenWeatherRestClient(exception: Exception());

      final _cubit = _getCubit(openWeatherRestClient: _openWeatherRestClient);

      try {
        //try catch here because a rethrow is written in the loadWeatherDetails function
        await _cubit.loadWeatherDetails(lat: 12.0, lng: 23.0);

        fail('No assertion is thrown unlike expected');
      } catch (_) {
        expect(_cubit.state, isA<WeatherDetailsLoadFailed>());

        verify(_openWeatherRestClient.getWeatherByCoordinates(
          any,
          any,
          appid: anyNamed('appid'),
          lang: anyNamed('lang'),
          units: anyNamed('units'),
          exclude: anyNamed('exclude'),
        )).called(1);
      }
    });
  });
}

WeatherDetailsCubit _getCubit({
  OpenWeatherRestClient? openWeatherRestClient,
}) {
  getIt.registerLazySingleton<OpenWeatherRestClient>(() => openWeatherRestClient ?? MockOpenWeatherRestClient());

  return WeatherDetailsCubit.initial(
    languageCubit: mockLanguageCubit(),
  );
}
