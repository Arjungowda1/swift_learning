import UIKit
import FirebaseAuth
class gP2DisplayMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_spl_g,getval_spl_g2 {
     func getSelectedBatch(selectedBatch: String) {
           gP2DisplayBatch.setTitle(selectedBatch, for: .normal)
           currBatch = Int(selectedBatch)!
              print(currBatch)
           fetchBatchData()
       }
       func getSelectedUsn(selectedUsn: String) {
              currUsn = selectedUsn
              gP2DisplayUsn.setTitle(selectedUsn, for: .normal)
        
            self.nov.text = "-"
            self.impandcod.text =  "-"
            self.resultandperf.text = "-"
            self.presentation.text = "-"
            self.viva.text = "-"
            self.report.text = "-"
            self.publication.text = "-"
            self.projectdiary.text = "-"
            self.total.text = "-"
            self.semFour.text = "-"
            self.semFive.text = "-"
            self.semSix.text = "-"
            
                  fetchPhase2marks()
                fetchGrades()
       }
       var currBatch:Int = 0
       var usnList:[String] = []
       var currUsn = ""
       var batchArray:[batchDetails] = []
       var marksArray:[phase2Details] = []
     var gradesArray:[academicMarks] = []
    
    @IBOutlet var gP2DisplayBatch: UIButton!
    @IBOutlet var gP2DisplayUsn: UIButton!
    @IBOutlet weak var nov: UILabel!
    @IBOutlet weak var impandcod: UILabel!
    @IBOutlet weak var resultandperf: UILabel!
    @IBOutlet weak var presentation: UILabel!
    @IBOutlet weak var viva: UILabel!
    @IBOutlet weak var report: UILabel!
    @IBOutlet weak var publication: UILabel!
    @IBOutlet weak var projectdiary: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var semFour: UILabel!
    @IBOutlet weak var semFive: UILabel!
    @IBOutlet weak var semSix: UILabel!
    
    @IBOutlet weak var selectPhase: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func gP2DisplayBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next21") as!gR1DisplayBatchViewController
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
    @IBAction func gP2DisplayUsnFunc(_ sender: UIButton) {
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
        case 1:
         let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gReview2") as? gR2DisplayMainViewController
         self.navigationController?.pushViewController(vc!, animated: true)
        
        case 2:
         let vc = UIStoryboard.init(name: "guide", bundle: Bundle.main).instantiateViewController(withIdentifier: "gPhase1") as? gP1DisplayMainViewController
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
     func fetchPhase2marks(){
          fetchDetails().getGuidePhase2Marks{ (marksData, error) in
           self.marksArray.removeAll()
           print("MarksData: \(marksData)")
           if marksData.count > 0
           {
            self.marksArray = marksData as![phase2Details]
            
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
                self.nov.text = String(i.novelty!)
                self.impandcod.text = String(i.implementation!)
                self.resultandperf.text = String(i.resultandperformace!)
                self.presentation.text = String(i.presentation!)
                self.viva.text = String(i.viva!)
                self.report.text = String(i.report!)
                self.publication.text = String(i.publication!)
                self.projectdiary.text = String(i.projectdiary!)
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
