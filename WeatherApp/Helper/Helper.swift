//
//  Helper.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//

import Foundation
import CoreText

class Helper {
    static let sharedInstance = Helper()
    
    func getDateString(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func getDateFromString(date: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return formatter.date(from: date) ?? Date()
    }
    
    func getTimeStringFromDateStr(date: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateNew = formatter.date(from: date) ?? Date()
        formatter.dateFormat = "hh:mm"
        
        return formatter.string(from: dateNew)
    }
    
    func convertDateFromTimestamp(timeStamp: Int?) -> Date {
        if timeStamp != nil {
            let date = Date(timeIntervalSince1970: Double(timeStamp!))
            let dateStr = getDateString(date: date)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateFinal = formatter.date(from: dateStr)
            
            return dateFinal ?? Date()
        }
        let dateStr = getDateString(date: Date())
        let formatter = DateFormatter()
        return formatter.date(from: dateStr) ?? Date()
    }
    
    func convertTimeFromTimestamp(timeStamp: Int?) -> String {
        if timeStamp != nil {
            let date = Date(timeIntervalSince1970: Double(timeStamp!))
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            let dateStr = formatter.string(from: date)
            return dateStr
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let dateStr = formatter.string(from: Date())
        
        return dateStr
    }
    
     
}

let helper = Helper.sharedInstance
