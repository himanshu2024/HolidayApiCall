//
//  HolidayRequest.swift
//  HolidayApiCall
//
//  Created by Himanshu Chaurasiya on 03/12/19.
//  Copyright © 2019 HPC. All rights reserved.
//

import Foundation

enum HolidayError : Error{
    case noDataAbailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURl : URL
    let API_KEY = "a16505fd604c8f2d7cd329542c99939ea8bc2bef"
    
    init(countryCode : String) {
        let date = Date()
        let formate = DateFormatter()
        formate.dateFormat = "yyyy"
        let currentYear = formate.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else{fatalError()}
        
        self.resourceURl = resourceURL
    }
    
    func getHolidays(completion : @escaping(Result<[HolidayDetails], HolidayError>) -> Void)  {
        let dataTask = URLSession.shared.dataTask(with: resourceURl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAbailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                completion(.success(holidayResponse.response.holidays))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
