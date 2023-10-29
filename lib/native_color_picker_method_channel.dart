import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'native_color_picker_platform_interface.dart';

/// An implementation of [NativeColorPickerPlatform] that uses method channels.
class MethodChannelNativeColorPicker extends NativeColorPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_color_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void callColorPicker({
    Color initialColor = Colors.white,
    required void Function(List<double>) onNewColor,
  }) {
    methodChannel.invokeMapMethod(
      "call_color_picker", [
        initialColor.red / 255,
        initialColor.green / 255,
        initialColor.blue / 255
      ],
    );
    methodChannel.setMethodCallHandler((MethodCall call) {
      final arguments = call.arguments as Map<String, dynamic>;
      debugPrint(arguments.toString());
      // final didProduce = arguments["didProduce"] as bool?;
      final red = arguments["red"] as double? ?? 0;
      final green = arguments["green"] as double? ?? 0;
      final blue = arguments["blue"] as double? ?? 0;

      final newColor = [red, green, blue];

      onNewColor.call(newColor);

      return Future.value(-1);
    });
  }
}
