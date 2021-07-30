//
//  addStudentViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 06/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase

class addStudentViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var usn: UITextField!
    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var branch: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var mailID: UITextField!
    @IBOutlet weak var password: UITextField!
     var auth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Submit(_ sender: UIButton) {
        let db = Database.database().reference()
        print("the db = \(db)")
        self.auth.createUser(withEmail: self.mailID.text!, password: self.password.text!) { (user, error) in
         if error != nil
         {
          //        handle error
          print("error = \(error?.localizedDescription)")
         }
         else
         {
          let uid = user?.user.uid
//            let uid = self.usn.text
          print(uid)
          let parent = db.child("studentDetails").child(uid!)
          let data = [ "Name": self.name.text!,"Email": self.mailID.text!,"Branch": self.branch.text!,"USN":self.usn.text!,"Year": self.year.text!,"Section":self.section.text!,"Role":"1","Batch":0,"uid":uid] as [String:Any]
          parent.setValue(data)

          }
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
