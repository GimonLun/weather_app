part of 'weather_details_cubit.dart';

abstract class WeatherDetailsState extends Equatable {
  final WeatherDetailsResponse? weatherDetailsResponse;

  const WeatherDetailsState({this.weatherDetailsResponse});

  @override
  List<Object?> get props => [weatherDetailsResponse];
}

class WeatherDetailsInitial extends WeatherDetailsState {
  const WeatherDetailsInitial() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class WeatherDetailsLoading extends WeatherDetailsState {
  const WeatherDetailsLoading() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class WeatherDetailsLoaded extends WeatherDetailsState {
  const WeatherDetailsLoaded({required WeatherDetailsResponse? weatherDetailsResponse})
      : super(weatherDetailsResponse: weatherDetailsResponse);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class WeatherDetailsLoadFailed extends WeatherDetailsState {
  const WeatherDetailsLoadFailed() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}
