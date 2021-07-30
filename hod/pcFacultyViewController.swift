//
//  pcFacultyViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getFac
{
 func getSelectedFaculty(selectedFac: String)
}
class pcFacultyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var pcFaculty = ["sdfd","sfdsf"]
    var delegate : getFac?
    var facArray:[facultyDetails] = []
    
    @IBOutlet weak var facTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcFacultyCell") as! pcFacultyTableViewCell
        let facObj = facArray[indexPath.row]
        cell.pcFaculty.text = facObj.name

           //cell.pcFaculty.text = pcFaculty[indexPath.row]
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.delegate?.getSelectedFaculty(selectedFac: facArray[indexPath.row].name!)
    // self.delegate?.getSelectedFaculty(selectedFac: pcFaculty[indexPath.row])

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFacultyData()
        facTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func fetchFacultyData()
    {
     fetchDetails().getAllFacultyDetails { (facData, error) in
      if facData.count > 0
      {
       
       self.facArray = facData as! [facultyDetails]
       print("student array : \(self.facArray)")
       if self.facArray.count > 0
       {
        for i in self.facArray
        {
         print(i.name)
        }
       }
       self.facTableView.reloadData()
      }
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
}
