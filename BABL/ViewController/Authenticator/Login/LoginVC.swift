//
//  ViewController.swift
//  BABL
//

import UIKit
import RealmSwift
import ProgressHUD

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewGradientTop: UIView!
    @IBOutlet weak var lblNewUser: UILabel!
    
    // MARK: Properties
    private var loginViewModel = LoginViewModel()
    let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
        signUpBtn()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpDesign()
    }

    // MARK: Design
    func setUpDesign() {
        designableView(view: btnLogin)
        viewGradientTop.setGradientBackground(colorTop: AppColors.gradientPoint2!, colorBottom: AppColors.gradientPoint1!)
        viewEmail.layer.borderColor = UIColor.lightGray.cgColor
        viewPassword.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: SignUp Attribute Click
    func signUpBtn() {
        self.lblNewUser.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.lblNewUser.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.lblNewUser.text else { return }
        let newUser = (text as NSString).range(of: "Sign up")
        if gesture.didTapAttributedTextInLabel(label: self.lblNewUser, inRange: newUser) {
            print("Sign Up")
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
            self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
        }
    }

    // MARK: Sign Up Button Action Function
    func signinValidation() {
        if txtEmail.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankEmailId.rawValue)
        } else if !isValidEmail(testStr: txtEmail.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidPassword.rawValue)
        } else if txtPassword.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPassword.rawValue)
        } else {
          //  ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
            
            self.loginViewModel.loginUser(email: txtEmail.text ?? "", password: txtPassword.text ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "", view: self.view) { response in
                ProgressHUD.dismiss()
              //  ActivityIndicator.hide()
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func signUpClick(_ sender: UIButton) {
        signinValidation()
    }
    
    @IBAction func forgotPassBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func passwordHiddClick(_ sender: UIButton) {
        if sender.isSelected {
            txtPassword.isSecureTextEntry = true
        } else {
            txtPassword.isSecureTextEntry = false
        }
        sender.isSelected = !sender.isSelected
    }
}

extension LoginVC: LoginViewModelDelegate {
    func didReceiveLoginResponse(loginResponse: LoginModel) {
        print(loginResponse.email ?? "")
        print(loginResponse.token ?? "")
        
      /*  let user = UserTable(firstName: loginResponse.firstName ?? "", lastName: loginResponse.lastName ?? "", email: loginResponse.email ?? "", id: loginResponse.userID ?? 0, token: loginResponse.token ?? "", profileId: loginResponse.profileID ?? "", invitecode: loginResponse.inviteCode ?? "", userimage: loginResponse.profileImage ?? "") */
        let resultsData = try? Realm().objects(UserTable.self)
        let user = UserTable()
        user.firstName = loginResponse.firstName ?? ""
        user.lastName = loginResponse.lastName ?? ""
        user.email = loginResponse.email ?? ""
        user.id = loginResponse.userID ?? 0
        user.token = loginResponse.token ?? ""
        user.profileId = loginResponse.profileID ?? ""
        user.inviteCode = loginResponse.inviteCode ?? ""
        user.userImage = loginResponse.profileImage ?? ""
        UserDefaults.standard.removeObject(forKey: UD_TOKEN)
        UserDefaults.standard.set(loginResponse.token ?? "", forKey: UD_TOKEN)

        DataBaseHelper.shared.deleteUserDetails(userDetails: user)
        DataBaseHelper.shared.saveUserDetails(userDetails: user)
        self.rootViewController(identifier: "RootVC")
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            viewEmail.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtPassword {
            viewPassword.layer.borderColor = AppColors.gradientPoint2?.cgColor
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
        } else if textField == txtPassword {
            if txtPassword.text!.isEmpty {
                viewPassword.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewPassword.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
}


