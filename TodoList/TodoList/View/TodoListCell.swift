//
//  TodoListCell.swift
//  TodoList
//
//  Created by 장일규 on 2022/02/15.
//

import Foundation
import UIKit
import Reusable

class TodoListCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoListCell: Reusable {
    
}
