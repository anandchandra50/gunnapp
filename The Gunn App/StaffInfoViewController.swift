//
//  StaffInfoViewController.swift
//  TheGunnApp
//
//  Created by Xavi Loinaz on 7/11/16.
//  Copyright © 2016 Xavi Loinaz. All rights reserved.
//

import UIKit
import MessageUI


class StaffInfoViewController: UIViewController,MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var goToWebsiteButton: UIButton!
    
    
    var staffs = [Staff]()
    var thisStaff : Staff = Staff()
    
    override func viewDidLoad() {
        let specialColor = UIColor(red: 255.0/255.0, green: 14.0/255.0, blue: 14.0/255.0, alpha: 1.0)
        navigationController!.navigationBar.barTintColor = specialColor
        super.viewDidLoad()
        
//        let instance = StaffTableViewController()
        
//        var staffs = instance.getStaffs()
        
//        var staff = staffs[indexPath.row]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        loadStaffList()
        
        teacherName.text = thisStaff.getName()
        position.text = thisStaff.getPosition()
        department.text = thisStaff.getDepartment()
        phoneNumber.text = thisStaff.getPhoneNumber()
        
        if thisStaff.getWebsite() != " " && thisStaff.getWebsite() != "" {
            goToWebsiteButton.isHidden = false
        } else {
            goToWebsiteButton.isHidden = true
        }
        
        if teacherName.text!.characters.count > 20 {
            teacherName.font = UIFont.systemFont(ofSize: 24)
        }
        
        
    }

    @IBAction func emailTeacher() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    
    @IBAction func goToWebsite() {
        if let website = thisStaff.getWebsite(){
            var websiteEdit = website
            websiteEdit.remove(at: websiteEdit.characters.index(before: websiteEdit.endIndex))
            if let checkURL = URL(string: websiteEdit) {
                if UIApplication.shared.openURL(checkURL) {
                    print("url successfully opened")
                }
            } else {
                print("invalid url")
            }
        }
        
    }
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let email = thisStaff.getEmail()
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([email])
//        mailComposerVC.setSubject("Sending you an in-app e-mail...")
//        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWith result: MFMailComposeResult, error: Error!) {
        controller.dismiss(animated: true, completion: nil)
        
    }

    
}
