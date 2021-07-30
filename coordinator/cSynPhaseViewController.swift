//
//  cSynPhaseViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 06/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_splcSyn3
{
    func getSelectedPhase(selectedPhase:String)
}
class cSynPhaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
     var cSynPhase = ["Review 1","Review 2","Phase 1","Phase 2"]
         var delegate : getval_splcSyn3?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cSynPhase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cSynPhaseCell", for: indexPath)
        cell.textLabel?.text = cSynPhase[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getSelectedPhase(selectedPhase: cSynPhase[indexPath.row])
        }


    override func viewDidLoad() {
        super.viewDidLoad()

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
