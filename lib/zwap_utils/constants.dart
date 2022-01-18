/// The constants class to retrieve some constants values
class Constants{

  /// Custom map to retrieves the months names
  static Map<int, String> monthlyName(){
    return {
      1:  "january",
      2:  "february",
      3:  "march",
      4:  "april",
      5:  "may",
      6:  "june",
      7:  "july",
      8:  "august",
      9:  "september",
      10: "october",
      11: "november",
      12: "december",
    };
  }

  /// The abbreviation of the months name
  static Map<int, String> monthlyAbbrName(){
    return {
      1:  "januaryAbbr",
      2:  "februaryAbbr",
      3:  "marchAbbr",
      4:  "aprilAbbr",
      5:  "mayAbbr",
      6:  "juneAbbr",
      7:  "julyAbbr",
      8:  "augustAbbr",
      9:  "septemberAbbr",
      10: "octoberAbbr",
      11: "novemberAbbr",
      12: "decemberAbbr",
    };
  }

  /// The abbreviations name for the week days
  static Map<int, String> weekDayAbbrName(){
    return {
      1:  "mondayAbbr",
      2:  "tuesdayAbbr",
      3:  "wednesdayAbbr",
      4:  "thursdayAbbr",
      5:  "fridayAbbr",
      6:  "saturdayAbbr",
      7:  "sundayAbbr",
    };
  }

  /// The regex for custom email
  static String get emailRegex => r"^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$";

  /// The regex for custom password
  static String get passwordRegex => r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

}