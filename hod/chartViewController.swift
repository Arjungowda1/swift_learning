//
//  chartViewController.swift
//  trackPro
//
//  Created by iOSLevel1 on 13/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import Charts

class chartViewController: UIViewController,UIPopoverPresentationControllerDelegate ,hodGetPhase {
    func getSelectedPhase(selectedPhase: String) {
        selectPhase.setTitle(selectedPhase, for: .normal)
        currPhase = selectedPhase
        //"Review 1","Review 2","Phase 1- Presentation","Phase 1- Synopsis","Phase 2- Presentation","Phase 2- Synopsis"
        switch currPhase {
         case "Review 1- Presentation","Review 2- Presentation","Phase 1- Presentation","Phase 2- Presentation":
          fetchNumberOfStudents()
        case "Review 1- Synopsis":
            fetchSynReview1()
        case "Review 2- Synopsis":
            fetchSynReview2()
         case "Phase 1- Synopsis":
         fetchSynPhase1()
        case "Phase 2- Synopsis":
            fetchSynPhase2()
         default:
         break
        }
        let batches = Array(Set(currBatches))
        print("Batches: \(batches)")
        print("Completed: \(completed)")
    }
    
    var valueFormatter: IValueFormatter?
    var studentArray:[studentDetails] = []
    var synArray:[synopsisDetails] = []
    var currBatches:[Int] = [0]
    var completedSynopsisReview1 = 0
    var completedSynopsisReview2 = 0
    var completedSynopsisPhase1 = 0
    var completedSynopsisPhase2 = 0
    var allBatches = [0]
    var currPhase = ""
    var sectionA = "A"
    var sectionB = "B"
    var sectionC = "C"
    var completed:[Int] = [0]

    @IBOutlet weak var sectionChartView: BarChartView!
    @IBOutlet weak var batchChartView: BarChartView!
    @IBOutlet weak var selectPhase: UIButton!
    
    @IBAction func selectedPhase(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "phaseSelection2") as! chartPhaseViewController
        // popcontrol.spec = true
        //popcontrol.somestring = rows2[indexPath.row]
        popcontrol.delegate = self
        popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
        popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popcontrol.preferredContentSize.height = 200
        popcontrol.preferredContentSize.width = 200
        popcontrol.popoverPresentationController?.delegate = self
        popcontrol.popoverPresentationController?.sourceView = sender
        popcontrol.popoverPresentationController?.sourceRect = sender.bounds
        self.present(popcontrol, animated: true, completion: nil)
    }
    
    func fetchNumberOfStudents(){
      let db1 = Database.database().reference()
      let update1 = db1.child("studentDetails")
      completed = [0,0,0]
      fetchDetails().getAllStudentDetails { (stuData, error) in
       self.studentArray.removeAll()
       if stuData.count > 0
       {
        self.studentArray = stuData as! [studentDetails]
       if self.studentArray.count > 0
       {
        for i in self.studentArray
        {
         self.currBatches.append(i.batch!)
         switch self.currPhase {
          case "Review 1- Presentation":
           switch i.section{
            case "A":
             if i.progressReview1 == 3
             {
              self.completed[0] += 1
             }
            case "B":
             if i.progressReview1 == 3
             {
              self.completed[1] += 1
             }
            case "C":
             if i.progressReview1 == 3
             {
              self.completed[2] += 1
             }
            default: break
          }
          case "Review 2- Presentation":
           switch i.section{
            case "A":
             if i.progressReview2 == 3
             {
              self.completed[0] += 1
             }
            case "B":
             if i.progressReview2 == 3
             {
              self.completed[1] += 1
             }
            case "C":
             if i.progressReview2 == 3
             {
              self.completed[2] += 1
             }
            default: break
          }
          case "Phase 1- Presentation":
           switch i.section{
            case "A":
             if i.progressPhase1 == 3
             {
              self.completed[0] += 1
             }
            case "B":
             if i.progressPhase1 == 3
             {
              self.completed[1] += 1
             }
            case "C":
             if i.progressPhase1 == 3
             {
              self.completed[2] += 1
             }
            default: break
          }
          case "Phase 2- Presentation":
           switch i.section{
            case "A":
             if i.progressPhase2 == 3
             {
              self.completed[0] += 1
             }
            case "B":
             if i.progressPhase2 == 3
             {
              self.completed[1] += 1
             }
            case "C":
             if i.progressPhase2 == 3
             {
              self.completed[2] += 1
             }
            default: break
          }
          default:
           break
         }
        }
        let batches = Array(Set(self.currBatches))
        print("Batches: \(batches)")
        print("Completed: \(self.completed)")
        
        self.displayChart()
       }
      }
      }
     }
    
    func displayChart()
    {
     var sections = ["A","B","C"]
     var dataEntries: [BarChartDataEntry] = []
     var dataEntries1: [BarChartDataEntry] = []
     var dataEntries2: [BarChartDataEntry] = []

    for i in 0..<completed.count {
     let dataEntry = BarChartDataEntry(x: Double(i), y: Double(completed[i]))
     
      //BarChartDataEntry(x:sections[i], completed:[Double(i)])
     dataEntries.append(dataEntry)
     
     }
     let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Sections")
     let chartData = BarChartData(dataSets: [chartDataSet])
     //  BarChartData(xVals: months, dataSet: chartDataSet)
     chartDataSet.setColor(UIColor.blue, alpha: 0.30)
     chartData.barWidth = 0.7
     chartData.setDrawValues(true)
     sectionChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sections)
     
     sectionChartView.drawBordersEnabled = false
     
//     sectionChartView.data?.setValueFormatter(valueFormatter!)
     
     sectionChartView.data = chartData
     
     //Display chart batch wise
     
    // let dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(completedSynopsisPhase1))
    //
    // let chartDataSet1 = BarChartDataSet(entries: dataEntries, label: "Batches completed")
    //
    // let chartData1 = BarChartData(dataSets: [chartDataSet1])
    // //  BarChartData(xVals: months, dataSet: chartDataSet)
    // chartDataSet1.setColor(UIColor.green, alpha: 0.30)
    // chartData1.barWidth = 0.7
    // chartData1.setDrawValues(true)
    //// batchChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sections)
    //
    // batchChartView.drawBordersEnabled = false
    //
    //// sectionChartView.data?.setValueFormatter(valueFormatter!)
    //
    // batchChartView.data = chartData1

     }
     
    func displayChart1(ph:String)
     {
      var dataEntries1: [BarChartDataEntry] = []
        var dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(0))
        dataEntries1.append(dataEntry1)
        switch ph {
        case "Review 1":
             dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(completedSynopsisReview1))
        case "Review 2":
             dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(completedSynopsisReview2))
        case "Phase 1":
             dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(completedSynopsisPhase1))
        case "Phase 2":
             dataEntry1 = BarChartDataEntry(x: Double(1), y: Double(completedSynopsisPhase2))
        default:
            break
        }
      dataEntries1.append(dataEntry1)
      
      let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Batches completed")
      
      let chartData1 = BarChartData(dataSets: [chartDataSet1])
      //  BarChartData(xVals: months, dataSet: chartDataSet)
      chartDataSet1.setColor(UIColor.green, alpha: 0.30)
      chartData1.barWidth = 0.4
      chartData1.setDrawValues(true)
      // batchChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sections)
      
      batchChartView.drawBordersEnabled = false
      
      // sectionChartView.data?.setValueFormatter(valueFormatter!)
      
      batchChartView.data = chartData1

     }
    
     /* func setChart(dataPoints: [String], values: [Double]) {
      barChartView.noDataText = "You need to provide data for the chart."
      var dataEntries: [BarChartDataEntry] = []
      
      for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(x: values[i], yValues:[Double(i)])
      //BarChartDataEntry(value: values[i], xIndex: i)
      
      dataEntries.append(dataEntry)
      //barChartView.descriptionText = ""
      
      }
      
      let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
      let chartData = BarChartData(dataSets: [chartDataSet])
      //  BarChartData(xVals: months, dataSet: chartDataSet)
      barChartView.data = chartData
      chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
      
      }
    */
    
    func fetchSynReview1()
    {
        self.completedSynopsisReview1 = 0
     let db1 = Database.database().reference()
     let update1 = db1.child("SynopsisAndPPT").child("Review 1")
     fetchDetails().getSynopsisReviewOne(callback: { (synData, error) in
        self.synArray.removeAll()
      if synData.count > 0
      {
       self.synArray = synData as! [synopsisDetails]
       if self.synArray.count > 0
       {
        for i in self.synArray
        {
         self.allBatches.append(Int(i.batchNum!)!)
         if (i.progressSynCoord! + i.progressSynGuide!) == 2
         {
          self.completedSynopsisReview1 += 1
         }
        }
        self.displayChart1(ph: "Review 1")
      }
      }
     })
     }
    
    func fetchSynReview2()
    {
        self.completedSynopsisReview2 = 0
     let db1 = Database.database().reference()
     let update1 = db1.child("SynopsisAndPPT").child("Review 2")
     fetchDetails().getSynopsisReviewTwo(callback: { (synData, error) in
        self.synArray.removeAll()
      if synData.count > 0
      {
       self.synArray = synData as! [synopsisDetails]
       if self.synArray.count > 0
       {
        for i in self.synArray
        {
         self.allBatches.append(Int(i.batchNum!)!)
         if (i.progressSynCoord! + i.progressSynGuide!) == 2
         {
          self.completedSynopsisReview2 += 1
         }
        }
       self.displayChart1(ph: "Review 2")
      }
      }
     })
     }
    
    func fetchSynPhase1()
    {
        self.completedSynopsisPhase1 = 0
     let db1 = Database.database().reference()
     let update1 = db1.child("SynopsisAndPPT").child("Phase 1")
     fetchDetails().getSynopsisPhaseOne(callback: { (synData, error) in
        self.synArray.removeAll()
      if synData.count > 0
      {
       self.synArray = synData as! [synopsisDetails]
       if self.synArray.count > 0
       {
        for i in self.synArray
        {
         self.allBatches.append(Int(i.batchNum!)!)
         if (i.progressSynCoord! + i.progressSynGuide!) == 2
         {
          self.completedSynopsisPhase1 += 1
         }
        }
        self.displayChart1(ph: "Phase 1")
      }
      }
     })
     }
     
     func fetchSynPhase2()
     {
        self.completedSynopsisPhase2 = 0
      let db1 = Database.database().reference()
      let update1 = db1.child("SynopsisAndPPT").child("Phase 2")
      fetchDetails().getSynopsisPhaseTwo(callback: { (synData, error) in
        self.synArray.removeAll()
       if synData.count > 0
       {
        self.synArray = synData as! [synopsisDetails]
        if self.synArray.count > 0
        {
         for i in self.synArray
         {
          self.allBatches.append(Int(i.batchNum!)!)
          if (i.progressSynCoord! + i.progressSynGuide!) == 2
          {
           self.completedSynopsisPhase2 += 1
          }
         }
           self.displayChart1(ph: "Phase 2")
        }
       }
      })
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
