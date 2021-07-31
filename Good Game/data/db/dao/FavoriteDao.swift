//
//  FavoriteDao.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import Foundation
import CoreData

class FavoriteDao: Database {
    func create(_ data: Games, completion: @escaping() -> Void){
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                _ = data.toNSManagedObject(task: taskContext, entity: entity)
                do {
                    try taskContext.save()
                    completion()
                }catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getAll(completion: @escaping(_ data: [Games]) -> Void){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Games] = []
                for result in results {
                    games.append(result.toGames())
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func findById(_ id: Int32, completion: @escaping(_ data: Games?) -> Void){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let results = try taskContext.fetch(fetchRequest)
                if results.count > 0 {
                    completion(results.first?.toGames())
                }else {
                    completion(nil)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteById(_ id: Int32,  completion: @escaping() -> Void){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func deleteAll(completion: @escaping() -> Void){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
}
