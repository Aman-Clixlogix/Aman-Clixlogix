//
//  PasswordUpdateVC.swift
//  BABL
//

import UIKit

class PasswordUpdateVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var viewGradientTop: UIView!
    @IBOutlet weak var btnResetPass: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtRePass: UITextField!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewRePass: UIView!
    
    // MARK: Properties
    var token: String?
    var screentype: String?
    private var passwordUpdateResponse = PasswordUpdateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordUpdateResponse.delegate = self
        setUpDesign()
    }
    
    // MARK: Design
    func setUpDesign() {
        designableView(view: btnResetPass)
        viewGradientTop.setGradientBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.gradientPoint2!)
    }
    
    // MARK: Password Validation
    func isValidate() {
        if txtPass.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPassword.rawValue)
        } else if !isValidPassword(testPassword: txtPass.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidPassword.rawValue)
        } else if txtRePass.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankConfirmPassword.rawValue)
        } else if txtPass.text! != txtRePass.text! {
            Singleton.shared.showToast(text: AppErrorAndAlerts.passwordNotMatching.rawValue)
        } else {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
            self.passwordUpdateResponse.passwordUpdateAPI(password: self.txtPass.text ?? "", token: self.token ?? "")
        }
    }

    // MARK: Button Actions
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
    
    @IBAction func resetBtnClick(_ sender: UIButton) {
        isValidate()
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.rootViewController(identifier: "loginvc")
    }
}

extension PasswordUpdateVC: PasswordUpdateViewModelDelegate {
    func didReceivePasswordUpdateResponse(response: String) {
        self.showAlertWithCompletionOK(title: AppErrorAndAlerts.appName.rawValue, message: AppErrorAndAlerts.passwordChangeSuccessful.rawValue) { UIAlertAction in
            self.rootViewController(identifier: "loginvc")
        }
    }
}

extension PasswordUpdateVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtPass {
            viewPass.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtRePass {
            viewRePass.layer.borderColor = AppColors.gradientPoint2?.cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtPass {
            if txtPass.text!.isEmpty {
                viewPass.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewPass.layer.borderColor = UIColor.black.cgColor
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

