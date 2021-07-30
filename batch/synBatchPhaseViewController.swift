import UIKit
protocol getPhase
{
    func getSelectedPhase(selectedPhase:String)
}
class synBatchPhaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
    var phase = ["Review 1","Review 2","Phase 1","Phase 2"]
      var delegate : getPhase?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellu",for: indexPath)
        cell.textLabel?.text = phase[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  self.delegate?.getSelectedPhase(selectedPhase: phase[indexPath.row])

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
