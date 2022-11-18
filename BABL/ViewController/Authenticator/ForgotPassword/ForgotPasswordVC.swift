//
//  ForgotPasswordVC.swift
//  BABL
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewGradientTop: UIView!
    @IBOutlet weak var btnSendEmail: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    
    // MARK: Properties
    private var forgotPasswordModel = ForgotPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpDesign()
    }
    
    // MARK: Design
    func setUpDesign() {
        designableView(view: btnSendEmail)
        viewGradientTop.setGradientBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.gradientPoint2!)
    }
    
    // MARK: Validations
    func isValidate() {
        if txtEmail.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankEmailId.rawValue)
        } else if !isValidEmail(testStr: txtEmail.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidEmailId.rawValue)
        } else {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
            self.forgotPasswordModel.forgotPasswordAPI(email: self.txtEmail.text ?? "")
        }
    }
    
    // MARK: Button Actions
    @IBAction func sendEmailBtnClick(_ sender: UIButton) {
        isValidate()
    }
    
    @IBAction func btnBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordVC: ForgotPasswordViewModelDelegate {
    func didReceiveForgotPasswordResponse(response: String) {
        self.showAlertWithCompletionOK(title: AppErrorAndAlerts.appName.rawValue, message: response)
        self.txtEmail.text = ""
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            viewEmail.layer.borderColor = AppColors.gradientPoint2?.cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            if !txtEmail.text!.isEmpty {
                viewEmail.layer.borderColor = UIColor.black.cgColor
            } else {
            }
        }
        return true
    }
}

