//
//  SetupViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    // Class variables
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var port: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add button effects
        appUtils.addButtonFeatures(button: self.saveButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        /* Action to save changes made to server settings
         
         args:
         - sender: Any
        
         returns:
         - Void
         */
        if ((self.hostname.text?.isEmpty)!) {
            // Error
            appUtils.showDefaultAlertWithCloseAction(controller: self, title: "Error", message: "Host Name field is required.")
            return
        } else if ((self.port.text?.isEmpty)!) {
            // Only using domain name. Set port to -1
            let warningAlert = UIAlertController(title: "Sure?", message: "Are you sure you do not need a port?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                serverInfo.hostname = self.hostname.text!
                serverInfo.port = -1
                self.showSuccessController()
            })
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            warningAlert.addAction(yesAction)
            warningAlert.addAction(noAction)
            self.present(warningAlert, animated: true, completion: nil)
        } else {
            // Using both hostname and port
            serverInfo.hostname = self.hostname.text!
            serverInfo.port = Int(self.port.text!)!
            self.showSuccessController()
        }
    }
    
    func showSuccessController() {
        // Show successful setup view controller
        let success = self.storyboard?.instantiateViewController(withIdentifier: "SuccessfulSetupViewController") as! SuccessfulSetupViewController
        self.present(success, animated: true, completion: nil)
    }
}
