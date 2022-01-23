part of 'log_cubit.dart';

abstract class LogState extends Equatable {
  final List<LocalLog> logs;

  const LogState({
    this.logs = const [],
  });

  @override
  List<Object?> get props => [logs];
}

class LogInitial extends LogState {
  const LogInitial();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LogLoading extends LogState {
  const LogLoading();

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LogLoaded extends LogState {
  const LogLoaded({required List<LocalLog> logs}) : super(logs: logs);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LogAdded extends LogLoaded {
  const LogAdded({required List<LocalLog> logs}) : super(logs: logs);

  @override
  List<Object?> get props => super.props..addAll([]);
}
