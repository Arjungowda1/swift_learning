//
//  pcSectionViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getSection
{
 func getSelectedSection(selectedSec: String)
}

class pcSectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
    var pcSection = ["A","B","C"]
    var delegate : getSection?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pcSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcSectionCell") as! pcSectionTableViewCell
        cell.pcSection.text = pcSection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.delegate?.getSelectedSection(selectedSec: pcSection[indexPath.row])
    
     // self.delegate?.getSelectedFaculty(selectedFac: pcFaculty[indexPath.row])
     
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
