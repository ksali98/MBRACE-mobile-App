//
//  MenuViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/18/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /* View controller class used as a main menu controller for navigating through specific app views.
     
     Note:
        - To add a menu item:
            1. Add the string name to the menuItemNames list
            2. Add a case for that string name in the menuItems enumeration
            3. Add a case for the enumeration case in the tableview delegate didSelectRowAt
     */
    
    // View controller outlets
    @IBOutlet weak var tableview: UITableView!
    
    // Class constant attributes
    let menuItemNames = ["Live Stream (Coming Soon)", "Analysis By Date", "Settings"]
    let numberOfSections = 1
    
    // Class specific enumerations
    enum menuItems: Int {
        case liveStream = 0, analysisByDate, settings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableview.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        /* Method to set the number of sections in the tableview
         
         args:
            - tableView (UITableView)
         returns:
            - Int
         */
        return self.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Delegate Method to set the number of rows in a given section for the tableview
         
         args:
            - tableView (UITableView)
            - section (Int)
         returns:
            Int
         */
        return self.menuItemNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Delegate Method to set the cell for a given row in the tableview
         
         args:
            - tableView (the selected UITableView)
            - indexPath (IndexPath object)
         returns:
            - UITableViewCell
         */
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "menuTableCell")
        cell?.textLabel?.text = self.menuItemNames[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Delegate Method called when a table view row cell has been selected
         
         args:
            - tableView (UITableView)
            - indexPath (IndexPath)
         returns:
            - void
         */
        
        // Deselect selected row so app does not appear broken
        self.tableview.deselectRow(at: indexPath, animated: true)
        
        var nextViewController: UIViewController!
        switch indexPath.row {
        case menuItems.liveStream.rawValue:
            // TODO: Go to live stream controller
            break
        case menuItems.analysisByDate.rawValue:
            // Date selected
            nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectDateViewController") as! SelectDateViewController
            break
        case menuItems.settings.rawValue:
            // Settings selected
            nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            break
        default:
            break
        }
        // Check if nextViewController has been set. If so, push it in the navigation controller
        if nextViewController != nil {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
