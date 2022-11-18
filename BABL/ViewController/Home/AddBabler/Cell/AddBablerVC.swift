//
//  AddBablerVC.swift
//  BABL
//
//

import UIKit
import RealmSwift
import ContactsUI
import SDWebImage

class AddBablerVC: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK: Properties
    var screenType: String?
    var bablName: String?
    var token: String?
    var contactList = [String]()
    private var addbablerViewModel = AddBablerViewModel()
    var contactListModel: [[Installed]]?
    var filteredContact: [[Installed]]?
    var contactId = [Int]()
    let resultsData = try! Realm().objects(UserTable.self)
    var bablers = [Babler]()
    var anonymize: Bool = false
    var bablDetail = IdeaModel()
    private var bablDetailsViewModel = BablDetailsViewModel()
    var bablersList = [[String: Any]]()
    var updateBablerDelegate: UpdateBablerSendData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bablDetailsViewModel.delegate = self
        self.token = resultsData.first?.token ?? ""
        operationQueueCall()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupDesign()
    }
    
    // MARK: SetUp Design
    func setupDesign() {
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.screenType ?? "" == "Invite" ? self.btnNext.setTitle("Done", for: .normal) : self.btnNext.setTitle("Next", for: .normal)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeight.constant = self.tblView.contentSize.height
    }
    
    // MARK: Operation Queue
    func operationQueueCall() {
        let getContactOperation = BlockOperation()
        getContactOperation.addExecutionBlock {
            self.getContactList()
        }
        let sendContactServerOperation = BlockOperation()
        sendContactServerOperation.addExecutionBlock {
            self.sendContactToServer()
        }
        sendContactServerOperation.addDependency(getContactOperation)
        let operationQueue = OperationQueue()
        operationQueue.addOperation(getContactOperation)
        operationQueue.addOperation(sendContactServerOperation)
    }
    
    // MARK: Get Contact List
    func getContactList() {
        contactList.removeAll()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as? [CNKeyDescriptor] ?? [CNKeyDescriptor]())
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
                
                for phoneNumber in contact.phoneNumbers {
                    self.contactList.append("\(phoneNumber.value.stringValue.removingWhitespaces())")
                }
            }
        } catch {
            print("unable to fetch contacts")
        }
        print(contactList)
        print("---->", contactList.count)
    }
    
    func sendContactToServer() {
        addbablerViewModel.delegate = self
        DispatchQueue.main.async {
            self.addbablerViewModel.getContactList(contactList: self.contactList, token: self.token ?? "", view: self.view)
        }
    }
    
    func bablersParticiants() {
        self.contactId.forEach { id in
            self.bablersList.append(["participant": id])
        }
        print(self.bablersList)
    }
    
    // MARK: Button Actions
    @IBAction func inviteBtnClick(_ sender: UIButton) {
        let txt = "Please join BABL by invitation code: \(resultsData.first?.inviteCode ?? "")"
        let myWebsite = NSURL(string: "com.babl://invitation/\(resultsData.first?.inviteCode ?? "")")
        let shareAll = [txt, myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func nextBtnClick(_ sender: UIButton) {
        if self.screenType ?? "" == "Invite" {
            self.bablersParticiants()
            self.bablDetailsViewModel.updateBablAPI(bablID: self.bablDetail.id ?? "", anonymize: self.anonymize, bablers: self.bablersList)
        } else {
            if self.contactId.isEmpty {
                Singleton.shared.showToast(text: "Please add bablers")
            } else {
                let nVC = self.storyboard?.instantiateViewController(withIdentifier: "BablSettingVC") as? BablSettingVC
                nVC?.bablDesc = self.bablName ?? ""
                nVC?.contactId = self.contactId
                let navController = UINavigationController(rootViewController: nVC ?? UIViewController())
                navController.modalPresentationStyle = .overFullScreen
                navController.setNavigationBarHidden(true, animated: false)
                self.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func textSearchChange(_ sender: UITextField) {
        self.filteredContact = sender.text!.isEmpty ? contactListModel : contactListModel?.filter({(model) -> Bool in
            return (model.first?.fullName ?? "").range(of: sender.text ?? "", options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.tblView.reloadData()
    }
}

extension AddBablerVC: AddBablerViewModelDelegate {
    func didReceiveHomeResponse(response: ContactListmodel) {
        self.contactListModel = response.installed
        self.filteredContact = response.installed
        if self.screenType ?? "" == "Invite" {
            for i in 0...(self.bablers.count) - 1 {
                self.contactListModel = self.contactListModel?.filter({ $0.first?.user != self.bablers[i].participant?.id })
                self.filteredContact = self.filteredContact?.filter({ $0.first?.user != self.bablers[i].participant?.id })
            }
            print("Filtered Data", filteredContact)
            tblView.reloadData()
        } else {
            self.contactListModel = response.installed
            self.filteredContact = response.installed
            tblView.reloadData()
        }
        self.tblView.reloadData()
    }
}

extension AddBablerVC: BablDetailsViewModelDelegate {
    func didReceiveBablDetailsResponse(response: IdeaModel) {
        print(response)
        self.updateBablerDelegate?.didSendData(response: response)
        self.dismiss(animated: true)
    }
}

extension AddBablerVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSearch {
            viewSearch.layer.borderColor = AppColors.gradientPoint2!.cgColor
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtSearch {
            if txtSearch.text!.isEmpty {
                viewSearch.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                viewSearch.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
}

extension AddBablerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredContact?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "AddBablerTableCell", for: indexPath) as? AddBablerTableCell
        let data = self.filteredContact?[indexPath.row]
        cell?.lblName.text = data?.first?.fullName?.capitalized ?? ""
        if ((data?.first?.profileImage ?? "") == "") {
            cell?.imgUser.setImage(string: data?.first?.fullName?.capitalized ?? "", color: AppColors.gradientPoint2!, circular: true, stroke: false, sizee: 16, backColor: AppColors.gradientPoint2!.cgColor, fontColor: .white)
        } else {
            cell?.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell?.imgUser.sd_setImage(with: URL(string: data?.first?.profileImage ?? ""))
        }
        
        if !self.contactId.contains(data?.first?.user ?? 0) {
            cell?.imgSelect.image = #imageLiteral(resourceName: "purple circle plus icon")
        } else {
            cell?.imgSelect.image = #imageLiteral(resourceName: "select tick icon ")
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblView.cellForRow(at: indexPath) as? AddBablerTableCell
        let data = self.filteredContact?[indexPath.row]
      
        if !self.contactId.contains(data?.first?.user ?? 0) {
            self.contactId.append(self.filteredContact?[indexPath.row].first?.user ?? 0)
        } else {
            contactId = contactId.filter { $0 != filteredContact?[indexPath.row].first?.user ?? 0 }
        }
        print(self.contactId)
        self.tblView.reloadData()
    }
}

