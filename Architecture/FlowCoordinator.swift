import UIKit

// MARK: FLOW COORDINATOR

protocol FlowCoordinatorDelegate: class{
    var window : UIWindow? {get set}
    var baseStoryBoard : UIStoryboard? {get set}
    var baseController: UIViewController? {get set}
    var currentTransition: FlowTransition?{ get set}
    var manager: FlowCoordinatorManager? { get set}
    func performTransition(transition: FlowTransition)
    func start()
    init()
    init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow)
    init(withManager manager: FlowCoordinatorManager, onWindow window: UIWindow)
}

class FlowCoordinator : FlowCoordinatorDelegate{
    
    var window: UIWindow?
    var baseStoryBoard: UIStoryboard?
    var baseController: UIViewController?
    var currentTransition: FlowTransition?
    var manager: FlowCoordinatorManager?
    
    required init(){
        
    }
    
    required convenience init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.currentTransition = FlowTransition.replace(flow.sotoryBoardId)
    }
   
    required convenience init(withManager manager: FlowCoordinatorManager, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.manager = manager
        
        var bootTransition: CoordinableStoryBoard?
        
        for configuration in (self.manager?.configurations)! {
            if(configuration.conditional()){
                let currentPriority = bootTransition != nil ? bootTransition!.priority.rawValue : 0
                if(currentPriority <= configuration.priority.rawValue){
                    bootTransition = configuration
                }
            }
        }
        
        self.currentTransition = FlowTransition.replace((bootTransition?.sotoryBoardId)!)
    }
    
    func performTransition(transition: FlowTransition) {
        switch transition {
        case .replace(let storyBoardID):
            let storyBoard = UIStoryboard(name: storyBoardID, bundle: nil)
            
            self.baseStoryBoard = storyBoard
            self.baseController = self.baseStoryBoard?.instantiateInitialViewController()
            
            if var coordinable = self.baseController as? Coordinable {
                coordinable.coordinator = self
            }
            
            self.window?.rootViewController = self.baseController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func start(){
        if(self.currentTransition != nil){
            self.performTransition(transition: self.currentTransition!)
        }
    }
}

// MARK: EXTRA

protocol FlowCoordinatorManager : class {
    var configurations: [CoordinableStoryBoard]{get set}
}

protocol Coordinable {
    var coordinator : FlowCoordinatorDelegate? {get set}
}

enum FlowTransition{
    case replace(String)
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
}


