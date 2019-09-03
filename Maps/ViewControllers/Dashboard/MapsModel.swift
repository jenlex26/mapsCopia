//
//  MapsModel.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import UIKit

class MapsModel {
    var objectId = String()
    var name = String()
    var description = String()
    var image = imageModel()
}

class imageModel {
    var name = String()
    var url = String()
}
