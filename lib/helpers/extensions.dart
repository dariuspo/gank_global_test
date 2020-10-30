import 'package:intl/intl.dart';

extension DateTimeExtensiosn on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }

  bool isSameDay(DateTime dateTime) {
    return dateTime.day == this.day &&
        dateTime.month == this.month &&
        dateTime.year == this.year;
  }

  String toChatDateLabel() {
    if (this.isToday()) return 'TODAY';
    if (this.isYesterday()) return 'YESTERDAY';
    return DateFormat('MMMM dd, yyyy').format(this).toUpperCase();
  }

  String toHhMm() {
    return DateFormat('HH:MM').format(this).toUpperCase();
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
