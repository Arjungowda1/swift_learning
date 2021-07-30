//
//  cR1DisplayBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 05/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
protocol getval_spl
{
    func getSelectedBatch(selectedBatch:String)
}
class cR1DisplayBatchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    var delegate : getval_spl?
    var batchArray:[batchDetails] = []
    var coordArray:[coordinatorDetails] = []
    var batchList:[String] = []
    
    @IBOutlet weak var batchTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let batchObj = batchArray[indexPath.row]
        cell.textLabel?.text = batchList[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.delegate?.getSelectedBatch(selectedBatch:String( batchList[indexPath.row]))
        }
    
    func fetchBatchData()
    {
        fetchDetails().getCoordinatorDetails(userId: Auth.auth().currentUser!.uid, callback: { (coordData, error) in
            self.coordArray.removeAll()
            if coordData.count>0
            {
                self.coordArray = coordData as! [coordinatorDetails]
     fetchDetails().getBatchDetails { (batchData, error) in
      self.batchArray.removeAll()
        self.batchList.removeAll()
      if batchData.count > 0
      {
       self.batchArray = batchData as! [batchDetails]
       print("batch array : \(self.batchArray)")
       if self.batchArray.count > 0
       {
        for i in self.batchArray
        {
            if i.section == self.coordArray[0].section
            {
                self.batchList.append(String(i.batchNumber!))
            }
//         print(i.batchNumber)
        }
       }
        self.batchTableView.reloadData()
      }
    self.batchTableView.reloadData()
     }
            }
        })
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
