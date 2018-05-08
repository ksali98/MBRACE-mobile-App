//
//  csvparser.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/11/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import Foundation

class CSVDataParser {
    /* Class to help with parsing data from a csv file
     
     This class is only used for csv files, and works for no other files. There isn't any error checking to see if the file is a csv file, so be sure to pass in a csv file when instantiating this class.
     */
    
    // Class attributes
    private var data: [[Int]]!
    private var object_count: Int!
    
    // Class constants
    private let ERROR_CODE = -1
    
    init(filepath: String) {
        /* Class constructor, starts reading data from file and parsing it
         
         args:
            - filepath (String)
         returns:
            - void
         */
        let filecontent = self._readDataFromFile(filepath: filepath)
        if !filecontent.isEmpty {
            self.data = self._parseData(data: filecontent)
        }
    }
    
    private func _readDataFromFile(filepath: String) -> String {
        /* Method to read the data from the csv file
         
         args:
            - filepath (String)
         returns:
            - String
         */
        do {
            // Get the file contents and clean them by removing any double new lines and empty spaces
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = contents.replacingOccurrences(of: "\n\n", with: "\n")
            contents = contents.replacingOccurrences(of: " ", with: "")
            return contents
        } catch {
            print("Error reading data from file.")
            return ""
        }
    }
    
    private func _parseData(data: String) -> [[Int]] {
        /* Method to parse a string of csv data
         
         args:
            - data (String)
         returns:
            - [[Int]]
         */
        var result: [[Int]] = []
        
        // Get rows from data
        let rows = data.components(separatedBy: "\n")
        
        for row in rows {
            // Get columns from current row
            if row.isEmpty {
                continue
            }
            let cols = row.components(separatedBy: ",")
            
            if self.object_count == nil {
                // Set the object count if it hasn't been set yet
                // The object count will be the nunbmer of columns in the data (Column count should be uniform for each row)
                self.object_count = cols.count
            }
            
            // Store the data in the results array
            for index in 0..<cols.count {
                if !result.indices.contains(index) {
                    result.append([])
                }
                let value = Int(cols[index])
                result[index].append(value!)
            }
        }
        return result
    }
    
    func getObjectCount() -> Int {
        /* Method to get the object count for the data
         
         args:
            None
         returns:
            - Int
         */
        if self.object_count != nil {
            // Data object has been set.
            return self.object_count
        } else {
            // Data object is nil. Error
            return self.ERROR_CODE
        }
    }
    
    func getAllData() -> [[Int]] {
        /* Method to get all the data from the csv
         
         args:
            None
         returns:
            - [[Int]]
         */
        if self.data != nil {
            // Data exists. return it
            return self.data
        } else {
            // Error getting data. return empty list
            return []
        }
    }
    
    func getDataForObject(index: Int) -> [Int] {
        /* Method to get data for a particular object index
         
         args:
            - index (Int)
         returns:
            - [Int]
         */
        if self.data != nil {
            // Data exists. return it
            return self.data[index]
        } else {
            // Error getting data. return empty list
            return []
        }
    }
}
