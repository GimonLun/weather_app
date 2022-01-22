import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/city.dart';

part 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit._({required CityListState state}) : super(state);

  factory CityListCubit.initial({
    CityListState? state,
    userProfile,
  }) {
    return CityListCubit._(state: state ?? const CityListInitial());
  }

  Future<void> initCityList() async {
    emit(const CityListLoading());

    final String response = await rootBundle.loadString('assets/cities.json');
    final data = await json.decode(response) as List;

    emit(CityListLoaded(cityList: data.map((d) => City.fromJson(d)).toList()));
  }
}
