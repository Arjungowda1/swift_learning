//
//  cStatMainViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 09/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import Charts
class cStatMainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,getval_splcSyn3 {
    func getSelectedPhase(selectedPhase: String) {
     currPhase = selectedPhase
     cStatPhase.setTitle(selectedPhase, for: .normal)
        if (currPhase == "Review 1")
        {
            fetchReviewOne()
        }
        else if (currPhase == "Review 2")
        {
            fetchReviewTwo()
        }
        else if (currPhase == "Phase 1")
        {
            fetchPhaseOne()
        }
        else
        {
            fetchPhaseTwo()
        }
        fetchNumberOfStudents()
    }
    
    @IBAction func resetPass(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email)!) { error in
          if error == nil
          {
            let myEmail = String((Auth.auth().currentUser?.email)!)
            let alert = UIAlertController(title: "Done!", message: "Reset password link has been sent to \(myEmail)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
          }
        }
    }
    
    var valueFormatter: IValueFormatter?
    var synArray:[synopsisDetails] = []
    var synArray2:[synopsisDetails] = []
    var studentArray:[studentDetails] = []
    var currPhase = ""
    var currSection = ""
    var completed:[Int] = [0]
    var currBatches:[Int] = [0]
    var synDetail:[synopsisDetails] = []
    var coordinatorArray:[coordinatorDetails] = []
    var completedSynopsisReview1 = 0
    var completedSynopsisReview2 = 0
    var completedSynopsisPhase1 = 0
    var completedSynopsisPhase2 = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return synArray2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cStatCell") as! cStatTableViewCell
        if synArray2.count == 0
        {
            cell.batch.text = ""
            cell.submi.text = ""
        }
        else
        {
            let synObj = synArray2[indexPath.row]
            cell.batch.text = synObj.batchNum
            if synObj.coordinatorStatus == ""
            {
                cell.submi.text = "Not submitted"
            }
            else
            {
                cell.submi.text = synObj.coordinatorStatus
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 50
          
      }
    
    @IBOutlet var cStatPhase: UIButton!
    @IBOutlet weak var sectionChartView: BarChartView!
    @IBOutlet weak var batchChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoord()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cStatPhaseFunc(_ sender: UIButton) {
        let popcontrol =  self.storyboard?.instantiateViewController(withIdentifier: "cSynPhase") as! cSynPhaseViewController
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
    
    func fetchReviewOne()
    {
        self.completedSynopsisReview1 = 0
        fetchDetails().getSynopsisReviewOne { (synData, error) in
            self.synArray2.removeAll()
         self.synArray.removeAll()
         if synData.count > 0
         {
         // print(batchData.count)
          self.synArray = synData as! [synopsisDetails]
          print("syn array : \(self.synArray)")
          if self.synArray.count > 0
          {
           for i in 0...(self.synArray.count - 1)
           {
            if self.synArray[i].section == self.currSection
            {
                if (self.synArray[i].progressSynCoord! + self.synArray[i].progressSynGuide!) == 2
                {
                    self.completedSynopsisReview1 += 1
                }
                self.synArray2.append(self.synArray[i])
            }
           }
            self.displayChart1(ph: "Review 1")
          }

         }
         self.statsTableView.reloadData()
        }
    }
    
    func fetchReviewTwo()
    {
        self.completedSynopsisReview2 = 0
        fetchDetails().getSynopsisReviewTwo { (synData, error) in
            self.synArray2.removeAll()
         self.synArray.removeAll()
         if synData.count > 0
         {
         // print(batchData.count)
          self.synArray = synData as! [synopsisDetails]
          print("syn array : \(self.synArray)")
          if self.synArray.count > 0
          {
           for i in 0...(self.synArray.count - 1)
           {
            if self.synArray[i].section == self.currSection
            {
                if (self.synArray[i].progressSynCoord! + self.synArray[i].progressSynGuide!) == 2
                {
                    self.completedSynopsisReview2 += 1
                }
                self.synArray2.append(self.synArray[i])
            }
           }
            self.displayChart1(ph: "Review 2")
          }

         }
         self.statsTableView.reloadData()
        }
    }
    
    func fetchPhaseOne()
    {
        self.completedSynopsisPhase1 = 0
        fetchDetails().getSynopsisPhaseOne { (synData, error) in
            self.synArray2.removeAll()
         self.synArray.removeAll()
         if synData.count > 0
         {
         // print(batchData.count)
          self.synArray = synData as! [synopsisDetails]
          print("syn array : \(self.synArray)")
          if self.synArray.count > 0
          {
           for i in 0...(self.synArray.count - 1)
           {
            if self.synArray[i].section == self.currSection
            {
                if (self.synArray[i].progressSynCoord! + self.synArray[i].progressSynGuide!) == 2
                {
                    self.completedSynopsisPhase1 += 1
                }
                self.synArray2.append(self.synArray[i])
            }
           }
            self.displayChart1(ph: "Phase 1")
          }

         }
         self.statsTableView.reloadData()
        }
    }
    
    func fetchPhaseTwo()
        {
            self.completedSynopsisPhase2 = 0
            fetchDetails().getSynopsisPhaseTwo { (synData, error) in
                self.synArray2.removeAll()
             self.synArray.removeAll()
             if synData.count > 0
             {
             // print(batchData.count)
              self.synArray = synData as! [synopsisDetails]
              print("syn array : \(self.synArray)")
              if self.synArray.count > 0
              {
                for i in 0...(self.synArray.count - 1)
               {
                if self.synArray[i].section == self.currSection
                {
                    if (self.synArray[i].progressSynCoord! + self.synArray[i].progressSynGuide!) == 2
                    {
                        self.completedSynopsisPhase1 += 1
                    }
                    self.synArray2.append(self.synArray[i])
                }
               }
                self.displayChart1(ph: "Phase 2")
              }
             }
             self.statsTableView.reloadData()
            }
        }
    
    func getCoord()
    {
        self.coordinatorArray.removeAll()
        fetchDetails().getCoordinatorDetails(userId: Auth.auth().currentUser!.uid, callback:
         { (coordData, error) in
          
          self.coordinatorArray = coordData as? [coordinatorDetails] ?? []
          print(self.coordinatorArray.count)
          if(self.coordinatorArray.count > 0)
          {
           // obtain role from the extracted data
           for i in self.coordinatorArray
           {
            print("sectionnn : \(i.section!)")
            self.currSection = i.section!
           }
          }
        })
    }
    
    @IBOutlet weak var statsTableView: UITableView!
    
    func fetchNumberOfStudents(){
     let db1 = Database.database().reference()
     let update1 = db1.child("studentDetails")
     completed = [0]
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
         case "Review 1":
          switch i.section{
           case "A":
            if i.progressReview1 == 3
            {
             self.completed[0] += 1
            }
           default: break
         }
         case "Review 2":
          switch i.section{
           case "A":
            if i.progressReview2 == 3
            {
             self.completed[0] += 1
            }
           default: break
         }
         case "Phase 1":
          switch i.section{
           case "A":
            if i.progressPhase1 == 3
            {
             self.completed[0] += 1
            }
           default: break
         }
         case "Phase 2":
          switch i.section{
           case "A":
            if i.progressPhase2 == 3
            {
             self.completed[0] += 1
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
         var sections = [currSection]
         var dataEntries: [BarChartDataEntry] = []
         var dataEntries1: [BarChartDataEntry] = []
         var dataEntries2: [BarChartDataEntry] = []

        for i in 0..<completed.count {
         let dataEntry = BarChartDataEntry(x: Double(i), y: Double(completed[i]))
         
          //BarChartDataEntry(x:sections[i], completed:[Double(i)])
         dataEntries.append(dataEntry)
         
         }
         let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Number of students who gave presentation")
         let chartData = BarChartData(dataSets: [chartDataSet])
         chartDataSet.setColor(UIColor.blue, alpha: 0.30)
         chartData.barWidth = 0.7
         chartData.setDrawValues(true)
         sectionChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sections)
         
         sectionChartView.drawBordersEnabled = false
         
    //     sectionChartView.data?.setValueFormatter(valueFormatter!)
         
         sectionChartView.data = chartData
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
     
     let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "batches whose synopsis/PPT got accepted by guide&coordinator")
     
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
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
           return UIModalPresentationStyle.none
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    @IBAction func logout(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let IntroVC = storyboard.instantiateViewController(withIdentifier: "Mainview") as! ViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = IntroVC
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
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
