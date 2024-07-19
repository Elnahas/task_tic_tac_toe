import 'package:intl/intl.dart';

class DateHelper {
  static String formatTimestampToMinutesAndSeconds(DateTime timestamp) {
    final DateFormat formatter = DateFormat('mm:ss');
    return formatter.format(timestamp);
  }
}
