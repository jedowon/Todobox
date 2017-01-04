//
//  TaskListViewController.swift
//  Todobox
//
//  Created by sunrin software10 on 2016. 12. 18..
//  Copyright © 2016년 sunrin software10. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var editButton: UIBarButtonItem!
    let doneButton: UIBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: nil,
        action: #selector(doneButtonDidTap)
    )
    
    var tasks: [Task] = [
        Task(title: "숙제하기", memo: "집가서 바로하기"), //삭제함
        Task(title: "코드짜기"),
        Task(title: "저녁 뭐먹을지 정하기"),
        Task(title: "양치하기"),
        Task(title: "잠자기", memo: "6시간"),
        ] {
        didSet {
            self.editButton.isEnabled = !tasks.isEmpty
            self.saveAll()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundColor = UIColor.red
        self.doneButton.target = self
        self.title = "나의 할 일"
        self.loadAll()
    }
    
    func saveAll() {
        let dicts = self.tasks.map { (task: Task) -> [String: Any] in
            return[
                "title": task.title,
                "done": task.done,
            ]
        }
        UserDefaults.standard.set(dicts, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    func loadAll() {
        guard let dicts = UserDefaults.standard.array(forKey: "tasks") as? [[String : Any]] else { return }
        self.tasks = dicts.flatMap { dict -> Task? in
            return Task(dictionary: dict)
            /*guard let title = dict["title"] as? String,
                let done = dict["done"] as? Bool
            else { return nil }
            return Task(title: title, done: done)
            */
            //1. 새로 할일 추가
            //2. 다시 Run
            //3. 1뻔에서 추가한게 남아있기
            //slack.swiftkorea.org
        }
        self.tableView.reloadData()
    }
    
    @IBAction func editButtonDidTap() {
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
            let rootViewController = navigationController.viewControllers.first,
            let taskEditViewController = rootViewController as? TaskEditViewController {
            
            taskEditViewController.TaskDidadd = { newTask in print("새 테스크가 추가될 것임!! \(newTask.title)")
                self.tasks.append(newTask)
                self.saveAll()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.memo
        if task.done{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        var task = tasks[i]
        task.done = !task.done
        tasks[i] = task
        
        self.saveAll()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        if self.tasks.isEmpty {
            self.doneButtonDidTap()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var newTasks = self.tasks
        let task = newTasks.remove(at: sourceIndexPath.row)
        newTasks.insert(task, at: destinationIndexPath.row)
        self.tasks = newTasks
    }
}
