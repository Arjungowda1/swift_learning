//
//  gAcademicsMainViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 09/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class gAcademicsMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_spl_g,getval_spl_g2 {
    func getSelectedBatch(selectedBatch: String) {
              currBatch = Int(selectedBatch)!
                 fetchBatchData()
         gAcademicBatch.setTitle(selectedBatch, for: .normal)
    }
    
    func getSelectedUsn(selectedUsn: String) {
        currUsn = selectedUsn
        gAcademicUsn.setTitle(selectedUsn, for: .normal)
    }
    
    @IBAction func resetPassLink(_ sender: UIButton) {
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
    
    var currBatch:Int = 0
    var usnList:[String] = []
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var academicMarks:[academicMarks] = []
    var semFour = 0
    var semFive = 0
    var semSix = 0
   
    
    @IBOutlet var gAcademicBatch: UIButton!
    @IBOutlet var gAcademicUsn: UIButton!
    
    @IBOutlet weak var fourthSem: UITextField!
    @IBOutlet weak var fifthSem: UITextField!
    @IBOutlet weak var sixthSem: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func gAcademicBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next21") as! gR1DisplayBatchViewController
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
    @IBAction func gAcademicUsnFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next22") as! gR1DisplayUsnViewController
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
    
    
    
    @IBAction func submitMarks(_ sender: Any) {
        let db = Database.database().reference()
        let branch = db.child("AcademicMarks")
        let branchKey = branch.childByAutoId().key
               let branchID = branch.child(branchKey!)
        
        let data = ["USN":currUsn,"Batch":currBatch,"SemFour":Float(fourthSem.text!),"SemFive":Float(fifthSem.text!),"SemSix":Float(sixthSem.text!),"ID":branchKey] as [String : Any]
        branchID.setValue(data)
                    
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
}
