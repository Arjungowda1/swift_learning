import UIKit
protocol getDomain
{
    func selectDomain(selectedDomain:String)
}
class synBatchDomainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
    var domain = ["iOS","IoT","Data science","Big data","Machine learning","Web technologies",
    "Computer Networks","Cyber security"]
    //  let varForProto:testproto?
      var delegate : getDomain?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellv",for: indexPath)
        cell.textLabel?.text = domain[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  self.delegate?.selectDomain(selectedDomain: domain[indexPath.row])
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
