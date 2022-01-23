import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/log/log_cubit.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class CityListPage extends StatefulWidget {
  static const routeName = 'city_list';

  const CityListPage({Key? key}) : super(key: key);

  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late LogCubit _logCubit;

  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

    _logCubit = BlocProvider.of<LogCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          _i18nService.translate(context, 'add_city'),
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
                onTap: () {
                  _logCubit.logEvent(
                    actionType: ActionType.create,
                    category: Category.city,
                    pageName: homePageCarousell,
                    data: _item.city.toString(),
                  );

                  Navigator.of(context).pop(_item);
                },
              );
            },
            itemCount: _cityList.length,
          );
        },
      ),
    );
  }
}
