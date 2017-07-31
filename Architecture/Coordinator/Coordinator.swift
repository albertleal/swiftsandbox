import UIKit

// MARK: Coordinator
protocol Coordinator: class{
    var window : UIWindow? {get set}
    var baseStoryBoard : UIStoryboard? {get set}
    var baseController: UIViewController? {get set}
    func performTransition(transition: CoordinatorTransition)
    init(onWindow window: UIWindow)
}

extension Coordinator {
    func performTransition(transition: CoordinatorTransition) {
        switch transition {
        case .window(let storyBoardID):
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
}

// MARK: Coordinator Transition
enum CoordinatorTransition{
    case window(String)
}

// MARK: Managed Coordinator
protocol ManagedCoordinator: Coordinator{
    var manager: CoordinatorManager? { get }
    var currentTransition: CoordinatorTransition?{ get }
    init(withManager manager: CoordinatorManager)
    init(withManager manager: CoordinatorManager, onWindow window: UIWindow)
    func start()
}

// MARK: Coordinator Managed
protocol CoordinatorManager : class {
    
}

// MARK: Coordinable
protocol Coordinable {
    var coordinator : Coordinator? {get set}
}
