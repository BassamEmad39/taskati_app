import 'package:flutter/material.dart';

extension Navigations on BuildContext {
  void pushTo(Widget screen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  void pushReplacementTo(Widget screen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void pop() {
    Navigator.pop(this);
  }
}
