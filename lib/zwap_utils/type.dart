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

  /// It writes the full minute for any string format
  String getMinute(){
    return this.minute == 0 ? "00" : this.minute.toString();
  }

  /// It writes the full minute for any string format
  String getHour(){
    return this.hour == 0 ? "00" : this.hour.toString();
  }
}

/// It adds some extensions method on String type
extension StringExtension on String {

  /// It capitalizes the first letter on a string
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  /// It renders the emoji in base of the string name
  String emojiChar(){
    return this.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397)
    );
  }
}
