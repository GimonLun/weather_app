import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';
import 'package:weather_app/service_locator.dart';

part 'weather_details_state.dart';

class WeatherDetailsCubit extends Cubit<WeatherDetailsState> {
  final OpenWeatherRestClient _openWeatherRestClient;

  WeatherDetailsCubit._({
    required WeatherDetailsState state,
  })  : _openWeatherRestClient = getIt.get(),
        super(state);

  factory WeatherDetailsCubit.initial({
    WeatherDetailsState? state,
  }) {
    return WeatherDetailsCubit._(
      state: state ?? const WeatherDetailsInitial(),
    );
  }

  Future<void> loadWeatherDetails({required double lat, required double lng}) async {
    emit(const WeatherDetailsLoading());

    try {
      final _detailsResponse = await _openWeatherRestClient.getWeatherByCoordinates(
        lng,
        lat,
      );

      emit(WeatherDetailsLoaded(weatherDetailsResponse: _detailsResponse));
    } catch (_) {
      emit(const WeatherDetailsLoadFailed());

      rethrow;
    }
  }
}
