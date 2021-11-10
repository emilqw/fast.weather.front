//
//  ModelError.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import Foundation
struct ModelError:Decodable{
    var error_code:Int
    var error_massage:String
}
