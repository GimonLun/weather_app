import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';
import 'package:weather_app/service_locator.dart';

part 'weather_details_state.dart';

class WeatherDetailsCubit extends Cubit<WeatherDetailsState> {
  final OpenWeatherRestClient _openWeatherRestClient;
  final City citySelected;

  WeatherDetailsCubit._({
    required WeatherDetailsState state,
    required this.citySelected,
  })  : _openWeatherRestClient = getIt.get(),
        super(state);

  factory WeatherDetailsCubit.initial({
    required City citySelected,
    WeatherDetailsState? state,
  }) {
    return WeatherDetailsCubit._(
      citySelected: citySelected,
      state: state ?? const WeatherDetailsInitial(),
    );
  }

  Future<void> loadWeatherDetails() async {
    emit(const WeatherDetailsLoading());

    try {
      final _detailsResponse = await _openWeatherRestClient.getCurrentWeatherByCoordinates(
        citySelected.lng,
        citySelected.lat,
        openWeatherApiKey,
      );

      emit(WeatherDetailsLoaded(weatherDetailsResponse: _detailsResponse));
    } catch (_) {
      emit(const WeatherDetailsLoadFailed());
    }
  }
}
