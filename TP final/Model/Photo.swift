//
//  Photo.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import Foundation

struct Photo:Codable {
    var albumId:Int
    var id:Int
    var title:String
    var url:String
    var thumbnailUrl:String
}
