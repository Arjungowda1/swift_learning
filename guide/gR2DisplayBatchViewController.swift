import UIKit
protocol getval_spl26
{
    func getsdata1(selected:String)
}
class gR2DisplayBatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
    var arr = ["Apple","Chicku","Straberry","Grapes","Tomato"]
    //  let varForProto:testproto?
      var delegate : getval_spl26?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellj",for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  if arr[indexPath.row] == "Apple"
                  {
                     // delegate.chooseFruit(Selected: arr[indexPath.row])
          //          let delegate = getValD?.self
          //            dismiss(animated: true, completion: nil)
                      self.delegate?.getsdata1(selected: arr[indexPath.row])
                      //print("Calling..")
                      dismiss(animated: true, completion: nil)
                  }
                  
                  if arr[indexPath.row] == "Straberry"
                  {
                      // delegate.chooseFruit(Selected: arr[indexPath.row])
                      //          let delegate = getValD?.self
                      //            dismiss(animated: true, completion: nil)
                      self.delegate?.getsdata1(selected: arr[indexPath.row])
                      print(arr[indexPath.row])
                     // print("Straberry..")
                      dismiss(animated: true, completion: nil)
                  }
                  if arr[indexPath.row] == "Chicku"
                  {
                      self.delegate?.getsdata1(selected: arr[indexPath.row])
                      print(arr[indexPath.row])
                    //  print("Straberry..")
                      dismiss(animated: true, completion: nil)
                  }
                  if arr[indexPath.row] == "Grapes"
                  {
                      // delegate.chooseFruit(Selected: arr[indexPath.row])
                      //          let delegate = getValD?.self
                      //            dismiss(animated: true, completion: nil)
                      self.delegate?.getsdata1(selected: arr[indexPath.row])
                      print(arr[indexPath.row])
                      // print("Straberry..")
                      dismiss(animated: true, completion: nil)
                  }
                  if arr[indexPath.row] == "Tomato"
                  {
                      self.delegate?.getsdata1(selected: arr[indexPath.row])
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



}
