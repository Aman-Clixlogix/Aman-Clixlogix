//
//  OtherProfileBlockVC.swift
//  BABL
//

import UIKit

class OtherProfileBlockVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: ViewController Dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == self.view {
            self.dismiss(animated: true)
        }
    }
}
