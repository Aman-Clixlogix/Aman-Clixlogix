//
//  MySettingVC.swift
//  BABL
//

import UIKit

class MySettingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblSubscription: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblPrivacy: UILabel!
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var viewSubscription: UIView!
    @IBOutlet weak var viewContact: UIView!
    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var viewTerms: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: SetupUI Design
    func setupDesign(lblNotifColor: UIColor, lblSubsColor: UIColor, lblContColor: UIColor, lblPrivColor: UIColor, lblTerm: UIColor, viewNotify: UIColor, viewSubscr: UIColor, viewConta: UIColor, viewPriv: UIColor, viewTer: UIColor) {
        self.lblNotification.textColor = lblNotifColor
        self.lblSubscription.textColor = lblSubsColor
        self.lblContact.textColor = lblContColor
        self.lblPrivacy.textColor = lblPrivColor
        self.lblTerms.textColor = lblTerm
        self.viewNotification.backgroundColor = viewNotify
        self.viewSubscription.backgroundColor = viewSubscr
        self.viewContact.backgroundColor = viewConta
        self.viewPrivacy.backgroundColor = viewPriv
        self.viewTerms.backgroundColor = viewTer
    }

    // MARK: Button Actions
    @IBAction func btnClick(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.viewNotification.dropShadow2(view: self.viewNotification, opacity: 0.3)
            self.viewSubscription.dropShadow2(view: self.viewSubscription, opacity: 0.0)
            self.viewContact.dropShadow2(view: self.viewContact, opacity: 0.0)
            self.viewTerms.dropShadow2(view: self.viewTerms, opacity: 0.0)
            self.viewPrivacy.dropShadow2(view: self.viewPrivacy, opacity: 0.0)
            setupDesign(lblNotifColor: .black, lblSubsColor: AppColors.mySettingImgBack!, lblContColor: AppColors.mySettingImgBack!, lblPrivColor: AppColors.mySettingImgBack!, lblTerm: AppColors.mySettingImgBack!, viewNotify: AppColors.gradientPoint2!, viewSubscr: AppColors.mySettingImgBack!, viewConta: AppColors.mySettingImgBack!, viewPriv: AppColors.mySettingImgBack!, viewTer: AppColors.mySettingImgBack!)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationSettingsVC") as? NotificationSettingsVC
            self.present(nVC ?? UIViewController(), animated: true)
        case 2:
            self.viewSubscription.dropShadow2(view: self.viewSubscription, opacity: 0.3)
            self.viewNotification.dropShadow2(view: self.viewNotification, opacity: 0.0)
            self.viewContact.dropShadow2(view: self.viewContact, opacity: 0.0)
            self.viewTerms.dropShadow2(view: self.viewTerms, opacity: 0.0)
            self.viewPrivacy.dropShadow2(view: self.viewPrivacy, opacity: 0.0)
            setupDesign(lblNotifColor: AppColors.mySettingImgBack!, lblSubsColor: .black, lblContColor: AppColors.mySettingImgBack!, lblPrivColor: AppColors.mySettingImgBack!, lblTerm: AppColors.mySettingImgBack!, viewNotify: AppColors.mySettingImgBack!, viewSubscr: AppColors.gradientPoint2!, viewConta: AppColors.mySettingImgBack!, viewPriv: AppColors.mySettingImgBack!, viewTer: AppColors.mySettingImgBack!)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionPlanVC") as? SubscriptionPlanVC
            self.present(nVC ?? UIViewController(), animated: true)
        case 3:
            self.viewContact.dropShadow2(view: self.viewContact, opacity: 0.3)
            self.viewSubscription.dropShadow2(view: self.viewSubscription, opacity: 0.0)
            self.viewNotification.dropShadow2(view: self.viewNotification, opacity: 0.0)
            self.viewTerms.dropShadow2(view: self.viewTerms, opacity: 0.0)
            self.viewPrivacy.dropShadow2(view: self.viewPrivacy, opacity: 0.0)
            setupDesign(lblNotifColor: AppColors.mySettingImgBack!, lblSubsColor: AppColors.mySettingImgBack!, lblContColor: .black, lblPrivColor: AppColors.mySettingImgBack!, lblTerm: AppColors.mySettingImgBack!, viewNotify: AppColors.mySettingImgBack!, viewSubscr: AppColors.mySettingImgBack!, viewConta: AppColors.gradientPoint2!, viewPriv: AppColors.mySettingImgBack!, viewTer: AppColors.mySettingImgBack!)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as? ContactUsVC
            self.present(nVC ?? UIViewController(), animated: true)
        case 4:
            self.viewPrivacy.dropShadow2(view: self.viewPrivacy, opacity: 0.3)
            self.viewSubscription.dropShadow2(view: self.viewSubscription, opacity: 0.0)
            self.viewNotification.dropShadow2(view: self.viewNotification, opacity: 0.0)
            self.viewContact.dropShadow2(view: self.viewContact, opacity: 0.0)
            self.viewTerms.dropShadow2(view: self.viewTerms, opacity: 0.0)
            setupDesign(lblNotifColor: AppColors.mySettingImgBack!, lblSubsColor: AppColors.mySettingImgBack!, lblContColor: AppColors.mySettingImgBack!, lblPrivColor: .black, lblTerm: AppColors.mySettingImgBack!, viewNotify: AppColors.mySettingImgBack!, viewSubscr: AppColors.mySettingImgBack!, viewConta: AppColors.mySettingImgBack!, viewPriv: AppColors.gradientPoint2!, viewTer: AppColors.mySettingImgBack!)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC
            nVC?.screenType = 1
            self.present(nVC ?? UIViewController(), animated: true)
        case 5:
            self.viewTerms.dropShadow2(view: self.viewTerms, opacity: 0.3)
            self.viewSubscription.dropShadow2(view: self.viewSubscription, opacity: 0.0)
            self.viewNotification.dropShadow2(view: self.viewNotification, opacity: 0.0)
            self.viewContact.dropShadow2(view: self.viewContact, opacity: 0.0)
            self.viewPrivacy.dropShadow2(view: self.viewPrivacy, opacity: 0.0)
            setupDesign(lblNotifColor: AppColors.mySettingImgBack!, lblSubsColor: AppColors.mySettingImgBack!, lblContColor: AppColors.mySettingImgBack!, lblPrivColor: AppColors.mySettingImgBack!, lblTerm: .black, viewNotify: AppColors.mySettingImgBack!, viewSubscr: AppColors.mySettingImgBack!, viewConta: AppColors.mySettingImgBack!, viewPriv: AppColors.mySettingImgBack!, viewTer: AppColors.gradientPoint2!)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC
            nVC?.screenType = 2
            self.present(nVC ?? UIViewController(), animated: true)
        default:
            print("Default")
        }
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
