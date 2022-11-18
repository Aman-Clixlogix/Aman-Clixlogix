//
//  BablDetailsVC.swift
//  BABL
//

import UIKit
import SDWebImage

class BablDetailsVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewHeader: BABLHeaderView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAnonymize: UILabel!
    @IBOutlet weak var switchAnonymize: UISwitch!

    // MARK: Properties
    var anonymize: Bool = false
    var bablDetail = IdeaModel()
    private var bablDetailsViewModel = BablDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bablDetailsViewModel.delegate = self
        setupDesign()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Setup Design
    func setupDesign() {
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        if self.bablDetail.anonymize ?? false == true {
            switchAnonymize.setOn(true, animated: true)
            self.anonymize = true
            let str = "* Turning this OFF would show the display of the participants name with their ideas in a BABL group"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("OFF", with: AppColors.gradientPoint2!)
            self.lblAnonymize.attributedText = string
        } else {
            switchAnonymize.setOn(false, animated: true)
            self.anonymize = false
            let str = "* Turning this ON would hide the display of the participants name with their ideas in a BABL gxssa   roup"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("ON", with: AppColors.gradientPoint2!)
            self.lblAnonymize.attributedText = string
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeight.constant = self.tblView.contentSize.height
    }
    
    // MARK: Setup from API
    func setupData() {
        self.viewHeader.viewRightArrow.isHidden = true
        self.viewHeader.btnDetail.isUserInteractionEnabled = false
        viewHeader.txtTitle.text = self.bablDetail.welcomeDescription ?? ""
        for i in 0...(self.bablDetail.bablers?.count ?? 0)-1 {
            if self.bablDetail.owner ?? 0 == self.bablDetail.bablers?[i].participant?.id ?? 0 {
                viewHeader.imgUser.setImage(string: "\(self.bablDetail.bablers?[i].participant?.full_name?.capitalized ?? "")", sizee: 18, backColor: UIColor.white.cgColor, fontColor: AppColors.profileGradient2!)
                if !(self.bablDetail.bablers?[i].participant?.profile_image ?? "").isEmpty {
                    viewHeader.imgUser.sd_setImage(with: URL(string: self.bablDetail.bablers?[i].participant?.profile_image ?? ""))
                }
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAnonymizeAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchAnonymize.setOn(true, animated: true)
            self.anonymize = true
            let str = "* Turning this OFF would show the display of the participants name with their ideas in a BABL group"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("OFF", with: AppColors.gradientPoint2!)
            self.lblAnonymize.attributedText = string
            self.bablDetailsViewModel.updateBablAPI(bablID: self.bablDetail.id ?? "", anonymize: self.anonymize, bablers: [])
        } else {
            switchAnonymize.setOn(false, animated: true)
            self.anonymize = false
            let str = "* Turning this ON would hide the display of the participants name with their ideas in a BABL gxssa   roup"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("ON", with: AppColors.gradientPoint2!)
            self.lblAnonymize.attributedText = string
            self.bablDetailsViewModel.updateBablAPI(bablID: self.bablDetail.id ?? "", anonymize: self.anonymize, bablers: [])
        }
    }
    
    @IBAction func inviteBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBablerVC") as? AddBablerVC
        nVC?.bablers = self.bablDetail.bablers ?? [Babler]()
        nVC?.anonymize = self.anonymize
        nVC?.bablDetail = self.bablDetail
        nVC?.screenType = "Invite"
        nVC?.isModalInPresentation = true
        nVC?.updateBablerDelegate = self
        self.present(nVC ?? UIViewController(), animated: true)
    }
}

extension BablDetailsVC: UpdateBablerSendData {
    func didSendData(response: IdeaModel) {
        self.bablDetail = response
        self.tblView.reloadData()
    }
}

extension BablDetailsVC: BablDetailsViewModelDelegate {
    func didReceiveBablDetailsResponse(response: IdeaModel) {
        print(response)
    }
}

extension BablDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bablDetail.bablers?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "BablDetailTableCell", for: indexPath) as? BablDetailTableCell
        let data = self.bablDetail.bablers?[indexPath.row]
        cell?.lblName.text = data?.participant?.full_name?.capitalized ?? ""
        
        cell?.imgUser.setImage(string: data?.participant?.full_name?.capitalized ?? "", color: AppColors.gradientPoint2!, circular: true, stroke: false, sizee: 16, backColor: AppColors.gradientPoint2!.cgColor, fontColor: .white)
        
        
        if data?.participant?.profile_image?.isEmpty == false {
            cell?.imgUser.sd_setImage(with: URL(string: data?.participant?.profile_image ?? ""))
        }
        if data?.status ?? "" == "pending" {
            cell?.btnNotify.isHidden = false
            cell?.btnTick.setImage(UIImage(named: "Info colour icon"), for: .normal)
        } else if data?.status ?? "" == "accepted" {
            cell?.btnNotify.isHidden = true
            cell?.btnTick.setImage(UIImage(named: "green check colour icon"), for: .normal)
        } else {
            
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("De-select")
    }
}


