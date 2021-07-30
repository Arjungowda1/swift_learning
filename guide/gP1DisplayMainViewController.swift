import UIKit
import FirebaseAuth
class gP1DisplayMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_spl_g,getval_spl_g2 {
     func getSelectedBatch(selectedBatch: String) {
              gP1DisplayBatch.setTitle(selectedBatch, for: .normal)
              currBatch = Int(selectedBatch)!
                 print(currBatch)
              fetchBatchData()
          }
          func getSelectedUsn(selectedUsn: String) {
                 currUsn = selectedUsn
                 gP1DisplayUsn.setTitle(selectedUsn, for: .normal)
            
                self.literatureSurvey.text = "-"
                self.methodologe.text = "-"
                self.implementation.text = "-"
                self.presentation.text = "-"
                self.vivavoice.text = "-"
                self.total.text = "-"
                self.semFour.text = "-"
                self.semFive.text = "-"
                self.semSix.text = "-"
            
                     fetchPhase1marks()
                    fetchGrades()
             }
       var currBatch:Int = 0
       var usnList:[String] = []
       var currUsn = ""
       var batchArray:[batchDetails] = []
       var marksArray:[phase1Details] = []
        var gradesArray:[academicMarks] = []
    
    @IBOutlet var gP1DisplayBatch: UIButton!
    @IBOutlet var gP1DisplayUsn: UIButton!
    @IBOutlet weak var literatureSurvey: UILabel!
    @IBOutlet weak var methodologe: UILabel!
    @IBOutlet weak var implementation: UILabel!
    @IBOutlet weak var presentation: UILabel!
    @IBOutlet weak var vivavoice: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var semFour: UILabel!
    @IBOutlet weak var semFive: UILabel!
    @IBOutlet weak var semSix: UILabel!
    
    @IBOutlet weak var selectPhase: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func gP1DisplayBatchFunc(_ sender: UIButton) {
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
    @IBAction func gP1DisplayUsnFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next22") as!gR1DisplayUsnViewController
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
        case 1:
         let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gReview2") as? gR2DisplayMainViewController
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
      }
     }
    }
     func fetchPhase1marks(){
          fetchDetails().getGuidePhase1Marks { (marksData, error) in
           self.marksArray.removeAll()
           print("MarksData: \(marksData)")
           if marksData.count > 0
           {
            // print(batchData.count)
            self.marksArray = marksData as! [phase1Details]
            
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
                self.literatureSurvey.text = String(i.litSurvey!)
                self.presentation.text = String(i.presentation!)
                self.vivavoice.text = String(i.viva!)
                self.methodologe.text = String(i.methodology!)
                self.implementation.text = String(i.implementation!)
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
