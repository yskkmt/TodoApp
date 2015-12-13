//
//  Todo.swift
//  TodoApp
//
//  Created by 木本 悠介 on 2015/11/28.
//  Copyright © 2015年 木本 悠介. All rights reserved.
//

import UIKit

//プライオリティー
enum TodoPriority: Int {
    case Low = 0
    case Middle = 1
    case High = 2
    
    func color() -> UIColor {
        switch self {
        case .Low:
            return UIColor.blueColor()
        case .Middle:
            return UIColor.greenColor()
        case .High:
            return UIColor.redColor()
        }
    }
    
    func textLabel() ->String {
        switch self {
        case .Low:
            return "低"
        case .Middle:
            return "中"
        case .High:
            return "高"
        }
    }
    
}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority: TodoPriority = .Low
    var urgent = 0
}

