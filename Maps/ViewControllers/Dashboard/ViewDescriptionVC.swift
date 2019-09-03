//
//  ViewDescriptionVC.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class ViewDescriptionVC: BaseViewController {
    
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelDescription: UITextView!
    @IBOutlet weak var maps: MKMapView!
    
    var descriptionPresenter: DescriptionViewPresenter?
    var index: Int = 0
    var nameData: String = ""
    var urlData: String = ""
    var descriptionData: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionPresenter = DescriptionViewPresenter(view: self)
        setUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonFormats(_ sender: Any) {
        self.backAction(sender)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setUI() {
        nameCountry.text = nameData
        labelDescription.text = descriptionData
        descriptionPresenter?.imageData(urlData: urlData)
        let annotations = self.maps.annotations
        self.maps.removeAnnotations(annotations)
        descriptionPresenter?.search(name: nameData)
    }
}
extension ViewDescriptionVC: DescriptionView {
    func getImage(image: UIImage) {
        self.image.image = image
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    func currentError(err: String) {
            print(err)
    }
    
    func getContry(annotation: MKPointAnnotation, region: MKCoordinateRegion) {
        self.maps.addAnnotation(annotation)
        self.maps.setRegion(region, animated: true)
    }
    
    
}
