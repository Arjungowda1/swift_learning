//
//  FetchStudViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 02/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth
class FetchStudViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBAction func resetPassword(_ sender: UIButton) {
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
    
    @IBOutlet weak var facultyTableview: UITableView!
    @IBOutlet weak var studentTableview: UITableView!
//    var usns = ["1jb16cs001", "1jb16cs002", "1jb16cs003"]
//    var studNames = ["abhinav","Abhishek","Adarsh"]
//    var sections = ["A", "A", "B"]
//    var studBatchs = ["01","01","17"]
//
//    var ids = ["abv@gmail.com","hnk@gmail.com","fhj@gmail.com"]
//    var facNames = ["abc","def","ghi"]
//    var facBatchs = ["0","0","0"]
//    var cordinators = ["yes","yes","no"]
//    var hods = ["no","no","yes"]
    
    var studentArray:[studentDetails] = []
    var facArray:[facultyDetails] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counting = 0
    if tableView == studentTableview
    {
        counting =  studentArray.count
    }
    if tableView == facultyTableview
    {
        counting = facArray.count
        
    }
        return counting
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
            if tableView == studentTableview
            {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "studentcell") as! FetchStudentTableViewCell
             let studentObj = studentArray[indexPath.row]
             cell1.usn.text = studentObj.usn
        //cell1.usn.text = usns[indexPath.row]
            //cell1.studName.text = studNames[indexPath.row]
             cell1.studName.text = studentObj.name
             

                cell1.section.text = studentObj.section
           // cell1.studBatch.text = studBatchs[indexPath.row]
             cell1.studBatch.text = String(studentObj.batch!)
             cell = cell1
            }
            if tableView == facultyTableview
            {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "facultyCell") as! facultyTableViewCell1
             let facObj = facArray[indexPath.row]
             cell2.id.text = facObj.mailID
               // cell2.id.text = ids[indexPath.row]
             
               // cell2.facName.text = facNames[indexPath.row]
             cell2.facName.text = facObj.name
                cell2.facBatch.text = String(facObj.batch!)
             if facObj.role == "3" {
             cell2.coordinator.text = "yes"
             }
             else { cell2.coordinator.text = "no"}

                //cell2.coordinator.text = cordinators[indexPath.row]
                //cell2.hod.text = hods[indexPath.row]
             if facObj.role == "2"
             {
             cell2.hod.text = "Yes"         }
             else {
              cell2.hod.text = "No"
             }
                cell = cell2
            }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
            
        }
        override func viewDidLoad() {
            super.viewDidLoad()
         DispatchQueue.main.async {
          self.fetchAllData()
          print("student array in didload : \(self.studentArray)")
          self.studentTableview.reloadData()
          self.fetchFacultyData()
          self.facultyTableview.reloadData()
         }
                  
            // Do any additional setup after loading the view.
        }
        
    func fetchAllData()
    {
     fetchDetails().getAllStudentDetails { (stuData, error) in
      if stuData.count > 0
     {

      self.studentArray = stuData as! [studentDetails]
      print("student array : \(self.studentArray)")
    if self.studentArray.count > 0
     {
       for i in self.studentArray
       {
        print(i.name)
       }
      }
      self.studentTableview.reloadData()
     }
     }
     /*
      
      // Role = 0 - Not allotted
      //student = 1, HOD = 2, co-ord = 3,Faculty =4, Principal = 5
      // Batch = 0 means not yet allotted

      
      fetchUserDetails().getFacultyDetails(userId: (userId)!, callback: { (facultyData, error) in
      self.facultyArray = facultyData as! [allUserDetails]
      print(self.facultyArray.count)
      if(self.facultyArray.count > 0)
      {
      // obtain role from the extracted data
      for i in self.facultyArray
    */
     }
    
    @IBAction func refresh(_ sender: UIButton) {
        self.facultyTableview.reloadData()
        self.studentTableview.reloadData()
    }
    
     
     func fetchFacultyData()
     {
      fetchDetails().getAllFacultyDetails { (facData, error) in
       if facData.count > 0
       {
        
        self.facArray = facData as! [facultyDetails]
        print("student array : \(self.facArray)")
        if self.facArray.count > 0
        {
         for i in self.facArray
         {
          print(i.name)
         }
        }
        self.facultyTableview.reloadData()
       }
      }
      /* fetchUserDetails().getFacultyDetails(userId: (userId)!, callback: { (facultyData, error) in
       self.facultyArray = facultyData as! [allUserDetails]
       print(self.facultyArray.count)
       if(self.facultyArray.count > 0)
       {
       // obtain role from the extracted data
       for i in self.facultyArray
       */
     }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    @IBAction func login(_ sender: UIButton) {
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
