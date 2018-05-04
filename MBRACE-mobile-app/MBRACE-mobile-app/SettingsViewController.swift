//
//  SettingsViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/21/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    /* View controller class to modify server connection parameters */

    // View controller outlets
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var port: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
        
        // Update fields with current hostname and port
        self.hostname.text = serverInfo.hostname
        if serverInfo.port != 0 || serverInfo.port != -1 {
            self.port.text = String(serverInfo.port)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        /* Method to save new server information settings
         
         args:
            - sender (Any)
         returns:
            Void
         */
        if ((self.hostname.text?.isEmpty)!) {
            // Host name has not be set
            effectUtils.showDefaultAlertWithCloseAction(controller: self, title: "Error", message: "Host Name field is required.")
            return
        } else if ((self.port.text?.isEmpty)!) {
            // Only using domain name. Set port to -1
            // Verify user does not want to use a port
            let warningAlert = UIAlertController(title: "Sure?", message: "Are you sure you do not need a port?", preferredStyle: .alert)
            
            // Create yes action
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                serverInfo.hostname = self.hostname.text!
                serverInfo.port = -1
                self.navigationController?.popViewController(animated: true)
            })
            // Create no action
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            // Add actions
            warningAlert.addAction(yesAction)
            warningAlert.addAction(noAction)
            
            self.present(warningAlert, animated: true, completion: nil)
        } else {
            // Using both hostname and port
            serverInfo.hostname = self.hostname.text!
            serverInfo.port = Int(self.port.text!)!
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
