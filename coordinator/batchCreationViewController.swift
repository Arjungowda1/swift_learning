//
//  batchCreationViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class batchCreationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var createBatchTableView: UITableView!
    @IBOutlet weak var displayBatchTableView: UITableView!
 var display = 0
     var studentArray:[studentDetails] = []
     var studentArray2:[studentDetails] = []
     var batchArray:[batchDetails] = []
     var batchArray2:[batchDetails] = []
     var batchZeroArray:[studentDetails] = []
     var batchUpdatingArray:[studentDetails] = []
     var lastBatchNumber:Int = 1
     var currBatchNumber:Int?
     typealias FinishedDownload = () -> ()
     var complitionHandler: (()->Void)?
    var currSection = ""
    var coordinatorArray:[coordinatorDetails] = []
        var createUsn = ["1jb16cs000","1jb16cs999","1jb16cs554","1jb16cs556"]
        var createName = ["Ali","Joseph","Goti","tmde"]
        
        var displayUsn = ["1jb16cs000","1jb16cs999"]
        var displayBatch = ["14","14"]
        var displayName = ["hbfh","werwe"]
     var selectedCells:[Int] = []
     var selUSNS:[String] = []
     var usnDict:[String:Any] = [:]
    
    @IBAction func resetpass(_ sender: UIButton) {
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
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      var cnt = 0
      if tableView == createBatchTableView
      {
       cnt = batchZeroArray.count
      }
      if tableView == displayBatchTableView
      {
       cnt = batchArray.count
       
       //cnt = displayUsn.count
      }
      return cnt
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      var cell = UITableViewCell()
      if tableView == createBatchTableView
      {
       let cell1 = tableView.dequeueReusableCell(withIdentifier: "createBatchCell") as! createBatchTableViewCell
       cell.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .none
       
       
       let stuObj = batchZeroArray[indexPath.row]
       cell1.createUsn.text = stuObj.usn
       
       cell1.createName.text = stuObj.name
       cell = cell1
      }
      if tableView == displayBatchTableView
      {
       let cell2 = tableView.dequeueReusableCell(withIdentifier: "displayBatchCell") as! displayBatchTableViewCell
       let batchObj = batchArray[indexPath.row]
       cell2.createdUsn.text = batchObj.usn1
       cell2.createdName.text = batchObj.name1
       cell2.usn2.text = batchObj.usn2
       cell2.name2.text = batchObj.name2
       cell2.usn3.text = batchObj.usn3
       cell2.name3.text = batchObj.name3
       cell2.usn4.text = batchObj.usn4
       cell2.name4.text = batchObj.name4
       cell2.createdBatch.text = "\(batchObj.batchNumber!)"
       
       
       
       //cell2.createdUsn.text = displayUsn[indexPath.row]
       // cell2.createdName.text = displayName[indexPath.row]
       // cell2.createdBatch.text = displayBatch[indexPath.row]
       cell = cell2
      }
      return cell
     }
    
     func fetchAllData()
     {
      fetchDetails().getAllStudentDetails { (stuData, error) in
        self.studentArray2.removeAll()
        self.studentArray.removeAll()
       if stuData.count > 0
       {
        self.studentArray2 = stuData as! [studentDetails]
       // print("student array : \(self.studentArray)")
        if self.studentArray2.count > 0
        {
            for i in 0...(self.studentArray2.count)
            {
                if self.studentArray2[i].section == self.currSection
                {
                    self.studentArray.append(self.studentArray2[i])
                }
            }
        }
       // self.createBatchTableView.reloadData()
       }
      }
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if self.selectedCells.contains(indexPath.row) {
       let myIndex = self.selectedCells.index(of: indexPath.row)
       self.selectedCells.remove(at: myIndex!)
      } else {
       self.selectedCells.append(indexPath.row)
      }
       
      
     }
    @IBAction func createBatch(_ sender: UIButton) {
        if selectedCells.count < 2
          {
           let alertController = UIAlertController(title: "Note", message: "Select atleast 2 members to create a batch", preferredStyle: .alert)
           let  action = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(action)
           self.present(alertController, animated: false, completion: nil)
          }
          display = 1
        //  selectUsns()
          selectUsns1()
             saveData()
          //displayBatchTableView.reloadData()
        selectedCells.removeAll()
        batchZeroArray.removeAll()
        
        display = 0
          fetchBatchData {
           (lastBatchNumber) in
        print("hello")
          }
        self.displayBatchTableView.reloadData()
        fetchStudentsWithBatchZeroData()
        self.createBatchTableView.reloadData()
        selUSNS.removeAll()
         selectedCells.removeAll()
    }
    //func selectUsns(handler: @escaping (()->Void))
    func selectUsns()

     {
      print("in array")
      
        for i in 0 ... selectedCells.count - 1
      {
       selUSNS.append(String(studentArray[selectedCells[i]].usn!))
          print(selUSNS)
       var key = "USN" + String(i+1)
       var keyname = "Name" + String(i+1)
       usnDict.updateValue(String(studentArray[selectedCells[i]].usn!), forKey: key)
       usnDict.updateValue(studentArray[selectedCells[i]].name!, forKey: keyname)
         }
      usnDict.updateValue(selectedCells.count, forKey: "NumberOfStudents")
      for stu in selectedCells.count ... 3
      {
       var key = "USN" + String(stu+1)
       var keyname = "Name" + String(stu+1)
       usnDict.updateValue("", forKey: key)
       usnDict.updateValue("", forKey: keyname)


      }
     }

     func selectUsns1()
      
     {
      print("in array")
      print(usnDict)
      print(lastBatchNumber)
      for i in 0 ... selectedCells.count - 1
      {
       selUSNS.append(String(batchZeroArray[selectedCells[i]].usn!))
       print(selUSNS)
       var key = "USN" + String(i+1)
       var keyname = "Name" + String(i+1)
//        var keysection = "Section" +
       usnDict.updateValue(String(batchZeroArray[selectedCells[i]].usn!), forKey: key)
       usnDict.updateValue(batchZeroArray[selectedCells[i]].name!, forKey: keyname)
      }
      usnDict.updateValue(selectedCells.count, forKey: "NumberOfStudents")
        var sec = String(batchZeroArray[selectedCells[0]].section!)
        usnDict.updateValue(sec, forKey: "Section")
        
      if selectedCells.count <= 3
      {
       for stu in selectedCells.count ... 3
      {
       var key = "USN" + String(stu+1)
       var keyname = "Name" + String(stu+1)
       usnDict.updateValue("", forKey: key)
       usnDict.updateValue("", forKey: keyname)
       print(usnDict)
       
      }
     }
     }
     
     
     
     func saveData()
     {
      let db = Database.database().reference()
      let update1 = db.child("BatchDetails")
      let update1_Key = update1.childByAutoId().key
      let update1_ID = update1.child(update1_Key!)
      
      update1_ID.setValue(self.usnDict)
      print("Batch0 : \(batchZeroArray)")
     updateStudentDetails()
      
     }
     
     func updateStudentDetails()
     {
      let db1 = Database.database().reference()
      let update1 = db1.child("studentDetails")

      var curBatchNum = (usnDict["BatchNumber"] as! Int)
      if batchZeroArray.count > 0
      {
      for i in batchZeroArray{
       for j in selUSNS
       {
        if i.usn == j
        {
         let id = i.uid
         let update1_ID = update1.child(id!)
         update1_ID.updateChildValues(["Batch":curBatchNum])
         print("Batch: \(curBatchNum)")

        }
       }
      }
      }
     }
        
    @IBAction func display(_ sender: UIButton) {
        display = 0
          fetchBatchData {
           (lastBatchNumber) in
        print("hello")
          }

          self.displayBatchTableView.reloadData()
        fetchStudentsWithBatchZeroData()
        self.createBatchTableView.reloadData()
        selUSNS.removeAll()
         selectedCells.removeAll()
    }
    
     func updateCount(completion: () -> ()) {
     // DispatchQueue.main.async {

      
      print("in update")
      fetchBatchData {(lastBatchNumber) in
      var currBatchNumber = lastBatchNumber + 1
       print("BatchNumber: \(lastBatchNumber)")
       self.usnDict.updateValue(currBatchNumber, forKey: "BatchNumber")
       print(self.usnDict)

      }
      //let db = Database.database().reference().child("BatchDetails")
     // let recentBatch = db.queryLimited(toLast: 1)
      
    //  db.queryLimited(toLast: 1)
    //   .observe(.childAdded, with: { snapshot in
    //    print(snapshot.value)
    //    var currObj = snapshot.value as! [String:Any]
    //    if let x = currObj["BatchNumber"]
    //    {
    //    self.currBatchNumber = currObj["BatchNumber"] as! Int
    //     /* let recentPostsQuery = (ref?.child("posts").queryLimited(toFirst: 100))!
    //*/
    //    }
    //  })
    //     print(" in update: \(self.currBatchNumber)")
    //    print("Currnumber: \(self.currBatchNumber)")
    //    var batchNumber:Int = 0
    //    if (self.currBatchNumber != nil)  {
    //     batchNumber = self.currBatchNumber! + 1
    //    }
    //    else { batchNumber = 1}
    //    print("BatchNumber: \(lastBatchNumber)")
    //    self.usnDict.updateValue(lastBatchNumber, forKey: "BatchNumber")
    //    print(self.usnDict)

       
     //}
      completion()

    //https://stackoverflow.com/questions/53028308/how-to-increment-the-value-in-specific-node-with-firebase-realtime-database-ios
      }
      
     override func viewDidLoad() {
            super.viewDidLoad()
        getCoord()
         var isMultipleSelectionActive = false
         var selectedItems: [String: Bool] = [:]
         createBatchTableView.allowsMultipleSelectionDuringEditing = true
         createBatchTableView.setEditing(true, animated: false)
      
      updateCount {() -> () in

       self.fetchStudentsWithBatchZeroData()
     //  self.createBatchTableView.reloadData()
      }
              // Do any additional setup after loading the view.
        }
        
     func fetchBatchData(callback: @escaping ResponseHandlerBlock1)
     {
      fetchDetails().getBatchDetails { (batchData, error) in
       self.batchArray.removeAll()
        self.batchArray2.removeAll()
       if batchData.count > 0
       {
       // print(batchData.count)
        self.batchArray2 = batchData as! [batchDetails]
        if self.batchArray2.count > 0
        {
            for i in 0...(self.batchArray2.count - 1)
            {
                if self.batchArray2[i].section == self.currSection
                {
                    self.batchArray.append(self.batchArray2[i])
                }
            }
        }
        
        print("batch array : \(self.batchArray)")
        if self.batchArray.count > 0
        {
         for i in self.batchArray
         {
          if i.batchNumber! > self.lastBatchNumber
         {
          self.lastBatchNumber = i.batchNumber!
          }
          
          print(i.batchNumber)
         }
         
        }
        callback(self.lastBatchNumber)
        //completion1()

        if self.display == 0
        {
        self.displayBatchTableView.reloadData()
        }
       }
       //self.displayBatchTableView.reloadData() // New one
      }
     
       }
     
     
     
     
     func fetchStudentsWithBatchZeroData()
     {
      fetchDetails().getAllStudentDetails { (stuData, error) in
       if stuData.count > 0
       {
        self.batchZeroArray.removeAll()
        self.studentArray.removeAll()
        self.studentArray = stuData as! [studentDetails]
        // print("student array : \(self.studentArray)")
        if self.studentArray.count > 0
        {
         for i in self.studentArray
         { print(i.batch)
            if i.batch  == 0 && i.section == self.currSection
          {
           self.batchZeroArray.append(i)
          }
          // print(i.name)
         }
        }
        print("In fetchbatchZero")
        print(self.batchZeroArray)
        self.createBatchTableView.reloadData()
       }
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
