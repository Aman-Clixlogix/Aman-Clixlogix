//
//  InvitePeopleVC.swift
//  BABL
//

import UIKit
import RealmSwift

class InvitePeopleVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var btnInvite: UIButton!
    let resultsData = try! Realm().objects(UserTable.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }

    // MARK: Setup UI Design
    func setupDesign() {
        designableView(view: btnInvite)
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteBtnClick(_ sender: UIButton) {
        let txt = "Please join BABL by invitation code: \(resultsData.first?.inviteCode ?? "")"
        let myWebsite = NSURL(string: "com.babl://invitation/\(resultsData.first?.inviteCode ?? "")")
        let shareAll = [txt, myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func skipBtnClick(_ sender: UIButton) {
        self.rootViewController(identifier: "RootVC")
    }

}
