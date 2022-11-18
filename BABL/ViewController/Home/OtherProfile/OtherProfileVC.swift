//
//  ProfileVC.swift
//  BABL
//

import UIKit

class OtherProfileVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var viewTxtView: UIView!
    @IBOutlet weak var tblViewBabl: UITableView!
    @IBOutlet weak var tblBablHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewConnect: UITableView!
    @IBOutlet weak var tblConnectHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }
    
    // MARK: SetUp Design
    func setupDesign() {
        gradientViewDesign()
        txtViewDesc.text = "Tell us something about your self..."
        txtViewDesc.textColor = .lightGray
        tblViewConnect.isHidden = true
        viewTop.setGradientProfileBack(colorTop: AppColors.profileGradient1!, colorBottom: AppColors.profileGradient2!)
        self.tblViewBabl.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tblViewConnect.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func gradientViewDesign() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColors.colorBackground!.withAlphaComponent(1.0).cgColor,
                                AppColors.colorBackground!.withAlphaComponent(0.8).cgColor,
                                AppColors.colorBackground!.withAlphaComponent(0.0).cgColor]
        gradientLayer.frame = viewBottom.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        viewBottom.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        self.tblBablHeight.constant = self.tblViewBabl.contentSize.height
        self.tblConnectHeight.constant = self.tblViewConnect.contentSize.height
    }
    
    // MARK: Button Actions
    @IBAction func segmentObj(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("0")
            self.tblViewConnect.isHidden = true
            self.tblViewBabl.isHidden = false
        } else {
            print("1")
            self.tblViewConnect.isHidden = false
            self.tblViewBabl.isHidden = true
        }
    }
    
    @IBAction func blockBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "OtherProfileBlockVC") as? OtherProfileBlockVC
        self.present(nVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OtherProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewBabl {
            return 6
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewBabl {
            let cell = tblViewBabl.dequeueReusableCell(withIdentifier: "OtherProfileBablCell", for: indexPath) as? OtherProfileBablCell
            return cell ?? UITableViewCell()
        } else {
            let cell = tblViewConnect.dequeueReusableCell(withIdentifier: "OtherProfileConnectionCell", for: indexPath) as? OtherProfileConnectionCell
            return cell ?? UITableViewCell()
        }
    }
}

extension OtherProfileVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewTxtView.layer.borderColor = UIColor.green.cgColor
        if txtViewDesc.textColor == .lightGray {
            txtViewDesc.text = ""
            txtViewDesc.textColor = .black
        } else {
            txtViewDesc.text = "Tell us something about your self..."
            txtViewDesc.textColor = .lightGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewDesc.text!.isEmpty {
            txtViewDesc.text = "Tell us something about your self..."
            txtViewDesc.textColor = .lightGray
            viewTxtView.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            viewTxtView.layer.borderColor = UIColor.black.cgColor
        }
    }
}

