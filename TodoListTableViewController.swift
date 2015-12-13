//
//  TodoListTableViewController.swift
//  TodoApp
//
//  Created by 木本 悠介 on 2015/11/28.
//  Copyright © 2015年 木本 悠介. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    let todoCollection = TodoCollection.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        todoCollection.fetchTodos()
        
        //self.todoCollection.fetchTodos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // 毎回呼ばれる
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.Plain, target: self, action: "newTodo")
        self.navigationItem.leftBarButtonItem = editButtonItem()
        self.tableView.reloadData()
    }
    
    //新規作成が押された時に実行される処理
    func newTodo() {
        self.performSegueWithIdentifier("PresentNewTodoViewController", sender: self)
    }
    
    // MARK: - Table view data source

    // Sectionの数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Rowの数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoCollection.todos.count
    }

    // セルの内容
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //セルの詳細を表示
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier")
        let todo = self.todoCollection.todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.descript
        cell.textLabel?.font = UIFont(name: "HirakakuProN-W3", size: 17)
        let priorityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 12))
        priorityLabel.text = todo.priority.textLabel()
        priorityLabel.textColor = todo.priority.color()
        print(todo.urgent)
        cell.accessoryView = priorityLabel

        // Configure the cell...

        return cell
    }
    
    //Editと削除機能追加
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            self.todoCollection.todos.removeAtIndex(indexPath.row)
            self.todoCollection.save()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        case .Insert:
            return
        default:
            return
        }
    }
    
    //せるの編集機能追加
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = self.todoCollection.todos[sourceIndexPath.row]
        self.todoCollection.todos.removeAtIndex(sourceIndexPath.row)
        self.todoCollection.todos.insert(todo, atIndex: destinationIndexPath.row)
        self.todoCollection.save()
    }
}
