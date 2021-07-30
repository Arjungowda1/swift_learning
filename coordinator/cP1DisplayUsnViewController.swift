//
//  cP1DisplayUsnViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 08/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_spl10
{
    func getsdata2(selected:String)
}
class cP1DisplayUsnViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    var arr = ["Apple","Chicku","Straberry","Grapes","Tomato"]
             var delegate : getval_spl10?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell10", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               if arr[indexPath.row] == "Apple"
               {
                  // delegate.chooseFruit(Selected: arr[indexPath.row])
       //          let delegate = getValD?.self
       //            dismiss(animated: true, completion: nil)
                   self.delegate?.getsdata2(selected: arr[indexPath.row])
                   //print("Calling..")
                   dismiss(animated: true, completion: nil)
               }
               
               if arr[indexPath.row] == "Straberry"
               {
                   // delegate.chooseFruit(Selected: arr[indexPath.row])
                   //          let delegate = getValD?.self
                   //            dismiss(animated: true, completion: nil)
                   self.delegate?.getsdata2(selected: arr[indexPath.row])
                   print(arr[indexPath.row])
                  // print("Straberry..")
                   dismiss(animated: true, completion: nil)
               }
               if arr[indexPath.row] == "Chicku"
               {
                   self.delegate?.getsdata2(selected: arr[indexPath.row])
                   print(arr[indexPath.row])
                 //  print("Straberry..")
                   dismiss(animated: true, completion: nil)
               }
               if arr[indexPath.row] == "Grapes"
               {
                   // delegate.chooseFruit(Selected: arr[indexPath.row])
                   //          let delegate = getValD?.self
                   //            dismiss(animated: true, completion: nil)
                   self.delegate?.getsdata2(selected: arr[indexPath.row])
                   print(arr[indexPath.row])
                   // print("Straberry..")
                   dismiss(animated: true, completion: nil)
               }
               if arr[indexPath.row] == "Tomato"
               {
                   self.delegate?.getsdata2(selected: arr[indexPath.row])
                   print(arr[indexPath.row])
                   //  print("Straberry..")
                   dismiss(animated: true, completion: nil)
               }


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
