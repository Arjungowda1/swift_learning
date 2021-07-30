//
//  ViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 18/02/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var coordinatorId:String = ""
var guideId:String = ""
class ViewController: UIViewController {
    // testing

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mailID: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let authObject = Auth.auth()
       var studentArray:[allUserDetails] = []
    var coordinatorArray:[coordinatorDetails] = []
       var facultyArray:[allUserDetails] = []
    var guideArray:[guideDetails] = []
       var userId: String?
       var usn:String?
       var role = ""
       var rolecheck:String?
    var batchNum:Int = 0
    var section:String?
    
    @IBAction func Submit(_ sender: UIButton) {
        login()
    }
    
    func login()
    {
        //admin login
        if(self.mailID.text == "admin@gmail.com" && self.password.text == "admin")
        {
            let storyboard : UIStoryboard = UIStoryboard(name: "admin", bundle: Bundle.main)
              
            let vc : FetchStudViewController = storyboard.instantiateViewController(withIdentifier: "adminMain") as! FetchStudViewController
              let navigationController = UINavigationController(rootViewController: vc)
              navigationController.modalPresentationStyle = .fullScreen
              self.present(navigationController, animated: true, completion: nil)
        }
        
         let authObject = Auth.auth()
    // Display activityindicator
      let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
      activityIndicator.hidesWhenStopped = true
      activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
      view.addSubview(activityIndicator)
        
      // Try signing in with credentials
      authObject.signIn(withEmail: self.mailID.text!, password: self.password.text!, completion:{(user, error) in
        if (error != nil) {
        // if there is error, display alertcontroller

          let alertcontrollerc = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
          self.present(alertcontrollerc, animated: true, completion: nil)
          
          let ok = UIAlertAction(title: "ok", style: .default, handler: { (ok) in
              activityIndicator.stopAnimating()
            
            // Display the login screen again
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dest = storyboard.instantiateViewController(withIdentifier: "Mainview") as! ViewController
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let nav = UINavigationController(rootViewController: dest)
            appdelegate.inputView?.window?.rootViewController = nav
          })
          alertcontrollerc.addAction(ok)
        }
            
        else {
         print("user?.uid = \(String(describing: user?.user.uid))")
            self.userId = user?.user.uid
        // Check whether it is a student account
            fetchDetails().getDetails2(userId: (user?.user.uid)!, callback:
                { (stuData, error) in
                self.studentArray = stuData as? [allUserDetails] ?? []
                print(self.studentArray.count)
         if(self.studentArray.count > 0)
              {
                self.userId = user?.user.uid
                // obtain role from the extracted data
         for i in self.studentArray
                {
                    print(self.studentArray)
                  if i.role != nil
                  {
                    print("role print = \(i.role)")
                    self.rolecheck = i.role
                     self.usn = i.usn
                    self.batchNum = i.batch!
                    self.section = i.section
                  //  defaults.set(i.role, forKey: "role")
                    // based on role instantiate the respective viewController
                    self.checkRole()
                    
                  }
                }
              }
         else {
            // Check whether it is faculty account
            self.facultyLogin()
        }
        
        
        
        
        
            })
            
           }
        })
        }
    
    func checkRole()
         {
           switch self.rolecheck
           {
           case "1"?:
             
//             print("Student login")
////             let vc = UIStoryboard.init(name: "batch", bundle: Bundle.main).instantiateViewController(withIdentifier: "studentStoryBoard") as? synBatchMainViewController
//             let storyBoard : UIStoryboard = UIStoryboard(name: "batch", bundle:nil)
//
//             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "studentStoryBoard") as! synBatchMainViewController
//             nextViewController.modalPresentationStyle = .fullScreen
//
//
//
//             self.present(nextViewController, animated:true, completion:nil)
//
//             print("check1")
////             vc!.stuUsn = usn!
//
////    self.navigationController?.pushViewController(vc!, animated: true)
//            print("check2")
            
            print("Student login")
               //             let vc = UIStoryboard.init(name: "batch", bundle: Bundle.main).instantiateViewController(withIdentifier: "studentStoryBoard") as? synBatchMainViewController
               let storyBoard : UIStoryboard = UIStoryboard(name: "batch", bundle:nil)
               

             
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "studentStoryBoard") as! synBatchMainViewController
               let navigationController = UINavigationController(rootViewController: nextViewController)
               
               
              // nextViewController.modalPresentationStyle = .fullScreen
               
               //Pass batchNumber, usn, uid and section to batchSynopsisViewController
               nextViewController.batchNumberOfUser = self.batchNum
               nextViewController.usnOfUser = self.usn!
               nextViewController.uidOfUser =  self.userId!
               nextViewController.sectionOfUser = self.section!
              // self.present(nextViewController, animated:true, completion:nil)
               navigationController.modalPresentationStyle = .fullScreen
               self.present(navigationController, animated: true, completion: nil)

               
               print("check1")
               //             vc!.stuUsn = usn!
               
               //    self.navigationController?.pushViewController(vc!, animated: true)
               print("check2")

           case "0"?:
//             let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "facultySB") as? synMainViewController
//             self.navigationController?.pushViewController(vc!, animated: true)
            
//            let vc : synMainViewController = storyboard.instantiateViewController(withIdentifier: "facultySB") as! synMainViewController
            let storyboard : UIStoryboard = UIStoryboard(name: "faculty", bundle: Bundle.main)
              
            let vc : fR1DisplayMainViewController = storyboard.instantiateViewController(withIdentifier: "fReview1") as! fR1DisplayMainViewController
              let navigationController = UINavigationController(rootViewController: vc)
              navigationController.modalPresentationStyle = .fullScreen
              self.present(navigationController, animated: true, completion: nil)

            print("reached")

           case "2"?:

                        let storyboard : UIStoryboard = UIStoryboard(name: "hod", bundle: Bundle.main)
                        
                      let vc : hodViewController = storyboard.instantiateViewController(withIdentifier: "hodMain") as! hodViewController
                        let navigationController = UINavigationController(rootViewController: vc)
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
            case "3":
            let storyboard : UIStoryboard = UIStoryboard(name: "coordinator", bundle: Bundle.main)

            let tabbar = storyboard.instantiateViewController(withIdentifier: "tabCoordinator")
                let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
           case "4":
                       let storyboard : UIStoryboard = UIStoryboard(name: "guide", bundle: Bundle.main)

                       let tabbar = storyboard.instantiateViewController(withIdentifier: "tabGuide")
                           let navigationController = UINavigationController(rootViewController: tabbar)
                       navigationController.modalPresentationStyle = .fullScreen
                       self.present(navigationController, animated: true, completion: nil)
            
           default:
             break
           }
         }
         
       
       
       func facultyLogin(){
          print("user?.uid = \(String(describing: userId))")
             // Check whether it is a student account
           fetchDetails().getFacultyDetails(userId: (userId)!, callback:
           { (facultyData, error) in
            if(  facultyData.count > 0 )
                {
                    self.facultyArray = facultyData as! [allUserDetails]
                    print(self.facultyArray.count)
//              if(self.facultyArray.count > 0)
//                   {
                     // obtain role from the extracted data
              for i in self.facultyArray
                     {
                         print(self.facultyArray)
                       if i.role != nil
                       {
                         print("role print = \(i.role)")
                         self.rolecheck = i.role
                       //  defaults.set(i.role, forKey: "role")
                         // based on role instantiate the respective viewController
                         self.checkRole()
                         
                       }
                     }
                   }
            else
              {
                self.coordinatorLogin()
            }
           
           
       })
       }

//       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           let destVC = segue.destination as! StudentsignupViewController
//           destVC.role = self.role
//
//    }
               
       func coordinatorLogin()
       {
        print("In cLogin user?.uid = \(String(describing: userId))")
        //  Check whether it is a coordinator account
        fetchDetails().getCoordinatorDetails(userId: (userId)!, callback:
         { (coordData, error) in
          
          self.coordinatorArray = coordData as? [coordinatorDetails] ?? []
          print(self.coordinatorArray.count)
          if(self.coordinatorArray.count > 0)
          {
           // obtain role from the extracted data
           for i in self.coordinatorArray
           {
            print(self.coordinatorArray)
            if i.role != nil
            {
             
             print("role print = \(i.role)")
             self.rolecheck = i.role
             coordinatorId = i.uid!
             //  defaults.set(i.role, forKey: "role")
             // based on role instantiate the respective viewController
             self.checkRole()
             
            }
           }
          }
          else {
           print("Guide Login")
           // function hodLogin
           //self.coordinatorLogin()
            self.guideLogin()
          }
          
          
        })
        
       }
    func guideLogin()
    {
        print("In gLogin user?.uid = \(String(describing: userId))")
        //  Check whether it is a coordinator account
        fetchDetails().getGuideDetails(userId: (userId)!, callback:
         { (coordData, error) in
          
          self.guideArray = coordData as? [guideDetails] ?? []
          print(self.guideArray.count)
          if(self.guideArray.count > 0)
          {
           // obtain role from the extracted data
           for i in self.guideArray
           {
            print(self.guideArray)
            if i.role != nil
            {
             
             print("role print = \(i.role)")
             self.rolecheck = i.role
             guideId = i.uid!
             //  defaults.set(i.role, forKey: "role")
             // based on role instantiate the respective viewController
             self.checkRole()
             
            }
           }
          }
//          else {
//
//          }
          
          
        })
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        loginButton.layer.cornerRadius = 25.0
        loginButton.tintColor = UIColor.white
        
    }


}

struct allUserDetails {
    var batch:Int?
    var branch:String?
    var email:String?
    var name:String?
     var role:String?
    var section:String?
    var usn:String?
    var year:String?
  var userId:String?
  
  init() {
    
  }
  
  init(withuserid uid:String){
    self.userId = uid
    
  }
  
  init(withDictionary dict:[String:AnyObject])
  {
    self.batch = dict["Batch"] as? Int ?? 0
    self.branch = dict["Branch"] as? String ?? ""
    self.email = dict["Email"] as? String ?? ""
    self.name = dict["Name"] as? String ?? ""
    self.role = dict["Role"] as? String ?? ""
    self.section = dict["Section"] as? String ?? ""
    self.usn = dict["USN"] as? String ?? ""
    self.year = dict["Year"] as? String ?? ""
  }
}
