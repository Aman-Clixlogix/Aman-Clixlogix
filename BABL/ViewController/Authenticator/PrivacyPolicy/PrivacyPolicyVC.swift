//
//  PrivacyPolicyVC.swift
//  BABL
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {
    
    // MARK: IBOUtlets
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var lblUpdate: UILabel!
    @IBOutlet weak var txtViewDesc: UITextView!
    
    // MARK: Properties
    var screenType: Int = 1
    private var privacyPolicyModel = PrivacyPolicyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }
    
    // MARK: Setup Design
    func setupDesign() {
        self.apiCall()
        if screenType == 1 {
            self.lblHead.text = "Privacy Policy"
        } else if screenType == 2 || screenType == 22 {
            self.lblHead.text = "Terms & Conditions"
        }
    }
    
    func apiCall() {
        if screenType == 1 {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint1!)
            privacyPolicyModel.delegate = self
            privacyPolicyModel.privacyPolicyAPI(api: UrlName.privacyPolicy)
        } else {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint1!)
            privacyPolicyModel.delegate = self
            privacyPolicyModel.privacyPolicyAPI(api: UrlName.termsConditions)
        }
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        if screenType == 22 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

extension PrivacyPolicyVC: PrivacyPolicyViewModelDelegate {
    func didReceivePrivacyPolicyResponse(response: PrivacyPolicyModel) {
        self.txtViewDesc.text = response.content ?? ""
        self.lblUpdate.text = "Updated \(utcToLocal(dateStr: response.updatedAt ?? "") ?? "")"
    }
}
