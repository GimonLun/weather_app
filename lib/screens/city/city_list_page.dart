import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({Key? key}) : super(key: key);

  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _i18nService.translate(context, 'city_list_title'),
        ),
      ),
      body: BlocBuilder<CityListCubit, CityListState>(
        builder: (context, cityListState) {
          if (cityListState is CityListLoading) {
            return Center(
              child: Text(_i18nService.translate(context, 'loading')),
            );
          }

          final _cityList = cityListState.cityList;

          return ListView.builder(
            itemBuilder: (context, index) {
              final _item = _cityList.elementAt(index);

              return ListTile(
                title: Text(_item.city),
              );
            },
            itemCount: _cityList.length,
          );
        },
      ),
    );
  }
}
