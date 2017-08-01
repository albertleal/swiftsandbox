import UIKit

// MARK: FLOW COORDINATOR

protocol FlowCoordinatorDelegate: class{
    var window : UIWindow? {get set}
    var currentTransition: FlowTransition?{get set}
    var currentCoordinable: Coordinable?{get set}
    var flowModel: FlowCoordinatorModel? {get set}
    func performTransition(transition: FlowTransition)
    func start()
    func step(fromCoordinable currentStep : Coordinable)
    init()
    init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow)
    init(withFlowModel model: FlowCoordinatorModel, onWindow window: UIWindow)
    init(withFlowModel model: FlowCoordinatorModel, onCoordinable coordinable: Coordinable)
}

class FlowCoordinator : FlowCoordinatorDelegate{
    var window: UIWindow?
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
    
    required convenience init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.currentTransition = FlowTransition.replace(flow.sotoryBoardId)
    }
   
    required convenience init(withFlowModel model: FlowCoordinatorModel, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.flowModel = model
        
        var bootTransition: CoordinableStoryBoard?
        
        for configuration in (self.flowModel?.storyBoardOptions)! {
            if(configuration.value.conditional()){
                let currentPriority = bootTransition != nil ? bootTransition!.priority.rawValue : 0
                if(currentPriority <= configuration.value.priority.rawValue){
                    bootTransition = configuration.value
                }
            }
        }
        if(bootTransition != nil){
            self.currentTransition = FlowTransition.replace((bootTransition?.sotoryBoardId)!)
        }
    }
    
    func performTransition(transition: FlowTransition) {
        switch transition {
        case .replace(let storyBoardID):
            let baseController = UIStoryboard(name: storyBoardID, bundle: nil).instantiateInitialViewController()
            
            if let coordinable = baseController as? Coordinable {
                coordinable.coordinator = self
            }
            
            self.window?.rootViewController = baseController
            self.window?.makeKeyAndVisible()
        case .popUp(let siegueId):
            self.currentCoordinable?.performSegue(withIdentifier: siegueId, sender: nil)
            break
        }
    }
    
    func start(){
        if(self.currentTransition != nil){
            self.performTransition(transition: self.currentTransition!)
            self.currentTransition = nil
        }
    }
    func step(fromCoordinable currentStep : Coordinable){
        if(self.currentTransition != nil){
            self.performTransition(transition: self.currentTransition!)
            self.currentTransition = nil
        }
    }
}

// MARK: EXTRA

protocol FlowCoordinatorModel : class {
    var storyBoardOptions: [String: CoordinableStoryBoard]?{get set}
    var sieguesOptions: [String: CoordinableSiegues]?{get set}
}
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

enum FlowTransition{
    case replace(String)
    case popUp(String)
}

struct CoordinableSiegues {
//    var isDefault: Bool?
    var priority: CoordinablePriority
    var sieguedId: String
    var conditional: ()->Bool
}

struct CoordinableStoryBoard {
    var isDefault: Bool?
    var priority: CoordinablePriority
    var sotoryBoardId: String
    var conditional: ()->Bool
}

enum CoordinablePriority : Int{
    case _default =  0
    case _normal =  1
    case _mandatory =  8
    case _bloquer =  9
    case _onStart =  10
}


