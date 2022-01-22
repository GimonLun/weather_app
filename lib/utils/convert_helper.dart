int dateTimeToint(DateTime value) => value.millisecondsSinceEpoch;

DateTime intToDateTime(int value) => DateTime.fromMillisecondsSinceEpoch(value * 1000);

String doubleToString(double value) => value.toString();

double stringToDouble(String value) => double.tryParse(value) ?? 0.0;
