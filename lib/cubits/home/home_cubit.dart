import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/city.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit._({required HomeState state}) : super(state);

  factory HomeCubit.initial({
    HomeState? state,
  }) {
    return HomeCubit._(state: state ?? const HomeInitial());
  }

  void addCityToHome(City city) {
    emit(HomeCityAdded(cityList: [...state.cityList, city]));
  }
}
