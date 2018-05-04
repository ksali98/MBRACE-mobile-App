//
//  FirstLaunchViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {
    /* View controller class used for when the app is first launched.
     
     This view controller simply displays a description about the app and allows the user to nagivate to setting up their app
     */

    // View controller outlets
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add button effects
        effectUtils.addButtonFeatures(button: self.startButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAction(_ sender: Any) {
        /* Action method to start the app, which means navigate to the setup view controller
         
         args:
            - sender (Any)
         returns:
            - void
         */
        let settings = self.storyboard?.instantiateViewController(withIdentifier: "SetupViewController") as! SetupViewController
        self.present(settings, animated: true, completion: nil)
    }
}
