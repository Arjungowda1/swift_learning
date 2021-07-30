//
//  synBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
protocol getSynGuideBatch
{
    func getSelectedBatch(selectedBatch: String)
}
class synBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
    @IBOutlet var gSynBatchTableview: UITableView!
//    var batchArray:[batchDetails] = []
    var batches:[guideDetails] = []
         var delegate : getSynGuideBatch?
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return batchArray.count
        return batches.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell99",for: indexPath)
//        let batchObj = batchArray[indexPath.row]
//           cell.textLabel?.text = String(batchObj.batchNumber!)
        let batchObj = batches[indexPath.row]
        cell.textLabel?.text = batchObj.batch
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                     self.delegate?.getSelectedBatch(selectedBatch:String( batchArray[indexPath.row].batchNumber!))
        self.delegate?.getSelectedBatch(selectedBatch:String( batches[indexPath.row].batch!))

                 }
       
//    func fetchBatchData()
//       {
//        fetchDetails().getBatchDetails { (batchData, error) in
//         self.batchArray.removeAll()
//         if batchData.count > 0
//         {
//          // print(batchData.count)
//          self.batchArray = batchData as! [batchDetails]
//          print("batch array : \(self.batchArray)")
//          if self.batchArray.count > 0
//          {
//           for i in self.batchArray
//           {
//            print(i.batchNumber)
//            //self.usnList = ["USN1":i.usn1!,"USN2":i.usn2!,"USN3":i.usn3!,"USn4":i.usn4!]
//            //     self.values.append(contentsOf: <#T##Sequence#>)
//
//           }
//          }
//              self.gSynBatchTableview.reloadData()
//
//         }
//       self.gSynBatchTableview.reloadData() // New one
//        }
//       }
    
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
                 self.gSynBatchTableview.reloadData()
             
            }
          self.gSynBatchTableview.reloadData() // New one
           })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//fetchBatchData()
        fetchGuideBatches()
        // Do any additional setup after loading the view.
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
