//
//  fP2AddMainViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 22/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class fP2AddMainViewController: UIViewController,UITextFieldDelegate,UIPopoverPresentationControllerDelegate,getval_spl_f,getval_spl_f2,getval_spl_f3 {
func getSelectedSection(selectedSection: String){
    print("Reaching..")
    curSection = selectedSection
    fP2AddSection.setTitle(selectedSection, for: .normal)
    fetchSectionData()
}
func getSelectedBatch(selectedBatch: String) {
    currBatch = Int(selectedBatch)!
 fP2AddBatch.setTitle(selectedBatch, for: .normal)
    print(currBatch)
 fetchBatchData()

}
func getSelectedUsn(selectedUsn: String) {
           self.submit.isHidden = false
           currUsn = selectedUsn
           validateUsnData()
           fP2AddUsn.setTitle(selectedUsn, for: .normal)
           updateProgress{() -> () in
           print("hello") }
    }
    var currBatch:Int = 0
    var usnList:[String] = []
    var batchList:[String] = []
    var curSection:String = ""
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[phase2Details] = []
    var studentArray:[studentDetails] = []
    
    var currProgressPhase2 = 0
    var incrementedProgPhase2 = 0
    
    @IBOutlet weak var fP2AddBatch: UIButton!
    @IBOutlet weak var fP2AddSection: UIButton!
    @IBOutlet weak var fP2AddUsn: UIButton!
    
    
    @IBOutlet weak var novelty: UITextField!
    @IBOutlet weak var implementationandcoding: UITextField!
    @IBOutlet weak var resultandperformance: UITextField!
    @IBOutlet weak var presentation: UITextField!
    @IBOutlet weak var vivaVoice: UITextField!
    @IBOutlet weak var publication: UITextField!
    @IBOutlet weak var projectDiary: UITextField!
    @IBOutlet weak var report: UITextField!
    @IBOutlet weak var total: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        novelty.delegate = self
        implementationandcoding.delegate = self
        resultandperformance.delegate = self
        presentation.delegate = self
        vivaVoice.delegate = self
        publication.delegate = self
        projectDiary.delegate = self
        report.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fP2AddBatch(_ sender: UIButton) {
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
    
    @IBAction func fP2AddSection(_ sender: UIButton) {
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
    

    @IBAction func fP2AddUsnFunc(_ sender: UIButton) {
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
    
    @IBOutlet weak var submit: UIButton!
    
    @IBAction func submit(_ sender: Any) {
        if(currUsn == "" || currBatch == 0)
        {
            let alert = UIAlertController(title: "Error!", message: "Please select from the dropdowns", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }

        if ((novelty.text?.isEmpty ?? true) || (implementationandcoding.text?.isEmpty ?? true) || (resultandperformance.text?.isEmpty ?? true) || (presentation.text?.isEmpty ?? true) || (vivaVoice.text?.isEmpty ?? true) || (publication.text?.isEmpty ?? true) || (projectDiary.text?.isEmpty ?? true) || (report.text?.isEmpty ?? true) || !(0...10 ~= Int(novelty.text!)!) || !(0...10 ~= Int(implementationandcoding.text!)!) || !(0...10 ~= Int(resultandperformance.text!)!) || !(0...5 ~= Int(presentation.text!)!) || !(0...5 ~= Int(vivaVoice.text!)!) || !(0...5 ~= Int(publication.text!)!) || !(0...5 ~= Int(projectDiary.text!)!) || !(0...20 ~= Int(report.text!)!))
        {
            let alert = UIAlertController(title: "Error!", message: "Please enter valid marks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: false,completion: nil)

        }
            
        else{
        var sum = Int(novelty.text!)! + Int(implementationandcoding.text!)! + Int(resultandperformance.text!)!
                     var sum2 = sum + Int(presentation.text!)! + Int(vivaVoice.text!)! + Int(report.text!)! + Int(publication.text!)! +
                        Int(projectDiary.text!)!

                       self.total.text = "\(sum2)"
                      let db = Database.database().reference()
                       let branch = db.child("FacultyMarks").child("Phase2")
                       let branchKey = branch.childByAutoId().key
                       let branchID = branch.child(branchKey!)
        let data = ["USN":currUsn,"Batch":currBatch,"Novelty":Int(novelty.text!), "Implementation":Int(implementationandcoding.text!),"Resultandperformace":Int(resultandperformance.text!),"Presentation":Int(presentation.text!),"VivaMarks":Int(vivaVoice.text!),"Report":Int(report.text!),"Publication":Int(publication.text!),"Projectdiary":Int(projectDiary.text!),"Total":sum2,"ID":branchKey] as [String : Any]
                       branchID.setValue(data)
            updateStudentDetails()
        }
    }
    
    func validateUsnData()
        {
            var flag = false
            
            fetchDetails().getFacultyPhase2Marks { (usnData, error) in
             
             if usnData.count > 0
             {
              // print(batchData.count)
              self.marksArray = usnData as! [phase2Details]
              print("marks array : \(self.marksArray)")
              if self.marksArray.count > 0
              {
               for i in self.marksArray
               {
    //            print(self.curSection)
                if i.usn == self.currUsn
                {
                    flag = true
                }
               }
                if(flag==true)
                {
                    let alert = UIAlertController(title: "Error!", message: "Data with this usn already exists", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    
                    self.present(alert, animated: true,completion: nil)
                    self.submit.isHidden = true
                }
              }
             }
            }
            
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
    
    func fetchProgressData(callback:@escaping ResponseHandlerBlock1)
    {
     fetchDetails().getAllStudentDetails { (stuData, error) in
      if stuData.count > 0
      {
       
       self.studentArray = stuData as! [studentDetails]
       // print("student array : \(self.studentArray)")
       if self.studentArray.count > 0
       {
        for i in self.studentArray
        { print(i.batch)
         if (i.batch == self.currBatch) && i.usn == self.currUsn
         {
          self.currProgressPhase2 = i.progressPhase2!
         }
         // print(i.name)
        }
       }
       callback(self.currProgressPhase2)   }
     }
    }
    
    func updateProgress(completion: () -> ())
    {
     fetchProgressData{(currProPhase2) in
      self.incrementedProgPhase2 = currProPhase2 + 1
      print("Updated value: /(self.incrementedProgPhase2)")
     }
    }
    
    func updateStudentDetails(){
     let db1 = Database.database().reference()
     let update1 = db1.child("studentDetails")
     if self.studentArray.count > 0
     {
      for i in self.studentArray
      {
       if i.usn == self.currUsn
       {
        let id = i.uid
        let update1_ID = update1.child(id!)
        update1_ID.updateChildValues(["ProgressPhase2":self.incrementedProgPhase2])
        
       }
      }
     }
     
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let allowedCharacters = CharacterSet.decimalDigits
          let characterSet = CharacterSet(charactersIn: string)
          return allowedCharacters.isSuperset(of: characterSet)
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

}
