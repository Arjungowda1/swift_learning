//
//  ptSectionViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 05/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class ptSectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var ptSection = ["a","b","c"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ptSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ptSectionCell") as! ptSectionTableViewCell
        cell.ptSection.text = ptSection[indexPath.row]
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
