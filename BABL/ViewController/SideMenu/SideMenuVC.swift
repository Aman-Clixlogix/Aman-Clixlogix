//
//  SideMenuVC.swift
//  BABL
//

import UIKit
import AKSideMenu
import RealmSwift
import SDWebImage

class SideMenuVC: UIViewController {
    
    // MARK: IBOutelts
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var btnMyProfile: UIButton!
    @IBOutlet weak var btnMyBabl: UIButton!
    @IBOutlet weak var btnMyBablBuddies: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var imgDrop: UIImageView!
    
    @IBOutlet weak var btnLogout: UIButton!
    
    // MARK: Properties
    private var logoutModel = LogoutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuViewController?.delegate = self
        self.logoutModel.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDataFromDataBase()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupDesign()
    }
    
    // MARK: Setup Design
    func setupDesign() {
        self.viewBack.setGradientBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.sideMenuBottomGradient!)
        designableView(view: btnLogout)
    }
    
    // MARK: Show Data from Database
    func showDataFromDataBase() {
        let resultsData = try? Realm().objects(UserTable.self)
        self.lblName.text = resultsData?.first?.firstName
        if resultsData?.first?.lastName != "" {
            self.lblName.text = "\(resultsData?.first?.firstName.capitalized ?? "") \(resultsData?.first?.lastName.capitalized ?? "")"
        }
        self.lblUsername.text = resultsData?.first?.email
        if ((resultsData?.first?.userImage ?? "") == "") {
            self.imgUser.setImage(string: "\(resultsData?.first?.firstName ?? "") \(resultsData?.first?.lastName ?? "")", color: AppColors.gradientPoint2!, circular: false, stroke: false, sizee: 20, backColor: AppColors.gradientPoint2!.cgColor, fontColor: UIColor.white)
        } else {
            self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgUser.sd_setImage(with: URL(string: resultsData?.first?.userImage ?? ""))
        }
    }
    
    // MARK: Button Actions
    @IBAction func sideOptionBtnClick(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if (self.view2.layer.sublayers?.count ?? 0) > 1 {
                self.view2.layer.sublayers?.remove(at: 0)
            }
            if (self.view3.layer.sublayers?.count ?? 0) > 1 {
                self.view3.layer.sublayers?.remove(at: 0)
            }
            if (self.view4.layer.sublayers?.count ?? 0) > 1 {
                self.view4.layer.sublayers?.remove(at: 0)
            }
            self.view1.setGradientSideMenuBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.sideMenuBottomGradient!)
            self.view1.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            self.btnMyProfile.tintColor = .white
            self.btnMyBabl.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnMyBablBuddies.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnSettings.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC
            self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
        case 2:
            if (self.view1.layer.sublayers?.count ?? 0) > 1 {
                self.view1.layer.sublayers?.remove(at: 0)
            }
            if (self.view3.layer.sublayers?.count ?? 0) > 1 {
                self.view3.layer.sublayers?.remove(at: 0)
            }
            if (self.view4.layer.sublayers?.count ?? 0) > 1 {
                self.view4.layer.sublayers?.remove(at: 0)
            }
            self.view2.setGradientSideMenuBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.sideMenuBottomGradient!)
            self.view2.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            self.btnMyBabl.tintColor = .white
            self.btnMyProfile.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnMyBablBuddies.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnSettings.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
        case 3:
            if (self.view2.layer.sublayers?.count ?? 0) > 1 {
                self.view2.layer.sublayers?.remove(at: 0)
            }
            if (self.view1.layer.sublayers?.count ?? 0) > 1 {
                self.view1.layer.sublayers?.remove(at: 0)
            }
            if (self.view4.layer.sublayers?.count ?? 0) > 1 {
                self.view4.layer.sublayers?.remove(at: 0)
            }
            self.view3.setGradientSideMenuBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.sideMenuBottomGradient!)
            self.view3.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            self.btnMyBablBuddies.tintColor = .white
            self.btnMyProfile.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnMyBabl.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnSettings.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "MyBablBuddiesVC") as? MyBablBuddiesVC
            self.navigationController?.present(nVC ?? UIViewController(), animated: true)
        case 4:
            if (self.view2.layer.sublayers?.count ?? 0) > 1 {
                self.view2.layer.sublayers?.remove(at: 0)
            }
            if (self.view1.layer.sublayers?.count ?? 0) > 1 {
                self.view1.layer.sublayers?.remove(at: 0)
            }
            if (self.view3.layer.sublayers?.count ?? 0) > 1 {
                self.view3.layer.sublayers?.remove(at: 0)
            }
            self.view4.setGradientSideMenuBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.sideMenuBottomGradient!)
            self.view4.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            self.btnSettings.tintColor = .white
            self.btnMyProfile.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnMyBabl.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            self.btnMyBablBuddies.tintColor = #colorLiteral(red: 0.1033779457, green: 0.4816052914, blue: 0.4564409852, alpha: 1)
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "MySettingVC") as? MySettingVC
            nVC?.isModalInPresentation = true
            self.present(nVC ?? UIViewController(), animated: true)
        case 5:
            self.sideMenuViewController?.hideMenuViewController()
        case 6:
            UserDefaults.standard.removeObject(forKey: UD_TOKEN)
            let user = UserTable()
            DataBaseHelper.shared.deleteUserDetails(userDetails: user)
            self.rootViewController(identifier: "RootVC")
           // self.logoutModel.logoutAPI(api: UrlName.logout)
        default:
            print("Default")
        }
    }
}

extension SideMenuVC: LogoutViewModelDelegate {
    func didReceiveLogoutResponse(response: LogoutModel) {
        UserDefaults.standard.removeObject(forKey: UD_TOKEN)
        let user = UserTable()
        DataBaseHelper.shared.deleteUserDetails(userDetails: user)
        self.rootViewController(identifier: "RootVC")
    }
}

// MARK: - <AKSideMenuDelegate>
extension SideMenuVC: AKSideMenuDelegate {
    public func sideMenu(_ sideMenu: AKSideMenu, willShowMenuViewController menuViewController: UIViewController) {
        debugPrint("willShowMenuViewController")
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didShowMenuViewController menuViewController: UIViewController) {
        debugPrint("didShowMenuViewController")
    }

    public func sideMenu(_ sideMenu: AKSideMenu, willHideMenuViewController menuViewController: UIViewController) {
        debugPrint("willHideMenuViewController")
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didHideMenuViewController menuViewController: UIViewController) {
        if (self.view2.layer.sublayers?.count ?? 0) > 1 {
            self.view2.layer.sublayers?.remove(at: 0)
        }
        if (self.view1.layer.sublayers?.count ?? 0) > 1 {
            self.view1.layer.sublayers?.remove(at: 0)
        }
        if (self.view3.layer.sublayers?.count ?? 0) > 1 {
            self.view3.layer.sublayers?.remove(at: 0)
        }
        if (self.view4.layer.sublayers?.count ?? 0) > 1 {
            self.view4.layer.sublayers?.remove(at: 0)
        }
        debugPrint("didHideMenuViewController")
    }
}
