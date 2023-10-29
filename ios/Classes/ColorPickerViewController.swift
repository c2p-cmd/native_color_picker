//
//  ColorPickerViewController.swift
//  native_color_picker
//
//  Created by Sharan Thakur on 29/10/23.
//

import Flutter
import Foundation

class ColorPickerViewController: UIColorPickerViewController {
    let methodName: String
    let channel: FlutterMethodChannel?
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    override var selectedColor: UIColor {
        didSet {
            let didProduce = selectedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            channel?.invokeMethod(methodName, arguments: [
                "didProduce" : didProduce,
                "red" : red,
                "green" : green,
                "blue" : blue
            ])
        }
    }
    
    required init(
        invoking methodName: String,
        on channel: FlutterMethodChannel?,
        with: (r: CGFloat, g: CGFloat, b: CGFloat),
        supportAlpha: Bool = false,
        alpha: CGFloat = 1.0,
        sourceItem: UIBarButtonItem?
    ) {
        // stored properties
        self.channel = channel
        self.methodName = methodName
        (self.red, self.green, self.blue) = with
        self.alpha = alpha
        
        // super initializer
        super.init()
        
        // overridden properties
        self.supportsAlpha = supportAlpha
        self.delegate = self
        if #available(iOS 16.0, *) {
            self.popoverPresentationController?.sourceItem = sourceItem
        }
        self.modalPresentationStyle = .automatic
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedColor = color
        let didProduce = selectedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        channel?.invokeMethod(methodName, arguments: [
            "didProduce" : didProduce,
            "red" : red,
            "green" : green,
            "blue" : blue
        ])
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        let didProduce = false
    }
}
