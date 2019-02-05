//
//  RKYUITextField.swift
//  RKYClasses
//
//  Created by RAHUL on 7/4/18.
//  Copyright © 2018 RAHUL. All rights reserved.
//

import UIKit

@IBDesignable
class RKYUITextField: UITextField {
private var __maxLengths = [UITextField: Int]()

    public enum FloatingDisplayStatus {
        case always
        case never
        case defaults
    }
    
    fileprivate var lblFloatPlaceholder: UILabel = UILabel()
    fileprivate var lblError: UILabel = UILabel()
    fileprivate let paddingX: CGFloat = 5.0
    fileprivate let paddingHeight: CGFloat = 10.0
    
    public var dtLayer: CALayer = CALayer()
    public var floatPlaceholderColor: UIColor = UIColor.black
    public var floatPlaceholderActiveColor: UIColor = UIColor.black
    public var floatingLabelShowAnimationDuration = 0.3
    public var floatingDisplayStatus: FloatingDisplayStatus = .defaults
    
    public var animateFloatPlaceholder: Bool = true

    @IBInspectable var isFloatingLabel: Bool = true {
        didSet { }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPaddingColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            return self.bottomBorderColor
        }
        set {
            self.borderStyle = UITextBorderStyle.none;
            let border = CALayer()
            let width = CGFloat(1.5)
            border.borderColor = newValue?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width+300, height: self.frame.size.height)
            
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
            
        }
    }
    
    private var _isRightViewVisible: Bool = true
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    func updateView() {
        setLeftImage()
        setRightImage()
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: tintColor])
    }
    
    func setLeftImage() {
        leftViewMode = UITextFieldViewMode.always
        var view: UIView
        var PadingColorView: UIView

        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding+5, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            var width = imageView.frame.width + leftPadding+5
            imageView.contentMode = .scaleAspectFit
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width += 5
            }
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            PadingColorView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.size.height))
            PadingColorView.backgroundColor = leftPaddingColor
            self.addSubview(PadingColorView)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
            PadingColorView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding-2, height: self.frame.size.height))
            PadingColorView.backgroundColor = leftPaddingColor
            self.addSubview(PadingColorView)
        }
        leftView = view
    }
    func setRightImage() {
        rightViewMode = UITextFieldViewMode.always
        var view: UIView
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            var width = imageView.frame.width + rightPadding+1
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width += 5
            }
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        rightView = view
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
//    ///// Floating Label
//
//
//    public var paddingYFloatLabel: CGFloat = 3.0 {
//        didSet { invalidateIntrinsicContentSize() }
//    }
//
//
//    override public init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
////        dtLayer.frame = CGRect(x: bounds.origin.x,
////                               y: bounds.origin.y,
////                               width: bounds.width,
////                               height: dtLayerHeight)
//        CATransaction.commit()
//
//        let floatingLabelSize = lblFloatPlaceholder.sizeThatFits(lblFloatPlaceholder.superview!.bounds.size)
//
//        lblFloatPlaceholder.frame = CGRect(x: x, y: lblFloatPlaceholder.frame.origin.y,
//                                           width: floatingLabelSize.width,
//                                           height: floatingLabelSize.height)
//
//        lblFloatPlaceholder.textColor = isFirstResponder ? floatPlaceholderActiveColor : floatPlaceholderColor
//
//        switch floatingDisplayStatus {
//        case .never:
//            hideFlotingLabel(isFirstResponder)
//        case .always:
//            showFloatingLabel(isFirstResponder)
//        default:
//            if let enteredText = text, !enteredText.isEmpty {
//                showFloatingLabel(isFirstResponder)
//            } else {
//                hideFlotingLabel(isFirstResponder)
//            }
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//
//    }
//
//    var placeholderColor: UIColor? {
//        didSet {
//            guard let color = placeholderColor else { return }
//            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
//                                                       attributes: [NSAttributedStringKey.foregroundColor: color,NSAttributedStringKey.font:UIFont.small])
//        }
//    }
//
//    fileprivate var x: CGFloat {
//
//        if let leftView = leftView {
//            return leftView.frame.origin.x + leftView.bounds.size.width + paddingX
//        }
//
//        return paddingX
//    }
//
//    fileprivate var fontHeight: CGFloat {
//        return ceil(font!.lineHeight)
//    }
//    
//    fileprivate var floatLabelWidth: CGFloat {
//
//        var width = bounds.size.width
//
//        if let leftViewWidth = leftView?.bounds.size.width {
//            width -= leftViewWidth
//        }
//
//        if let rightViewWidth = rightView?.bounds.size.width {
//            width -= rightViewWidth
//        }
//
//        return width - (self.x * 2)
//    }
//
//    fileprivate var placeholderFinal: String {
//        if let attributed = attributedPlaceholder { return attributed.string }
//        return placeholder ?? " "
//    }
//
//    fileprivate var isFloatLabelShowing: Bool = false
//
//
//    override public var placeholder: String? {
//        didSet {
//            let color = UIColor.gray
//            lblFloatPlaceholder.text = placeholderFinal
//            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
//                                                       attributes: [NSAttributedStringKey.foregroundColor: color,NSAttributedStringKey.font:UIFont.medium])
//        }
//    }
//
//    override public var attributedPlaceholder: NSAttributedString? {
//        didSet { lblFloatPlaceholder.text = placeholderFinal }
//    }
//
//
//    fileprivate func commonInit() {
//        self.backgroundColor = UIColor.clear
//        dtLayer.cornerRadius = 2
//        dtLayer.borderWidth = 1.0
//        dtLayer.borderColor = UIColor.red.cgColor
//        dtLayer.backgroundColor = UIColor.red.cgColor
//
//        floatPlaceholderColor = UIColor.gray
//        floatPlaceholderActiveColor = UIColor.green
//
//        lblFloatPlaceholder.frame = CGRect.zero
//        lblFloatPlaceholder.alpha = 0.0
//        lblFloatPlaceholder.font = UIFont.small
//        lblFloatPlaceholder.text = placeholderFinal
//
//        addSubview(lblFloatPlaceholder)
//
//    }
//    fileprivate func showFloatingLabel(_ animated: Bool) {
//
//        if isFloatingLabel {
//            let animations: (() -> ()) = {
//                self.lblFloatPlaceholder.alpha = 1.0
//                self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
//                                                        y: self.paddingYFloatLabel,
//                                                        width: self.lblFloatPlaceholder.bounds.size.width,
//                                                        height: self.lblFloatPlaceholder.bounds.size.height)
//            }
//
//            if animated && animateFloatPlaceholder {
//                UIView.animate(withDuration: floatingLabelShowAnimationDuration,
//                               delay: 0.0,
//                               options: [.beginFromCurrentState, .curveEaseOut],
//                               animations: animations) { status in
//                                DispatchQueue.main.async {
//                                    self.layoutIfNeeded()
//                                }
//                }
//            } else {
//                animations()
//            }
//        }
//    }
//
//    fileprivate func hideFlotingLabel(_ animated: Bool) {
//
//        if isFloatingLabel {
//            let animations: (() -> ()) = {
//                self.lblFloatPlaceholder.alpha = 0.0
//                self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
//                                                        y: self.lblFloatPlaceholder.font.lineHeight,
//                                                        width: self.lblFloatPlaceholder.bounds.size.width,
//                                                        height: self.lblFloatPlaceholder.bounds.size.height)
//            }
//
//            if animated && animateFloatPlaceholder {
//                UIView.animate(withDuration: floatingLabelShowAnimationDuration,
//                               delay: 0.0,
//                               options: [.beginFromCurrentState, .curveEaseOut],
//                               animations: animations) { status in
//                                DispatchQueue.main.async {
//                                    self.layoutIfNeeded()
//                                }
//                }
//            } else {
//                animations()
//            }
//        }
//    }
//
//
//    ///// Floating Label
}
extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    func strikeThrough() -> NSAttributedString {
        
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0,attributeString.length))
        attributeString.addAttribute(NSAttributedStringKey.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    var numberValue: NSNumber? {
        if let value = Int(self) {
            return NSNumber(value: value)
        }
        return nil
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}











