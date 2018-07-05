//
//  SetupViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController, UITextFieldDelegate {
    /* View controller class used to set up the server information */

    // Class atributes
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var port: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add button effects
        effectUtils.addButtonFeatures(button: self.saveButton)
        self.hostname.delegate = self
        self.port.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        /* Action method to save changes made to server settings
         
         args:
            - sender (Any)
         returns:
            - void
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
                self.showSuccessController()
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
            self.showSuccessController()
        }
    }
    
    func showSuccessController() {
        /* Method to present the successful setup view controller
         
         args:
            None
         returns:
            - void
         */
        let success = self.storyboard?.instantiateViewController(withIdentifier: "SuccessfulSetupViewController") as! SuccessfulSetupViewController
        self.present(success, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
