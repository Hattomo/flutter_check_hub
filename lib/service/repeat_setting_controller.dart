import 'dart:async';

class RepeatSettingController {
  int repeatNumberSetting = -1;

  final StreamController<int> _repeatsettingController =
      StreamController<int>();

  Stream<int> get repeatsettingStream => _repeatsettingController.stream;

  void setRepeatSetting(int repeatsetting) {
    _repeatsettingController.sink.add(repeatsetting);
  }

  void dispose() {
    _repeatsettingController.close();
  }
}
