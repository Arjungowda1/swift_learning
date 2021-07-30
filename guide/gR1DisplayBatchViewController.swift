import UIKit
import Firebase
protocol getval_spl_g
{
     func getSelectedBatch(selectedBatch:String)
}
class gR1DisplayBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
      var batchArray:[batchDetails] = []
    var batches:[guideDetails] = []
      var delegate : getval_spl_g?
    
    @IBOutlet weak var batchTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellf",for: indexPath)
        let batchObj = batches[indexPath.row]
        cell.textLabel?.text = batchObj.batch!
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  self.delegate?.getSelectedBatch(selectedBatch:String( batches[indexPath.row].batch!))
              }

    func fetchGuideBatches()
             {
               fetchDetails().getGuideBatches(userId: Auth.auth().currentUser!.uid , callback: { (batchData, error) in
               self.batches.removeAll()
               if batchData.count > 0
               {
                // print(batchData.count)
                self.batches = batchData as! [guideDetails]
                print("batch array : \(self.batches)")
                if self.batches.count > 0
                {
                 for i in self.batches
                 {
                   print(i.batch)
                 }
                }
                    self.batchTableView.reloadData()
                
               }
             self.batchTableView.reloadData() // New one
              })
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGuideBatches()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
