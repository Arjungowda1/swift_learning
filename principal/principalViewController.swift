//
//  principalViewController.swift
//  trackPro
//
//  Created by IOS on 02/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import FirebaseAuth

class principalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,getval_splPrin,getval_splPrin2{
    
    var sections = ["A"]
    var guides = ["someGuide"]
    var usns = ["1jb16cs000"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as! detailsTableViewCell
        cell.section.text = sections[indexPath.row]
        cell.guide.text = guides[indexPath.row]
        cell.usn.text = usns[indexPath.row]
        return cell
    }
    
    func getsdata(selected: String) {
        print("Reaching..")
        if selected == "Apple"
        {
            pBranch.setTitle(selected, for: .normal)
        }
        else if selected == "Chikku"
        {
            pBranch.setTitle(selected, for: .normal)
        }
        
        else if selected == "Straberry"
        {
            pBranch.setTitle(selected, for: .normal)
        }
        else if selected == "Grapes"
        {
            pBranch.setTitle(selected, for: .normal)
        }
        else
        {
            pBranch.setTitle(selected, for: .normal)
        }
    }
    func getsdata2(selected: String) {
        print("Reaching..")
        if selected == "Apple"
        {
            pSec.setTitle(selected, for: .normal)
        }
        else if selected == "Chikku"
        {
            pSec.setTitle(selected, for: .normal)
        }
        
        else if selected == "Straberry"
        {
            pSec.setTitle(selected, for: .normal)
        }
        else if selected == "Grapes"
        {
            pSec.setTitle(selected, for: .normal)
        }
        else
        {
            pSec.setTitle(selected, for: .normal)
        }
    }
    
    @IBOutlet var pBranch: UIButton!
    @IBOutlet var pSec: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pBranchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "nextPrin1") as! pBatchViewController
               // popcontrol.spec = true
                //popcontrol.somestring = rows2[indexPath.row]
               popcontrol.delegate = self
                popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
                popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                popcontrol.preferredContentSize.height = 200
                popcontrol.preferredContentSize.width = 200
                popcontrol.popoverPresentationController?.delegate = self
                popcontrol.popoverPresentationController?.sourceView = sender
                popcontrol.popoverPresentationController?.sourceRect = sender.bounds
                self.present(popcontrol, animated: true, completion: nil)
    }
    @IBAction func pSecFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "nextPrin2") as! pSectionViewController
               // popcontrol.spec = true
                //popcontrol.somestring = rows2[indexPath.row]
               popcontrol.delegate = self
                popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
                popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                popcontrol.preferredContentSize.height = 200
                popcontrol.preferredContentSize.width = 200
                popcontrol.popoverPresentationController?.delegate = self
                popcontrol.popoverPresentationController?.sourceView = sender
                popcontrol.popoverPresentationController?.sourceRect = sender.bounds
                self.present(popcontrol, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
          return UIModalPresentationStyle.none
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
    @IBAction func logout(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let IntroVC = storyboard.instantiateViewController(withIdentifier: "Mainview") as! ViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = IntroVC
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
}
