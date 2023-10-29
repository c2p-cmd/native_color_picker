import 'package:flutter/material.dart';
import 'native_color_picker_platform_interface.dart';

class NativeColorPicker {
  Future<String?> getPlatformVersion() {
    return NativeColorPickerPlatform.instance.getPlatformVersion();
  }
}

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    required this.child,
    required this.onNewColor,
    Color? initialColor,
    super.key,
  }) : initialColor = initialColor ?? Colors.white;

  final Widget child;
  final void Function(List<double>) onNewColor;
  final Color initialColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NativeColorPickerPlatform.instance.callColorPicker(
          initialColor: initialColor,
          onNewColor: onNewColor,
        );
      },
      child: child,
    );
  }
}
