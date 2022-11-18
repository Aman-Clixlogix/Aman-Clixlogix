//
//  CustomButtom.swift
//
//  Created by Manisha  Sharma on 29/12/2018.
//  Copyright © 2018 Qualwebs. All rights reserved.
//

import UIKit

public func designableView(view: UIButton) {
    view.layer.borderColor = UIColor.gray.cgColor
    view.layer.cornerRadius = 28
    view.layer.shadowRadius = 4
    view.layer.shadowOffset = CGSize(width: 0, height: 6)
    view.layer.shadowOpacity = 0.3
    view.layer.borderWidth = 0
    view.layer.shadowColor = AppColors.gradientPoint2!.cgColor
}

public func designableView2(view: UIView) {
    view.layer.borderColor = UIColor.gray.cgColor
    view.layer.cornerRadius = 20
    view.layer.shadowRadius = 0
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.3
    view.layer.borderWidth = 0
    view.layer.shadowColor = UIColor(red: 187.0/255.0, green: 214.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
}
public func dashableView(view: UIView) {
    let yourViewBorder = CAShapeLayer()
    yourViewBorder.strokeColor = UIColor.gray.cgColor
    yourViewBorder.lineDashPattern = [4, 4]
    yourViewBorder.frame = view.bounds
    yourViewBorder.fillColor = nil
    yourViewBorder.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 20).cgPath
    view.layer.addSublayer(yourViewBorder)
}
@IBDesignable
class CustomUIView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
//    @IBInspectable var topCornerRadius: CGFloat {
//        get {
//            return CGFloat(layer.maskedCorners.rawValue)
//        }
//        set {
//            layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//            layer.masksToBounds = true
//        }
//    }
   
    @IBInspectable var  borderWidtg: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var  borderColors: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColors.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
//    @IBInspectable var shadowPath: CGPath {
//        get {
//            return layer.shadowPath!
//        }
//        set {
//            layer.shadowPath = newValue
//        }
//    }
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        } set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        } set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        } set {
            self.layer.shadowOffset = newValue
        }
    }
}
@IBDesignable
class CustomLabel: UILabel {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        } set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var bottomLine: Bool {
        get {
            return self.bottomLine
        } set {
            if newValue {
                let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
                super.drawText(in: self.frame.inset(by: insets))
            }
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
        }
    }
}

@IBDesignable
class Segmentt: UISegmentedControl {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
        }
    }
}

@IBDesignable
class View: UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var circle: Bool {
        get {
            return self.circle
        }
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.width/2
                self.clipsToBounds = true
            }
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
//    @IBInspectable var shadowpath: CGPath {
//        get {
//            return layer.shadowPath!
//        }
//        set {
//            layer.shadowPath = newValue
//        }
//    }
}

@IBDesignable
class ImageView: UIImageView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var circle: Bool {
        get {
            return self.circle
        }
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.width/2
                self.clipsToBounds = true
            }
        }
    }
    @IBInspectable var customTintColor: UIColor {
        get {
            return self.customTintColor
        } set {
            let templateImage =  self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        }
    }
}

@IBDesignable
class DesignableUITextField: UITextField {
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
}

    @IBDesignable
    class CustomSwitch: UISwitch {
        public var offTintColor = UIColor.lightGray
        public var cornerRadius: CGFloat = 0.5
        public var thumbCornerRadius: CGFloat = 0.5
        public var thumbSize = CGSize.zero
        public var padding: CGFloat = 1
        public var animationDuration: Double = 0.5
        fileprivate var thumbView = UIView(frame: CGRect.zero)
        fileprivate var onPoint = CGPoint.zero
        fileprivate var offPoint = CGPoint.zero
        fileprivate var isAnimating = false
        private func clear() {
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
        func setupUI() {
            self.clear()
            self.clipsToBounds = false
            self.thumbView.backgroundColor = self.thumbTintColor
            self.thumbView.isUserInteractionEnabled = false
            self.addSubview(self.thumbView)
        }
        public override func layoutSubviews() {
            super.layoutSubviews()
            if !self.isAnimating {
                self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
                self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
                let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width:
                    self.bounds.size.height - 2, height: self.bounds.height - 2)
                let yPostition = (self.bounds.size.height - thumbSize.height) / 2
                self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
                self.offPoint = CGPoint(x: self.padding, y: yPostition)
                self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
                self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            }
        }
        private func animate() {
            self.isOn = !self.isOn
            self.isAnimating = true
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut,
                                                                 UIView.AnimationOptions.beginFromCurrentState], animations: {
                                                                    self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
                                                                    self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            }, completion: { _ in
                self.isAnimating = false
                self.sendActions(for: UIControl.Event.valueChanged)
            })
        }
        override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
            super.beginTracking(touch, with: event)
            self.animate()
            return true
        }
}

@IBDesignable open class AJCustomView: UIView {
    @IBInspectable var roundTopLeftCorner: Bool = false
    @IBInspectable var roundTopRightCorner: Bool = false
    @IBInspectable var roundBottomLeftCorner: Bool = false
    @IBInspectable var roundBottomRightCorner: Bool = false
    @IBInspectable var roundTopCorner: Bool = false
    private var shadowLayer: CAShapeLayer!
    func roundCorners(cornerRadius: Double) {
        if #available(iOS 10.0, *) {
            if roundTopLeftCorner {
                self.layer.maskedCorners = [.layerMinXMinYCorner]
            } else if roundTopRightCorner {
                self.layer.maskedCorners = [.layerMaxXMinYCorner]
            } else if roundBottomLeftCorner {
                self.layer.maskedCorners = [.layerMinXMaxYCorner]
            } else if roundBottomRightCorner {
                self.layer.maskedCorners = [.layerMaxXMaxYCorner]
            }
            if roundTopLeftCorner && roundTopRightCorner {
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if roundBottomLeftCorner && roundBottomRightCorner {
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            if roundTopLeftCorner && roundTopRightCorner && roundBottomLeftCorner && roundBottomRightCorner {
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            self.layer.cornerRadius = CGFloat(cornerRadius)
            self.clipsToBounds = true
        } else {
            var path = UIBezierPath()
            if roundTopLeftCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            if roundTopRightCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            if roundBottomLeftCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            if roundBottomRightCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            if roundTopLeftCorner && roundTopRightCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            if roundTopLeftCorner && roundTopRightCorner && roundBottomLeftCorner && roundBottomRightCorner {
                path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            }
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        if roundTopCorner {
            roundCorners(cornerRadius: cornerRadius )
        }
    }
    /* When positive, the background of the layer will be drawn with rounded corners. Also effects the mask generated by the `masksToBounds' property. Defaults to zero. Animatable.*/
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            if !roundTopCorner {
                self.layer.cornerRadius = CGFloat(newValue)
            } else {
                roundCorners(cornerRadius: newValue)
            }
        }
    }
    /* The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.*/
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowSize: CGFloat {
        get {
            return self.layer.shadowPath as? CGFloat ?? 0.0
        }
        set {
            let shadowPath = UIBezierPath(rect: CGRect(x: self.frame.origin.x - newValue / 2,
                                                       y: self.frame.origin.x - newValue / 2,
                                                       width: self.frame.size.width + newValue,
                                                       height: self.frame.size.height + newValue))
            self.layer.shadowPath = shadowPath.cgPath
        }
    }
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    /*// Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }*/
}
