//
//  LoginPresenter.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import ObjectMapper

protocol LoginView {
    func showProgress()
    func hideProgress()
    func showGetconfigSuccess(isValid: Bool, message: String)
    func showForgotPasswordSuccess()
    func showLoginSuccess()
    func showForgotPasswordSuccessError(message: String)
}

class LoginPresenter {
    
    var view: LoginView
    
    init(view: LoginView) {
        self.view = view
        
    }
    
    func getCongigurations() {
//
//        APIManager.performGetConfigurations(type: .getConfig) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "FAIL conection with CONFIG_URATION SERVER")
//            } else {
//                self.view.showGetconfigSuccess(isValid: response?.alreadyPay ?? true, message: response?.message ?? "")
//            }
//        }
//
    }
    
    func performLogin(mail: String, password: String) {
//        APIManager.performLogin(type: .login, mail: mail, password: password) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "Login")
//                self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//            } else {
//                guard let data = response, let ok = data.success else {
//                    self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//                    return
//                }
//
//                if ok {
//                    if let user = data.result?["user"] as? NSDictionary, let token = data.result?["token"]  {
//
//                        let userMap = Mapper<UserModel>().map(JSON: user as? [String : Any] ?? [:])
//
//                        UserCurrentSession.shared().name = userMap?.name
//                        UserCurrentSession.shared().mail = userMap?.mail
//                        UserCurrentSession.shared().password = password
//                        UserCurrentSession.shared().token =  token as? String ?? ""
//                        debug(info: "SE ALMACENO USUSARIO CON EXITO")
//                        self.view.showLoginSuccess()
//                    } else {
//                        self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//                    }
//                } else {
//                    self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//                }
//            }
//        }
    }
    
    func performForgotPassword(mail: String) {
//        APIManager.performForgotPassword(mail: mail, type: .forgot) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "Registro")
//                self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//            } else {
//                guard let data = response, let ok = data.success else {
//                    self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//                    return
//                }
//                _ = ok ? self.view.showLoginSuccess() : self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//            }
//        }
//        
    }
    
    
}
