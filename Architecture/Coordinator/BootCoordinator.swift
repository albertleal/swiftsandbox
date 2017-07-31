import UIKit

class BootCoordinator : ManagedCoordinator{
    var window: UIWindow?
    var baseStoryBoard: UIStoryboard?
    var baseController: UIViewController?
    
    required init(onWindow window: UIWindow) {
        self.window = window
    }
    
    var manager: CoordinatorManager?
    required init(withManager manager: CoordinatorManager) {
        self.manager = manager
    }
    
    required convenience init(withManager manager: CoordinatorManager, onWindow window: UIWindow) {
        self.init(onWindow: window)
        self.manager = manager
    }
    
    func start(){
        let bootManager : BootCoordinatorManager = self.manager as! BootCoordinatorManager
        let publicStoryboardID = bootManager.publicStoryboardID
        let privateStoryboardID = bootManager.privateStoryboardID
        let mandatoryUpdateStoryboardID = bootManager.mandatoryUpdateStoryboardID
        let mantainanceStoryboardID = bootManager.mantainanceStoryboardID
        
        //Public Session
        var bootTransition : CoordinatorTransition = .window(publicStoryboardID)
        
        //Mantainance First
        if((bootManager.isMantainanceRequired()) && mantainanceStoryboardID != nil){
            bootTransition = .window(mantainanceStoryboardID!)
        }else{
            //Mandatory Update
            if((bootManager.isMandatoryUpdateRequired()) && mandatoryUpdateStoryboardID != nil){
                bootTransition = .window(mandatoryUpdateStoryboardID!)
            }else{
                //Private Session
                if((bootManager.canNavigateToPrivate()) && privateStoryboardID != nil){
                    bootTransition = .window(privateStoryboardID!)
                }
            }
        }
        
        self.performTransition(transition: bootTransition)
    }
}

protocol BootCoordinatorManager : CoordinatorManager {
    func canNavigateToPrivate() -> Bool
    func isMandatoryUpdateRequired() -> Bool
    func isMantainanceRequired() -> Bool
    
    var publicStoryboardID: String {get set}
    var privateStoryboardID: String? {get set}
    var mandatoryUpdateStoryboardID: String? {get set}
    var mantainanceStoryboardID: String? {get set}
}
