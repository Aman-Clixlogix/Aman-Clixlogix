//
//  DataBase.swift
//  BABL
//

import Foundation
import RealmSwift
import SwiftyJSON

// Define your models like regular Swift classes
class UserTable: Object {
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var email = ""
    @Persisted var id = 0
    @Persisted var token = ""
    @Persisted var profileId = ""
    @Persisted var inviteCode = ""
    @Persisted var userImage = ""
    @Persisted var userName = ""
}
