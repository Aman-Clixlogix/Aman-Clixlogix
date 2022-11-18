//
//  IdeaVC.swift
//  BABL
//
//

import UIKit

class IdeaVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var viewHeader: BABLHeaderView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var tblViewIdea: UITableView!
    @IBOutlet weak var tblViewIdeaHeight: NSLayoutConstraint!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var viewIdea: UIView!
    @IBOutlet weak var tblViewComment: UITableView!
    @IBOutlet weak var tblViewCommentHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Properties
    private var ideaViewModel = IdeaViewModel()
    var bablDetail = IdeaModel()
    var id: String?
    var status: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        ideaViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bablDetailApiCall()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientViewDesign()
    }
    
    // MARK: Setup Design
    func setupDesign() {
        self.tblViewIdea.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tblViewComment.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        viewComment.isHidden = true
        tblViewIdea.isHidden = true
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewIdeaHeight.constant = self.tblViewIdea.contentSize.height
        self.tblViewCommentHeight.constant = self.tblViewComment.contentSize.height
    }

    func gradientViewDesign() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColors.colorBackground!.withAlphaComponent(1.0).cgColor,
                                AppColors.colorBackground!.withAlphaComponent(0.8).cgColor,
                                AppColors.colorBackground!.withAlphaComponent(0.0).cgColor]
        gradientLayer.frame = viewBottom.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        viewBottom.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: API Call
    func bablDetailApiCall() {
        ideaViewModel.ideaAPI(id: id ?? "")
    }
    
    // MARK: Button Actions
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomViewBtnClick(_ sender: UIButton) {
        UIView.transition(with: viewIdea, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.viewIdea.isHidden = false
            self.viewComment.isHidden = true
        })
    }
}

extension IdeaVC: IdeaViewModelDelegate {
    func didReceiveIdeaResponse(response: IdeaModel) {
        print(response)
        self.bablDetail = response
        for i in 0...(self.bablDetail.bablers?.count ?? 0)-1 {
            if self.bablDetail.owner ?? 0 == self.bablDetail.bablers?[i].participant?.id ?? 0 {
                viewHeader.imgUser.setImage(string: "\(self.bablDetail.bablers?[i].participant?.full_name ?? "")", sizee: 18, backColor: UIColor.white.cgColor, fontColor: AppColors.profileGradient2!)
                if !(self.bablDetail.bablers?[i].participant?.profile_image ?? "").isEmpty {
                    viewHeader.imgUser.sd_setImage(with: URL(string: self.bablDetail.bablers?[i].participant?.profile_image ?? ""))
                }
            }
        }
        viewHeader.txtTitle.text = response.welcomeDescription ?? ""
        viewHeader.btnDetail.addTarget(self, action: #selector(bablDetailBtn(sender:)), for: .touchUpInside)
    }
    
    @objc func bablDetailBtn(sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "BablDetailsVC") as?  BablDetailsVC
        nVC?.bablDetail = self.bablDetail
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}

extension IdeaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewIdea {
             return 0
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewIdea {
            let cell = tblViewIdea.dequeueReusableCell(withIdentifier: "IdeaTableCell", for: indexPath) as? IdeaTableCell
            let str = "Let's hang out with our friends. #hangoutwithfriends"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("#hangoutwithfriends", with: AppColors.gradientPoint2!)
            cell?.txtViewBabl.attributedText = string
            cell?.txtViewBabl.font = UIFont.systemFont(ofSize: 16)
            return cell ?? UITableViewCell()
        } else {
            let cell = tblViewComment.dequeueReusableCell(withIdentifier: "IdeaCommentTableCell", for: indexPath) as? IdeaCommentTableCell
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewIdea {
            UIView.transition(with: viewIdea, duration: 0,
                              options: .transitionCrossDissolve,
                              animations: {
                self.viewIdea.isHidden = true
                self.viewComment.isHidden = false
                self.scrollView.contentOffset = .zero
            })
        }
    }
}


