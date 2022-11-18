//
//  BablDetailTableCell.swift
//  BABL
//

import UIKit

class BablDetailTableCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnTick: UIButton!
    @IBOutlet weak var btnNotify: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
