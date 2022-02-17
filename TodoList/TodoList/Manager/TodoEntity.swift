//
//  TodoEntity.swift
//  TodoList
//
//  Created by 장일규 on 2022/02/17.
//

import Foundation
import RealmSwift

class TodoEntity: Object {
    
    @Persisted(primaryKey: true) var todoId: Int = 0 // 시퀀스
    @Persisted var todoText: String = "" // 내용
    @Persisted var isDone: Bool // 
    @Persisted var regDate: Double = 0.0 // 생성일
    @Persisted var modDate: Double = 0.0 // 수정일
    
    convenience init(todoText: String) {
        self.init()
        self.todoText = todoText
    }
}
