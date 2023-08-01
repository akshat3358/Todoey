import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
        }catch{
            print("Erro initialising new realm,\(error)")
        }
        
        
        //To see the hidden file on mac system --> cmd + shift + .
        
        //To find user defaults plist file path
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }

}

