//
//  cSynBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 06/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_splcSyn2
{
    func getSelectedBatch(selectedBatch: String)
}
class cSynBatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
     var batchArray:[batchDetails] = []
    @IBOutlet weak var cSynBatchTableview: UITableView!
    //  let varForProto:testproto?
      var delegate : getval_splcSyn2?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cSynBatchCell", for: indexPath)
        let batchObj = batchArray[indexPath.row]
        cell.textLabel?.text = String(batchObj.batchNumber!)
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.delegate?.getSelectedBatch(selectedBatch:String( batchArray[indexPath.row].batchNumber!))
        }
    
    func fetchBatchData()
    {
     fetchDetails().getBatchDetails { (batchData, error) in
      self.batchArray.removeAll()
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
         //self.usnList = ["USN1":i.usn1!,"USN2":i.usn2!,"USN3":i.usn3!,"USn4":i.usn4!]
         //     self.values.append(contentsOf: <#T##Sequence#>)
         
        }
       }
           self.cSynBatchTableview.reloadData()
       
      }
      //self.displayBatchTableView.reloadData() // New one
     }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
fetchBatchData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                    // Dispose of any resources that can be recreated.
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
