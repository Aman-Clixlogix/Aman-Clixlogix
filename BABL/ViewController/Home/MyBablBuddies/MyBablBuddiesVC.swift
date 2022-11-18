//
//  MyBablBuddiesVC.swift
//  BABL
//

import UIKit

class MyBablBuddiesVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: Search Box
extension MyBablBuddiesVC: UITextFieldDelegate {
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSearch {
            viewSearch.layer.borderColor = UIColor.green.cgColor
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtSearch {
            if txtSearch.text!.isEmpty {
                viewSearch.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewSearch.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
}

// MARK: Table View
extension MyBablBuddiesVC: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MyBablBuddiesTableCell", for: indexPath) as? MyBablBuddiesTableCell
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("De-select")
    }
}



