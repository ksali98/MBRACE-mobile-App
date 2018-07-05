//
//  LineChartTimeViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

class LineChartTimeViewController: DemoBaseViewController {
    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var currentTimeViewingLabel: UILabel!
    
    var data: [Any]!
    var objectIndex: Int!
    var current_position: Int!
    var total_item_count: Int!
    var subset_item_count: Int!
    var start_index: Int!
    var end_index: Int!
    
    // Constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Analyis for Object \(self.objectIndex + 1)"
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleHorizontalCubic,
                        .toggleStepped,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.highlightPerDragEnabled = true
        
        chartView.backgroundColor = .white
        
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .insideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 170
        leftAxis.yOffset = -9
        leftAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)

        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        chartView.animate(xAxisDuration: 2.5)
        
        if (self.data != nil) {
            self.current_position = 1
            self.total_item_count = self.data.count
            self.subset_item_count = Int(self.total_item_count / 4)
            self.updateChartData()
        } else {
            // Set data count checks for nil as well and reports an error message
            // So we use it here
            self.setDataCount()
        }
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        self.currentTimeViewingLabel.text = CURRENT_TIME_VIEW_STRINGS[self.current_position - 1]
        let main_index = self.subset_item_count * self.current_position
        self.end_index = main_index - 1
        self.start_index = main_index - self.subset_item_count
        
        print("Total: \(self.total_item_count)")
        print("Subset Total: \(self.subset_item_count)")
        print("Current Position: \(self.current_position)")
        print("Start Index: \(self.start_index)")
        print("End Index: \(self.end_index)")
        self.setDataCount()
    }
    
    @IBAction func previousTimeFrameAction(_ sender: Any) {
        /* Action method for toggling the previous time frame before the current one
         
         args:
            - sender (Any)
         returns:
            - void
         */
        if (self.current_position == 1) { return }
        self.current_position = self.current_position - 1
        self.updateChartData()
    }
    
    @IBAction func nextTimeFrameAction(_ sender: Any) {
        /* Action method for toggling the next time frame after the current one
         
         args:
            - sender (Any)
         returns:
            - void
         */
        if (self.current_position == 4) { return }
        self.current_position = self.current_position + 1
        self.updateChartData()
    }
    
    func setDataCount() {
        if (self.data != nil) {
            let new_subset = self.data[self.start_index...self.end_index]
            let dataEntries = stride(from: self.start_index, to: self.end_index, by: 1).map { (index) -> ChartDataEntry in
                return ChartDataEntry(x: Double(index), y: Double(new_subset[index] as! Int))
            }
            
            let set1 = LineChartDataSet(values: dataEntries, label: "Object \(self.objectIndex) DataSet")
            set1.axisDependency = .left
            set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
            set1.lineWidth = 1.5
            set1.drawCirclesEnabled = false
            set1.drawValuesEnabled = false
            set1.fillAlpha = 0.26
            set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
            set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set1.drawCircleHoleEnabled = false
            
            let data = LineChartData(dataSet: set1)
            data.setValueTextColor(.white)
            data.setValueFont(.systemFont(ofSize: 9, weight: .light))
            chartView.data = data
        } else {
            // Error
            let alertvc = UIAlertController(title: "Error", message: "Data for object has not been set. Try again.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            })
            alertvc.addAction(closeAction)
            self.present(alertvc, animated: true, completion: nil)
        }
    }
    
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleFilled:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCircles:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        case .toggleStepped:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView.setNeedsDisplay()
            
        case .toggleHorizontalCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }
}
