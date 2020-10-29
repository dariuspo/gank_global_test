// originally from https://github.com/vgventures/after_init
// just renamed to afterInitState, instead of didInitState

import 'package:flutter/widgets.dart';

/// This mixin adds a [afterInitState] lifecycle method to a [StatefulWidget] [State] object.
/// From there you can safely access [BuildContext.inheritFromWidgetOfExactType].
mixin AfterInitMixin<T extends StatefulWidget> on State<T> {
  bool _didInitState = false;

  @override
  @mustCallSuper
  void didChangeDependencies() {
    if (!_didInitState) {
      afterInitState();
      _didInitState = true;
    }
    super.didChangeDependencies();
  }

  /// Called only once, after [initState], and before [didChangeDependencies].
  void afterInitState();
}
