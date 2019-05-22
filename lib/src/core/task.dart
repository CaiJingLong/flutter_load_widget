class Task {
  final Duration duration;

  final Function function;

  bool isCancel = false;

  Task(this.duration, this.function);

  void run() {
    Future.delayed(duration, () {
      if (!isCancel) {
        function();
      }
    });
  }

  void cancel() {
    isCancel = true;
  }
}
