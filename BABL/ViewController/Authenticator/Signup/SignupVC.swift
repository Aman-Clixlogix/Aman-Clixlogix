//
//  SignupVC.swift
//  BABL
//

import UIKit
import RealmSwift
import CountryList

class SignupVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewGradientTop: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var btnCountryCode2: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var retxtPhone: UITextField!
    @IBOutlet weak var txtInvitation: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtRePass: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewRePhone: UIView!
    @IBOutlet weak var viewInvitation: UIView!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewRePass: UIView!
    @IBOutlet weak var lblTermsCondition: UILabel!
    @IBOutlet weak var lblLogin: UILabel!

    // MARK: Properties
    private var signupViewModel = SignupViewModel()
    var countryList = CountryList()
    var firstName: String?
    var lastName: String?
    var countryCode: String!
    var phoneType: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefault()
        tapGestureLogin()
        tapGesturetermsAndConditions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpDesign()
    }
    
    // MARK: Design
    func setUpDesign() {
        designableView(view: btnSignup)
        viewGradientTop.setGradientBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.gradientPoint2!)
    }
    
    // MARK: Set Default
    func setDefault() {
        signupViewModel.delegate = self
        self.btnCountryCode.setTitle("+91", for: .normal)
        self.countryCode = "91"
        countryList.delegate = self
    }
    
    // MARK: Terms and Condition Tap Gesture
    func tapGesturetermsAndConditions() {
        var textArray = [String]()
        var fontArray = [UIFont]()
        var colorArray = [UIColor]()
        textArray.append("By Selecting the checkbox, I agree to the ")
        textArray.append("Terms and Condition")
        textArray.append("of the BABL App.")
        fontArray.append(UIFont(name: "AvenirNextLTPro-Regular", size: 16) ?? UIFont())
        fontArray.append(UIFont(name: "AvenirNextLTPro-Regular", size: 16) ?? UIFont())
        fontArray.append(UIFont(name: "AvenirNextLTPro-Regular", size: 16) ?? UIFont())
        colorArray.append(UIColor.black)
        colorArray.append(AppColors.gradientPoint2!)
        colorArray.append(UIColor.black)
        self.lblTermsCondition.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.lblTermsCondition.isUserInteractionEnabled = true
        self.lblTermsCondition.numberOfLines = 0
        self.lblTermsCondition.translatesAutoresizingMaskIntoConstraints = false
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.lblTermsCondition.addGestureRecognizer(tapgesture)
    }
    
    func getAttributedString(arrayText: [String]?, arrayColors: [UIColor]?, arrayFonts: [UIFont]?) -> NSMutableAttributedString {
        let finalAttributedString = NSMutableAttributedString()
        for i in 0 ..< (arrayText?.count)! {
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key: Any]))
            if i == 1 {
                let attributess = [NSAttributedString.Key.foregroundColor: AppColors.gradientPoint2, NSAttributedString.Key.font: arrayFonts?[0]]
                let attributedStrr = (NSAttributedString.init(string: arrayText?[1] ?? "", attributes: attributess as [NSAttributedString.Key: Any]))
                let str = NSMutableAttributedString(attributedString: attributedStrr)
                str.setUnderlineWith("Terms and Condition", with: AppColors.gradientPoint2!)
                finalAttributedString.append(str)
            }
            if i != 0 {

                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            if i != 1 {
                finalAttributedString.append(attributedStr)
            }
        }
        // add paragraph attribute
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineSpacing = 2
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.paragraphStyle: paragraph]
        finalAttributedString.addAttributes(attributes, range: NSRange(location: 0, length: finalAttributedString.length))
        return finalAttributedString
    }
    
    func tapGestureLogin() {
        self.lblLogin.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLoginLbl(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.lblLogin.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedOnLoginLbl(_ gesture: UITapGestureRecognizer) {
        guard let text2 = self.lblLogin.text else { return }
        let loginRange = (text2 as NSString).range(of: "Login")
        if gesture.didTapAttributedTextInLabel(label: self.lblLogin, inRange: loginRange) {
            print("user tapped on login")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.lblTermsCondition.text else { return }
        let termsConditionsRange = (text as NSString).range(of: "Terms and Condition")
        if gesture.didTapAttributedTextInLabel(label: self.lblTermsCondition, inRange: termsConditionsRange) {
            print("user tapped on terms and conditions text")
            let pVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC
            pVC?.screenType = 22
            self.navigationController?.pushViewController(pVC ?? UIViewController(), animated: true)
        }
    }
    
    // MARK: Sign Up Button Action Function
    func signUpValidations() {
        if txtName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if txtUserName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if !isValidUsername(str: txtUserName.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidUserName.rawValue)
        } else if txtEmail.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankEmailId.rawValue)
        } else if txtPhone.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPhoneNo.rawValue)
        } else if !isValidNumber(testValu: txtPhone.text ?? "") {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidPhoneNo.rawValue)
        } else if retxtPhone.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankRePhoneNo.rawValue)
        } else if !isValidNumber(testValu: retxtPhone.text ?? "") {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidPhoneNo.rawValue)
        } else if txtPhone.text! != retxtPhone.text! {
            Singleton.shared.showToast(text: AppErrorAndAlerts.phoneNotMatching.rawValue)
        } else if btnCountryCode.titleLabel!.text! != btnCountryCode2.titleLabel!.text! {
            Singleton.shared.showToast(text: AppErrorAndAlerts.countryCodeNotMatching.rawValue)
        } else if !isValidEmail(testStr: txtEmail.text ?? "") {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidEmailId.rawValue)
        } else if txtPass.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPassword.rawValue)
        } else if !isValidPassword(testPassword: txtPass.text ?? "") {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidPassword.rawValue)
        } else if txtRePass.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankConfirmPassword.rawValue)
        } else if txtPass.text! != txtRePass.text! {
            Singleton.shared.showToast(text: AppErrorAndAlerts.passwordNotMatching.rawValue)
        } else if !btnCheckBox.isSelected {
            Singleton.shared.showToast(text: AppErrorAndAlerts.accpetTermsConditionError.rawValue)
        } else {
            if txtName.text!.containsWhitespace {
                let fullName = txtName.text!
                    var components = fullName.components(separatedBy: " ")
                    if components.count > 0 {
                        self.firstName = components.removeFirst()
                        self.lastName = components.joined(separator: " ")
                    }
                ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
                self.signupViewModel.signupUser(userName: txtUserName.text ?? "", firstName: self.firstName ?? "", lastName: self.lastName ?? "", email: txtEmail.text ?? "", countryCode: self.countryCode, phone: self.txtPhone.text ?? "", password: txtPass.text ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "")
            } else {
                Singleton.shared.showToast(text: AppErrorAndAlerts.invalidFullName.rawValue)
//                ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
//                self.signupViewModel.signupUser(userName: txtUserName.text ?? "", firstName: self.txtName.text ?? "", lastName: "", email: txtEmail.text ?? "", countryCode: self.countryCode, phone: self.txtPhone.text ?? "", password: txtPass.text ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "")
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func txtNameTxtField(_ sender: UITextField) {
        if sender.text!.containsWhitespace {
            txtUserName.text = txtName.text?.removingWhitespaces()
        } else {
            txtUserName.text = sender.text ?? ""
        }
    }
    
    @IBAction func btnCheckBoxClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupBtnClick(_ sender: UIButton) {
         signUpValidations()
    }
    
    @IBAction func countryBtnClick(_ sender: UIButton) {
        if sender.tag == 1 {
            self.phoneType = 1
        } else {
            self.phoneType = 2
        }
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func passBtnClick(_ sender: UIButton) {
        if sender.isSelected {
            txtPass.isSecureTextEntry = true
        } else {
            txtPass.isSecureTextEntry = false
        }
        sender.isSelected = !sender.isSelected
    }

    @IBAction func rePassBtnClick(_ sender: UIButton) {
        if sender.isSelected {
            txtRePass.isSecureTextEntry = true
        } else {
            txtRePass.isSecureTextEntry = false
        }
        sender.isSelected = !sender.isSelected
    }
}

extension SignupVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        // print(country.countryCode)
        let strCode = "+" + country.phoneExtension
        if self.phoneType == 1 {
            self.btnCountryCode.setTitle(strCode, for: .normal)
        } else {
            self.btnCountryCode2.setTitle(strCode, for: .normal)
        }
        self.countryCode = country.phoneExtension
    }
}

extension SignupVC: SignupViewModelDelegate {
    func didReceiveSignupResponse(signupResponse: SignupModel) {
        print(signupResponse.email ?? "")
        let user = UserTable()
        user.firstName = signupResponse.firstName ?? ""
        user.lastName = signupResponse.lastName ?? ""
        user.email = signupResponse.email ?? ""
        user.id = signupResponse.id ?? 0
        user.token = signupResponse.token ?? ""
        user.profileId = signupResponse.profileID ?? ""
        user.userName = signupResponse.username ?? ""
        
        DataBaseHelper.shared.deleteUserDetails(userDetails: UserTable())
        DataBaseHelper.shared.saveUserDetails(userDetails: user)
        
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSetUpVC") as? ProfileSetUpVC
        nVC?.countryCode = self.countryCode
        nVC?.phoneNumber = self.txtPhone.text ?? ""
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}

extension SignupVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            viewEmail.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtPass {
            viewPass.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtName {
            viewName.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtUserName {
            viewUserName.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtPhone {
            viewPhone.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == retxtPhone {
            viewRePhone.layer.borderColor = AppColors.gradientPoint2?.cgColor
        }else if textField == txtInvitation {
            viewInvitation.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtRePass {
            viewRePass.layer.borderColor = AppColors.gradientPoint2?.cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            if txtEmail.text!.isEmpty {
                viewEmail.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewEmail.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtPass {
            if txtPass.text!.isEmpty {
                viewPass.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewPass.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtName {
            if txtName.text!.isEmpty {
                viewName.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewName.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtUserName {
            if txtUserName.text!.isEmpty {
                viewUserName.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewUserName.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtPhone {
            if txtPhone.text!.isEmpty {
                viewPhone.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewPhone.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == retxtPhone {
            if retxtPhone.text!.isEmpty {
                viewRePhone.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewRePhone.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtInvitation {
            if txtInvitation.text!.isEmpty {
                viewInvitation.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewInvitation.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtRePass {
            if txtRePass.text!.isEmpty {
                viewRePass.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewRePass.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
}

