import UIKit
// MARK: Flow Model
protocol BootCoordinatorModel : class {
    var storyBoardOptions: [String: CoordinableStoryBoard]?{get set}
}

struct CoordinableStoryBoard {
    var isDefault: Bool?
    var priority: CoordinablePriority
    var sotoryBoardId: String
    var conditional: ()->Bool
}

// MARK: Enums
enum BootTransition{
    case replace(String)
}

// MARK: Boot Coordinator
protocol BootCordinatorDelegate {
    var window : UIWindow? {get set}
    var currentTransition: BootTransition? {get set}
    var bootModel: BootCoordinatorModel? {get set}
    var currentCoordinable: Coordinable? {get set}
    
    init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow)
    init(withFlowModel model: BootCoordinatorModel, onWindow window: UIWindow)
    func start()
}

class BootCordinator : BootCordinatorDelegate{
    var window: UIWindow?
    var currentTransition: BootTransition?
    var bootModel: BootCoordinatorModel?
    var currentCoordinable: Coordinable?
    
    required init(){
        
    }
    
    required convenience init(withStoryBoardFlow flow: CoordinableStoryBoard, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.currentTransition = BootTransition.replace(flow.sotoryBoardId)
    }
    
    required convenience init(withFlowModel model: BootCoordinatorModel, onWindow window: UIWindow) {
        self.init()
        self.window = window
        self.bootModel = model
        
        var bootTransition: CoordinableStoryBoard?
        
        for configuration in (self.bootModel?.storyBoardOptions)! {
            if(configuration.value.conditional()){
                let currentPriority = bootTransition != nil ? bootTransition!.priority.rawValue : 0
                if(currentPriority <= configuration.value.priority.rawValue){
                    bootTransition = configuration.value
                }
            }
        }
        
        if(bootTransition != nil){
            self.currentTransition = BootTransition.replace((bootTransition?.sotoryBoardId)!)
        }
    }
    
    func performTransition(transition: BootTransition) {
        switch transition {
        case .replace(let storyBoardID):
                let baseController = UIStoryboard(name: storyBoardID, bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = baseController
                self.window?.makeKeyAndVisible()
        }
    }
    
    func start(){
        if(self.currentTransition != nil){
            self.performTransition(transition: self.currentTransition!)
            self.currentTransition = nil
        }
    }
}
