//
//  Holiday.swift
//  HolidayApiCall
//
//  Created by Himanshu Chaurasiya on 02/12/19.
//  Copyright © 2019 HPC. All rights reserved.
//

import Foundation

struct HolidayResponse : Decodable {
    var response : Holidays
}

struct Holidays : Decodable {
    var holidays : [HolidayDetails]
}

struct HolidayDetails : Decodable {
    var name : String
    var date : DateInfo
}

struct DateInfo : Decodable {
    var iso : String
}
