import UIKit
protocol getSynPhaseGuide
{
    func getSelectedPhase(selectedPhase:String)
}
class synPhaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIPopoverPresentationControllerDelegate{
    var synPhase = ["Review 1","Review 2","Phase 1","Phase 2"]
    var delegate:getSynPhaseGuide?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return synPhase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellc",for: indexPath)
        cell.textLabel?.text = synPhase[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  self.delegate?.getSelectedPhase(selectedPhase: synPhase[indexPath.row])
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
