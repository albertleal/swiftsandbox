import UIKit

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

enum CoordinatorTransition{
    case window(String)
}

protocol ManagedCoordinator: Coordinator{
    var manager : CoordinatorManager? {get}
    init(withManager manager: CoordinatorManager)
    init(withManager manager: CoordinatorManager, onWindow window: UIWindow)
    func start()
}

protocol CoordinatorManager : class {
    
}

protocol Coordinable {
    var coordinator : Coordinator? {get set}
}
