//
//  BablSettingVC.swift
//  BABL
//
//

import UIKit
import RealmSwift

class BablSettingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var btnBabl: UIButton!
    @IBOutlet weak var viewdDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblSubmitDate: UILabel!
    @IBOutlet weak var lblSubmitTime: UILabel!
    @IBOutlet weak var lblPickTime: UILabel!
    @IBOutlet weak var switchAnonymize: UISwitch!
    
    // MARK: Properties
    var date: String?
    var time: String?
    var datePickerType: Int = 1
    var animBool: Bool = true
    var submitIdeas: String?
    var pickup: String?
    var anonymize: Bool = false
    var bablDesc: String?
    var contactId = [Int]()
    var bablersList = [[String: Any]]()
    private var bablSettingViewModel = BablSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bablSettingViewModel.delegate = self
        bablersParticiants()
        setUpDesign()
    }

    // MARK: Design
    func setUpDesign() {
        designableView(view: btnBabl)
        
        viewdDatePicker.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: self.view.frame.height)
        view.addSubview(viewdDatePicker)
    }
    
    // MARK: DatePicker Dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == viewdDatePicker {
            self.viewdDatePicker.animHide()
            self.animBool = true
        }
    }
    
    func bablersParticiants() {
        self.contactId.forEach { id in
            self.bablersList.append(["participant": id])
        }
        print(self.bablersList)
    }
    
    // MARK: Button Actions
    @IBAction func dateBtnClick(_ sender: UIButton) {
        if self.animBool == true {
            self.datePicker.datePickerMode = .dateAndTime
            self.viewdDatePicker.animShow()
            self.animBool = false
            self.datePickerType = 1
        }
    }
    
    @IBAction func timeBtnClick(_ sender: UIButton) {
        if self.animBool == true {
            self.datePicker.datePickerMode = .time
            self.viewdDatePicker.animShow()
            self.animBool = false
            self.datePickerType = 2
        }
    }
    
    @IBAction func dateOKBtnClick(_ sender: UIButton) {
        if datePickerType == 1 {
            self.date = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "dd-MM-yyyy"))"
            self.time = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "h:mm a"))"
            self.submitIdeas = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd'T'HH:mm:ss'Z'"))"
            self.lblSubmitDate.text = "\(self.date ?? "")"
            self.lblSubmitTime.text = "\(self.time ?? "")"
        } else if datePickerType == 2 {
            self.time = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "h:mm a"))"
            self.pickup = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "HH:mm:ss"))"
            self.lblPickTime.text = "\(self.time ?? "")"
        }
        
        viewdDatePicker.animHide()
        self.animBool = true
    }
    
    @IBAction func datePickerChange(_ sender: UIButton) {
        if datePickerType == 1 {
            self.date = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "dd-MM-yyyy"))"
            self.time = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "h:mm a"))"
            self.submitIdeas = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "yyyy-MM-dd'T'HH:mm:ss'Z'"))"
            self.lblSubmitDate.text = "\(self.date ?? "")"
            self.lblSubmitTime.text = "\(self.time ?? "")"
        } else if datePickerType == 2 {
            self.time = "\(self.convertTimestampToDate(Int(self.datePicker.date.timeIntervalSince1970), to: "h:mm a"))"
            self.pickup = "\(self.convertTimestampToDateUTC(Int(self.datePicker.date.timeIntervalSince1970), to: "HH:mm:ss"))"
            self.lblPickTime.text = "\(self.time ?? "")"
        }
    }
    
    @IBAction func switchAnonymizeAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchAnonymize.setOn(true, animated: true)
            self.anonymize = true
        } else {
            switchAnonymize.setOn(false, animated: true)
            self.anonymize = false
        }
    }
    
    @IBAction func letsBablBtnClick(_ sender: UIButton) {
        if lblSubmitDate.text == "Select Date" {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankSubmitIdeasBy.rawValue)
        } else if lblPickTime.text == "Select Time" {
            Singleton.shared.showToast(text: AppErrorAndAlerts.blankPickWinBy.rawValue)
        } else {
            ActivityIndicator.show(view: self.view, color: AppColors.gradientPoint2!)
            self.bablSettingViewModel.createBablAPI(description: self.bablDesc ?? "", submit_by: self.submitIdeas ?? "", winner_by: self.pickup ?? "", anonymize: self.anonymize, bablers: bablersList)
        }
    }
    
    @IBAction func cancelBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BablSettingVC: BablSettingViewModelDelegate {
    func didReceiveBablSettingResponse(response: BablSettingModel) {
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "BablSettingVC") as!  BablSettingVC
            let navController = UINavigationController(rootViewController: vc3)
            navController.modalPresentationStyle = .overCurrentContext
        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "IdeaVC") as? IdeaVC
        nVC?.id = response.id ?? ""
        self.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
//        let nVC = self.storyboard?.instantiateViewController(withIdentifier: "IdeaVC") as? IdeaVC
//        nVC?.id = response.id ?? ""
//        nVC?.navigationController?.pushViewController(nVC ?? UIViewController(), animated: true)
    }
}
