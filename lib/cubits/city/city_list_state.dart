part of 'city_list_cubit.dart';

abstract class CityListState extends Equatable {
  final List<City> cityList;

  const CityListState({this.cityList = const []});

  @override
  List<Object?> get props => [cityList];
}

class CityListInitial extends CityListState {
  const CityListInitial() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class CityListLoading extends CityListState {
  const CityListLoading() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class CityListLoaded extends CityListState {
  const CityListLoaded({required List<City> cityList}) : super(cityList: cityList);

  @override
  List<Object?> get props => super.props..addAll([]);
}
