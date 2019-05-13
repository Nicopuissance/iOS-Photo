//
//  User.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import Foundation

struct User:Codable{
    var id:Int
    var name:String
    var username:String
    var email:String
    var address:Address
    var phone:String
    var website:String
    var company:Company
    
}



