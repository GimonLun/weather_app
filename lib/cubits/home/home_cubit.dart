import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/constants/storage_key_constants.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/hive_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HiveService _hiveService;

  late Box<City> _homeCityListBox;

  HomeCubit._({required HomeState state})
      : _hiveService = getIt.get(),
        super(state);

  factory HomeCubit.initial({
    HomeState? state,
  }) {
    return HomeCubit._(state: state ?? const HomeInitial());
  }

  Future<void> initHomeCubit() async {
    _homeCityListBox = await _hiveService.openBox<City>(homeCityListBoxKey);

    final _cityList = _homeCityListBox.values.toList();
    _cityList.sort((a, b) => a.index - b.index);

    emit(HomeLoaded(cityList: _cityList));
  }

  Future<void> addCityToHome(City city) async {
    if (state.cityList.contains(city)) {
      emit(HomeCityAddBefore(cityList: state.cityList));
      return;
    }

    final _updateList = [...state.cityList, city];

    emit(HomeCityAdded(cityList: _updateList));

    await updateStoreList(_updateList);
  }

  Future<void> removeCityFromHome(City city) async {
    final _updatedList = [...state.cityList];

    _updatedList.remove(city);

    emit(HomeCityRemoved(cityList: _updatedList));

    await updateStoreList(_updatedList);
  }

  Future<void> updateStoreList(List<City> cities) async {
    await _homeCityListBox.clear();

    for (var i = 0; i < cities.length; i++) {
      final _city = cities.elementAt(i).copyWith(index: i);

      await _homeCityListBox.put(_city.city, _city);
    }
  }
}
