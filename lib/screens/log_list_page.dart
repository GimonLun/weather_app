import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/log/log_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class LogListPage extends StatefulWidget {
  static const routeName = 'log_list';

  const LogListPage({Key? key}) : super(key: key);

  @override
  _LogListPageState createState() => _LogListPageState();
}

class _LogListPageState extends State<LogListPage> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          _i18nService.translate(context, 'logs_history'),
        ),
      ),
      body: BlocBuilder<LogCubit, LogState>(
        builder: (context, logState) {
          if (logState is! LogLoaded) {
            return Center(
              child: Text(_i18nService.translate(context, 'loading')),
            );
          }

          final _logList = logState.logs;

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final _item = _logList.elementAt(index);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceMid),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TextWithPadding('Page: ${_item.pageName}'),
                      _TextWithPadding('Data: ${_item.data}'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TextWithPadding('${_item.actionType}, ${_item.category}'),
                      _TextWithPadding(
                        DateFormat('dd MMM yyyy hh:mma').format(_item.dateTime),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _logList.length,
          );
        },
      ),
    );
  }
}

class _TextWithPadding extends StatelessWidget {
  final String text;

  const _TextWithPadding(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spaceSmall),
      child: Text(text),
    );
  }
}
