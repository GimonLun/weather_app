part of 'city_list_cubit.dart';

abstract class CityListState extends Equatable {
  const CityListState();

  @override
  List<Object?> get props => [];
}

class CityListInitial extends CityListState {
  const CityListInitial() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}
