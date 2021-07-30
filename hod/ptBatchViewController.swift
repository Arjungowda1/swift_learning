//
//  ptBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 05/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class ptBatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ptBatch = ["1","2","33"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ptBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ptBatchCell") as! ptBatchTableViewCell
        cell.ptBatch.text = ptBatch[indexPath.row]
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
