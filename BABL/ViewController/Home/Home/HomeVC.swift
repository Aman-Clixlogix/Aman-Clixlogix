//
//  HomeVC.swift
//  BABL
//

import UIKit
import AKSideMenu

class HomeVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var btnStart: UIButton!
    
    // MARK: Properties
    private var homeViewModel = HomeViewModel()
    var homeModelData = HomeModel()
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetup()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(methodPullToRefresh(sender:)), for: .valueChanged)
        self.tblView.addSubview(self.refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeFeedApiCall()
    }
    
    @objc func methodPullToRefresh(sender: AnyObject) {
        self.refreshControl?.beginRefreshing()
        homeFeedApiCall()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientViewDesign()
        designableView(view: btnStart)
    }

    // MARK: Setup Design
    func defaultSetup() {
        viewNoData.isHidden = true
        viewData.isHidden = true
        homeViewModel.delegate = self
    }
    
    // MARK: Setup Design
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
    func homeFeedApiCall() {
        homeViewModel.homeFeedAPI()
    }
    
    // MARK: Button Actions
    @IBAction func addBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "StartBablVC") as? StartBablVC
        self.navigationController?.present(nVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func startBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "StartBablVC") as? StartBablVC
        self.navigationController?.present(nVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func sideMenuBtnClick(_ sender: UIButton) {
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    
    @IBAction func notificatioBtnClick(_ sender: UIButton) {
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}

extension HomeVC: HomeViewModelDelegate {
    func didReceiveHomeNextResponse(homeResponse: HomeModel) {
        self.homeModelData.results?.append(contentsOf: homeResponse.results ?? [Result]())
        self.homeModelData.next = homeResponse.next
        self.homeModelData.previous = homeResponse.previous
        self.tblView.reloadData()
    }
    
    func didReceiveHomeResponse(homeResponse: HomeModel) {
        print(homeResponse)
        if homeResponse.count ?? 0 == 0 {
            viewData.isHidden = true
            viewNoData.isHidden = false
        } else {
            viewNoData.isHidden = true
            viewData.isHidden = false
            self.homeModelData = homeResponse
            tblView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModelData.results?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell
        let data = homeModelData.results?[indexPath.row]
        cell?.lblTitle.text = data?.resultDescription ?? ""
        cell?.lblStatus.setTitle(data?.status ?? "", for: .normal)
        if data?.status ?? "" == "Ideation" {
            cell?.lblStatus.backgroundColor = AppColors.gradientPoint2!
        } else if data?.status ?? "" == "Selection" {
            cell?.lblStatus.backgroundColor = AppColors.gradientPoint1!
        } else if data?.status ?? "" == "Reveal" {
            cell?.lblStatus.backgroundColor = AppColors.revealColor!
        }
        cell?.lblParticipants.text = "\(data?.participantCount ?? 0) people"
        cell?.lblStatus.tag = indexPath.row
        cell?.lblStatus.addTarget(self, action: #selector(statusAction(sender:)), for: .touchUpInside)
        let currentDate = getCurrentDateString()
        let dateFormatterr = DateFormatter()
          dateFormatterr.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
          let datee = dateFormatterr.date(from: currentDate)!
        let submitDate = data?.submitBy ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: submitDate)
        if (date?.offset(from: datee) == "") {
            cell?.lblTime.text = datee.offset(from: date ?? Date())
        } else {
            cell?.lblTime.text = date?.offset(from: datee)
        }
        
        let str = "Bob, Yasmine is part of this BABL"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let string = NSMutableAttributedString(string: trimmedString)
        string.setUnderlineWith("Bob", with: AppColors.gradientPoint2!)
        string.setUnderlineWith("BABL", with: AppColors.gradientPoint2!)
        string.setColorForText("Bob", with: AppColors.gradientPoint2!)
        string.setColorForText("BABL", with: AppColors.gradientPoint2!)
        string.setUnderlineWith("Yasmine", with: AppColors.gradientPoint2!)
        string.setColorForText("Yasmine", with: AppColors.gradientPoint2!)
        cell?.lblMembers.attributedText = string
        return cell ?? UITableViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tblView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if (homeModelData.next != nil) {
                    homeViewModel.homeNextAPI(api: homeModelData.next ?? "")
                }
            }
        }
    }
    
    @objc func statusAction(sender: UIButton) {
        let buttonTag = sender.tag
        let data = homeModelData.results?[buttonTag]
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "IdeaVC") as! IdeaVC
        nVC.id = data?.id ?? ""
        self.navigationController?.pushViewController(nVC, animated: true)
    }
}


