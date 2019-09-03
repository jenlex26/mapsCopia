//
//  DashboardVC.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage
import Alamofire

class DashboardVC: BaseViewController {
    
    @IBOutlet weak var tableViewFormats: UITableView!

    var mapsPresenter: DashboardPresenter?
    var index: Int = 0
    var arr1 = [MapCountry]()
    var formatDetailArray = [""]
    var arrFilter = [String]()
    
    var nameService = ""
    var urlService = ""
    var descriptionService = ""
    
    var arrModel = [MapCountry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapsPresenter = DashboardPresenter(view: self as DashboardView, vc: self)
        self.tableViewFormats.delegate = self
        self.tableViewFormats.dataSource = self
        performMaps()


        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewDescriptionVC {
            vc.index = index
            vc.nameData = nameService
            vc.urlData = urlService
            vc.descriptionData = descriptionService
        }
        
    }
    
    func performMaps() {

        APIManager.performMaps(type: .forgot) { (error, response) in
            if error != nil {
                debugError(error: error, type: "Login")
            } else {
                guard let dataMaps = response else {
                    return
                }
                DispatchQueue.main.async {
                    self.arrModel = dataMaps.country.sorted { $0.name!.lowercased() < $1.name!.lowercased() }

                    self.tableViewFormats.reloadData()
                }
                
            }
        }
    }
    
}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapsCell") as! mapsCell
        cell.lblMaps.text = arrModel[indexPath.row].name
        let imageUrl = arrModel[indexPath.row].image?.url
        Alamofire.request(imageUrl!).downloadProgress(closure: {
            (progrees) in
        }).responseData {(response) in
            if let data = response.result.value {
                DispatchQueue.main.async {
                    cell.imageMaps.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 12
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        nameService = arrModel[indexPath.row].name!
        urlService = arrModel[indexPath.row].image!.url!
        descriptionService = arrModel[indexPath.row].description!
        self.performSegue(withIdentifier: "ViewSegue", sender: nil)
    }
    
}
extension DashboardVC: DashboardView {
    func showForgotPasswordSuccessError(message: String) {

    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    
    
}
