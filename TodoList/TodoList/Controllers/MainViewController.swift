//
//  MainViewController.swift
//  TodoList
//
//  Created by 장일규 on 2022/02/15.
//

import Foundation
import UIKit
import Reusable


class MainViewController: UIViewController {
    
   lazy var rightAddButton: UIBarButtonItem = {
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed(_:)))
        rightAddButton.tag = 1
        return rightAddButton
    }()
    
   lazy var leftEditButton: UIBarButtonItem = {
        let leftEditButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonPressed(_:)))
        leftEditButton.tag = 2
       self.tableView.setEditing(false, animated: true)
        return leftEditButton
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
        // Realm path
        print(RealmManager.shared.filePath()!)
    }
    
    func setup() {
        setNavigationItem()
        addViews()
        setConstraints()
        setConfigureTableView()
    }
    
    func setConfigureTableView() {
        tableView.register(cellType: TodoListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
                case 1:
                let alert = UIAlertController(title: "오늘 무슨 공부하지?", message: "무슨 공부할지 입력해주세용~", preferredStyle: .alert)
                let registerButton = UIAlertAction(title: "등록", style: .default) {
                    _ in
                    guard let title = alert.textFields?[0].text else { return }
                    let todo = TodoEntity(todoText: title)
                    // todo Insert
                    RealmManager.shared.insertTodo(todo: todo)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
                let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(cancelButton)
                alert.addAction(registerButton)
                alert.addTextField { textFiled in
                    textFiled.placeholder = "공부 화이팅~🤗"
                }
                self.present(alert, animated: true, completion: nil)
                
                case 2:
                print("2")
                default:
                print("default")
            }
        }
    }
    
    func addViews(){
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableViewConstraints()
    }
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setNavigationItem() {
        self.title = "Todo List"
        self.navigationItem.leftBarButtonItem = self.leftEditButton
        self.navigationItem.rightBarButtonItem = self.rightAddButton
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmManager.shared.todoTotalCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TodoListCell
        let todoAll = RealmManager.shared.selectAll()
        
        cell.textLabel?.text = todoAll[indexPath.row].todoText
        
        if todoAll[indexPath.row].isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let todoAll = RealmManager.shared.selectAll()
        let todoEntity = todoAll[indexPath.row]
        
        RealmManager.shared.done(todoEntity: todoEntity, isDone: !todoEntity.isDone)
        
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        
        
        print(todoEntity)
//        todo.isDone = !todo.isDone
//        todoAll[indexPath.row] = todo
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
