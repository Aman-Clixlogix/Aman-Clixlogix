import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class SessionManager: UIViewController {

    static var shared = SessionManager()

    var createWallet: Bool = true
    var hud = ProgressHUD()
    
    func methodForApiCalling<T: Codable>(url: String, method: HTTPMethod, parameter: Parameters?, objectClass: T.Type, requestCode: String, userToken: String?, completionHandler: @escaping (T) -> Void) {
        print("URL: \(url)")
        print("METHOD: \(method)")
        print("PARAMETERS: \(parameter ?? Dictionary())")
        print("TOKEN: \(String(describing: getHeader(reqCode: requestCode, userToken: userToken ?? "")))")
        self.showProgressLoader()
        if isConnection() {
            AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: (getHeader(reqCode: requestCode, userToken: userToken)) ?? HTTPHeaders()).responseJSON { (dataResponse) in
                
                ProgressHUD.dismiss()
                let statusCode = dataResponse.response?.statusCode
                print("statusCode: ", dataResponse.response?.statusCode as Any)
                print("dataResponse: \(dataResponse)")
                
                let json = (try? JSONSerialization.jsonObject(with: dataResponse.data ?? Data(), options: [])) as? [String: AnyObject]
             //   print(json?.first?.value[0] ?? "")
                switch dataResponse.result {
                case .success:
                    let object = self.convertDataToObject(response: dataResponse.data, T.self)
                  //  let object2 = self.convertDataToObject(response: dataResponse.data, T)
                    
                    if (statusCode ?? 0) == 200 {
                        completionHandler(object!)
                    } else if (statusCode ?? 0) == 201 {
                        completionHandler(object!)
                    } else if statusCode == 400 {
                        Singleton.shared.showToast(text: "\(json?.first?.value[0] ?? "")")
                    } else if statusCode == 401 {
                        if (json?.first?.value as? String) == "Invalid token." {
                            UserDefaults.standard.removeObject(forKey: UD_TOKEN)
                            let user = UserTable()
                            DataBaseHelper.shared.deleteUserDetails(userDetails: user)
                            if let keyWindow = UIWindow.key {
                                keyWindow.rootViewController?.rootViewController(identifier: "loginvc")
//                                self.showAlert(title: AppErrorAndAlerts.appName.rawValue, msg: "Invalid token. Please login again!")
                            }
                        } else {
                            Singleton.shared.showToast(text: (json?.first?.value as? String) ?? "")
                        }
                    } else if statusCode == 404 {
                        Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
                    } else {
                        Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
                    }
                    ActivityIndicator.hide()
                case .failure:
                    ActivityIndicator.hide()
                    if statusCode == 500 {
                        Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
                    } else {
                        let error = dataResponse.error?.localizedDescription
                        Singleton.shared.showToast(text: error ?? "")
                    }
                    
                }
            }
        } else {
            Alert.showAlert(alerttitle: AppErrorAndAlerts.appName.rawValue, alertmessage: AppErrorAndAlerts.networkIssue.rawValue, ButtonTitle: "Ok", viewController: self)
        }
    }

    func methodForApiCallingg<T: Codable>(url: String, method: HTTPMethod, parameter: Parameters?, objectClass: T.Type, requestCode: String, userToken: String?, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        print("URL: \(url)")
        print("METHOD: \(method)")
        print("PARAMETERS: \(parameter ?? Dictionary())")
        print("TOKEN: \(String(describing: getHeader(reqCode: requestCode, userToken: userToken ?? "")))")
        
        if isConnection() {
            AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: (getHeader(reqCode: requestCode, userToken: userToken)) ?? HTTPHeaders()).responseJSON { (dataResponse) in
                
                let statusCode = dataResponse.response?.statusCode
                print("statusCode: ", dataResponse.response?.statusCode as Any)
                print("dataResponse: \(dataResponse)")
                
                let json = (try? JSONSerialization.jsonObject(with: dataResponse.data ?? Data(), options: [])) as? [String: AnyObject]
             //   print(json?.first?.value[0] ?? "")
                ActivityIndicator.hide()
                completionHandler(dataResponse)
//                switch dataResponse.result {
//                case .success:
//                    let object = self.convertDataToObject(response: dataResponse.data, T.self)
//                  //  let object2 = self.convertDataToObject(response: dataResponse.data, T)
//
//                    if (statusCode ?? 0) == 200 {
//                      //  completionHandler(object!)
//                    } else if (statusCode ?? 0) == 201 {
//                       // completionHandler(object!)
//                    } else if statusCode == 400 {
//                        Singleton.shared.showToast(text: "\(json?.first?.value[0] ?? "")")
//                    } else if statusCode == 401 {
//                        self.showAlert(title: AppErrorAndAlerts.appName.rawValue, msg: (json?.first?.value as? String) ?? "")
//                        Singleton.shared.showToast(text: (json?.first?.value as? String) ?? "")
//                    } else if statusCode == 404 {
//                        Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
//                    } else {
//                        Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
//                    }
//                    ActivityIndicator.hide()
//                case .failure:
//                    ActivityIndicator.hide()
//                    let error = dataResponse.error?.localizedDescription
//                    Singleton.shared.showToast(text: error ?? "")
//                }
            }
        } else {
            Alert.showAlert(alerttitle: AppErrorAndAlerts.appName.rawValue, alertmessage: AppErrorAndAlerts.networkIssue.rawValue, ButtonTitle: "Ok", viewController: self)
        }
    }

    private func showAlert(title: String, msg: String?) {
        if let keyWindow = UIWindow.key {
            keyWindow.rootViewController?.showAlert(title: "", message: msg, action1Name: "OK", action2Name: nil)
        }
    }
    
    func multipartformPostrequest<T: Codable>(url: String, method: HTTPMethod, param: Parameters?, imageKey: String, image: UIImage?, imageName: String?, userToken: String, objectClass: T.Type, completionHandler: @escaping (T) -> Void) {
        
        // let urlRequest = URLRequest(url: URL(string: BASE_URL + url)!)
        self.showProgressLoader()
        let urlString: URLConvertible = url as URLConvertible
    
        print("URL: \(urlString)")
        print("Params: \(String(describing: param))")
        print(userToken)
    
        
        /* if !appDelegate.isInternetReachable{
         hud.dismiss(animated: true)
         self.showAlert(message: AlertMessageConstant.NO_INTERNET)
         return
         }*/
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if param != nil {
                for (key, value) in param! {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                            if element is Int {
                                let value = "(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
            }
            
            
            if image != nil {
                multipartFormData.append((image?.jpegData(compressionQuality: 0.5))!, withName: imageKey, fileName: imageName, mimeType: "image/jpeg")
            }
            
        }, to: urlString, usingThreshold: UInt64.init(), method: method, headers: getHeader(reqCode: "", userToken: userToken), interceptor: nil, fileManager: FileManager.default, requestModifier: nil).uploadProgress(queue: .main, closure: { progress in
            // Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseString { (dataResponse) in
            ProgressHUD.dismiss()
            let statusCode = dataResponse.response?.statusCode
            print("statusCode: ", dataResponse.response?.statusCode as Any)
            print("dataResponse: \(dataResponse)")
            
            let json = (try? JSONSerialization.jsonObject(with: dataResponse.data ?? Data(), options: [])) as? [String: AnyObject]
            print(json?.first?.value[0] ?? "")
            
            switch dataResponse.result {
            case .success:
                let object = self.convertDataToObject(response: dataResponse.data, T.self)
                
                if (statusCode ?? 0) == 200 {
                    completionHandler(object!)
                } else if (statusCode ?? 0) == 201 {
                    completionHandler(object!)
                } else if statusCode == 400 {
                    Singleton.shared.showToast(text: "\(json?.first?.value[0] ?? "")")
                } else if statusCode == 401 {
                    self.showAlert(title: AppErrorAndAlerts.appName.rawValue, msg: (json?.first?.value as? String) ?? "")
                    Singleton.shared.showToast(text: (json?.first?.value as? String) ?? "")
                } else if statusCode == 404 {
                    Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
                } else {
                    Singleton.shared.showToast(text: AppErrorAndAlerts.internalServerError.rawValue)
                }
                ActivityIndicator.hide()
            case .failure:
                ActivityIndicator.hide()
                let error = dataResponse.error?.localizedDescription
                Singleton.shared.showToast(text: error ?? "")
            }
        }
    }
    
    func showProgressLoader() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorAnimation = AppColors.gradientPoint2!
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorProgress = .clear
        ProgressHUD.show()
    }

    
    
//        func makeMultipartRequest(url: String, fileData: Data, param: [String:Any], fileName: String, completionHandler: @escaping (Any) -> Void) {
//
//            AF.upload(multipartFormData: { (multipartFormData) in
//                for (key, value) in param {
//                    if key == "file_type" {
//                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                    } else {
//                        multipartFormData.append(value as! Data, withName: key as! String, fileName: "image.png", mimeType: "image/png")
//                    }
//                }
//
//            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: getHeader(reqCode: "", userToken: nil)) { (encodingResult) in
//
//                switch encodingResult {
//                case .success:
//                    response.responseString(completionHandler: { (dataResponse) in
//
//                        ActivityIndicator.hide()
//
//                        let errorObject = self.convertDataToObject(response: dataResponse.data, UploadImage.self)
//
//                        if dataResponse.response?.statusCode == 200 {
//                            let object = self.convertDataToObject(response: dataResponse.data, UploadImage.self)
//                            completionHandler(object!)
//                        } else {
//                            UIApplication.shared.keyWindow?.rootViewController?.showAlert(title: "Error", message: errorObject?.message, action1Name: "Ok", action2Name: nil)
//                            ActivityIndicator.hide()
//                        }
//                    })
//                    break
//                case .failure:
//                    //Showing error message on alert
//                    UIApplication.shared.keyWindow?.rootViewController?.showAlert(title: "Error", message: error.localizedDescription, action1Name: "Ok", action2Name: nil)
//                    ActivityIndicator.hide()
//                    break
//                }
//            }
//        }
//
    private func convertDataToObject<T: Codable>(response inData: Data?, _ object: T.Type) -> T? {
        if let data = inData {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: data)
                return decoded
            } catch {
                print(error)
            }
        }
        return nil
    }

    func getHeader(reqCode: String, userToken: String?) -> HTTPHeaders? {
       // let token = UserDefaults.standard.string(forKey: UD_TOKEN)
        if (userToken == nil) {
            return nil
        } else {
            return ["Authorization": "token " + userToken!]
        }
    }
}
