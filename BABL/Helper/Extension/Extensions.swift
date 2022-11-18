//
//  Extemsions.swift
//
//  Created by Manisha  Sharma on 02/01/2019.
//  Copyright © 2019 Qualwebs. All rights reserved.
//

import UIKit
import SystemConfiguration
import AKSideMenu

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class OYSegmentControl: UISegmentedControl {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let segmentStringSelected: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0),
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    let segmentStringHighlited: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0),
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5567105412, green: 0.5807551742, blue: 0.6022000909, alpha: 1)
    ]
    setTitleTextAttributes(segmentStringHighlited, for: .normal)
    setTitleTextAttributes(segmentStringSelected, for: .selected)
    setTitleTextAttributes(segmentStringHighlited, for: .highlighted)
    layer.masksToBounds = true
    if #available(iOS 13.0, *) {
      selectedSegmentTintColor = #colorLiteral(red: 0.4720882177, green: 0.8643459678, blue: 0.8250272274, alpha: 1)
    } else {
      tintColor = #colorLiteral(red: 0.4720882177, green: 0.8643459678, blue: 0.8250272274, alpha: 1)
    }
    backgroundColor = #colorLiteral(red: 0.9191747308, green: 0.9334954619, blue: 0.9506797194, alpha: 1)
    // corner radius
    let cornerRadius = bounds.height / 2
    let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    // background
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = maskedCorners
    let foregroundIndex = numberOfSegments
    if subviews.indices.contains(foregroundIndex),
      let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
      foregroundImageView.image = UIImage()
      foregroundImageView.clipsToBounds = true
      foregroundImageView.layer.masksToBounds = true
      foregroundImageView.backgroundColor = #colorLiteral(red: 0.4720882177, green: 0.8643459678, blue: 0.8250272274, alpha: 1)
      foregroundImageView.layer.cornerRadius = bounds.height / 2 + 5
      foregroundImageView.layer.maskedCorners = maskedCorners
    }
  }
  
  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}

extension UITextView {
    func resolveHashTags() {
        // turn string in to NSString
        let nsText = NSString(string: self.text)
        // this needs to be an array of NSString.  String does not work.
        let words = nsText.components(separatedBy: CharacterSet(charactersIn: "#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_").inverted)
        // you can staple URLs onto attributed strings
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(self.attributedText)
        // tag each word if it has a hashtag
        for word in words {
            if word.count < 3 {
                continue
            }
            // found a word that is prepended by a hashtag!
            // homework for you: implement @mentions here too.
            if word.hasPrefix("#") {
                // a range is the character position, followed by how many characters are in the word.
                // we need this because we staple the "href" to this range.
                let matchRange: NSRange = nsText.range(of: word as String)
                // drop the hashtag
                let stringifiedWord = word.dropFirst()
                if let firstChar = stringifiedWord.unicodeScalars.first, NSCharacterSet.decimalDigits.contains(firstChar) {
                    // hashtag contains a number, like "#1"
                    // so don't make it clickable
                } else {
                    // set a link for when the user clicks on this word.
                    // it's not enough to use the word "hash", but you need the url scheme syntax "hash://"
                    // note:  since it's a URL now, the color is set to the project's tint color
                    attrString.addAttribute(NSAttributedString.Key.link, value: "\(stringifiedWord)", range: matchRange)
                }
            }
        }
        // we're used to textView.text
        // but here we use textView.attributedText
        // again, this will also wipe out any fonts and colors from the storyboard,
        // so remember to re-add them in the attrs dictionary above
        self.attributedText = attrString
    }
}

class EmojiTextField: UITextField {

       // required for iOS 13
       override var textInputContextIdentifier: String? { "" }

        override var textInputMode: UITextInputMode? {
            for mode in UITextInputMode.activeInputModes {
                if mode.primaryLanguage == "emoji" {
                    return mode
                }
            }
            return nil
        }

    override init(frame: CGRect) {
            super.init(frame: frame)

            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)

             commonInit()
        }

        func commonInit() {
            NotificationCenter.default.addObserver(self, selector: #selector(inputModeDidChange), name: UITextField.textDidChangeNotification, object: nil)
        }

        @objc func inputModeDidChange(_ notification: Notification) {
            guard isFirstResponder else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.reloadInputViews()
            }
        }
    }

extension UIView {
    func setCircularShadow() {
        self.layer.shadowColor = UIColor(red: 111/255, green: 113/255, blue: 121/255, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
       layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientSideMenuBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.45, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.45)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
       layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientProfileBack(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientTopBottom(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
       layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension Notification.Name {
    static let userData = Notification.Name("UserData")
}

extension UIViewController {
    
    func isConnection() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
    
    func embed(_ viewController: String, inView view11: UIView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: viewController) as UIViewController
        // add as a childviewcontroller
        addChild(controller)
         // Add the child's View as a subview
         view11.addSubview(controller.view)
         controller.view.frame = view11.bounds
         controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

         // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
    }
    
    func removeADDChildVC(vC: String, vieww: UIView) {
            if self.children.count > 0 {
                    let viewControllers: [UIViewController] = self.children
                    for viewContoller in viewControllers {
                        viewContoller.willMove(toParent: nil)
                        viewContoller.view.removeFromSuperview()
                        viewContoller.removeFromParent()
                    }
                }
            embed(vC, inView: vieww)
        }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension String {
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension UIViewController {
     func buildController(viewController: UIViewController) {
        // Create content and menu controllers
        let navigationController = UINavigationController(rootViewController: viewController)
        let leftMenuViewController = SideMenuVC()

        // Create sideMenuController
        let sideMenuViewController = AKSideMenu(contentViewController: navigationController,
                                                leftMenuViewController: leftMenuViewController,
                                                rightMenuViewController: leftMenuViewController)

         sideMenuViewController.menuPreferredStatusBarStyle = .lightContent
         sideMenuViewController.contentViewShadowColor = .black
         sideMenuViewController.contentViewShadowOffset = .zero
         sideMenuViewController.contentViewShadowOpacity = 0.6
         sideMenuViewController.contentViewShadowRadius = 12
         sideMenuViewController.contentViewShadowEnabled = true
         window?.rootViewController = sideMenuViewController
         window?.makeKeyAndVisible()
    }
    
    func rootViewController(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func tableViewNoData(text: String, textColor: UIColor, tableName: UITableView) {
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableName.bounds.size.width, height: tableName.bounds.size.height))
        noDataLabel.text             = text
        noDataLabel.textColor        = textColor
        noDataLabel.textAlignment    = .center
        tableName.backgroundView     = noDataLabel
        tableName.separatorStyle     = .none
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData: NSData = img.jpegData(compressionQuality: 0.50)! as NSData // UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    
    func showAlert(title: String?, message: String?, action1Name: String?, action2Name: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action1Name, style: .default, handler: nil))
        if action2Name != nil {
            alertController.addAction(UIAlertAction(title: action2Name, style: .default, handler: nil))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertWithCompletionOK(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okBtn)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithCompletion(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesBtn = UIAlertAction(title: "Yes", style: .default, handler: completion)
        let noBtn = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(yesBtn)
        alertController.addAction(noBtn)
        self.present(alertController, animated: true, completion: nil)
    }

    func setNavTitle(title: String?) {
        if tabBarController != nil {
            if title != nil {
                self.tabBarController?.navigationItem.titleView = nil
                self.tabBarController?.navigationItem.title = title
            } else {
                var view  = UIImageView(frame: CGRect(x: 0, y: 0, width: 54, height: 44))
                view = UIImageView(image: #imageLiteral(resourceName: "drupp logo"))
                view.clipsToBounds = true
                self.tabBarController?.navigationItem.titleView = view

                let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                navigationController?.navigationBar.titleTextAttributes = textAttributes
//                self.tabBarController?.navigationItem.titleView?.backgroundColor = UIColor.black
//                self.tabBarController?.navigationItem.titleView?.tintColor = UIColor.white
                self.tabBarController?.navigationItem.titleView?.contentMode = .center
            }
        } else {
            if title != nil {
                self.navigationItem.titleView = nil
                self.navigationItem.title = title
                self.navigationController?.navigationItem.titleView?.tintColor = UIColor.white
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            }
        }
    }
    func setNavigationBar(_ leftBarButton: String? = nil, rightBarButton: String?) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09019607843, green: 0.1254901961, blue: 0.2274509804, alpha: 1)
//        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        var leftBarButtonItem: UIBarButtonItem?
        let _: UIBarButtonItem?
//        let rightItem = UIBarButtonItem(title: "Emergency", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.navigateEmergency))
//        rightItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 14.0)!], for: UIControl.State.normal)
//        rightItem.setTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 0.0), for: UIBarMetrics.compact)
        // image symbol #imageLiteral(resourceName: "back")
        if leftBarButton == "back" {
            var view  = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            view = UIImageView(image: #imageLiteral(resourceName: "back (1)"))
            view.clipsToBounds = true
            leftBarButtonItem = UIBarButtonItem(image: view.image, style: .plain, target: self, action: #selector(self.back))


        //   rightBarButtonItem = rightItem
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        // Set right bar button so title view comes in center
       // navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func back() {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func editback() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pushController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func presentController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
    //    func popToTabController() {
    //        for controller in (navigationController?.viewControllers)! {
    //            if controller is TabsViewController {
    //                self.navigationController?.popToViewController(controller, animated: true)
    //            }
    //        }
    //    }
    
    func convertTimestampToDate(_ timestamp: Int, to format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func convertTimestampToDateUTC(_ timestamp: Int, to format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.string(from: date)
    }
    
    func getCurrentDateString() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: dateStr)
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    func openUrl(urlStr: String) {
        let url = URL(string: urlStr)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func isValidUsername(str: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^(?=\\S{3})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$", options: .caseInsensitive)
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.count)).count > 0 {return true}
        } catch {}
        return false
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidNumber(testValu: String) -> Bool {
        let phone_Regex = "^[0-9]{10,10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_Regex)
        let result = phoneTest.evaluate(with: testValu)
        return result
    }
    
    func isValidPassword(testPassword: String) -> Bool {
        // let password = testPassword.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,16}"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        let result = passwordCheck.evaluate(with: testPassword)
        return result
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}

extension UIView {
    func dropShadow2(view: UIView, opacity: Float) {
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowOpacity = opacity
        view.layer.borderWidth = 0
        view.layer.shadowColor = AppColors.gradientPoint2!.cgColor
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.3, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
//    func setCircularShadow() {
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 1, height: 1)
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 1
//        self.layer.cornerRadius = self.frame.width / 2
//        self.layer.cornerRadius = 30.0
//
//
//        // drop shadow
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 2
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//    }
    
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font!],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}

extension UISwitch {
    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension UIImageView {
    func changeTint(color: UIColor) {
        let templateImage =  self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIView {
    func setShadow(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
    }
    
}

extension String {
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
}

class UnderlinedLabel: UILabel {
override var text: String? {
    didSet {
        guard let text = text else { return }
        let textRange = (text as NSString).range(of: text)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
        }
    }
}

extension NSMutableAttributedString {
    // If no text is send, then the style will be applied to full text
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range: NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
    
    func setUnderlineWith(_ textToFind: String?, with color: UIColor) {
        let range: NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range!)
            addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range!)
        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
           
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter += 1
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

    func getAttributedString(arrayText: [String]?, arrayColors: [UIColor]?, arrayFonts: [UIFont]?) -> NSMutableAttributedString {

        let finalAttributedString = NSMutableAttributedString()

        for i in 0 ..< (arrayText?.count)! {

            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key: Any]))

            if i != 0 {

                finalAttributedString.append(NSAttributedString.init(string: " "))
            }

            finalAttributedString.append(attributedStr)
        }

        // add paragraph attribute
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.paragraphStyle: paragraph]
        finalAttributedString.addAttributes(attributes, range: NSRange(location: 0, length: finalAttributedString.length))

        return finalAttributedString
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date)) Years"   }
        if months(from: date)  > 0 { return "\(months(from: date)) Months"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) Weeks"   }
        if days(from: date)    > 0 { return "\(days(from: date)) Days"    }
        if hours(from: date)   > 0 { return "\(hours(from: date)) hrs"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date)) Min" }
        return ""
    }
    
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension UIView {
    func animShow() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                           animations: {
                            self.center.y -= self.bounds.height
                            self.layoutIfNeeded()
                           }, completion: nil)
            self.isHidden = false
        }
    func animHide() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                           animations: {
                            self.center.y += self.bounds.height
                            self.layoutIfNeeded()
                           }, completion: nil)
            self.isHidden = true
        }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

