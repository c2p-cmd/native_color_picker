import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_color_picker_platform_interface.dart';

/// An implementation of [NativeColorPickerPlatform] that uses method channels.
class MethodChannelNativeColorPicker extends NativeColorPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_color_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
