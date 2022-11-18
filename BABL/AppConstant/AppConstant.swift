//
//  Constants.swift
//
//  Created by Manisha  Sharma on 02/01/2019.
//  Copyright © 2019 Qualwebs. All rights reserved.
//

import UIKit

struct AppColors {
    static let colorBackground = UIColor(named: "ColorBackground")
    static let gradientPoint1 = UIColor(named: "GradientPoint1")
    static let gradientPoint2 = UIColor(named: "GradientPoint2")
    static let profileGradient1 = UIColor(named: "ProfileGradient1")
    static let profileGradient2 = UIColor(named: "ProfileGradient2")
    static let sideMenuBottomGradient = UIColor(named: "SideMenuBottomGradient")
    static let mySettingImgBack = UIColor(named: "MySettingImageBack")
    static let revealColor = UIColor(named: "RevealColor")
}

struct BaseUrl {
    static let base_url = "http://66.175.217.67:8000/v1.0/"
}

struct UrlName {
    static let login = BaseUrl.base_url + "users/login/"
    static let signup = BaseUrl.base_url + "users/register/"
    static let updateProfile = BaseUrl.base_url + "users/profile/"
    static let homeFeed = BaseUrl.base_url + "babls/home/"
    static let myBablList = BaseUrl.base_url + "babls/list/"
    static let forgotPassword = BaseUrl.base_url + "reset-password/"
    static let passwordUpdate = BaseUrl.base_url + "reset-password/confirm/"
    static let termsConditions = BaseUrl.base_url + "pages/terms-and-conditions/"
    static let privacyPolicy = BaseUrl.base_url + "pages/privacy-policy/"
    static let contactlist = BaseUrl.base_url + "users/filter/contacts/"
    static let createBabl = BaseUrl.base_url + "babls/"
    static let ideaDetails = BaseUrl.base_url + "babls/"
    static let notificationList = BaseUrl.base_url + "users/notifications/list/"
    static let contactUs = BaseUrl.base_url + "pages/contact-us/"
    static let logout = BaseUrl.base_url + "users/logout/" 
}

enum AppErrorAndAlerts: String, Error {
    case appName = "BABL"
    case errorType = "Error"
    case alertType = "Alert"
    case networkIssue = "Oops! You appear to be offline."
    case slowInternet = "It Seems your internet connection is slow."
    case internalServerError = "We are performing some technical tasks at our end. Kindly try again in some time."
    case redirectStatus = "We are facing some technical error at our end. Kindly try again in some time."
    case badRequest = "Backend Validation Failed."
    case logoutConfirmation = "Are you sure you want to logout?"
    case blankEmailId = "Please enter your Email Id"
    case invalidEmailId = "Please enter your valid Email Id"
    case blankPhoneNo = "Please enter your Phone Number"
    case blankRePhoneNo = "Please Re-enter you Phone Number"
    case invalidPhoneNo = "Please enter your valid Phone Number"
    case blankPassword = "Please enter you password"
    case blankSubject = "Please enter your subject"
    case invalidPassword = "Password should be between 8 to 16 characters with atleast 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character"
    case passwordNotMatching = "Password is not matching"
    case phoneNotMatching = "Phone Number is not matching"
    case countryCodeNotMatching = "Country Code is not matching"
    case blankConfirmPassword = "Please re-enter your password"
    case invalidConfirmPassword = "Password and confirm password does not match"
    case blankDescription = "Please tell us something about your self"
    case blankLocation = "Please enter your location"
    case blankPronouns = "Pronouns field can't be empty"
    case blankDOB = "Please select your date of birth"
    case blankOTP = "Please enter the OTP you have been received"
    case blankFirstName = "Please enter your First Name"
    case invalidFirstName = "Please enter your valid First Name"
    case blankLastName = "Please enter your Last Name"
    case invalidLastName = "Please enter your valid Last Name"
    case invalidUserName = "Please enter your valid User Name"
    case blankUserName = "Please enter your User Name"
    case invalidFullName = "Please enter Full Name"
    case userNameNotAvailable = "Please try another User Name. This User Name is already taken by other user."
    case blankGender = "Please select your Gender"
    case accpetTermsConditionError = "Please accept our Terms & Conditions"
    case passwordChangeSuccessful = "Your Password Change Successfully"
    case checkYourMail = "Please check your mail for further process"
    case blankSubmitIdeasBy = "Please select date and time"
    case blankPickWinBy = "Please select time"
}

// MARK: USER DEFAULTS
var UD_TOKEN = "access_token"

