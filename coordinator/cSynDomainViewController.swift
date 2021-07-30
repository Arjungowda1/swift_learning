//
//  cSynDomainViewController.swift
//  trackPro
//
//  Created by IOSLevel-01 on 06/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
protocol getval_splcSyn
{
    func getsdata(selected:String)
}
class cSynDomainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arr = ["iOS","ML","Data Science","IOT","web"]
    var delegate : getval_splcSyn?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cSynDomainCell",for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if arr[indexPath.row] == "iOS"
            {
               // delegate.chooseFruit(Selected: arr[indexPath.row])
    //          let delegate = getValD?.self
    //            dismiss(animated: true, completion: nil)
                self.delegate?.getsdata(selected: arr[indexPath.row])
                //print("Calling..")
                dismiss(animated: true, completion: nil)
            }
            
            if arr[indexPath.row] == "ML"
            {
                // delegate.chooseFruit(Selected: arr[indexPath.row])
                //          let delegate = getValD?.self
                //            dismiss(animated: true, completion: nil)
                self.delegate?.getsdata(selected: arr[indexPath.row])
                print(arr[indexPath.row])
               // print("Straberry..")
                dismiss(animated: true, completion: nil)
            }
            if arr[indexPath.row] == "Data Science"
            {
                self.delegate?.getsdata(selected: arr[indexPath.row])
                print(arr[indexPath.row])
              //  print("Straberry..")
                dismiss(animated: true, completion: nil)
            }
            if arr[indexPath.row] == "IOT"
            {
                // delegate.chooseFruit(Selected: arr[indexPath.row])
                //          let delegate = getValD?.self
                //            dismiss(animated: true, completion: nil)
                self.delegate?.getsdata(selected: arr[indexPath.row])
                print(arr[indexPath.row])
                // print("Straberry..")
                dismiss(animated: true, completion: nil)
            }
            if arr[indexPath.row] == "web"
            {
                self.delegate?.getsdata(selected: arr[indexPath.row])
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
