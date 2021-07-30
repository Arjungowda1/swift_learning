import UIKit
import FirebaseAuth
class gR2DisplayMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_spl_g,getval_spl_g2 {
    func getSelectedBatch(selectedBatch: String) {
           gR2DisplayBatch.setTitle(selectedBatch, for: .normal)
           currBatch = Int(selectedBatch)!
              print(currBatch)
           fetchBatchData()
       }
       func getSelectedUsn(selectedUsn: String) {
              currUsn = selectedUsn
              gR2DisplayUsn.setTitle(selectedUsn, for: .normal)
        
        self.objectivesMarks.text = "-"
        self.presentationMarks.text = "-"
        self.vivaMarks.text = "-"
        self.methodologyMarks.text = "-"
        self.progressMarks.text = "-"
        self.total.text = "-"
        self.record.text = "-"
            self.semFour.text = "-"
            self.semFive.text = "-"
            self.semSix.text = "-"
        
                  fetchReview2marks()
                fetchGrades()
          }
    var currBatch:Int = 0
    var usnList:[String] = []
    var currUsn = ""
    var batchArray:[batchDetails] = []
    var marksArray:[review2Details] = []
    var gradesArray:[academicMarks] = []
    
    @IBOutlet var gR2DisplayBatch: UIButton!
    @IBOutlet var gR2DisplayUsn: UIButton!
    @IBOutlet weak var objectivesMarks: UILabel!
    @IBOutlet weak var presentationMarks: UILabel!
    @IBOutlet weak var vivaMarks: UILabel!
    @IBOutlet weak var methodologyMarks: UILabel!
    @IBOutlet weak var semFour: UILabel!
    @IBOutlet weak var semFive: UILabel!
    @IBOutlet weak var semSix: UILabel!
    
    @IBOutlet weak var progressMarks: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var record: UILabel!
    @IBOutlet weak var selectPhase: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gR2DisplayBatchFunc(_ sender: UIButton) {
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
    
    @IBAction func gR2DisplayUsnFunc(_ sender: UIButton) {
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
    
    @IBAction func selectPhaseAction(_ sender: UISegmentedControl) {
        switch selectPhase.selectedSegmentIndex {
        case 0:
        let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gReview1") as? gR1DisplayMainViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
        case 2:
         let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gPhase1") as? gP1DisplayMainViewController
         self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
            let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gPhase2") as? gP2DisplayMainViewController
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
        
       func fetchReview2marks(){
          fetchDetails().getGuideReview2Marks { (marksData, error) in
           self.marksArray.removeAll()
           print("MarksData: \(marksData)")
           if marksData.count > 0
           {
            // print(batchData.count)
            self.marksArray = marksData as! [review2Details]
            
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
                self.objectivesMarks.text = String(i.objectives!)
                self.presentationMarks.text = String(i.presentation!)
                self.vivaMarks.text = String(i.viva!)
                self.methodologyMarks.text = String(i.methodology!)
                self.progressMarks.text = String(i.progress!)
                self.total.text = String(i.total!)
                self.record.text = String(i.record!)
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
