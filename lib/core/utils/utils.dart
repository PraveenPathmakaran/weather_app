//time stamp to String

import 'package:intl/intl.dart';

class AppUtils {
  static String getTime(final int timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String timeObj = DateFormat("jm").format(time);
    return timeObj;
  }

  static String getDay(final int timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String timeObj = DateFormat("E").format(time);
    return timeObj;
  }
}
