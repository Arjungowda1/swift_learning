import UIKit
import Firebase
class gR2AddMainViewController: UIViewController,UITextFieldDelegate,UIPopoverPresentationControllerDelegate,getval_spl_g,getval_spl_g2 {
    func getSelectedBatch(selectedBatch: String) {
          currBatch = Int(selectedBatch)!
           fetchBatchData()

           gR2AddBatch.setTitle(selectedBatch, for: .normal)
       }
       func getSelectedUsn(selectedUsn: String) {
        self.submit.isHidden = false
            currUsn = selectedUsn
        validateUsnData()
            gR2AddUsn.setTitle(selectedUsn, for: .normal)
        updateProgress{() -> () in
        print("hello") }
       }
    var currBatch:Int = 0
    var usnList:[String] = []
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[review2Details] = []
    var studentArray:[studentDetails] = []
    var objMarks = 0
    var presMarks = 0
    var vivaVoceMarks = 0
    var methMarks = 0
    var proMarks = 0
    var totalMarks = 0
    var recMarks = 0
    
    var currProgressReview2 = 0
    var incrementedProgReview2 = 0
    
    @IBOutlet weak var objectivesMarks: UITextField!
    @IBOutlet weak var presentationMarks: UITextField!
    @IBOutlet weak var vivaMarks: UITextField!
    @IBOutlet weak var methodologyMarks: UITextField!
    @IBOutlet weak var progressMarks: UITextField!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var record: UITextField!
    @IBOutlet var gR2AddBatch: UIButton!
    @IBOutlet var gR2AddUsn: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    override func viewDidLoad() {
        objectivesMarks.delegate = self
        presentationMarks.delegate = self
        vivaMarks.delegate = self
        methodologyMarks.delegate = self
        progressMarks.delegate = self
        record.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func gR2AddBatchFunc(_ sender: UIButton) {
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
    @IBAction func gR2AddUsnFunc(_ sender: UIButton) {
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
    
    @IBAction func submit(_ sender: UIButton) {
        if(currUsn == "" || currBatch == 0)
        {
            let alert = UIAlertController(title: "Error!", message: "Please select from the dropdowns", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }

        if ((objectivesMarks.text?.isEmpty ?? true) || (presentationMarks.text?.isEmpty ?? true) || (vivaMarks.text?.isEmpty ?? true) || (methodologyMarks.text?.isEmpty ?? true) || (progressMarks.text?.isEmpty ?? true) || (record.text?.isEmpty ?? true) || !(0...5 ~= Int(objectivesMarks.text!)!) || !(0...5 ~= Int(presentationMarks.text!)!) || !(0...5 ~= Int(vivaMarks.text!)!) || !(0...10 ~= Int(methodologyMarks.text!)!) || !(0...5 ~= Int(progressMarks.text!)!) || !(0...50 ~= Int(record.text!)!))
        {
            let alert = UIAlertController(title: "Error!", message: "Please enter valid marks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: false,completion: nil)

        }
        else
        {
        var sum = Int(objectivesMarks.text!)! + Int(presentationMarks.text!)! + Int(vivaMarks.text!)! + Int(methodologyMarks.text!)!
        var sum2 = sum + Int(progressMarks.text!)!
        print(methodologyMarks.text!)
          self.total.text = "\(sum2)"
          let db = Database.database().reference()
          let branch = db.child("GuideMarks").child("Review2")
          let branchKey = branch.childByAutoId().key
          let branchID = branch.child(branchKey!)
        let data = ["USN":currUsn,"Batch":currBatch,"Objectives":Int(objectivesMarks.text!), "Presentation":Int(presentationMarks.text!),"VivaMarks":Int(vivaMarks.text!),"Methodolgy":Int(methodologyMarks.text!),"Progress":Int(progressMarks.text!),"Total":sum2,"Record":Int(record.text!),"ID":branchKey] as [String : Any]
          branchID.setValue(data)
             updateStudentDetails()
        }
    }
    
    func validateUsnData()
        {
            var flag = false
            
            fetchDetails().getGuideReview2Marks { (usnData, error) in
             
             if usnData.count > 0
             {
              // print(batchData.count)
              self.marksArray = usnData as! [review2Details]
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
//                    self.dismiss(animated: false, completion: nil)
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
          self.currProgressReview2 = i.progressReview2!
         }
         // print(i.name)
        }
       }
       callback(self.currProgressReview2)   }
     }
    }
    
    func updateProgress(completion: () -> ())
    {
     fetchProgressData{(currProReview2) in
      self.incrementedProgReview2 = currProReview2 + 1
      print("Updated value: /(self.incrementedProgReview2)")
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
        update1_ID.updateChildValues(["ProgressReview2":self.incrementedProgReview2])
        
       }
      }
     }
     
     
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             let allowedCharacters = CharacterSet.decimalDigits
             let characterSet = CharacterSet(charactersIn: string)
             return allowedCharacters.isSuperset(of: characterSet)
       }

}
