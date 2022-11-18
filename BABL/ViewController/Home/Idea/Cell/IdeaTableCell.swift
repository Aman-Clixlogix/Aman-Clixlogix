//
//  IdeaTableCell.swift
//  BABL
//

import UIKit

class IdeaTableCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var txtViewBabl: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
