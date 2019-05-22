import 'package:flutter/material.dart';

class LoadingDismissFuture {
  final OverlayEntry entry;
  Duration animDuration;
  bool isRemove = false;

  LoadingDismissFuture(this.entry, this.animDuration) {
    FutureManager.getInstance().futures.add(this);
  }

  void _realRemove() {
    if (isRemove) {
      return;
    }
    isRemove = true;
    entry.remove();
  }

  void dismiss([bool now = false]) {
    if (isRemove) {
      return;
    }
    if (now) {
      FutureManager.getInstance().futures.remove(this);
      entry.remove();
      return;
    }
    isRemove = true;
    FutureManager.getInstance().futures.remove(this);
    Future.delayed(animDuration, entry.remove);
  }
}

class FutureManager {
  static FutureManager _instance;

  FutureManager._();

  factory FutureManager.getInstance() {
    _instance ??= FutureManager._();
    return _instance;
  }

  var futures = <LoadingDismissFuture>[];

  dismissAll([bool now = true]) {
    futures.toList().forEach((f) {
      f.dismiss(now);
    });
    futures.clear();
  }
}
