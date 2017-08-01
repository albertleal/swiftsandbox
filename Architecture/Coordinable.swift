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
}

class Coordinable : UIViewController, CoordinableDelegate{
    var coordinator : FlowCoordinatorDelegate?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextStep = segue.destination as? Coordinable {
            nextStep.coordinator = self.coordinator
        }
    }
}
