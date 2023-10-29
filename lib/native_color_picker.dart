
import 'native_color_picker_platform_interface.dart';

class NativeColorPicker {
  Future<String?> getPlatformVersion() {
    return NativeColorPickerPlatform.instance.getPlatformVersion();
  }
}
