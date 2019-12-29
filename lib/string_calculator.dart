import 'package:string_calculator/negative_number_exception.dart';

class StringCalculator {
  static const DEFAULT_DELIMITER = ",";
  static const START_OF_DELIMITER_INIT = 2;
  static const MAX = 1000;

  var _addCalledCount = 0;

  calledCount() => _addCalledCount;

  int add(String input) {
    _addCalledCount++;

    if (input.isEmpty) return 0;

    _requireOnlyPositivesNumbers(_numbers(input));

    return _numbers(input).fold(0, (previous, current) => previous + current);
  }

  Iterable<int> _numbers(String input) => _removeDelimiterInit(input)
      .split(_delimiter(input))
      .map((stringNumber) => int.parse(stringNumber))
      .where(_isLessThenMax);

  bool _isLessThenMax(number) => number < MAX;

  RegExp _delimiter(input) {
    final defaultDelimiter = _hasDelimiterInit(input)
        ? input.substring(START_OF_DELIMITER_INIT, _endOfDelimiterInit(input))
        : DEFAULT_DELIMITER;
    return RegExp('[$defaultDelimiter\\n]');
  }

  bool _hasDelimiterInit(input) => input.startsWith("//");

  int _endOfDelimiterInit(input) => input.indexOf("\n");

  String _removeDelimiterInit(input) => _hasDelimiterInit(input)
      ? input.substring(_endOfDelimiterInit(input) + 1)
      : input;

  void _requireOnlyPositivesNumbers(numbers) {
    if (numbers.any(_isNegative))
      throw NegativeNumberException(numbers.where(_isNegative));
  }

  bool _isNegative(num number) => number.isNegative;
}
