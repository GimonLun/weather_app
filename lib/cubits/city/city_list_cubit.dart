import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit._({required CityListState state}) : super(state);

  factory CityListCubit.initial({
    CityListState? state,
    userProfile,
  }) {
    return CityListCubit._(state: state ?? const CityListInitial());
  }
}
