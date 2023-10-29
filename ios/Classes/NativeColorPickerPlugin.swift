import Flutter
import UIKit

public class NativeColorPickerPlugin: NSObject, FlutterPlugin {
    static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "native_color_picker", binaryMessenger: registrar.messenger())
        let instance = NativeColorPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break
        case "call_color_picker":
            let colorArray = call.arguments as? [CGFloat] ?? [0, 0, 0]
            showPicker(initialColor: (r: colorArray[0], g: colorArray[1], b: colorArray[2]), result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func showPicker(initialColor: (r: CGFloat, g: CGFloat, b: CGFloat), _ flutterResult: @escaping FlutterResult) {
        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController
        else {
            flutterResult(FlutterError(code: "VIEW CONTROLLER", message: "NO View Controller Found", details: nil))
            return
        }
        
        let sourceItem = rootViewController.navigationItem.rightBarButtonItem
        
        let methodName = "call_color_picker"
        let colorPickerVC = ColorPickerViewController(invoking: methodName, on: Self.channel, with: initialColor, sourceItem: sourceItem)
        rootViewController.present(colorPickerVC, animated: true)
    }
}
