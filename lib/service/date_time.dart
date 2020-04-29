import 'dart:async';

class DateTimeManager {
  DateTime selectedDate = DateTime.now();

  final StreamController<DateTime> _dateStreamController =
      StreamController<DateTime>();

  Stream<DateTime> get dateStream => _dateStreamController.stream;

  void addDate() {
    selectedDate = selectedDate.add(const Duration(days: 1));
    _dateStreamController.sink.add(selectedDate);
  }

  void subtractDate() {
    print(selectedDate);
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    _dateStreamController.sink.add(selectedDate);
    print(selectedDate);
  }

  void dispose() {
    _dateStreamController.close();
  }
}