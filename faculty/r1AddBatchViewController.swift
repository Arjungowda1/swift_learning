//
//  r1AddBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class r1AddBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var r1AddBatch = ["1","2","3","4","5","6"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return r1AddBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "r1AddBatchCell") as! r1AddBatchTableViewCell
        cell.r1AddBatch.text = r1AddBatch[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
