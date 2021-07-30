
//
//  statisticsViewController.swift
//  trackPro
//
//  Created by IOSLevel1 on 03/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class statisticsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var batch = ["1","2","3"]
    var sub = ["submitted","submitted","not submitted"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "statCell") as! statsCellTableViewCell
        
        cell.batch.text = batch[indexPath.row]
        cell.sub.text = sub[indexPath.row]
        
        
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
