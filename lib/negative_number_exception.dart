class NegativeNumberException extends ArgumentError {
  Iterable<num> negativesNumbers;

  NegativeNumberException(this.negativesNumbers);

  @override
  get message => "Negatives not allowed : $negativesNumbers";
}
