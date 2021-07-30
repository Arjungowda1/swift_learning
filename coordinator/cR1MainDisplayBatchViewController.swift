//
//  cR1MainDisplayBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 05/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth

class cR1MainDisplayBatchViewController: UIViewController ,UIPopoverPresentationControllerDelegate,getval_spl,getval_spl2{
    func getSelectedBatch(selectedBatch: String) {
     cR1DisplayBatch.setTitle(selectedBatch, for: .normal)
     currBatch = Int(selectedBatch)!
        print(currBatch)
     fetchBatchData()

    }
    func getSelectedUsn(selectedUsn: String) {
            currUsn = selectedUsn
            cR1DisplayUsn.setTitle(selectedUsn, for: .normal)
        
            self.litSurveyMarks.text = "-"
            self.presentationMarks.text = "-"
            self.vivaMarks.text = "-"
            self.total.text = "-"
            self.semFour.text = "-"
            self.semFive.text = "-"
            self.semSix.text = "-"
        
                fetchReview1marks()
                fetchGrades()
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
    
    var currBatch:Int = 0
    var usnList:[String] = []
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[reviewDetails] = []
    var gradesArray:[academicMarks] = []
    
    @IBOutlet weak var selectPhase: UISegmentedControl!
    
    @IBOutlet weak var litSurveyMarks: UILabel!
    
    @IBOutlet weak var presentationMarks: UILabel!
    
    @IBOutlet weak var vivaMarks: UILabel!
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var semFour: UILabel!
    @IBOutlet weak var semFive: UILabel!
    @IBOutlet weak var semSix: UILabel!
    
    
    @IBOutlet weak var cR1DisplayBatch: UIButton!
    @IBOutlet weak var cR1DisplayUsn: UIButton!
    
    @IBAction func selectCR1DisplayBatch(_ sender: UIButton) {
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
    @IBAction func selectCR1DisplayUsn(_ sender: UIButton) {
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
    
    @IBAction func selectPhaseAction(_ sender: UISegmentedControl) {
        switch selectPhase.selectedSegmentIndex {
        case 1:
         let vc = UIStoryboard.init(name: "coordinator", bundle: Bundle.main).instantiateViewController(withIdentifier: "review2") as? cR2MainDisplayViewController
         self.navigationController?.pushViewController(vc!, animated: true)
        
        case 2:
         let vc = UIStoryboard.init(name: "coordinator", bundle: Bundle.main).instantiateViewController(withIdentifier: "phase1") as? cP1MainDisplayViewController
         self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
            let vc = UIStoryboard.init(name: "coordinator", bundle: Bundle.main).instantiateViewController(withIdentifier: "phase2") as? cP2MainDisplayViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
         break
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
    
    func fetchReview1marks(){
     fetchDetails().getCoordReview1Marks { (marksData, error) in
      self.marksArray.removeAll()
      print("MarksData: \(marksData)")
      if marksData.count > 0
      {
       // print(batchData.count)
       self.marksArray = marksData as! [reviewDetails]
       
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
          self.litSurveyMarks.text = String(i.litSurvey!)
          self.presentationMarks.text = String(i.presentation!)
          self.vivaMarks.text = String(i.viva!)
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
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
