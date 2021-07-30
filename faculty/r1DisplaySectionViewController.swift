//
//  r1DisplaySectionViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class r1DisplaySectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var r1DisSection = ["A","B","C"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return r1DisSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "r1DisSectionCell") as! r1DisplaySectionTableViewCell
        cell.r1DisplaySection.text = r1DisSection[indexPath.row]
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
