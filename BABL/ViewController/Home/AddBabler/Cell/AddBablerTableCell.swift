//
//  AddBablerTableCell.swift
//  BABL
//

import UIKit

class AddBablerTableCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgSelect: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
