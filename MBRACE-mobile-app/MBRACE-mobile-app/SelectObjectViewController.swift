//
//  SelectObjectViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 5/7/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SelectObjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // View controller outlets
    @IBOutlet weak var tableview: UITableView!
    
    // Class attributes
    var filepath: String!
    var parser: CSVDataParser!
    
    // Class constants
    let SECTION_COUNT = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.tableFooterView = UIView()
        
        if (filepath == nil) {
            let alertvc = UIAlertController(title: "Error", message: "File path has not been set. Try again.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            })
            alertvc.addAction(closeAction)
            self.present(alertvc, animated: true, completion: nil)
        } else {
            self.parser = CSVDataParser(filepath: self.filepath)
            self.tableview.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        /* Tableview delegate method to set the number of rows in the tableview
         
         args:
            - tableView (UITableView)
         returns:
            - Int
         */
        return self.SECTION_COUNT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Tableview delegate method to set the number of rows in each section
         
         args:
            - tableView (UITableView)
            - section (Int)
         returns:
            - Int
         */
        
        // Make sure parser object has been set
        if (self.parser == nil) {
            return 0
        }
        return parser.getObjectCount() + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Tableview delegate method to set the cell for the row at a specific index path
         
         args:
            - tableView (UITableView)
            - indexPath (IndexPath)
         returns:
            - UITableViewCell
         */
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "objectCell")
        
        // Make sure parser object has been set
        if (parser == nil) {
            return cell!
        } else if (indexPath.row == parser.getObjectCount()) {
            cell?.textLabel?.text = "All Objects (Coming soon)"
        } else {
            cell?.textLabel?.text = "Object \(indexPath.row + 1)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Tableview delegate method called when a cell is selected
         
         args:
            - tableView (UITableView)
            - indexPath (IndexPath)
         returns:
            - void
         */
        self.tableview.deselectRow(at: indexPath, animated: true)
        var data: [Any]!
        if indexPath.row == parser.getObjectCount() {
            // Will implement in the future
            return
        } else {
            data = parser.getDataForObject(index: indexPath.row)
        }
        let lineGraphvc = LineChartTimeViewController()
        lineGraphvc.data = data
        self.navigationController?.pushViewController(lineGraphvc, animated: true)
    }
}
