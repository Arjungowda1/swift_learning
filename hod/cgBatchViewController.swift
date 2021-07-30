//
//  cgBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 05/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getGuideBatch2
{
    func getGSelectedBatch(selectedBatch:String)
}
class cgBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
     var cgBatch = ["1jbhhgfb","ahdsbhs"]
       //  let varForProto:testproto?
         var delegate : getGuideBatch2?
    var batchList:[String:String] = [:]
       var batchArray:[batchDetails] = []
    var values:[String] = []
    @IBOutlet weak var batchTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cgBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cgBatchCell",for: indexPath)
        cell.textLabel?.text = cgBatch[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.delegate?.getGSelectedBatch(selectedBatch:cgBatch[indexPath.row])
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
            self.batchTableView.reloadData()
         }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("batches")
        print(cgBatch)
        print(cgBatch.count)
        self.batchTableView.reloadData()
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
