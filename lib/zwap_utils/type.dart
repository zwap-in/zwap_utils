/// The tuple type to use inside this platform
class TupleType<T, F>{

  /// First type
  T a;

  /// Second type
  F b;

  TupleType({required this.a, required this.b});

}

/// Add some custom methods to the DateTime object
extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    int days = (day - this.weekday) % DateTime.daysPerWeek;
    return this.add(
      Duration(
        days: days != 0 ? days : 7,
      ),
    );
  }
}

/// It capitalizes the first letter on a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
