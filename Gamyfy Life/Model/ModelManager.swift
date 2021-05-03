import Foundation
import UIKit

//Creating a Global Instance
var shareInstance = ModelManager()

class ModelManager {
    
    var database: FMDatabase? = nil
    
    static func getInstance() -> ModelManager {
        if shareInstance.database == nil {
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "GamyfyLifeDataBase.db"))
        }
        return shareInstance
    }
    //MARK: - Saving Task Data
    func saveTask(task: TaskModel) -> Bool {
        shareInstance.database?.open()
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO task (taskName, startDate, endDate, frequency) VALUES(?,?,?,?)", withArgumentsIn: [task.taskName, task.startDate, task.endDate, task.frequency])
        shareInstance.database?.close()
        return isSave!
    }
    
    //MARK: - Fetching Task Data
    func getAllTasks() -> [TaskModel] {
        shareInstance.database?.open()
        var tasks = [TaskModel]()
        do {
            let resultSet: FMResultSet? = try shareInstance.database?.executeQuery("SELECT * FROM task", values: nil)
            if resultSet != nil {
                while resultSet!.next() {
                    let task = TaskModel(id: resultSet!.string(forColumn: "id")!, taskName: resultSet!.string(forColumn: "taskName")!, startDate: resultSet!.date(forColumn: "startDate")!, endDate: resultSet!.date(forColumn: "endDate")!, frequency: resultSet!.string(forColumn: "frequency")!)
                    tasks.append(task)
                }
            }
        } catch let err {
            print(err.localizedDescription)
        }
        shareInstance.database?.close()
        return tasks
    }
    //MARK: - Updating Task Data
    func updateTask(task: TaskModel) -> Bool {
        shareInstance.database?.open()
        let isUpdate = shareInstance.database?.executeUpdate("UPDATE task SET taskName=?, startDate=?, endDate=?, frequency=? WHERE id=?", withArgumentsIn: [task.taskName, task.startDate, task.endDate, task.frequency, task.id])
        shareInstance.database?.close()
        return isUpdate!
    }
    
    //MARK: - Deleting Task Data
    func deleteTask(task: TaskModel) -> Bool {
        shareInstance.database?.open()
        let isDelete = shareInstance.database?.executeUpdate("DELETE FROM task WHERE taskName=?", withArgumentsIn: [task.taskName])
        shareInstance.database?.close()
        return isDelete!
    }
}


