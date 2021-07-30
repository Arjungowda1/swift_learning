//
//  cguideBatchViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 24/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getGuideSection
{
 func getGSelectedSection(GselectedSec: String)
}
class cguideBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
    var pcSection = ["A","B","C"]
       var delegate : getGuideSection?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pcSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cgSectionCell") as! guideSectionTableViewCell
               cell.guideSection.text = pcSection[indexPath.row]
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getGSelectedSection(GselectedSec: pcSection[indexPath.row])
       
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
