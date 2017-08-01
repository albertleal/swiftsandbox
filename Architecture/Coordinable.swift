import UIKit
// MARK: Enums
enum CoordinablePriority : Int{
    case _default =  0
    case _normal =  1
    case _mandatory =  8
    case _bloquer =  9
    case _onStart =  10
}

// MARK: Coordinable
protocol CoordinableDelegate: class{
    var coordinator : FlowCoordinatorDelegate?{get set}
    var viewModel: ViewModelDelegate?{get set}
}

class Coordinable : UIViewController, CoordinableDelegate{
    var coordinator : FlowCoordinatorDelegate?
    var viewModel: ViewModelDelegate?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextStep = segue.destination as? Coordinable {
            nextStep.coordinator = self.coordinator
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let backItem = UIBarButtonItem(title: (self.viewModel?.title)!, style: .plain, target: nil, action: nil)

        self.navigationItem.backBarButtonItem = backItem
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = (self.viewModel?.title)!
        self.coordinator?.nextStep()
    }
}
