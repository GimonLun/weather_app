part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  final Language currentLanguage;

  const LanguageState({
    required this.currentLanguage,
  });

  @override
  List<Object?> get props => [currentLanguage];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({
    required Language currentLanguage,
  }) : super(currentLanguage: currentLanguage);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LanguageChangeSuccess extends LanguageInitial {
  const LanguageChangeSuccess({
    required Language currentLanguage,
  }) : super(currentLanguage: currentLanguage);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LanguageUpdateInProgress extends LanguageInitial {
  const LanguageUpdateInProgress({
    required Language currentLanguage,
  }) : super(currentLanguage: currentLanguage);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LanguageUpdateSuccess extends LanguageInitial {
  const LanguageUpdateSuccess({
    required Language currentLanguage,
  }) : super(currentLanguage: currentLanguage);

  @override
  List<Object?> get props => super.props..addAll([]);
}
