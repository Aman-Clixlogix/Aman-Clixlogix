//
//  NotificationTableCell.swift
//  BABL
//

import UIKit

class NotificationTableCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewAccepDecline: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
