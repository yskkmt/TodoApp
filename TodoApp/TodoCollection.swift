//
//  TodoCollection.swift
//  TodoApp
//
//  Created by 木本 悠介 on 2015/11/28.
//  Copyright © 2015年 木本 悠介. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
    static let sharedInstance = TodoCollection()
    var todos:[Todo] = []
    
    func fetchTodos() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let todoList = defaults.objectForKey("todoList") as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(todoDic)
                self.todos.append(todo)
            }
        }
    }
    
    func addTodoCollection(todo: Todo) {
        self.todos.append(todo)
        self.save()
    }
    
    func save(){
        var todoList: Array<Dictionary<String, AnyObject>> = []
        for todo in todos {
            let todoDic = TodoCollection.convertDictionary(todo)
            todoList.append(todoDic)
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(todoList, forKey: "todoList")
        defaults.synchronize()
    }
    
    //todoクラスを辞書型に変更
    class func convertDictionary(todo: Todo) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["title"] = todo.title
        dic["descript"] = todo.descript
        dic["priority"] = todo.priority.rawValue
        dic["urgent"] = todo.urgent
        return dic
    }
    
    //辞書型をTodoクラスに変更
    class func convertTodoModel(attributes: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = attributes["title"] as! String
        todo.descript = attributes["descript"] as! String
        todo.priority = TodoPriority(rawValue: attributes["priority"] as! Int)!
        todo.urgent = attributes["urgent"] as! Int
        return todo
    }
}
