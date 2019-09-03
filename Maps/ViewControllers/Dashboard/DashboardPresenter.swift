//
//  DashboardPresenter.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

protocol DashboardView {
    func showProgress()
    func hideProgress()
    func showForgotPasswordSuccessError(message: String)
}

class DashboardPresenter {
    
    var view: DashboardView
    var viewController: DashboardVC
    var arr = [MapCountry]()
    
    init(view: DashboardView, vc: DashboardVC) {
        self.view = view
        self.viewController = vc
        
    }
 
//    func performMaps() -> [MapCountry] {
//        var arrModel = [MapCountry]()
//        APIManager.performMaps(type: .forgot) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "Login")
//            } else {
//                guard let dataMaps = response else {
//                    return
//                }
//                    arrModel = dataMaps.country
//            }
//        }
//        return arrModel
//    }
    
//    func performMaps() {
//        APIManager.performMaps(type: .forgot) { (error, response) in
//            if error != nil {
//                debugError(error: error, type: "Login")
//                self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//            } else {
//                guard let dataMaps = response else {
//                    self.view.showForgotPasswordSuccessError(message: Globals.genericError)
//                    return
//                }
//
////                if data.name!.isEmpty {
////                    print(data)
////                    if let user = data.result?["user"] as? NSDictionary, let token = data.result?["token"]  {
////
////                        let userMap = Mapper<UserModel>().map(JSON: user as? [String : Any] ?? [:])
////
////                        UserCurrentSession.shared().name = userMap?.name
////                        UserCurrentSession.shared().mail = userMap?.mail
////                        UserCurrentSession.shared().phone = userMap?.phone
////                        UserCurrentSession.shared().address = userMap?.address
////                        UserCurrentSession.shared().password = password
////                        UserCurrentSession.shared().token =  token as? String ?? ""
////                        debug(info: "SE ALMACENO USUSARIO CON EXITO")
////                        self.view.showLoginSuccess()
////                    } else {
////                        self.view.showForgotPasswordSuccessError(message: Globals.genericError)
////                    }
////                } else {
////                    self.view.showForgotPasswordSuccessError(message: Globals.genericError)
////                }
//            }
//        }
//    }
}
