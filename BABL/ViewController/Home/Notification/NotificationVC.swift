//
//  NotificationVC.swift
//  BABL
//

import UIKit

class NotificationVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as? NotificationTableCell
        let str = "BABL \"Where can I hangout...\" Is in Ideation"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let string = NSMutableAttributedString(string: trimmedString)
        string.setColorForText("Ideation", with: AppColors.gradientPoint2!)
        cell?.lblDetail.attributedText = string
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
