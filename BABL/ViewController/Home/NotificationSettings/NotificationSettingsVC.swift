//
//  NotificationSettingsVC.swift
//  BABL
//

import UIKit

class NotificationSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
