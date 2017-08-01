import UIKit
// MARK: Flow Model
protocol FlowCoordinatorModel : class {
    var sieguesOptions: [String: CoordinableSiegues]?{get set}
}

struct CoordinableSiegues {
    var priority: CoordinablePriority
    var sieguedId: String
    var conditional: ()->Bool
}

// MARK: Enums
enum FlowTransition{
    case popUp(String)
}

// MARK: Flow Coordinator
protocol FlowCoordinatorDelegate: class{
    var currentTransition: FlowTransition?{get set}
    var currentCoordinable: Coordinable?{get set}
    var flowModel: FlowCoordinatorModel? {get set}
    func performTransition(transition: FlowTransition)
    func nextStep()
    init()
    init(withFlowModel model: FlowCoordinatorModel, onCoordinable coordinable: Coordinable)
}

class FlowCoordinator : FlowCoordinatorDelegate{
    var currentTransition: FlowTransition?
    var flowModel: FlowCoordinatorModel?
    var currentCoordinable: Coordinable?
    
    required init(){
        
    }
    
    required convenience init(withFlowModel model: FlowCoordinatorModel, onCoordinable coordinable: Coordinable) {
        self.init()
        self.flowModel = model
        self.currentCoordinable = coordinable
        var bootTransition: CoordinableSiegues?
        
        for configuration in (self.flowModel?.sieguesOptions)! {
            if(configuration.value.conditional() && configuration.value.priority == ._onStart){
                bootTransition = configuration.value
            }
        }
        
        if(bootTransition != nil){
            self.currentTransition = FlowTransition.popUp((bootTransition?.sieguedId)!)
        }
    }
    
    func performTransition(transition: FlowTransition) {
        switch transition {
        case .popUp(let siegueId):
            self.currentCoordinable?.performSegue(withIdentifier: siegueId, sender: nil)
        }
    }

    func nextStep(){
        if(self.currentTransition != nil){
            self.performTransition(transition: self.currentTransition!)
            self.currentTransition = nil
        }
    }
}
