//
//  fSectionViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 23/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_spl_f
{
     func getSelectedSection(selectedSection:String)
}
class fSectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
     var arr = ["A","B","C"]
    var delegate : getval_spl_f?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fSec",for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
self.delegate?.getSelectedSection(selectedSection: arr[indexPath.row])
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
