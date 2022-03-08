//
//  CoreDataStack.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/7.
//

import CoreData
import UIKit

class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init() {}
    
    // MARK: - Core Data stack
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShortcutItem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Working context

extension CoreDataStack {
    var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedObjectContext
        return context
    }
    
    func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension CoreDataStack {
    
    //搜索
    func searchData(url:String) -> Data? {
        //设置查询条件
        let fetchRequest = NSFetchRequest<ImageData>(entityName:"ImageData")
//        fetchRequest.fetchLimit = 1 //限定查询结果的数量
//        fetchRequest.fetchOffset = 0 //查询的偏移量
        //查询操作
        do {
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            if fetchedObjects.count <= 0 {
                return nil
            }else{
                //遍历查询的结果
                for info in fetchedObjects{
                    if info.url == url {
                        return info.image!
                    }
                }
            }
        }
        catch {
            fatalError("不能保存：\(error)")
        }
        return nil
    }
    
    func addData(url:String, imageData:Data) {
        //替换
        let fetchRequest = NSFetchRequest<ImageData>(entityName:"ImageData")
        do {
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            for info in fetchedObjects{
                if info.url == url {
                    info.image = imageData
                    return
                }
            }
            //重新保存-更新到数据库
            try! managedObjectContext.save()
        }
        catch {
            fatalError("不能保存：\(error)")
        }
        
        //创建User对象
        let data = NSEntityDescription.insertNewObject(forEntityName: "ImageData",
                                                       into: managedObjectContext) as! ImageData
        data.url = url
        data.image = imageData        
        do {
            try managedObjectContext.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<ImageData>(entityName:"ImageData")
        do {
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            for info in fetchedObjects{
                managedObjectContext.delete(info)
            }
            //重新保存-更新到数据库
            try! managedObjectContext.save()
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    func replaceData(url:String, imageData:Data) {
        let fetchRequest = NSFetchRequest<ImageData>(entityName:"ImageData")
        do {
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            for info in fetchedObjects{
                if info.url == url {
                    info.image = imageData
                    try managedObjectContext.save()
                    return
                }
            }
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    
}
