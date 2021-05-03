import Foundation
import UIKit

class Util {
    
    static let share = Util()
    
    //MARK: - Getting the path of the DataBase
    
    func getPath(dbName: String) -> String{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(dbName)
        print(fileUrl.path)
        return fileUrl.path
    }
    
    //MARK: - Creating a path for the Database if it doesnt Exist
    
    func copyDataBase(dbName: String) {
        let dbPath = getPath(dbName: "GamyfyLifeDataBase.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath){
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(dbName)
            
            do {
                try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
