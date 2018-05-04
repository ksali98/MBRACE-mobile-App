//
//  SuccessfulSetupViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SuccessfulSetupViewController: UIViewController {

    // Class variables
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add button effects
        effectUtils.addButtonFeatures(button: self.connectButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectAction(_ sender: Any) {
        /* Action method to navigate to main menu navigation controller
         
         args:
            - sender (Any)
         returns:
            - void
         */
        let menuNav = self.storyboard?.instantiateViewController(withIdentifier: "mainNavController") as! UINavigationController
        self.present(menuNav, animated: true, completion: nil)
    }
}
