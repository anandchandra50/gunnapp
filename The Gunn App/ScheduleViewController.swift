//
//  ScheduleViewController.swift
//  The Gunn App
//
//  Created by Xavi Loinaz on 6/5/16.
//  Copyright © 2016 Xavi Loinaz. All rights reserved.
//

import UIKit
import Alamofire
import CircularSpinner

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var dayAndDate: UILabel!
    @IBOutlet weak var minutesRemaining: UILabel!
    @IBOutlet weak var timeProgressBar: UIProgressView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    private var currentEvents: [Event] = []
    private var fetched = false
    var alternateScheduleDates : [String] = []
    var scheduleForCurrentDay : [Period] = []
    var whichSegControl : Int = 0
    
    
    @IBAction func goToPortal() {
        if let url = URL(string: "https://id.pausd.org/arms/m") {
            
            UIApplication.shared.openURL(url)
            
        }
    }
    
    
    @IBAction func updateInfo(_ sender: AnyObject) {
        updateUI()
    }
    
    @IBOutlet weak var distanceToTableShort: NSLayoutConstraint!
    
    @IBOutlet weak var distanceToTableLong: NSLayoutConstraint!
    
    @IBOutlet weak var dayAndDateToProgBar: NSLayoutConstraint!
    
    
    
    @IBAction func switchSegments(_ sender: AnyObject) {
        
        
        if segmentedController.selectedSegmentIndex == 0 {
            whichSegControl = 0
            scheduleForCurrentDay.removeAll()
            updateUI()
            scheduleTable.reloadData()
            minutesRemaining.isHidden = false
            timeProgressBar.isHidden = false
            dayAndDate.isHidden = false
            distanceToTableLong.priority = 999
            distanceToTableShort.priority = 999
            distanceToTableLong.constant = 68
            distanceToTableShort.constant = 43
            //dayAndDateToProgBar.priority = 999
            
        }
        if segmentedController.selectedSegmentIndex == 1 {
            whichSegControl = 1
            scheduleForCurrentDay.removeAll()
            updateUI()
            scheduleTable.reloadData()
            minutesRemaining.isHidden = true
            timeProgressBar.isHidden = true
            dayAndDate.isHidden = false
            distanceToTableLong.priority = 1
            distanceToTableShort.priority = 999
            distanceToTableShort.constant = 6
            //dayAndDateToProgBar.priority = 750
            
        }
        if segmentedController.selectedSegmentIndex == 2 {
            whichSegControl = 2
            scheduleForCurrentDay.removeAll()
            scheduleForCurrentDay.append(Period(name: "Monday Regular Schedule", startTime: " ", endTime: " "))
            scheduleForCurrentDay.append(Period(name: "A", startTime: "8:25", endTime: "9:45"))
            scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
            scheduleForCurrentDay.append(Period(name: "B", startTime: "10:00", endTime: "11:15"))
            scheduleForCurrentDay.append(Period(name: "C", startTime: "11:25", endTime: "12:40"))
            scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:40", endTime: "1:20"))
            scheduleForCurrentDay.append(Period(name: "F", startTime: "1:20", endTime: "2:35"))
            scheduleForCurrentDay.append(Period(name: "Tuesday Regular Schedule", startTime: " ", endTime: " "))
            scheduleForCurrentDay.append(Period(name: "D", startTime: "8:25", endTime: "9:45"))
            scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
            scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:00", endTime: "10:50"))
            scheduleForCurrentDay.append(Period(name: "E", startTime: "11:00", endTime: "12:15"))
            scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
            scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:15"))
            scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:40"))
            scheduleForCurrentDay.append(Period(name: "Wednesday Regular Schedule", startTime: " ", endTime: " "))
            scheduleForCurrentDay.append(Period(name: "B", startTime: "8:25", endTime: "9:50"))
            scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
            scheduleForCurrentDay.append(Period(name: "C", startTime: "10:05", endTime: "11:25"))
            scheduleForCurrentDay.append(Period(name: "D", startTime: "11:35", endTime: "12:55"))
            scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:55", endTime: "1:35"))
            scheduleForCurrentDay.append(Period(name: "F", startTime: "1:35", endTime: "2:55"))
            scheduleForCurrentDay.append(Period(name: "Thursday Regular Schedule", startTime: " ", endTime: " "))
            scheduleForCurrentDay.append(Period(name: "E", startTime: "8:25", endTime: "9:50"))
            scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
            scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:05", endTime: "10:55"))
            scheduleForCurrentDay.append(Period(name: "B", startTime: "11:05", endTime: "12:15"))
            scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
            scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:05"))
            scheduleForCurrentDay.append(Period(name: "G", startTime: "2:15", endTime: "3:35"))
            scheduleForCurrentDay.append(Period(name: "Friday Regular Schedule", startTime: " ", endTime: " "))
            scheduleForCurrentDay.append(Period(name: "C", startTime: "8:25", endTime: "9:40"))
            scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:40", endTime: "9:55"))
            scheduleForCurrentDay.append(Period(name: "D", startTime: "9:55", endTime: "11:05"))
            scheduleForCurrentDay.append(Period(name: "E", startTime: "11:15", endTime: "12:25"))
            scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:25", endTime: "1:05"))
            scheduleForCurrentDay.append(Period(name: "F", startTime: "1:05", endTime: "2:15"))
            scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:35"))
            
            scheduleTable.reloadData()
            minutesRemaining.isHidden = true
            timeProgressBar.isHidden = true
            dayAndDate.isHidden = true
            distanceToTableLong.priority = 999
            distanceToTableShort.priority = 1
            distanceToTableLong.constant = 4
            //dayAndDateToProgBar.priority = 750
            
        }
    }
    
    
    var timer: Timer!
    var refresher: UIRefreshControl!
    
    
    func refreshEvery15Secs(){
        updateEventData()
        print("Refreshed: ")
    }
    
    func refresh(_ sender: AnyObject){
        fetchTodayCalendar()
    }
    
    override func viewDidLoad() {
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(ScheduleViewController.refresh(_:)), for: .valueChanged)
        
        timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector:#selector(ScheduleViewController.refreshEvery15Secs), userInfo: nil, repeats: true)
        updateUI()
    }
    
    
    private func fetchTodayCalendar() {
        print("fetching calendar!")
        //https://www.googleapis.com/calendar/v3/calendars/u5mgb2vlddfj70d7frf3r015h0@group.calendar.google.com/events?key=AIzaSyApXsfqthjz95RcM07CIF_1sApEvr4fN80&&singleEvents=true&&orderBy=startTime&timeMin=2017-08-1T00:00:00-07:00
        
        let today = Date()
        let startTime = today.iso8601
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        let endTime = twoDaysFromNow.iso8601
        
        let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/u5mgb2vlddfj70d7frf3r015h0@group.calendar.google.com/events?key=AIzaSyApXsfqthjz95RcM07CIF_1sApEvr4fN80&&singleEvents=true&&orderBy=startTime&timeMin=\(startTime)&timeMax=\(endTime)")!
        print("url is \(url)")
        
        Alamofire.request(url).responseJSON { (response) in
            if let events = response.result.value as? [[String: Any]] {
                print("got result: \(events)")
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
                    let currentDate = Date()
                    if(eve!.startTime! != ""){
                        
                        if(self.laterThanToday(eve!.startTime!)){
                            self.currentEvents.append(eve!)
                            // print("This happened")
                        }
                    }
                    else if(eve!.startDate != ""){
                        if(self.laterThanToday(eve!.startDate!)){
                            self.currentEvents.append(eve!)
                            // print("This happened")
                        }
                    }
                    
                }

            }
            CircularSpinner.hide()
            self.updateEventData()

        }
        
    }
    
    private func parseJSON() {
        
    }
    
    private func updateUI() {
        CircularSpinner.show("", animated: true, type: .indeterminate)
        let specialColor = UIColor(red: 255.0/255.0, green: 14.0/255.0, blue: 14.0/255.0, alpha: 1.0)
        navigationController!.navigationBar.barTintColor = specialColor

        // Do any additional setup after loading the view, typically from a nib.
        /*
        let json = DownloadJSON()
        let events = json.downloadAndParseJSON()
        */
        
        
        fetchTodayCalendar()
       
    }
    
    private func updateEventData() {
        guard currentEvents.count != 0 else {
            useDefaultSchedule()
            return
        }
        let events = currentEvents
        for i in 0..<events.count {
            if let summary = events[i].getSummary() {
                if summary.lowercased().range(of: "schedule") != nil && summary.lowercased().range(of: "below") != nil && summary.lowercased().range(of: "back") == nil && summary.lowercased().range(of: "school") == nil && summary.lowercased().range(of: "night") == nil {
                    alternateScheduleDates.append(events[i].getStartDate()!)
                    
                }
            }
        }
        
        if (whichSegControl == 0) {
            
            let date = Date()
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components([.day , .month , .year, .hour , .minute], from: date)
            
            
            let year = components.year
            let month = components.month
            let day = components.day
            let hour = components.hour
            let minute = components.minute
            
            var alternateScheduleDay = false
            
            var todayDateYear = String(describing: year!)
            var todayDateMonth = String(describing: month!)
            var todayDateDay = String(describing: day!)
            print(todayDateDay)
            var todayDate : String = todayDateYear + "-" + todayDateMonth + "-" + todayDateDay
            print(todayDate)
            
            if month! < 10 && day! < 10 {
                todayDate = String(describing: year!) + "-0" + String(describing: month!) + "-0" + String(describing: day!)
            } else if month! < 10 {
                todayDate = String(describing: year!) + "-0" + String(describing: month!) + "-" + String(describing: day!)
            } else if day! < 10 {
                todayDate = String(describing: year!) + "-" + String(describing: month!) + "-0" + String(describing: day!)
            }
            print(todayDate)
            
            var theAltScheduleEvent : Event = Event()
            
            for x in 0..<events.count {
                for altDate in alternateScheduleDates {
                    if events[x].getStartDate() == todayDate && events[x].getStartDate() == altDate && events[x].getSummary()!.lowercased().range(of: "schedule") != nil &&  events[x].getSummary()!.lowercased().range(of: "below") != nil{
                        alternateScheduleDay = true
                        theAltScheduleEvent = events[x]
                        //break
                    }
                }
                //break
            }
            
            // Marks whether or not today is a holiday based on what the Gunn calendar says (i.e. WINTER BREAK, STAFF DEVELOPMENT DAY, etc.)
            var holiday = false
            for e in events {
                if e.getStartDate() == todayDate {
                    if e.getSummary()!.range(of: "HOLIDAY") != nil || e.getSummary()!.range(of: "WINTER BREAK") != nil || e.getSummary()!.range(of: "STAFF DEVELOPMENT DAY") != nil || e.getSummary()!.range(of: "SPRING BREAK") != nil || e.getSummary()!.lowercased().range(of: "teacher work day") != nil {
                        holiday = true
                    }
                }
            }
            
            // The code below is for summer and holidays
            if (month! == 6 && day! > 1) || (month! == 7) || (month! == 8 && day! < 15) || holiday {
                
                var DAndDTextP1 = String(getDayOfWeek(today: todayDate)!) + ", " + String(monthConverter(month!))
                var DAndDTextP2 = " " + String(describing: day) + ", " + String(describing: year) + " " + "(No School!)"
                dayAndDate.text = DAndDTextP1 + DAndDTextP2
                // dayAndDate.text = String(getDayOfWeek(todayDate)!) + ", " + String(monthConverter(month)) + " " + String(day) + ", " + String(year) + " " + "(No School!)"
                minutesRemaining.text = "School's out!"
                timeProgressBar.setProgress(0, animated: false)
                
                adjustTextSize(dayAndDate)
                
                
                
            } else if alternateScheduleDay { // The code below is for alternate schedules
                
                print("ALTERNATE SCHEDULE DAY")
                
                let scheduleRawString = theAltScheduleEvent.getDescription()
                
                let arrayOfPeriodStrings = scheduleRawString!.components(separatedBy: "\n")
                print(arrayOfPeriodStrings)
                
                var listOfPeriodsForDay : [String] = []
                var listOfStartTimesForDay : [String] = []
                var listOfEndTimesForDay : [String] = []
                for b in arrayOfPeriodStrings {
                    if !(b.isEmpty){
                        
                        // Gets array of periods for the day's schedule
                        
                        print(b)
                        
                        
                        // getIndexOf is a function I created in this class
                        let endIndex = getIndexOf(theString: b, character: "(") - 2
                        
                        
                        // let endIndex = Int(b.index(of: "("))
                        //print(type(of: endIndex))
                        //print(endIndex)
                        // let endIndex = Int(String(describing: b.characters.index(of: "(")))! - 2
                        // let endIndex = 2
                        
                        var periodSubstring = b[0..<endIndex+1]
                        if periodSubstring.lowercased().range(of: "period") != nil && 9 >= periodSubstring.characters.count && periodSubstring.characters.count >= 8 {
                            periodSubstring = periodSubstring[endIndex]
                        }
                        if periodSubstring.lowercased().range(of: "staff") == nil && periodSubstring.lowercased().range(of: "dept") == nil {
                            listOfPeriodsForDay.append(periodSubstring)
                        }
                        
                        // Gets array of period start times for the day's schedule
                        // let startIndex2 = Int(String(describing: b.characters.index(of: "(")!))! + 1
                        let startIndex2 = getIndexOf(theString: b, character: "(") + 1
                        // let endIndex2 = Int(String(describing: b.characters.index(of: "-")!))!
                        let endIndex2 = getIndexOf(theString: b, character: "-")
                        let periodStartTimeSubstring = b[startIndex2..<endIndex2]
                        listOfStartTimesForDay.append(periodStartTimeSubstring)
                        
                        // Gets array of period end times for the day's schedule
                        // let startIndex3 = Int(String(describing: b.characters.index(of: "-")!))! + 1
                        let startIndex3 = getIndexOf(theString: b, character: "-") + 1
                        // let endIndex3 = Int(String(describing: b.characters.index(of: ")")!))!
                        let endIndex3 = getIndexOf(theString: b, character: ")")
                        let periodEndTimeSubstring = b[startIndex3..<endIndex3]
                        listOfEndTimesForDay.append(periodEndTimeSubstring)
                        
                    }
                }
                if !listOfPeriodsForDay.isEmpty {
                    for c in 0...listOfPeriodsForDay.count-1 {
                        scheduleForCurrentDay.append(Period(name: listOfPeriodsForDay[c], startTime: listOfStartTimesForDay[c], endTime: listOfEndTimesForDay[c]))
                    }
                } else {
                    var prep1 = getDayOfWeek(today: todayDate)!
                    var p1 = String(prep1)
                    var p2 = ", " + String(monthConverter(month!))
                    var p3 = " " + String(describing: day) + ", " + String(describing: year) + " " + "(No School!)"
                    dayAndDate.text = p1! + p2 + p3
                }
                
                
                if let dayOfWeek = getDayOfWeek(today: todayDate){
                    
                    var todayDateText1 = String(dayOfWeek) + ", "
                    var todayDateText2 = String(monthConverter(month!))
                    var todayDateText3 = " " + String(describing: day!) + ", " + String(describing: year!) + " "
                    var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                    
                    if dayOfWeek != "Monday" && dayOfWeek != "Tuesday" && dayOfWeek != "Wednesday" && dayOfWeek != "Thursday" && dayOfWeek != "Friday" {
                        dayAndDate.text = todayDateText + "(No School!)"
                        // dayAndDate.text = String(dayOfWeek) + ", " + String(monthConverter(month)) + " " + String(day) + ", " + String(year) + " " + "(No School!)"
                    }
                    
                    var displayedText = todayDateText + "(Alternate Schedule)"
                    
                    
                    dayAndDate.text = displayedText
                    
                    if displayedText.characters.count <= 38 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 17)
                    } else if displayedText.characters.count <= 40 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 16)
                    } else if displayedText.characters.count <= 42 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 15)
                    } else if displayedText.characters.count <= 45 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 14)
                    } else if displayedText.characters.count <= 47 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 13)
                    } else if displayedText.characters.count <= 50 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 12)
                    } else {
                        dayAndDate.font = UIFont.systemFont(ofSize: 11)
                    }
                    
                    
                    
                    
                }
                
            } else { // the code below is for regular schedules
                print("REGULAR SCHEDULE DAY")
                print(todayDate)
                let dayOfWeek = getDayOfWeek(today: todayDate)
                print("It looks like we passed the dayOfWeek if let successfully")
                var todayDateText1 = String(describing: dayOfWeek!) + ", "
                var todayDateText2 = String(monthConverter(month!)) + " "
                var todayDateText3 = String(describing: day!) + ", "
                var todayDateText4 = String(describing: year!) + " "
                var todayDateText = todayDateText1 + todayDateText2 + todayDateText3 + todayDateText4
                var displayedText = todayDateText + "(Regular Schedule)"
                
                dayAndDate.text = displayedText
                
                if displayedText.characters.count <= 38 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 17)
                } else if displayedText.characters.count <= 40 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 16)
                } else if displayedText.characters.count <= 42 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 15)
                } else if displayedText.characters.count <= 45 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 14)
                } else if displayedText.characters.count <= 47 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 13)
                } else if displayedText.characters.count <= 50 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 12)
                } else {
                    dayAndDate.font = UIFont.systemFont(ofSize: 11)
                }
                
                
                if dayOfWeek == "Monday" {
                    scheduleForCurrentDay.append(Period(name: "A", startTime: "8:25", endTime: "9:45"))
                    scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
                    scheduleForCurrentDay.append(Period(name: "B", startTime: "10:00", endTime: "11:15"))
                    scheduleForCurrentDay.append(Period(name: "C", startTime: "11:25", endTime: "12:40"))
                    scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:40", endTime: "1:20"))
                    scheduleForCurrentDay.append(Period(name: "F", startTime: "1:20", endTime: "2:35"))
                    
                    
                } else if dayOfWeek == "Tuesday" {
                    scheduleForCurrentDay.append(Period(name: "D", startTime: "8:25", endTime: "9:45"))
                    scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
                    scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:00", endTime: "10:50"))
                    scheduleForCurrentDay.append(Period(name: "E", startTime: "11:00", endTime: "12:15"))
                    scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
                    scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:15"))
                    scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:40"))
                    
                    
                } else if dayOfWeek == "Wednesday" {
                    scheduleForCurrentDay.append(Period(name: "B", startTime: "8:25", endTime: "9:50"))
                    scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
                    scheduleForCurrentDay.append(Period(name: "C", startTime: "10:05", endTime: "11:25"))
                    scheduleForCurrentDay.append(Period(name: "D", startTime: "11:35", endTime: "12:55"))
                    scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:55", endTime: "1:35"))
                    scheduleForCurrentDay.append(Period(name: "F", startTime: "1:35", endTime: "2:55"))
                    
                } else if dayOfWeek == "Thursday" {
                    scheduleForCurrentDay.append(Period(name: "E", startTime: "8:25", endTime: "9:50"))
                    scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
                    scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:05", endTime: "10:55"))
                    scheduleForCurrentDay.append(Period(name: "B", startTime: "11:05", endTime: "12:15"))
                    scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
                    scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:05"))
                    scheduleForCurrentDay.append(Period(name: "G", startTime: "2:15", endTime: "3:35"))
                    
                } else if dayOfWeek == "Friday" {
                    scheduleForCurrentDay.append(Period(name: "C", startTime: "8:25", endTime: "9:40"))
                    scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:40", endTime: "9:55"))
                    scheduleForCurrentDay.append(Period(name: "D", startTime: "9:55", endTime: "11:05"))
                    scheduleForCurrentDay.append(Period(name: "E", startTime: "11:15", endTime: "12:25"))
                    scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:25", endTime: "1:05"))
                    scheduleForCurrentDay.append(Period(name: "F", startTime: "1:05", endTime: "2:15"))
                    scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:35"))
                    
                } else {
                    var todayDateText1 = String(describing: getDayOfWeek) + ", "
                    var todayDateText2 = String(monthConverter(month!))
                    var todayDateText3 = " " + String(describing: day) + ", " + String(describing: year) + " "
                    var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                    displayedText = todayDateText + "(No School!)"
                    dayAndDate.text = displayedText
                    if displayedText.characters.count <= 38 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 17)
                    } else if displayedText.characters.count <= 40 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 16)
                    } else if displayedText.characters.count <= 42 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 15)
                    } else if displayedText.characters.count <= 45 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 14)
                    } else if displayedText.characters.count <= 47 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 13)
                    } else if displayedText.characters.count <= 50 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 12)
                    } else {
                        dayAndDate.font = UIFont.systemFont(ofSize: 11)
                    }
                }
                
                
                
            }
            
            
            if scheduleForCurrentDay.isEmpty {
                minutesRemaining.text = "School's out!"
            }
            
            
            let minutesPassedInDay = Int(hour! * 60 + minute!)
            var timeUntilPeriod = false
            var minutesUntil = 0
            var whichPeriod = ""
            var progressBarValue : Float = 0
            var counter = -1
            
            for y in scheduleForCurrentDay {
                counter += 1
                var hoursAndMinutesStart = y.getStartTime().components(separatedBy: ":")
                var theHoursStart : Int = Int(hoursAndMinutesStart[0])!
                if Int(theHoursStart) > 7 {
                    theHoursStart = Int(hoursAndMinutesStart[0])!
                } else {
                    theHoursStart = Int(hoursAndMinutesStart[0])! + 12
                }
                let theMinutesStart = hoursAndMinutesStart[1]
                let minutesForTimeStart = theHoursStart * 60 + Int(theMinutesStart)!
                
                if minutesPassedInDay < minutesForTimeStart {
                    minutesUntil = minutesForTimeStart - minutesPassedInDay
                    timeUntilPeriod = true
                    if y.getName().characters.count == 1 {
                        whichPeriod = "\(y.getName()) period starts"
                    } else {
                        whichPeriod = "\(y.getName()) starts"
                    }
                    if counter > 0 {
                        var hoursAndMinutesEndPrev = scheduleForCurrentDay[counter-1].getEndTime().components(separatedBy: ":")
                        let theHoursEndPrev = hoursAndMinutesEndPrev[0]
                        let theMinutesEndPrev = hoursAndMinutesEndPrev[1]
                        let minutesForTimeEndPrev = Int(theHoursEndPrev)! * 60 + Int(theMinutesEndPrev)!
                        let lengthOfGap = Float(minutesForTimeStart - minutesForTimeEndPrev)
                        let timePassedInGap = Float(minutesPassedInDay - minutesForTimeEndPrev)
                        progressBarValue = timePassedInGap / lengthOfGap
                    }
                    break
                }
                
                var hoursAndMinutesEnd = y.getEndTime().components(separatedBy: ":")
                print(hoursAndMinutesEnd)
                var theHoursEnd : Int = Int(hoursAndMinutesEnd[0])!
                if Int(theHoursEnd) > 7 {
                    theHoursEnd = Int(hoursAndMinutesEnd[0])!
                } else {
                    theHoursEnd = Int(hoursAndMinutesEnd[0])! + 12
                }
                let theMinutesEnd = hoursAndMinutesEnd[1]
                let minutesForTimeEnd = theHoursEnd * 60 + Int(theMinutesEnd)!
                
                if minutesPassedInDay < minutesForTimeEnd {
                    minutesUntil = minutesForTimeEnd - minutesPassedInDay
                    timeUntilPeriod = true
                    if y.getName().characters.count == 1 {
                        whichPeriod = "\(y.getName()) period ends"
                    } else {
                        whichPeriod = "\(y.getName()) ends"
                    }
                    let lengthOfPeriod = Float(minutesForTimeEnd - minutesForTimeStart)
                    let progressThroughPeriod  = Float(minutesPassedInDay - minutesForTimeStart)
                    progressBarValue = progressThroughPeriod / lengthOfPeriod
                    break
                }
                
            }
            
            if timeUntilPeriod {
                minutesRemaining.text = "\(minutesUntil) minutes remaining until \(whichPeriod)"
            } else {
                minutesRemaining.text = "School's out!"
                
            }
            
            if minutesRemaining.text!.characters.count > 54 {
                minutesRemaining.font = UIFont.systemFont(ofSize: 10)
            }
            
            timeProgressBar.setProgress(progressBarValue, animated: false)
            
            
            
        } else if (whichSegControl == 1) {
            let calendar = Calendar.current
            let date = Date()
            let tomorrow = (calendar as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
            let components = (calendar as NSCalendar).components([.day , .month , .year, .hour , .minute], from: tomorrow!)
            
            
            let year = components.year!
            let month = components.month!
            let day = components.day!
            let hour = components.hour!
            let minute = components.minute!
            print("Tomorrow: \(year), \(month), \(day), \(hour), \(minute)")
            
            
            var alternateScheduleDay = false
            
            var todayDate : String = String(describing: year) + "-" + String(describing: month) + "-" + String(describing: day)
            
            if month < 10 && day < 10 {
                todayDate = String(describing: year) + "-0" + String(describing: month) + "-0" + String(describing: day)
            } else if month < 10 {
                todayDate = String(describing: year) + "-0" + String(describing: month) + "-" + String(describing: day)
            } else if day < 10 {
                todayDate = String(describing: year) + "-" + String(describing: month) + "-0" + String(describing: day)
            }
            
            var theAltScheduleEvent : Event = Event()
            
            for x in 0..<events.count {
                for altDate in alternateScheduleDates {
                    if events[x].getStartDate() == todayDate && events[x].getStartDate() == altDate && events[x].getSummary()!.lowercased().range(of: "schedule") != nil && events[x].getSummary()!.lowercased().range(of: "below") != nil || events[x].getSummary()!.lowercased().range(of: "minimum day") != nil{
                        alternateScheduleDay = true
                        theAltScheduleEvent = events[x]
                        //break
                    }
                }
                //break
            }
            
            
            
            
            var holiday = false
            
            for e in events {
                if e.getStartDate() == todayDate {
                    if e.getSummary()!.range(of: "HOLIDAY") != nil || e.getSummary()!.range(of: "WINTER BREAK") != nil || e.getSummary()!.range(of: "STAFF DEVELOPMENT DAY") != nil || e.getSummary()!.range(of: "SPRING BREAK") != nil || e.getSummary()!.lowercased().range(of: "teacher work day") != nil {
                        holiday = true
                    }
                }
            }
            
            
            if (month == 6 && day > 2) || (month == 7) || (month == 8 && day < 15) || holiday { // The code below is for summer and holidays
                
                var todayDateText1 = String(describing: getDayOfWeek) + ", "
                var todayDateText2 = String(monthConverter(month))
                var todayDateText3 = " " + String(describing: day) + ", " + String(describing: year) + " "
                var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                dayAndDate.text = todayDateText + "(No School!)"
                minutesRemaining.text = "School's out!"
                timeProgressBar.setProgress(0, animated: false)
                
                adjustTextSize(dayAndDate)
                
            } else if alternateScheduleDay { // The code below is for alternate schedules
                
                let scheduleRawString = theAltScheduleEvent.getDescription()
                
                let arrayOfPeriodStrings = scheduleRawString!.components(separatedBy: "\n")
                
                var listOfPeriodsForDay : [String] = []
                var listOfStartTimesForDay : [String] = []
                var listOfEndTimesForDay : [String] = []
                for b in arrayOfPeriodStrings {
                    if !(b.isEmpty){
                        
                        // Gets array of periods for the day's schedule
                        let endIndex = getIndexOf(theString: b, character: "(") - 2
                        var periodSubstring = b[0..<endIndex+1]
                        if periodSubstring.lowercased().range(of: "period") != nil && 9 >= periodSubstring.characters.count && periodSubstring.characters.count >= 8 {
                            periodSubstring = periodSubstring[endIndex]
                        }
                        if periodSubstring.lowercased().range(of: "staff") == nil && periodSubstring.lowercased().range(of: "dept") == nil {
                            listOfPeriodsForDay.append(periodSubstring)
                        }
                        
                        // Gets array of period start times for the day's schedule
                        // let startIndex2 = Int(String(describing: b.characters.index(of: "(")!))! + 1
                        // let endIndex2 = Int(String(describing: b.characters.index(of: "-")!))!
                        let startIndex2 = getIndexOf(theString: b, character: "(") + 1
                        let endIndex2 = getIndexOf(theString: b, character: "-")
                        let periodStartTimeSubstring = b[startIndex2..<endIndex2]
                        listOfStartTimesForDay.append(periodStartTimeSubstring)
                        
                        // Gets array of period end times for the day's schedule
                        // let startIndex3 = Int(String(describing: b.characters.index(of: "-")!))! + 1
                        // let endIndex3 = Int(String(describing: b.characters.index(of: ")")!))!
                        let startIndex3 = getIndexOf(theString: b, character: "-") + 1
                        let endIndex3 = getIndexOf(theString: b, character: ")")
                        let periodEndTimeSubstring = b[startIndex3..<endIndex3]
                        listOfEndTimesForDay.append(periodEndTimeSubstring)
                    }
                }
                
                if !listOfPeriodsForDay.isEmpty {
                    for c in 0...listOfPeriodsForDay.count-1 {
                        scheduleForCurrentDay.append(Period(name: listOfPeriodsForDay[c], startTime: listOfStartTimesForDay[c], endTime: listOfEndTimesForDay[c]))
                    }
                } else {
                    var todayDateText1 = String(describing: getDayOfWeek) + ", "
                    var todayDateText2 = String(monthConverter(month))
                    var todayDateText3 = " " + String(describing: day) + ", " + String(describing: year) + " "
                    var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                    dayAndDate.text = todayDateText + "(No School!)"
                    
                }
                
                
                
                
                
                
                if let dayOfWeek = getDayOfWeek(today: todayDate){
                    print(dayOfWeek)
                    
                    if dayOfWeek != "Monday" && dayOfWeek != "Tuesday" && dayOfWeek != "Wednesday" && dayOfWeek != "Thursday" && dayOfWeek != "Friday" {
                        var todayDateText1 = String(describing: dayOfWeek) + ", "
                        var todayDateText2 = String(monthConverter(month))
                        var todayDateText3 = " " + String(describing: day) + ", " + String(describing: year) + " "
                        var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                        dayAndDate.text = todayDateText + "(No School!)"
                    }
                    
                    var todayDateText1 = String(describing: dayOfWeek) + ", "
                    var todayDateText2 = String(monthConverter(month))
                    var todayDateText3 = " " + String(describing: day) + ", " + String(describing: year) + " "
                    var todayDateText = todayDateText1 + todayDateText2! + todayDateText3
                    dayAndDate.text = todayDateText + "(No School!)"
                    var displayedText = todayDateText + "(No School!)"
                    
                    if displayedText.characters.count <= 38 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 17)
                    } else if displayedText.characters.count <= 40 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 16)
                    } else if displayedText.characters.count <= 42 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 15)
                    } else if displayedText.characters.count <= 45 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 14)
                    } else if displayedText.characters.count <= 47 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 13)
                    } else if displayedText.characters.count <= 50 {
                        dayAndDate.font = UIFont.systemFont(ofSize: 12)
                    } else {
                        dayAndDate.font = UIFont.systemFont(ofSize: 11)
                    }
                    
                    
                    
                    
                }
                
            } else { // the code below is for regular schedules
                useDefaultSchedule()
            }
            
        }
    }
    
    
    
    
    
    
    private func useDefaultSchedule() {
        
        let calendar = Calendar.current
        let date = Date()
        let tomorrow = (calendar as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
        let components = (calendar as NSCalendar).components([.day , .month , .year, .hour , .minute], from: tomorrow!)
        
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        let hour = components.hour!
        let minute = components.minute!
        print("Tomorrow: \(year), \(month), \(day), \(hour), \(minute)")
        
        var todayDateYear = String(describing: year)
        var todayDateMonth = String(describing: month)
        var todayDateDay = String(describing: day)
        print(todayDateDay)
        var todayDate : String = todayDateYear + "-" + todayDateMonth + "-" + todayDateDay
        
        if let dayOfWeek = getDayOfWeek(today: todayDate) {
            
            var part1OfDisplayedText = String(dayOfWeek) + ", " + String(monthConverter(month))
            var part2OfDisplayedText = " " + String(describing: day) + ", " + String(describing: year) + " " + "(Regular Schedule)"
            var displayedText = part1OfDisplayedText + part2OfDisplayedText
            // var displayedText = String(dayOfWeek) + ", " + String(monthConverter(month)) + " " + String(day) + ", " + String(year) + " " + "(Regular Schedule)"
            
            dayAndDate.text = displayedText
            
            if displayedText.characters.count <= 38 {
                dayAndDate.font = UIFont.systemFont(ofSize: 17)
            } else if displayedText.characters.count <= 40 {
                dayAndDate.font = UIFont.systemFont(ofSize: 16)
            } else if displayedText.characters.count <= 42 {
                dayAndDate.font = UIFont.systemFont(ofSize: 15)
            } else if displayedText.characters.count <= 45 {
                dayAndDate.font = UIFont.systemFont(ofSize: 14)
            } else if displayedText.characters.count <= 47 {
                dayAndDate.font = UIFont.systemFont(ofSize: 13)
            } else if displayedText.characters.count <= 50 {
                dayAndDate.font = UIFont.systemFont(ofSize: 12)
            } else {
                dayAndDate.font = UIFont.systemFont(ofSize: 11)
            }
            
            
            if dayOfWeek == "Monday" {
                scheduleForCurrentDay.append(Period(name: "A", startTime: "8:25", endTime: "9:45"))
                scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
                scheduleForCurrentDay.append(Period(name: "B", startTime: "10:00", endTime: "11:15"))
                scheduleForCurrentDay.append(Period(name: "C", startTime: "11:25", endTime: "12:40"))
                scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:40", endTime: "1:20"))
                scheduleForCurrentDay.append(Period(name: "F", startTime: "1:20", endTime: "2:35"))
                
                
            } else if dayOfWeek == "Tuesday" {
                scheduleForCurrentDay.append(Period(name: "D", startTime: "8:25", endTime: "9:45"))
                scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:45", endTime: "10:00"))
                scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:00", endTime: "10:50"))
                scheduleForCurrentDay.append(Period(name: "E", startTime: "11:00", endTime: "12:15"))
                scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
                scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:15"))
                scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:40"))
                
                
            } else if dayOfWeek == "Wednesday" {
                scheduleForCurrentDay.append(Period(name: "B", startTime: "8:25", endTime: "9:50"))
                scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
                scheduleForCurrentDay.append(Period(name: "C", startTime: "10:05", endTime: "11:25"))
                scheduleForCurrentDay.append(Period(name: "D", startTime: "11:35", endTime: "12:55"))
                scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:55", endTime: "1:35"))
                scheduleForCurrentDay.append(Period(name: "F", startTime: "1:35", endTime: "2:55"))
                
            } else if dayOfWeek == "Thursday" {
                scheduleForCurrentDay.append(Period(name: "E", startTime: "8:25", endTime: "9:50"))
                scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:50", endTime: "10:05"))
                scheduleForCurrentDay.append(Period(name: "FlexTime/SEL", startTime: "10:05", endTime: "10:55"))
                scheduleForCurrentDay.append(Period(name: "B", startTime: "11:05", endTime: "12:15"))
                scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:15", endTime: "12:55"))
                scheduleForCurrentDay.append(Period(name: "A", startTime: "12:55", endTime: "2:05"))
                scheduleForCurrentDay.append(Period(name: "G", startTime: "2:15", endTime: "3:35"))
                
            } else if dayOfWeek == "Friday" {
                scheduleForCurrentDay.append(Period(name: "C", startTime: "8:25", endTime: "9:40"))
                scheduleForCurrentDay.append(Period(name: "Brunch", startTime: "9:40", endTime: "9:55"))
                scheduleForCurrentDay.append(Period(name: "D", startTime: "9:55", endTime: "11:05"))
                scheduleForCurrentDay.append(Period(name: "E", startTime: "11:15", endTime: "12:25"))
                scheduleForCurrentDay.append(Period(name: "Lunch", startTime: "12:25", endTime: "1:05"))
                scheduleForCurrentDay.append(Period(name: "F", startTime: "1:05", endTime: "2:15"))
                scheduleForCurrentDay.append(Period(name: "G", startTime: "2:25", endTime: "3:35"))
                
            } else {
                var displayedText1 = String(dayOfWeek) + ", "
                var displayedText2 = String(monthConverter(month)) + " "
                var displayedText3 = String(describing: day) + ", " + String(describing: year) + " " + "(No School!)"
                displayedText = displayedText1 + displayedText2 + displayedText3
                
                dayAndDate.text = displayedText
                if displayedText.characters.count <= 38 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 17)
                } else if displayedText.characters.count <= 40 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 16)
                } else if displayedText.characters.count <= 42 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 15)
                } else if displayedText.characters.count <= 45 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 14)
                } else if displayedText.characters.count <= 47 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 13)
                } else if displayedText.characters.count <= 50 {
                    dayAndDate.font = UIFont.systemFont(ofSize: 12)
                } else {
                    dayAndDate.font = UIFont.systemFont(ofSize: 11)
                }
            }
            
            
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getIndexOf(theString: String, character: String)->Int {
        
        var endIndex = 0
        var counter = 0
        for letter in theString.characters {
            if letter == character.characters[character.startIndex] {
                endIndex = counter
            }
            counter += 1
        }
        return endIndex
        
    }
    
    func adjustTextSize(_ label: UILabel) {
        if label.text!.characters.count <= 38 {
            dayAndDate.font = UIFont.systemFont(ofSize: 17)
        } else if label.text!.characters.count <= 40 {
            dayAndDate.font = UIFont.systemFont(ofSize: 16)
        } else if label.text!.characters.count <= 42 {
            dayAndDate.font = UIFont.systemFont(ofSize: 15)
        } else if label.text!.characters.count <= 45 {
            dayAndDate.font = UIFont.systemFont(ofSize: 14)
        } else if label.text!.characters.count <= 47 {
            dayAndDate.font = UIFont.systemFont(ofSize: 13)
        } else if label.text!.characters.count <= 50 {
            dayAndDate.font = UIFont.systemFont(ofSize: 12)
        } else {
            dayAndDate.font = UIFont.systemFont(ofSize: 11)
        }
    }
    
    
    
    func getDayOfWeek(today: String)->String? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            if weekDay == 1 {
                return "Sunday"
            } else if weekDay == 2 {
                return "Monday"
            } else if weekDay == 3 {
                return "Tuesday"
            } else if weekDay == 4 {
                return "Wednesday"
            } else if weekDay == 5 {
                return "Thursday"
            } else if weekDay == 6 {
                return "Friday"
            } else  {
                return "Saturday"
            }
        } else {
            return nil
        }
    }
    
    
    func monthConverter(_ num: Int) -> String {
        if num == 1 {
            return "January"
        } else if num == 2 {
            return "February"
        } else if num == 3 {
            return "March"
        } else if num == 4 {
            return "April"
        } else if num == 5 {
            return "May"
        } else if num == 6 {
            return "June"
        } else if num == 7 {
            return "July"
        } else if num == 8 {
            return "August"
        } else if num == 9 {
            return "September"
        } else if num == 10 {
            return "October"
        } else if num == 11 {
            return "November"
        } else {
            return "December"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return scheduleForCurrentDay.count
        return scheduleForCurrentDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell", for: indexPath) as! ScheduleViewCell
        
        let row = indexPath.row
        let thePeriod = scheduleForCurrentDay[row].getName()
        
        
        cell.period.text = thePeriod
        cell.periodTime.text = String(scheduleForCurrentDay[row].getStartTime()) + "-" + String(scheduleForCurrentDay[row].getEndTime())
        
        
        if (cell.period.text!.range(of: "Regular Schedule") != nil) && whichSegControl == 2 {
            
            cell.period.font = UIFont.boldSystemFont(ofSize: 17)
            cell.periodTime.text = " "
            
        } else if cell.period.text!.characters.count > 23 {
            cell.period.font = UIFont.systemFont(ofSize: 11)
        } else {
            cell.period.font = UIFont.systemFont(ofSize: 17)
        }
        
        
        return cell
    }

    
}


extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
}
