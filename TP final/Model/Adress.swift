//
//  Adress.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import Foundation

struct Address:Codable {
    var street:String
    var suite:String
    var city:String
    var zipcode:String
    var geo:Geo
}
