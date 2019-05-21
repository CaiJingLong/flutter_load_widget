# load

Global loading widget, which can be used through simple configuration.

Pure flutter library, not use native code.

- [load](#load)
  - [ScreenShot](#screenshot)
  - [Usage](#usage)

## ScreenShot

![Screenshot_2019-05-21-14-08-42-731_com.example.ex.png](https://raw.githubusercontent.com/kikt-blog/image/master/img/Screenshot_2019-05-21-14-08-42-731_com.example.ex.png)

## Usage

- install

Add to yaml

```yaml
dependencies:
  load: 0.1.0
```

- import

```dart
import 'package:load/load.dart';
```

- wrap your application

```dart
void main() {
  runApp(
    LoadingProvider(
      child: MyApp(),
    ),
  );
}

or

LoadingProvider(
  child: MaterialApp(),
);
```

see example/lib/main.dart

- show or hide dialog

```dart
showLoadingDialog();
hideLoadingDialog();
```
