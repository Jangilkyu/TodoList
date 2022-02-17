//
//  RealmManager.swift
//  TodoList
//
//  Created by 장일규 on 2022/02/17.
//

import Foundation
import RealmSwift

class RealmManager {

    static let shared = RealmManager()
    private var realm: Realm
    
    private init() {
        realm = try! Realm()
       
    }
    
    private func todoID() -> Int {
        return realm.objects(TodoEntity.self).count + 1
    }
    
    func todoTotalCount() -> Int {
        return realm.objects(TodoEntity.self).count
    }
    
    func insertTodo(todo: TodoEntity) {
        todo.todoId = todoID()
        todo.regDate = Date().currentTimeMillis()
        
        try! realm.write{
            realm.add(todo)
        }
    }
    
    func updateTodo(todoId: Int, todoText: String?) {
        let todoEntity = selectById(todoId: todoId)
        if let todoEntity = todoEntity {
            try! realm.write {
                if let todoText = todoText{
                    todoEntity.todoText = todoText
                }
                todoEntity.modDate = Date().currentTimeMillis()
            }
        }
    }
    
    func done(todoEntity: TodoEntity,isDone: Bool) {
        try! realm.write{
            todoEntity.isDone = isDone
        }

    }
    
    func selectAll() -> Results<TodoEntity> {
        return realm.objects(TodoEntity.self)
    }
    
    
    func selectById(todoId: Int) -> TodoEntity? {
        let predicate = NSPredicate(format: "todoId == %i", todoId)
        return realm.objects(TodoEntity.self).filter(predicate).first
    }
    
    func filePath() -> URL? {
        let originalDefaultRealmURL = Realm.Configuration.defaultConfiguration.fileURL
        
        return originalDefaultRealmURL!
    }
    
}

extension Date {
    func currentTimeMillis() -> Double {
        return Double(self.timeIntervalSince1970 * 1000)
    }
}

