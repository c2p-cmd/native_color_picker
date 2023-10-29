import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_color_picker_method_channel.dart';

abstract class NativeColorPickerPlatform extends PlatformInterface {
  /// Constructs a NativeColorPickerPlatform.
  NativeColorPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeColorPickerPlatform _instance = MethodChannelNativeColorPicker();

  /// The default instance of [NativeColorPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeColorPicker].
  static NativeColorPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeColorPickerPlatform] when
  /// they register themselves.
  static set instance(NativeColorPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void callColorPicker({
    Color initialColor = Colors.white,
    required void Function(List<double>) onNewColor,
  }) {
    throw UnimplementedError('callColorPicker() has not been implemented.');
  }
}
