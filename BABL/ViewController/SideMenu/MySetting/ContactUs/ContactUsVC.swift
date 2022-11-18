//
//  ContactUsVC.swift
//  BABL
//

import UIKit
import DropDown

class ContactUsVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var viewTxtView: UIView!
    @IBOutlet weak var viewSubject: UIView!
    @IBOutlet weak var btnSubmit: UIButton!

    // MARK: Properties
    private var contactUsViewModel = ContactUsViewModel()
    let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactUsViewModel.delegate = self
        setupByDefault()
      //  dropDownDesign()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupDesign()
    }
    
    // MARK: Setup UI Design
    func setupDesign() {
        designableView(view: btnSubmit)
    }
    
    // MARK: Setup Default
    func setupByDefault() {
        txtViewDesc.text = "Tell us something about your query..."
        txtViewDesc.textColor = .lightGray
    }
    
    // MARK: DropDown Design
    func dropDownDesign() {
        dropDown.anchorView = viewSubject
        dropDown.direction = .bottom
        dropDown.cornerRadius = 14
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Man", "Woman", "Others"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtSubject.text = item
        }
    }
    
    // MARK: Button Actions
    @IBAction func subjectBtnClick(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        if txtName.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankUserName.rawValue)
        } else if txtSubject.text!.isEmpty {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankSubject.rawValue)
        } else if txtViewDesc.textColor == .lightGray {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankDescription.rawValue)
        } else {
            self.contactUsViewModel.methodForAPI(fullName: self.txtName.text ?? "", subject: self.txtSubject.text ?? "", description: self.txtViewDesc.text)
        }
    }
}

extension ContactUsVC: ContactUsViewModelDelegate {
    func didReceiveContactUsResponse(response: ContactUsModel) {
        print(response)
        self.showAlertWithCompletionOK(title: AppErrorAndAlerts.appName.rawValue, message: "Thanks for contacting us! will get back to you shortly.") { UIAlertAction in
            self.txtName.text?.removeAll()
            self.txtUserName.text?.removeAll()
            self.txtSubject.text?.removeAll()
            self.txtViewDesc.text = "Tell us something about your query..."
            self.txtViewDesc.textColor = .lightGray
            self.viewUserName.layer.borderColor = UIColor.lightGray.cgColor
            self.viewSubject.layer.borderColor = UIColor.lightGray.cgColor
            self.txtViewDesc.layer.borderColor = UIColor.lightGray.cgColor
            self.txtName.becomeFirstResponder()
            
        }
    }
}

extension ContactUsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewTxtView.layer.borderColor = UIColor.green.cgColor
        if txtViewDesc.textColor == .lightGray {
            txtViewDesc.text = ""
            txtViewDesc.textColor = .black
        } else {
            txtViewDesc.text = "Tell us something about your query..."
            txtViewDesc.textColor = .lightGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewDesc.text!.isEmpty {
            txtViewDesc.text = "Tell us something about your query..."
            txtViewDesc.textColor = .lightGray
            viewTxtView.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            viewTxtView.layer.borderColor = UIColor.black.cgColor
        }
    }
}

extension ContactUsVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            viewName.layer.borderColor = UIColor.green.cgColor
        } else if textField == txtUserName {
            viewUserName.layer.borderColor = UIColor.green.cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
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
        }
        return true
    }
}
