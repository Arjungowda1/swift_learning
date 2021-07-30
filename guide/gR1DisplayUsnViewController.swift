import UIKit
protocol getval_spl_g2
{
    func getSelectedUsn(selectedUsn:String)
}
class gR1DisplayUsnViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
   var cR1Usn = ["1jbhhgfb","ahdsbhs"]
    //  let varForProto:testproto?
      var delegate : getval_spl_g2?
    var batchArray:[batchDetails] = []
       var usnList:[String:String] = [:]
       var values:[String] = []
    @IBOutlet weak var usnTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cR1Usn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celle",for: indexPath)
        cell.textLabel?.text =  cR1Usn[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                 self.delegate?.getSelectedUsn(selectedUsn:cR1Usn[indexPath.row])
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
         print(i.batchNumber)
         self.usnList = ["USN1":i.usn1!,"USN2":i.usn2!,"USN3":i.usn3!,"USn4":i.usn4!]
    //     self.values.append(contentsOf: <#T##Sequence#>)
         
        }
       }
       //if self.display == 0
       // {
       self.usnTableView.reloadData()
       // }
      }
      //self.displayBatchTableView.reloadData() // New one
     }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("usns")
               print(cR1Usn)
               print(cR1Usn.count)
               self.usnTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
