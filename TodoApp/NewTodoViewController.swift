//
//  NewTodoViewController.swift
//  TodoApp
//
//  Created by 木本 悠介 on 2015/11/30.
//  Copyright © 2015年 木本 悠介. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var urgent: UISegmentedControl!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var todoField: UITextField!
    let todoCollection = TodoCollection.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
        descriptionView.layer.borderWidth = 1
        //タップされたことを認識する
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(tapRecognizer)
        todoField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
    }
    
    //closeボタンが押された時に実行する処理
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //saveボタンが押された時に実行する処理
    func save() {
        if todoField.text!.isEmpty {
            let alertView = UIAlertController(title: "エラー", message: "Todoが記述されていません", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        } else {
            let todo = Todo()
            todo.title = todoField.text!
            todo.descript = descriptionView.text
            todo.priority = TodoPriority(rawValue: prioritySegment.selectedSegmentIndex)!
            todo.urgent = urgent.selectedSegmentIndex
            self.todoCollection.addTodoCollection(todo)
            print(self.todoCollection.todos)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //タップされた時に実行する処理
    func tapGesture(sender: UITapGestureRecognizer) {
        todoField.resignFirstResponder()
        descriptionView.resignFirstResponder()
    }
    
    //textFieldのReturnが押された時にキーボードを閉じるためのデリゲートメソッド
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        todoField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
