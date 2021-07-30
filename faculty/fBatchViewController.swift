//
//  fBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 23/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_spl_f2
{
     func getSelectedBatch(selectedBatch:String)
}
class fBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate {
    var cgBatch = ["0","0"]
    var batchArray:[batchDetails] = []
    var batchList:[String:String] = [:]
    var values:[String] = []
    var delegate : getval_spl_f2?
    @IBOutlet weak var fBatchTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cgBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fBatchCell",for: indexPath)
        cell.textLabel?.text = cgBatch[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  self.delegate?.getSelectedBatch(selectedBatch: cgBatch[indexPath.row])
              }
    func fetchSectionData()
    {
        fetchDetails().getSectionDetails { (sectionData, error) in
         self.batchArray.removeAll()
           self.batchList.removeAll()
         if sectionData.count > 0
         {
          // print(batchData.count)
          self.batchArray = sectionData as! [batchDetails]
          print("batch array : \(self.batchArray)")
          if self.batchArray.count > 0
          {
           for i in self.batchArray
           {
            print(i.section)
            self.batchList = ["BatchNumber":String(i.batchNumber!)]
           }
          }
            self.fBatchTableView.reloadData()
         }
        }
    }
//    func fetchBatchData()
//    {
//     fetchDetails().getBatchDetails { (batchData, error) in
//      self.batchArray.removeAll()
//      if batchData.count > 0
//      {
//       // print(batchData.count)
//       self.batchArray = batchData as! [batchDetails]
//       print("batch array : \(self.batchArray)")
//       if self.batchArray.count > 0
//       {
//        for i in self.batchArray
//        {
//         print(i.batchNumber)
//         //self.usnList = ["USN1":i.usn1!,"USN2":i.usn2!,"USN3":i.usn3!,"USn4":i.usn4!]
//         //     self.values.append(contentsOf: <#T##Sequence#>)
//
//        }
//       }
//           self.fBatchTableView.reloadData()
//
//      }
//    self.fBatchTableView.reloadData() // New one
//     }
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
self.fBatchTableView.reloadData()
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
