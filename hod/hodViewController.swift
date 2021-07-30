//
//  hodViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 15/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class hodViewController: UIViewController,UIPopoverPresentationControllerDelegate,getFac,getSection,getGuideSection,getFacForGuide,getGuideBatch2 {
    func getGSelectedBatch(selectedBatch: String) {
         curBatch = selectedBatch
         guideBatchSelect.setTitle(selectedBatch, for: .normal)
    }
    func getGSelectedFaculty(selectedGFac: String) {
       gSelFaculty = selectedGFac.replacingOccurrences(of: " ", with: "")
        guideFacultySelect.setTitle(selectedGFac, for: .normal)
    }
    
    func getGSelectedSection(GselectedSec: String) {
        curSection = GselectedSec
        guideSectionSelect.setTitle(GselectedSec, for: .normal)
        fetchSectionData()
    }
    func getSelectedFaculty(selectedFac: String)
       {
        print(selectedFac)
           selFcaulty = selectedFac.replacingOccurrences(of: " ", with: "")
        facSelect.setTitle(selectedFac, for: .normal)
           
       }
    func getSelectedSection(selectedSec: String) {
     selSection = selectedSec
        
     sectionSelect.setTitle(selectedSec, for: .normal)
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
    
    var db : DatabaseReference!

    // var auth = Auth.auth()
     var selFcaulty = ""
     var selSection = ""
     var gSelFaculty = ""
    var curSection:String = ""
    var curBatch:String = ""
    var uidMain = ""
//    currsection is for guide batch dd
    var batchList:[String] = []
    var batchArray:[batchDetails] = []
    
    @IBOutlet weak var sectionSelect: UIButton!
    @IBOutlet weak var facSelect: UIButton!
    
    @IBOutlet weak var guideSectionSelect: UIButton!
    @IBOutlet weak var guideFacultySelect: UIButton!
    
    @IBOutlet weak var guideBatchSelect: UIButton!
    @IBAction func selectSection(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "sectionSelection") as! pcSectionViewController
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
    
    @IBAction func selectFaculty(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "facSelection") as! pcFacultyViewController
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
    @IBAction func guideSectionSelectFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "gSecSelection") as! cguideBatchViewController
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
    @IBAction func guideFacultySelectFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "gfacSelection") as! cgFacultyViewController
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
    
    @IBAction func guideBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "gBatchSelection") as! cgBatchViewController
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
    

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
     return UIModalPresentationStyle.none
    }
    
    @IBAction func addProjCoordinator(_ sender: UIButton) {
        let db = Database.database().reference()
         var auth = Auth.auth()
         print("the db = \(db)")
         var mailId = selFcaulty + "123@gmail.com"
         var password = selFcaulty + "123"
         auth.createUser(withEmail: mailId, password: password) { (user, error) in
          if error != nil
          {
           //        handle error
           print("error = \(error?.localizedDescription)")
          }
          else
          {
           let uid = user?.user.uid
           print(uid)
           let parent = db.child("projectCoordDetails").child(uid!)
            let data = [ "Name": self.selFcaulty,"Email": mailId,"Section": self.selSection,"Role":"3","uid":uid] as [String:Any]
           parent.setValue(data)

          }

         
        }
    }
    
   
    @IBAction func addProjGuide(_ sender: UIButton) {
        let db = Database.database().reference()
                var auth = Auth.auth()
                print("the db = \(db)")
                var mailId = gSelFaculty + "Guide@gmail.com"
                var password = gSelFaculty + "123"
                auth.createUser(withEmail: mailId, password: password) { (user, error) in
                 if error != nil
                 {
                  //        handle error
                  print("error = \(error?.localizedDescription)")
                    let ref = db.child("projectGuideDetails")
                    var mailId = self.gSelFaculty + "Guide@gmail.com"
                    ref.queryOrdered(byChild: "Email").queryEqual(toValue: mailId).observeSingleEvent(of: .value, with: { snapshot in
                        for child in snapshot.children{
//                            var uid = snapshot.key
//                            for child in snapshot.children {
//                            let snap = child as! DataSnapshot
//                            let dict = snap.value as! [String: Any]
//                            var uid = dict["uid"] as! String
//                            }
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: Any]
                            let uid = dict["uid"] as! String
                           //User email exist
                            let email = dict["Email"] as! String
                            if email == mailId
                            {
                                self.uidMain = uid
                            }
                       print(uid)
                        }
//                    let uid = user?.user.uid
//                    print(uid)
                        let parent = db.child("projectGuideDetails").child(self.uidMain)
                    let keys = parent.childByAutoId().key
                        let parent2 = db.child("projectGuideDetails").child(self.uidMain).child("batches").child(keys!)
                    parent2.updateChildValues(["BatchNumber":self.curBatch,"section":self.curSection])
                            
                                               })
                 }
                 else
                 {
                  let uid = user?.user.uid
                  print(uid)
                  let parent = db.child("projectGuideDetails").child(uid!)
                    let keys = parent.childByAutoId().key
                    let parent2 = parent.child("batches").child(keys!)
                  let data = [ "Name": self.gSelFaculty,"Email": mailId,"Role":"4","uid":uid] as [String:Any]
                    let data2 = ["BatchNumber":self.curBatch,"section":self.curSection] as [String:Any]
                  parent.setValue(data)
                    parent2.setValue(data2)
                 }
               }
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
