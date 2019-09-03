//
//  ViewDescriptionPresenter.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

protocol DescriptionView {
    func showProgress()
    func hideProgress()
}

class DescriptionViewPresenter {
    
    var view: DescriptionView
    var viewController: ViewDescriptionVC
    
    
    init(view: DescriptionView, vc: ViewDescriptionVC) {
        self.view = view
        viewController = vc
    }

}
