import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/utils/convert_helper.dart';

void main() {
  test('dateTimeToint will convert date time passed in and returns as millisecondsSinceEpoch int value', () {
    final _now = DateTime.now();

    final _result = dateTimeToint(_now);
    expect(_result, equals(_now.millisecondsSinceEpoch));
  });

  test('intToDateTime will convert millisecondsSinceEpoch int value returns as DateTime value', () {
    final _date = DateTime.tryParse('2022-01-23 11:29:21');

    final _result = intToDateTime(1642908561);

    expect(_result, equals(_date));
  });

  test('doubleToString will convert double value returns as String value', () {
    final _result = doubleToString(12.23);

    expect(_result, equals('12.23'));
  });

  group('stringToDouble', () {
    test('stringToDouble will convert string value returns as double value if it is valid', () {
      final _result = stringToDouble('12.23');

      expect(_result, equals(12.23));
    });

    test('stringToDouble will return 0.0 if pass in value is invalid double string', () {
      final _result = stringToDouble('asadsad');

      expect(_result, equals(0.0));
    });
  });
}
