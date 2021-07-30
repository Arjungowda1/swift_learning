//
//  sdPhaseViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 05/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol sdGetPhase
{
 func getSelectedPhase(selectedPhase:String)
}
class sdPhaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var sdPhase = ["Review 1","Review 2","Phase 1","Phase 2"]
    var delegate: sdGetPhase?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdPhase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sdPhaseCell") as! sdPhaseTableViewCell
        cell.sdPhase.text = sdPhase[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.delegate?.getSelectedPhase(selectedPhase:sdPhase[indexPath.row])
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
