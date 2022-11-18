//
//  ProfileSetUpVC.swift
//  BABL
//

import UIKit
import DropDown
import RealmSwift
import GooglePlaces
import CountryList

class ProfileSetUpVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewGradientTop: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
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
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewPronouns: UIView!
    @IBOutlet weak var viewDescrip: UIView!
    @IBOutlet weak var viewFB: UIView!
    @IBOutlet weak var viewInsta: UIView!
    @IBOutlet weak var viewTwitter: UIView!
    @IBOutlet weak var viewLinkedin: UIView!
    
    // MARK: Properties
    var date: String?
    var animBool: Bool = true
    let dropDown = DropDown()
    var gender: String?
    private var profileSetupViewModel = ProfileSetupViewModel()
    var countryList = CountryList()
    var countryCode: String!
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileSetupViewModel.delegate = self
        showDataFromDataBase()
        dropDownDesign()
        setupByDefault()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUIDesign()
    }
    
    // MARK: Design
    func setupUIDesign() {
        designableView(view: btnSubmit)
        viewGradientTop.setGradientBackground(colorTop: AppColors.gradientPoint1!, colorBottom: AppColors.gradientPoint2!)
    }
    
    // MARK: Setup logic By-Default
    func setupByDefault() {
        viewdDatePicker.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: self.view.frame.height)
        view.addSubview(viewdDatePicker)
        
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.maximumDate = date
        animBool = true

        txtViewComment.text = "Tell us something about your self..."
        txtViewComment.textColor = .lightGray
        
        self.btnCountryCode.setTitle("+\(self.countryCode ?? "")", for: .normal)
        self.txtPhone.text = self.phoneNumber ?? ""
        countryList.delegate = self
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
        dropDown.dataSource = ["Male", "Female", "Others"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtPronouns.text = item
            if item == "Male" {
                self.gender = "M"
            } else if item == "Female" {
                self.gender = "F"
            } else {
                self.gender = "Others"
            }
        }
    }
    
    // MARK: Show Data from Database
    func showDataFromDataBase() {
        let resultsData = try? Realm().objects(UserTable.self)
        self.txtName.text = resultsData?.first?.firstName
        if resultsData?.first?.lastName != "" {
            self.txtName.text = "\(resultsData?.first?.firstName ?? "") \(resultsData?.first?.lastName ?? "")"
        }
        self.txtEmail.text = resultsData?.first?.email
        self.txtUserName.text = resultsData?.first?.userName
    }
    
    // MARK: Validations
    func isValidate() {
        if txtName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if isValidUsername(str: txtName.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidUserName.rawValue)
        } else if txtName.text!.count > 60 {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidUserName.rawValue)
        } else if txtUserName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if txtEmail.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankEmailId.rawValue)
        } else if !isValidEmail(testStr: txtEmail.text!) {
            Singleton.shared.showToast(text: AppErrorAndAlerts.invalidEmailId.rawValue)
        } else if txtLocation.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankLocation.rawValue)
        } else if txtPronouns.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPronouns.rawValue)
        } else if txtDOB.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankDOB.rawValue)
        } else if txtViewComment.textColor == .lightGray || txtViewComment.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankDescription.rawValue)
        } else {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
            self.profileSetupViewModel.profileSetupAPI(userName: self.txtUserName.text ?? "", fullName: self.txtName.text ?? "", email: self.txtEmail.text ?? "", location: self.txtLocation.text ?? "", pronouns: self.gender ?? "", countryCode: self.countryCode, phone: self.txtPhone.text ?? "", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "", bio: self.txtViewComment.text ?? "", dob: self.txtDOB.text ?? "", fb: self.txtFB.text ?? "", twitter: self.txtTwitter.text ?? "", linkedin: self.txtLinkedin.text ?? "", insta: self.txtInsta.text ?? "")
        }
    }
    
    // MARK: Button Actions
    @IBAction func dateBtnClick(_ sender: UIButton) {
        if self.animBool == true {
            self.viewdDatePicker.animShow()
            self.animBool = false
        }
    }
    
    @IBAction func dateOKBtnClick(_ sender: UIButton) {
        self.date = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd"))"
        self.txtDOB.text = self.date
        viewdDatePicker.animHide()
        self.animBool = true
    }
    
    @IBAction func datePickerChange(_ sender: UIButton) {
        self.date = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd"))"
        self.txtDOB.text = self.date
    }
    
    @IBAction func countryBtnClick(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
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
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        isValidate()
    }
}

extension ProfileSetUpVC: ProfileSetupViewModelDelegate {
    func didReceiveProfileSetupResponse(profileResponse: ProfileSetupModel) {
        print(profileResponse.birthday ?? "")
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadProfileVC") as? UploadProfileVC
        nVC?.email = profileResponse.email ?? ""
        nVC?.pronouns = profileResponse.pronouns ?? ""
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}

extension ProfileSetUpVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        // print(country.countryCode)
        let strCode = "+" + country.phoneExtension
        self.btnCountryCode.setTitle(strCode, for: .normal)
        self.countryCode = country.phoneExtension
    }
}

extension ProfileSetUpVC: GMSAutocompleteViewControllerDelegate {
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

extension ProfileSetUpVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewDescrip.layer.borderColor = AppColors.gradientPoint2?.cgColor
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

extension ProfileSetUpVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            viewEmail.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtName {
            viewName.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtUserName {
            viewUserName.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtPhone {
            viewPhone.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtLocation {
            viewLocation.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtFB {
            viewFB.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtInsta {
            viewInsta.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtTwitter {
            viewTwitter.layer.borderColor = AppColors.gradientPoint2?.cgColor
        } else if textField == txtLinkedin {
            viewLinkedin.layer.borderColor = AppColors.gradientPoint2?.cgColor
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
        } else if textField == txtPhone {
            if txtPhone.text!.isEmpty {
                viewPhone.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewPhone.layer.borderColor = UIColor.black.cgColor
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


