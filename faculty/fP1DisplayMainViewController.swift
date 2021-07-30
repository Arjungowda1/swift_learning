//
//  fP1DisplayMainViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 22/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth

class fP1DisplayMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_spl_f,getval_spl_f2,getval_spl_f3 {
    func getSelectedSection(selectedSection: String){
        print("Reaching..")
        curSection = selectedSection
        fP1Section.setTitle(selectedSection, for: .normal)
        
        fetchSectionData()
    }
    func getSelectedBatch(selectedBatch: String) {
        curSection = selectedBatch
     fP1Batch.setTitle(selectedBatch, for: .normal)
     currBatch = Int(selectedBatch)!
        print(currBatch)
     fetchBatchData()

    }
    func getSelectedUsn(selectedUsn: String) {
               currUsn = selectedUsn
               fP1Usn.setTitle(selectedUsn, for: .normal)
            self.literatureSurvey.text = "-"
                self.methodologe.text = "-"
                self.implementation.text = "-"
                self.presentation.text = "-"
                self.vivavoice.text = "-"
                self.total.text = "-"
                self.semFour.text = "-"
                self.semFive.text = "-"
                self.semSix.text = "-"
            
                     fetchPhase1marks()
                    fetchGrades()
        }
    
    @IBOutlet weak var selectPhase: UISegmentedControl!
    @IBAction func selectPhaseAction(_ sender: UISegmentedControl) {
        switch selectPhase.selectedSegmentIndex {
        case 0:
        let vc = UIStoryboard.init(name: "faculty", bundle: Bundle.main).instantiateViewController(withIdentifier: "fReview1") as? fR1DisplayMainViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        case 1:
         let vc = UIStoryboard.init(name: "faculty", bundle: Bundle.main).instantiateViewController(withIdentifier: "fReview2") as? fR2DisplayMainViewController
         self.navigationController?.pushViewController(vc!, animated: true)
        
            case 3:
            let vc = UIStoryboard.init(name: "faculty", bundle: Bundle.main).instantiateViewController(withIdentifier: "fPhase2") as? fP2DisplayMainViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
         break
        }
    }
    
    @IBOutlet weak var fP1Batch: UIButton!
    @IBOutlet weak var fP1Section: UIButton!
    @IBOutlet weak var fP1Usn: UIButton!
    
    var currBatch:Int = 0
    var usnList:[String] = []
    var batchList:[String] = []
    var curSection:String = ""
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[phase1Details] = []
    var gradesArray:[academicMarks] = []
    
    @IBOutlet weak var literatureSurvey: UILabel!
    @IBOutlet weak var methodologe: UILabel!
    @IBOutlet weak var implementation: UILabel!
    @IBOutlet weak var presentation: UILabel!
    @IBOutlet weak var vivavoice: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var semFour: UILabel!
    @IBOutlet weak var semFive: UILabel!
    @IBOutlet weak var semSix: UILabel!
    
    
    @IBAction func fP1SectionFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "fSectionVC") as! fSectionViewController
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
    @IBAction func fP1DisplayBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "fBatchVC") as! fBatchViewController
               // popcontrol.spec = true
                //popcontrol.somestring = rows2[indexPath.row]
               popcontrol.delegate = self
                popcontrol.cgBatch = self.batchList
                popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
                popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                popcontrol.preferredContentSize.height = 200
                popcontrol.preferredContentSize.width = 200
                popcontrol.popoverPresentationController?.delegate = self
        popcontrol.popoverPresentationController?.sourceView = sender
                popcontrol.popoverPresentationController?.sourceRect = sender.bounds
                self.present(popcontrol, animated: true, completion: nil)
    }
    
    @IBAction func fP1DisplayFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "fUsnVC") as! fUsnViewController
        // popcontrol.spec = true
         //popcontrol.somestring = rows2[indexPath.row]
        popcontrol.delegate = self
        popcontrol.cR1Usn = self.usnList
         popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
         popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
         popcontrol.preferredContentSize.height = 200
         popcontrol.preferredContentSize.width = 200
         popcontrol.popoverPresentationController?.delegate = self
         popcontrol.popoverPresentationController?.sourceView = sender
         popcontrol.popoverPresentationController?.sourceRect = sender.bounds
         self.present(popcontrol, animated: true, completion: nil)
    }
    
    func fetchSectionData()
    {
        fetchDetails().getSectionDetails { (sectionData, error) in
         self.batchArray.removeAll()
           self.batchList.removeAll()
         if sectionData.count > 0
         {
          // print(batchData.count)
          self.batchArray = sectionData as! [batchDetails]
          print("batch array : \(self.batchArray)")
          if self.batchArray.count > 0
          {
           for i in self.batchArray
           {
            print(self.curSection)
            if i.section == self.curSection
            {
             self.batchList.append(String(i.batchNumber!))
             print(self.batchList)
            }
           }
          }
         }
        }
        
    }
    
    func fetchPhase1marks(){
          fetchDetails().getFacultyPhase1Marks { (marksData, error) in
           self.marksArray.removeAll()
           print("MarksData: \(marksData)")
           if marksData.count > 0
           {
            // print(batchData.count)
            self.marksArray = marksData as! [phase1Details]
            
            print("marks array : \(self.marksArray)")
            if self.marksArray.count > 0
            {
             for i in self.marksArray
             {
              print(self.currBatch)
              print(i.batchNumber)
              print(self.currUsn)
              print(i.usn)
              if i.batchNumber == self.currBatch && i.usn == self.currUsn
              {print(" Cond satisfied")
               self.literatureSurvey.text = String(i.litSurvey!)
               self.presentation.text = String(i.presentation!)
               self.vivavoice.text = String(i.viva!)
               self.methodologe.text = String(i.methodology!)
               self.implementation.text = String(i.implementation!)
               self.total.text = String(i.total!)
              }
             }
            }
            }
          }
    }
    
    func fetchGrades(){
        fetchDetails().getGrades(usn: (currUsn), callback:
        { (marksData, error) in
      self.gradesArray.removeAll()
      print("MarksData: \(marksData)")
      if marksData.count > 0
      {
       // print(batchData.count)
       self.gradesArray = marksData as! [academicMarks]
       
       print("marks array : \(self.marksArray)")
       if self.gradesArray.count > 0
       {
        for i in self.gradesArray
        {
         print(self.currUsn)
         print(i.usn)
         if i.batchNumber == self.currBatch && i.usn == self.currUsn
         {print(" Cond satisfied")
           self.semFour.text = String(i.semFour!)
            self.semFive.text = String(i.semFive!)
            self.semSix.text = String(i.semSix!)
         }
        }
       }
      }
     })
    }
    
        func fetchBatchData()
        {
         fetchDetails().getBatchDetails { (batchData, error) in
          self.batchArray.removeAll()
            self.usnList.removeAll()
          if batchData.count > 0
          {
           // print(batchData.count)
           self.batchArray = batchData as! [batchDetails]
           print("batch array : \(self.batchArray)")
           if self.batchArray.count > 0
           {
            for i in self.batchArray
            {
             print(self.currBatch)
             if i.batchNumber == self.currBatch
             {
              self.usnList.append(i.usn1!)
              self.usnList.append(i.usn2!)
              self.usnList.append(i.usn3!)
              self.usnList.append(i.usn4!)
              print(self.usnList)
             }
            }
           }
           //if self.display == 0
           // {
           // self.displayBatchTableView.reloadData()
           // }
          }
          //self.displayBatchTableView.reloadData() // New one
         }
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    
    
}
