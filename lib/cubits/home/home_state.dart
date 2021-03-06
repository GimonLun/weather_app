part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final List<City> cityList;

  const HomeState({this.cityList = const []});

  @override
  List<Object?> get props => [cityList];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class HomeLoading extends HomeState {
  const HomeLoading() : super();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class HomeLoaded extends HomeState {
  const HomeLoaded({required List<City> cityList}) : super(cityList: cityList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class HomeCityAdded extends HomeLoaded {
  const HomeCityAdded({required List<City> cityList}) : super(cityList: cityList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class HomeCityAddBefore extends HomeLoaded {
  const HomeCityAddBefore({required List<City> cityList}) : super(cityList: cityList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class HomeCityRemoved extends HomeLoaded {
  const HomeCityRemoved({required List<City> cityList}) : super(cityList: cityList);

  @override
  List<Object?> get props => super.props..addAll([]);
}
