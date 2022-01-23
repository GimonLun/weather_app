// Mocks generated by Mockito 5.0.17 from annotations
// in weather_app/test/mocks/cubits/commons/mock_commons.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/cubits/commons/languages/language_cubit.dart'
    as _i2;
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart' as _i3;
import 'package:weather_app/data/enums_extensions/enums.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeLanguageState_0 extends _i1.Fake implements _i2.LanguageState {}

class _FakeThemeState_1 extends _i1.Fake implements _i3.ThemeState {}

/// A class which mocks [LanguageCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockLanguageCubit extends _i1.Mock implements _i2.LanguageCubit {
  MockLanguageCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LanguageState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeLanguageState_0()) as _i2.LanguageState);
  @override
  _i4.Stream<_i2.LanguageState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.LanguageState>.empty())
          as _i4.Stream<_i2.LanguageState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i4.Future<void> initAppLanguage() =>
      (super.noSuchMethod(Invocation.method(#initAppLanguage, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> changeLanguage({_i5.Language? language}) =>
      (super.noSuchMethod(
          Invocation.method(#changeLanguage, [], {#language: language}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void emit(_i2.LanguageState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i2.LanguageState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [ThemeCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeCubit extends _i1.Mock implements _i3.ThemeCubit {
  MockThemeCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.ThemeState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeThemeState_1()) as _i3.ThemeState);
  @override
  _i4.Stream<_i3.ThemeState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.ThemeState>.empty())
          as _i4.Stream<_i3.ThemeState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i4.Future<void> initAppTheme() =>
      (super.noSuchMethod(Invocation.method(#initAppTheme, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> changeTheme() =>
      (super.noSuchMethod(Invocation.method(#changeTheme, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void emit(_i3.ThemeState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i3.ThemeState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}
