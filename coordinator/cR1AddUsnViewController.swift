//
//  cR1AddUsnViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 06/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_spl4
{
    func getSelectedUsn(selectedUsn:String)
}
class cR1AddUsnViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
    var cR1Usn = ["1jbhhgfb","ahdsbhs"]
    var delegate : getval_spl4?
    var batchArray:[batchDetails] = []
    var usnList:[String:String] = [:]
    var values:[String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cR1Usn.count
    }
    
    @IBOutlet weak var usnTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
        cell.textLabel?.text = cR1Usn[indexPath.row]
        return  cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
