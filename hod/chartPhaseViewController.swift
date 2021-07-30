//
//  chartPhaseViewController.swift
//  trackPro
//
//  Created by iOSLevel1 on 13/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol hodGetPhase
{
 func getSelectedPhase(selectedPhase:String)
}
class chartPhaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var phases = ["Review 1- Presentation","Review 1- Synopsis","Review 2- Presentation","Review 2- Synopsis","Phase 1- Presentation","Phase 1- Synopsis","Phase 2- Presentation","Phase 2- Synopsis"]
    var delegate: hodGetPhase?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartPhaseCell") as! chaPhaseTableViewCell
        cell.chaPhaseLabel.text = phases[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.delegate?.getSelectedPhase(selectedPhase:phases[indexPath.row])
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
