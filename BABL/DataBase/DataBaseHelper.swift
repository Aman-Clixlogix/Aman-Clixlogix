//
//  DataBaseHelper.swift
//  BABL
//

import UIKit
import RealmSwift

class DataBaseHelper: UIViewController {
    static let shared = DataBaseHelper()
    
    private var realm = try! Realm()
    
    func getDatabaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func deleteUserDetails(userDetails: UserTable) {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func saveUserDetails(userDetails: UserTable) {
        try! realm.write {
            realm.add(userDetails)
        }
    }
    
    func getAllUserDetails() -> UserTable {
        return UserTable(value: realm.objects(UserTable.self))
    }
}
