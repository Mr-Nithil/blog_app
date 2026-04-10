import 'package:intl/intl.dart';

String formatDateByDDMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM yyyy").format(dateTime);
}
