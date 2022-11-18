//
//  StartBablVC.swift
//  BABL
//

import UIKit

class StartBablVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var txtViewName: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewName: UIView!
    
    // MARK: Properties
    let maxLength = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }
    
    // MARK: Setup Design
    func setupDesign() {
        lblCount.text = "Limit 100 characters"

        designableView(view: btnNext)
        
        txtViewName.text = "Please make sure your prompt should be clear and crisp..."
        txtViewName.textColor = .lightGray
    }
    
    // MARK: Button Actions
    @IBAction func cancelBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        if self.txtViewName.textColor == .lightGray {
            Singleton.shared.showToast(text: "Babl name field can't be empty")
        } else {
            let nVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBablerVC") as? AddBablerVC
            nVC?.bablName = self.txtViewName.text ?? ""
            self.present(nVC ?? UIViewController(), animated: true, completion: nil)
        }
    }
}

extension StartBablVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(maxLength - textView.text.count) characters remaining"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return txtViewName.text.count + (text.count - range.length) <= maxLength
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewName.layer.borderColor = AppColors.gradientPoint2!.cgColor
        if txtViewName.textColor == .lightGray {
            txtViewName.text = ""
            txtViewName.textColor = .black
        } else {
            txtViewName.text = "Tell us something about your self..."
            txtViewName.textColor = .lightGray
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewName.text!.isEmpty {
            txtViewName.text = "Tell us something about your self..."
            txtViewName.textColor = .lightGray
            viewName.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            viewName.layer.borderColor = UIColor.black.cgColor
        }
    }
}


