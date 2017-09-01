//
//  DownloadJSON.swift
//  TheGunnApp
//
//  Created by Xavi Loinaz on 7/17/16.
//  Copyright © 2016 Xavi Loinaz. All rights reserved.
//

//




import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
}



class DownloadJSON {
    
    var events = [Event]()
    
    
    
    func intToDayString(_ day: Int?) -> String? {
        if(day! == 1){
            return "Sunday"
        }
        if(day! == 2){
            return "Monday"
        }
        if(day! == 3){
            return "Tuesday"
        }
        if(day! == 4){
            return "Wednesday"
        }
        if(day! == 5){
            return "Thursday"
        }
        if(day! == 6){
            return "Friday"
        }
        if(day! == 7){
            return "Saturday"
        }
        return ""
    }
    
    func getDayOfWeek(_ today:String)->Int? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return nil
        }
    }
    
    func dateString(_ str:String?) -> String{
        var datestr = ""
        if(str!.characters.count > 9){
            //            print(str!.characters.count)
            let year = str![0] + str![1] + str![2] + str![3]
            let month = str![5] + str![6]
            let day = str![8] + str![9]
            
            //            datestr += month + "/" + day + "/" + year
            let week = year + "-" + month + "-" + day
            let dayNum = getDayOfWeek(week)!
            datestr = intToDayString(dayNum)! + ", " + month + "/" + day + "/" + year
        }
        
        
        return datestr
    }
    
    func yearString(_ str:String?) -> String{
        var result = ""
        if(str!.characters.count > 9){
            
            //            print(str!.characters.count)
            let year = str![0] + str![1] + str![2] + str![3]
            result = year
        }
        return result
    }
    func monthString(_ str:String?) -> String{
        var result = ""
        if(str!.characters.count > 9){
            let month = str![5] + str![6]
            result = month
        }
        return result
    }
    func dayString(_ str:String?) -> String{
        var result = ""
        if(str!.characters.count > 9){
            let day = str![8] + str![9]
            result = day
        }
        return result
    }
    
    
    func timeString(_ str: String?) -> String{
        var time = ""
        if(str!.characters.count > 9){
            time += str![11] + str![12] + str![13] + str![14] + str![15]
            
            if(Int(time[0] + time[1]) > 12){
                time = String(Int(time[0] + time[1])!-12) + time[2] + time[3] + time[4] + " PM"
            }
            else{
                time += " AM"
            }
            if (time[0] == "0"){
                time = time[1..<time.characters.count]
            }
            
            
        }
        
        
        return time
        
    }
    let date = Date()
    let calendar = Calendar.current
    func laterThanToday(_ str1: String?) -> Bool {
        
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        let curYear = components.year
        let curMonth = components.month
        let curDay = components.day
        if(Int(yearString(str1)) > curYear){
            return true
        }
        else if(Int(yearString(str1)) == curYear){
            if(Int(monthString(str1)) > curMonth){
                return true
            }
            else if(Int(monthString(str1)) == curMonth){
                if(Int(dayString(str1)) >= curDay){
                    return true
                }
            }
        }
        //        print(curMonth + curDay + curYear)
        return false
    }
    
    
    func downloadAndParseJSON()-> [Event]{

        do {
            if let file = Bundle.main.url(forResource: "events", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let events = json as? [[String: Any]] {
                    // json is a dictionary
                    // print("Dictionary")
                    // print(events)
                    
                    for event in events {
                        let eve : Event? = Event()
                        if let startingPoint = event["start"] as? [String: Any] {
                            if let startDate = startingPoint["date"] as? String {
                                eve!.startDate = startDate
                            }
                            if let startTime = startingPoint["dateTime"] as? String {
                                eve!.startTime = startTime
                            }
                        }
                        if let endingPoint = event["end"] as? [String: Any] {
                            if let endDate = endingPoint["date"] as? String {
                                eve!.endDate = endDate
                            }
                            if let endTime = endingPoint["dateTime"] as? String {
                                eve!.endTime = endTime
                            }
                        }
                        if let summary = event["summary"] as? String {
                            eve!.summary = summary
                            // print("This happened (Summary stuff)")
                        }
                        if let location = event["location"] as? String {
                            eve!.location = location
                            // print("This happened (Location stuff)")
                        }
                        if let description = event["description"] as? String {
                            eve!.description = description
                            // print("This happened (Description stuff)")
                        }
                        
                        if(eve!.startTime! != ""){
                            if(laterThanToday(eve!.startTime!)){
                                self.events.append(eve!)
                                // print("This happened")
                            }
                        }
                        else if(eve!.startDate != ""){
                            if(laterThanToday(eve!.startDate!)){
                                self.events.append(eve!)
                                // print("This happened")
                            }
                        }
                        
                    }
                    
                    
                    
                } else if let event = json as? [Any] {
                    // json is an array
                    print("Array")
                    print(events)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        print(events.count)
        return events
        
        

    }
    
}
