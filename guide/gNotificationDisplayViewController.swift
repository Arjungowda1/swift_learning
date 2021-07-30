//
//  gNotificationDisplayViewController.swift
//  trackPro
//
//  Created by iOSLevel1 on 14/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class gNotificationDisplayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gNotifyCell")
        cell?.textLabel?.text = notifyArray[indexPath.row]
        return cell!
    }
    
    var notifyArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(notifyArray)
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
