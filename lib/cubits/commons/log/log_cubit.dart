import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/constants/storage_key_constants.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';
import 'package:weather_app/data/models/logs/local_log.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/hive_service.dart';

part 'log_state.dart';

class LogCubit extends Cubit<LogState> {
  final HiveService _hiveService;

  late Box<LocalLog> _logBox;

  LogCubit._({required LogState state})
      : _hiveService = getIt.get(),
        super(state);

  factory LogCubit.initial({
    LogState? state,
    userProfile,
  }) {
    return LogCubit._(state: state ?? const LogInitial());
  }

  Future<void> initLogCubit() async {
    _logBox = await _hiveService.openBox<LocalLog>(logBoxKey);

    final _logList = _logBox.values.toList();
    _logList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    emit(LogLoaded(logs: _logList));
  }

  Future<void> logEvent({
    required ActionType actionType,
    required Category category,
    required String pageName,
    String? data,
  }) async {
    final _log = LocalLog(
      dateTime: DateTime.now(),
      actionType: actionType,
      category: category,
      pageName: pageName,
      data: data,
    );

    emit(LogAdded(logs: [_log, ...state.logs]));

    await _logBox.put(_log.hashCode, _log);
  }
}
