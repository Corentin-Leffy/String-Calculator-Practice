import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  handleSimpleCase();
  handleMultipleDelimiters();
  handleNegativesNumbers();
  handleCountInvocation();
  handleBigNumbers();
}

void handleSimpleCase() {
  group('Simple case : ', () {
    final stringCalculator = StringCalculator();

    final result = {"": 0, "1": 1, "1,2": 3, "1,2,3,4": 10};

    result.forEach((input, expected) {
      test('Given `$input`, should return `$expected`', () {
        expect(stringCalculator.add(input), expected);
      });
    });
  });
}

void handleMultipleDelimiters() {
  group('Multiple delimiters : ', () {
    final stringCalculator = StringCalculator();

    test('Can handle commas AND new lines as delimiter', () {
      expect(stringCalculator.add("1\n2,3"), 6);
    });

    test('Can support different delimiters instead of commas', () {
      expect(stringCalculator.add("//;\n1;2"), 3);
    });
  });
}

void handleNegativesNumbers() {
  group('Negatives numbers : ', () {
    final stringCalculator = StringCalculator();

    final result = {
      "-1, 0": "-1",
      "-1,-10,-40": "-1, -10, -40",
      "1,10,-40": "-40",
    };

    result.forEach((input, expected) {
      test('Given `$input`, will throw an exception and list `$expected`', () {
        expect(() => stringCalculator.add(input),
            throwsA(negativeNumberException(expected)));
      });
    });
  });
}

void handleCountInvocation() {
  group('Count the number of time add is invoked : ', () {
    final result = {0, 1, 2, 3, 10};

    result.forEach((numberOfInvocation) {
      test('Add method should be call $numberOfInvocation time', () {
        expect(numberOfInvocation,
            createCalculatorWith(numberOfInvocation).calledCount());
      });
    });
  });
}

void handleBigNumbers() {
  group('Big numbers : ', () {
    final stringCalculator = StringCalculator();

    final result = {"1000,2": 2, "1000,1001": 0, "999,100, 29239": 1099};

    result.forEach((input, expected) {
      test('Given `$input`, should return `$expected`', () {
        expect(expected, stringCalculator.add(input));
      });
    });
  });
}

StringCalculator createCalculatorWith(int input) {
  final stringCalculator = StringCalculator();
  for (int n = 0; n < input; n++) {
    stringCalculator.add("");
  }
  return stringCalculator;
}

Matcher negativeNumberException(String negativesNumbers) => predicate((e) =>
    e is ArgumentError &&
    e.message == 'Negatives not allowed : ($negativesNumbers)');
