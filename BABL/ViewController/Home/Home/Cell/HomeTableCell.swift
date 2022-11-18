//
//  HomeTableCell.swift
//  BABL
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblMembers: UnderlinedLabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UIButton!
    @IBOutlet weak var lblParticipants: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
