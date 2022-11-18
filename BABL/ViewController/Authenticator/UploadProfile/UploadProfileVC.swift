//
//  UploadProfileVC.swift
//  BABL
//

import UIKit
import RealmSwift

class UploadProfileVC: UIViewController, UINavigationControllerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeader1: UILabel!
    @IBOutlet weak var lblHeader2: UILabel!
    
    // MARK: Properties
    var imagePicker = UIImagePickerController()
    var designType: Int = 1
    var email: String?
    var pronouns: String?
    private var uploadProfileResponse = UploadProfileViewModel()
    let realmData = try! Realm().objects(UserTable.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        uploadProfileResponse.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupDesign()
    }

    // MARK: Setup UI Design
    func setupDesign() {
        dashableView(view: viewDash)
        designableView(view: btnNext)
    }
    
    // MARK: Action Sheet for Image Picker
    func addActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let galleryOption = UIAlertAction(title: "Upload from photos", style: .default, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let cameraOption = UIAlertAction(title: "Take a new picture", style: .default, handler: { action in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cameraOption)
        alertController.addAction(galleryOption)
        alertController.addAction(cancelOption)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Button Action
    @IBAction func imgBtnClick(_ sender: UIButton) {
        if designType == 1 {
            addActionSheet()
        } else {
            designType = 1
            self.imgView.image = UIImage(named: "icon")
            self.imgView.contentMode = .center
            dashableView(view: viewDash)
            self.lblHeader1.text = "Upload Profile Pic"
            self.lblHeader2.isHidden = false
        }
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "InvitePeopleVC") as? InvitePeopleVC
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}

extension UploadProfileVC: UploadProfileViewModelDelegate {
    func didReceiveUploadProfileResponse(profileResponse: UpdateProfileModel) {
        let user = UserTable()
        user.firstName = realmData.first?.firstName ?? ""
        user.lastName = realmData.first?.lastName ?? ""
        user.email = realmData.first?.email ?? ""
        user.id = realmData.first?.id ?? 0
        user.token = realmData.first?.token ?? ""
        user.profileId = realmData.first?.profileId ?? ""
        user.userName = realmData.first?.userName ?? ""
        user.userImage = profileResponse.profileImage ?? ""
        DataBaseHelper.shared.deleteUserDetails(userDetails: UserTable())
        DataBaseHelper.shared.saveUserDetails(userDetails: user)
        Singleton.shared.showToast(text: "Profile Update successfully!")
    }
}

extension UploadProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imgView.image = img
        self.imgView.contentMode = .scaleAspectFill
        self.lblHeader1.text = "Photo Uploaded!"
        self.lblHeader2.isHidden = true
        self.uploadProfileResponse.profileSetupAPI(image: img ?? UIImage(), email: self.email ?? "", pronouns: self.pronouns ?? "")
        viewDash.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        self.dismiss(animated: true) {
            self.designType = 2
        }
    }
}
