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
    if (state.cityList.contains(city)) {
      emit(HomeCityAddBefore(cityList: state.cityList));
      return;
    }

    emit(HomeCityAdded(cityList: [...state.cityList, city]));
  }

  void removeCityFromHome(City city) {
    final _updatedList = [...state.cityList];

    _updatedList.remove(city);

    emit(HomeCityRemoved(cityList: _updatedList));
  }
}
