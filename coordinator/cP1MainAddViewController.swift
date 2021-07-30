//
//  cP1MainAddViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 08/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase

class cP1MainAddViewController: UIViewController,UITextFieldDelegate,UIPopoverPresentationControllerDelegate,getval_spl,getval_spl2 {
    func getSelectedBatch(selectedBatch: String) {
          currBatch = Int(selectedBatch)!
           fetchBatchData()

           cP1AddBatch.setTitle(selectedBatch, for: .normal)
       }
       func getSelectedUsn(selectedUsn: String) {
        self.submit.isHidden = false
            currUsn = selectedUsn
        validateUsnData()
            cP1AddUsn.setTitle(selectedUsn, for: .normal)
        updateProgress{() -> () in
        print("hello") }
       }
    var currBatch:Int = 0
    var usnList:[String] = []
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[phase1Details] = []
    var studentArray:[studentDetails] = []
    var lit = 0
    var met = 0
    var imp = 0
    var pre = 0
    var viv = 0
    var tot = 0
    var currProgressPhase1 = 0
    var incrementedProgPhase1 = 0
    
    @IBOutlet weak var litSurvey: UITextField!
    @IBOutlet weak var methodology: UITextField!
    @IBOutlet weak var implementation: UITextField!
    @IBOutlet weak var present: UITextField!
    @IBOutlet weak var viva: UITextField!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var submit: UIButton!
    
    
    @IBOutlet var cP1AddBatch: UIButton!
    @IBOutlet var cP1AddUsn: UIButton!
    
    override func viewDidLoad() {
        litSurvey.delegate = self
        methodology.delegate = self
        implementation.delegate = self
        present.delegate = self
        viva.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cP1AddBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next") as! cR1DisplayBatchViewController
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
    @IBAction func cP1AddUsnFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next2") as! cR1DisplayUsnViewController
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
    
    @IBAction func submit(_ sender: UIButton) {
        
        if(currUsn == "" || currBatch == 0 )
        {
            let alert = UIAlertController(title: "Error!", message: "Please select from the dropdowns", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }

        if ((litSurvey.text?.isEmpty ?? true) || (methodology.text?.isEmpty ?? true) || (implementation.text?.isEmpty ?? true) || (present.text?.isEmpty ?? true) || (viva.text?.isEmpty ?? true) || !(0...5 ~= Int(litSurvey.text!)!) || !(0...5 ~= Int(methodology.text!)!) || !(0...10 ~= Int(implementation.text!)!) || !(0...5 ~= Int(present.text!)!) || !(0...5 ~= Int(viva.text!)!))
        {
            let alert = UIAlertController(title: "Error!", message: "Please enter valid marks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: false,completion: nil)
        }
        else
        {
        var sum = Int(litSurvey.text!)! + Int(methodology.text!)! + Int(implementation.text!)!
               var sum2 = sum + Int(present.text!)! + Int(viva.text!)!
                 self.total.text = "\(sum2)"
                let db = Database.database().reference()
                 let branch = db.child("CoordinatorMarks").child("Phase1")
                 let branchKey = branch.childByAutoId().key
                 let branchID = branch.child(branchKey!)
               let data = ["USN":currUsn,"Batch":currBatch,"LitSurvey":Int(litSurvey.text!), "Presentation":Int(present.text!),"Implementation":Int(implementation.text!),"VivaMarks":Int(viva.text!),"Methodolgy":Int(methodology.text!),"Total":sum2,"ID":branchKey] as [String : Any]
                 branchID.setValue(data)
            updateStudentDetails()
//
                /* let db = Database.database().reference()
                 let update1 = db.child("BatchDetails")
                 let update1_Key = update1.childByAutoId().key
                 let update1_ID = update1.child(update1_Key!)
                 
                 update1_ID.setValue(self.usnDict)

               */
        }
    }
    
    func validateUsnData()
        {
            var flag = false
            
            fetchDetails().getCoordPhase1Marks { (usnData, error) in
             
             if usnData.count > 0
             {
              // print(batchData.count)
              self.marksArray = usnData as! [phase1Details]
              print("marks array : \(self.marksArray)")
              if self.marksArray.count > 0
              {
               for i in self.marksArray
               {
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
          self.currProgressPhase1 = i.progressPhase1!
         }
         // print(i.name)
        }
       }
       callback(self.currProgressPhase1)   }
     }
    }
    
    func updateProgress(completion: () -> ())
    {
     fetchProgressData{(currProPhase1) in
      self.incrementedProgPhase1 = currProPhase1 + 1
      print("Updated value: /(self.incrementedProgPhase1)")
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
        update1_ID.updateChildValues(["ProgressPhase1":self.incrementedProgPhase1])
        
       }
      }
     }
     
     
    }
    
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
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
