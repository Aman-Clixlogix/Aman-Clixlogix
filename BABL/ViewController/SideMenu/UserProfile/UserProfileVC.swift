//
//  UserProfileVC.swift
//  BABL
//

import UIKit
import DropDown
import RealmSwift
import GooglePlaces
import SDWebImage

class UserProfileVC: UIViewController, UINavigationControllerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var viewdDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPronouns: UITextField!
    @IBOutlet weak var txtFB: UITextField!
    @IBOutlet weak var txtInsta: UITextField!
    @IBOutlet weak var txtTwitter: UITextField!
    @IBOutlet weak var txtLinkedin: UITextField!
    @IBOutlet weak var txtViewComment: UITextView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewPronouns: UIView!
    @IBOutlet weak var viewDescrip: UIView!
    @IBOutlet weak var viewFB: UIView!
    @IBOutlet weak var viewInsta: UIView!
    @IBOutlet weak var viewTwitter: UIView!
    @IBOutlet weak var viewLinkedin: UIView!
    @IBOutlet weak var viewSocialHandles: UIView!
    @IBOutlet weak var viewSocialFB: UIView!
    @IBOutlet weak var viewSocialInsta: UIView!
    @IBOutlet weak var viewSocialTwitter: UIView!
    @IBOutlet weak var viewSocialLinkedin: UIView!
    @IBOutlet weak var switchPrivateAcnt: UISwitch!
    
    // MARK: Properties
    var date: String?
    var gender: String?
    var firstName: String?
    var lastName: String?
    var fb: String?
    var insta: String?
    var twitter: String?
    var linkedin: String?
    var animBool: Bool = true
    var privateAccount: Bool = false
    let dropDown = DropDown()
    var imagePicker = UIImagePickerController()
    private var userProfileResponse = UserProfileViewModel()
    let realmData = try! Realm().objects(UserTable.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupByDefault()
        dropDownDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userProfileResponse.delegate = self
        userProfileResponse.getProfileAPI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupDesign()
    }

    // MARK: SetUp Design
    func setupDesign() {
        viewTop.setGradientProfileBack(colorTop: AppColors.profileGradient1!, colorBottom: AppColors.profileGradient2!)
    }
    
    // MARK: Setup logic By-Default
    func setupByDefault() {
        viewdDatePicker.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: self.view.frame.height)
        view.addSubview(viewdDatePicker)
        imagePicker.delegate = self
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.maximumDate = date
        txtViewComment.text = "Tell us something about your self..."
        txtViewComment.textColor = .lightGray
        self.viewSocialHandles.isHidden = true
        self.viewFB.isHidden = true
        self.viewInsta.isHidden = true
        self.viewTwitter.isHidden = true
        self.viewLinkedin.isHidden = true
        self.viewSocialFB.isHidden = true
        self.viewSocialInsta.isHidden = true
        self.viewSocialTwitter.isHidden = true
        self.viewSocialLinkedin.isHidden = true
    }
    
    // MARK: DatePicker Dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == viewdDatePicker {
            self.viewdDatePicker.animHide()
            self.animBool = true
        }
    }
    
    // MARK: DropDown Design
    func dropDownDesign() {
        dropDown.anchorView = viewPronouns
        dropDown.direction = .bottom
        dropDown.cornerRadius = 14
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Man", "Woman", "Others"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtPronouns.text = item
            if item == "Man" {
                self.gender = "M"
            } else if item == "Woman" {
                self.gender = "F"
            } else {
                self.gender = "Others"
            }
        }
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
    
    // MARK: Validations
    func isValidate() {
        if txtName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if txtUserName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if txtLocation.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankLocation.rawValue)
        } else if txtViewComment.textColor == .lightGray || txtViewComment.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankDescription.rawValue)
        } else {
            if txtName.text!.containsWhitespace {
                let fullName = txtName.text!
                    var components = fullName.components(separatedBy: " ")
                    if components.count > 0 {
                        self.firstName = components.removeFirst()
                        self.lastName = components.joined(separator: " ")
                    }
                self.userProfileResponse.profileSetupAPI(fullName: (self.firstName ?? "") + " " + (self.lastName ?? ""), email: self.txtEmail.text ?? "", location: self.txtLocation.text ?? "", pronouns: self.gender ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "", bio: self.txtViewComment.text ?? "", dob: self.date ?? "", fb: self.txtFB.text ?? "", twitter: self.txtTwitter.text ?? "", linkedin: self.txtLinkedin.text ?? "", insta: self.txtInsta.text ?? "", privateAccount: self.privateAccount)
            } else {
                Singleton.shared.showToast(text: AppErrorAndAlerts.invalidFullName.rawValue)
//                ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
//                self.signupViewModel.signupUser(userName: txtUserName.text ?? "", firstName: self.txtName.text ?? "", lastName: "", email: txtEmail.text ?? "", countryCode: self.countryCode, phone: self.txtPhone.text ?? "", password: txtPass.text ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "")
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func imgBtnClick(_ sender: UIButton) {
        addActionSheet()
    }
    
    @IBAction func dateBtnClick(_ sender: UIButton) {
        if self.animBool == true {
            self.viewdDatePicker.animShow()
            self.animBool = false
        }
    }
    
    @IBAction func dateOKBtnClick(_ sender: UIButton) {
        self.date = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd"))"
        self.txtDOB.text = self.date
        viewdDatePicker.animHide()
        self.animBool = true
    }
    
    @IBAction func datePickerChange(_ sender: UIButton) {
        self.date = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd"))"
        self.txtDOB.text = self.date
    }
    
    @IBAction func locationBtnClick(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
       // filter.type = .address
       // filter.country = "USA"
        autocompleteController.autocompleteFilter = filter
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func pronounsBtnClick(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func fbBtnClick(_ sender: UIButton) {
        let appURL = URL(string: "https://facebook.com/")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://facebook.com/")!
            application.open(webURL)
        }
    }
    
    @IBAction func instaBtnClick(_ sender: UIButton) {
        let appURL = URL(string: "https://instagram.com/")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://instagram.com/")!
            application.open(webURL)
        }
    }
    
    @IBAction func twitterBtnClick(_ sender: UIButton) {
        let appURL = URL(string: "https://twitter.com/")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://twitter.com/")!
            application.open(webURL)
        }
    }
    
    @IBAction func linkedinBtnClick(_ sender: UIButton) {
        let appURL = URL(string: "https://linkedin.com/")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://linkedin.com/")!
            application.open(webURL)
        }
    }
    
    @IBAction func fbCancelBtnClick(_ sender: UIButton) {
        self.viewSocialFB.isHidden = true
        self.viewFB.isHidden = false
        self.txtFB.text?.removeAll()
        if self.txtFB.text!.isEmpty && self.txtInsta.text!.isEmpty && self.txtTwitter.text!.isEmpty && self.txtLinkedin.text!.isEmpty {
            self.viewSocialHandles.isHidden = true
        }
    }
    
    @IBAction func instaCancelBtnClick(_ sender: UIButton) {
        self.viewSocialInsta.isHidden = true
        self.viewInsta.isHidden = false
        self.txtInsta.text?.removeAll()
        if self.txtFB.text!.isEmpty && self.txtInsta.text!.isEmpty && self.txtTwitter.text!.isEmpty && self.txtLinkedin.text!.isEmpty {
            self.viewSocialHandles.isHidden = true
        }
    }
    
    @IBAction func twitterCancelBtnClick(_ sender: UIButton) {
        self.viewSocialTwitter.isHidden = true
        self.viewTwitter.isHidden = false
        self.txtTwitter.text?.removeAll()
        if self.txtFB.text!.isEmpty && self.txtInsta.text!.isEmpty && self.txtTwitter.text!.isEmpty && self.txtLinkedin.text!.isEmpty {
            self.viewSocialHandles.isHidden = true
        }
    }
    
    @IBAction func linkedinCancelBtnClick(_ sender: UIButton) {
        self.viewSocialLinkedin.isHidden = true
        self.viewLinkedin.isHidden = false
        self.txtLinkedin.text?.removeAll()
        if self.txtFB.text!.isEmpty && self.txtInsta.text!.isEmpty && self.txtTwitter.text!.isEmpty && self.txtLinkedin.text!.isEmpty {
            self.viewSocialHandles.isHidden = true
        }
    }
    
    @IBAction func switchPrivateAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchPrivateAcnt.setOn(true, animated: true)
            self.privateAccount = true
            isValidate()
        } else {
            switchPrivateAcnt.setOn(false, animated: true)
            self.privateAccount = false
            isValidate()
        }
    }
    
    @IBAction func saveBtnClick(_ sender: UIButton) {
        isValidate()
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Image Picker Delegate
extension UserProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imgUser.image = img
        self.userProfileResponse.imageUploadAPI(image: img ?? UIImage(), email: self.txtEmail.text ?? "", pronouns: self.gender ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserProfileVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.txtLocation.text = "\(place.formattedAddress ?? "")"
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        Singleton.shared.showToast(text: error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UserProfileVC: UserProfileViewModelDelegate {
    func didReceiveUserProfileResponse(profileResponse: UpdateProfileModel) {
        print(profileResponse)
        let user = UserTable()
        user.firstName = self.firstName ?? ""
        user.lastName = self.lastName ?? ""
        user.email = profileResponse.email ?? ""
        user.profileId = profileResponse.id ?? ""
        user.token = realmData.first?.token ?? ""
        user.id = realmData.first?.id ?? 0
        user.profileId = realmData.first?.profileId ?? ""
        user.userName = profileResponse.username ?? ""
        user.userImage = profileResponse.profileImage ?? ""
        DataBaseHelper.shared.deleteUserDetails(userDetails: UserTable())
        DataBaseHelper.shared.saveUserDetails(userDetails: user)
        if profileResponse.privateAccount ?? false == true {
            switchPrivateAcnt.setOn(true, animated: true)
            self.privateAccount = true
        } else {
            switchPrivateAcnt.setOn(false, animated: true)
            self.privateAccount = false
        }
        if profileResponse.facebook?.isEmpty == false {
            viewFB.isHidden = true
            viewSocialFB.isHidden = false
        } else {
            viewFB.isHidden = false
            viewSocialFB.isHidden = true
        }
        if profileResponse.instagram?.isEmpty == false {
            viewInsta.isHidden = true
            viewSocialInsta.isHidden = false
        } else {
            viewInsta.isHidden = false
            viewSocialInsta.isHidden = true
        }
        if profileResponse.twitter?.isEmpty == false {
            viewTwitter.isHidden = true
            viewSocialTwitter.isHidden = false
        } else {
            viewTwitter.isHidden = false
            viewSocialTwitter.isHidden = true
        }
        if profileResponse.linkedIn?.isEmpty == false {
            viewLinkedin.isHidden = true
            viewSocialLinkedin.isHidden = false
        } else {
            viewLinkedin.isHidden = false
            viewSocialLinkedin.isHidden = true
        }
        if profileResponse.facebook!.isEmpty && profileResponse.instagram!.isEmpty && profileResponse.twitter!.isEmpty && profileResponse.linkedIn!.isEmpty {
            self.viewSocialHandles.isHidden = true
        } else {
            self.viewSocialHandles.isHidden = false
        }
        self.txtName.becomeFirstResponder()
        Singleton.shared.showToast(text: "Profile Update successfully!")
    }
    func didReceiveGetProfileResponse(profileResponse: UpdateProfileModel) {
        print(profileResponse)
        self.txtName.text = profileResponse.fullName ?? ""
        self.txtUserName.text = profileResponse.username ?? ""
        self.txtEmail.text = profileResponse.email ?? ""
        self.txtNumber.text = "\(profileResponse.phone_number ?? 0)"
        self.txtPronouns.text = profileResponse.pronouns ?? ""
        self.txtLocation.text = profileResponse.location ?? ""
        if (profileResponse.pronouns ?? "") == "M" {
            self.gender = "M"
            self.txtPronouns.text = "Man"
        } else if (profileResponse.pronouns ?? "") == "W" {
            self.gender = "F"
            self.txtPronouns.text = "Woman"
        } else {
            self.gender = "M"
        }
        if profileResponse.profileImage?.isEmpty == true {
            self.imgUser.setImage(string: (realmData.first?.firstName.capitalized ?? "") + " " + (realmData.first?.lastName.capitalized ?? ""), sizee: 30.0, backColor: AppColors.gradientPoint2!.cgColor, fontColor: .white)
        } else {
            self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgUser.sd_setImage(with: URL(string: profileResponse.profileImage ?? ""))
        }
        self.txtDOB.text = profileResponse.birthday ?? ""
        self.txtViewComment.text = profileResponse.bio ?? ""
        self.txtFB.text = profileResponse.facebook ?? ""
        self.txtInsta.text = profileResponse.instagram ?? ""
        self.txtTwitter.text = profileResponse.twitter ?? ""
        self.txtLinkedin.text = profileResponse.linkedIn ?? ""
        self.fb = profileResponse.facebook ?? ""
        self.insta = profileResponse.instagram ?? ""
        self.twitter = profileResponse.twitter ?? ""
        self.linkedin = profileResponse.linkedIn ?? ""
        self.viewName.layer.borderColor = UIColor.black.cgColor
        self.viewUserName.layer.borderColor = UIColor.black.cgColor
        self.viewEmail.layer.borderColor = UIColor.black.cgColor
        self.viewNumber.layer.borderColor = UIColor.black.cgColor
        self.viewLocation.layer.borderColor = UIColor.black.cgColor
        self.viewdDatePicker.layer.borderColor = UIColor.black.cgColor
        self.viewPronouns.layer.borderColor = UIColor.black.cgColor
        self.viewdDatePicker.layer.borderColor = UIColor.black.cgColor
        self.viewDescrip.layer.borderColor = UIColor.black.cgColor
        self.txtViewComment.textColor = .black
        if self.txtFB.text!.isEmpty && self.txtInsta.text!.isEmpty && self.txtTwitter.text!.isEmpty && self.txtLinkedin.text!.isEmpty {
            self.viewSocialHandles.isHidden = true
        } else {
            self.viewSocialHandles.isHidden = false
        }
        if profileResponse.facebook?.isEmpty == false {
            viewFB.isHidden = true
            viewSocialFB.isHidden = false
        } else {
            viewFB.isHidden = false
            viewSocialFB.isHidden = true
        }
        if profileResponse.instagram?.isEmpty == false {
            viewInsta.isHidden = true
            viewSocialInsta.isHidden = false
        } else {
            viewInsta.isHidden = false
            viewSocialInsta.isHidden = true
        }
        if profileResponse.twitter?.isEmpty == false {
            viewTwitter.isHidden = true
            viewSocialTwitter.isHidden = false
        } else {
            viewTwitter.isHidden = false
            viewSocialTwitter.isHidden = true
        }
        if profileResponse.linkedIn?.isEmpty == false {
            viewLinkedin.isHidden = true
            viewSocialLinkedin.isHidden = false
        } else {
            viewLinkedin.isHidden = false
            viewSocialLinkedin.isHidden = true
        }
    }
}

// MARK: Text View Delegate
extension UserProfileVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewDescrip.layer.borderColor = UIColor.green.cgColor
        if txtViewComment.textColor == .lightGray {
            txtViewComment.text = ""
            txtViewComment.textColor = .black
        } else {
            txtViewComment.text = "Tell us something about your self..."
            txtViewComment.textColor = .lightGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewComment.text!.isEmpty {
            txtViewComment.text = "Tell us something about your self..."
            txtViewComment.textColor = .lightGray
            viewDescrip.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            viewDescrip.layer.borderColor = UIColor.black.cgColor
        }
    }
}

// MARK: Text Field Delegate
extension UserProfileVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            viewEmail.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtName {
            viewName.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtUserName {
            viewUserName.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtLocation {
            viewLocation.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtFB {
            viewFB.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtInsta {
            viewInsta.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtTwitter {
            viewTwitter.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtLinkedin {
            viewLinkedin.layer.borderColor = UIColor.green.cgColor
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
        } else if textField == txtFB {
            if txtFB.text!.isEmpty {
                viewFB.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewFB.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtInsta {
            if txtInsta.text!.isEmpty {
                viewInsta.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewInsta.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtTwitter {
            if txtTwitter.text!.isEmpty {
                viewTwitter.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewTwitter.layer.borderColor = UIColor.black.cgColor
            }
        } else if textField == txtLinkedin {
            if txtLinkedin.text!.isEmpty {
                viewLinkedin.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewLinkedin.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
}
