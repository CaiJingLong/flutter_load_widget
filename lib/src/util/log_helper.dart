class LoadLogHelper {
  static bool showLog = false;

  static void log(String msg) {
    if (showLog) print("load library: $msg");
  }
}
