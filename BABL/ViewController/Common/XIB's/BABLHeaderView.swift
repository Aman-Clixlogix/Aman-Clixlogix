//
//  BABLHeaderView.swift
//  BABL
//

import UIKit

class BABLHeaderView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var viewRightArrow: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("BABLHeaderView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
