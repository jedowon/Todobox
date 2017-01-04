//
//  TaskEditViewController.swift
//  Todobox
//
//  Created by sunrin software10 on 2016. 12. 19..
//  Copyright © 2016년 sunrin software10. All rights reserved.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var memoInput: UITextView!
    
    var TaskDidadd: ((Task) -> Void)?
    
    @IBAction func cancelButtonDidTap() {
        let alertController = UIAlertController (
            title: "헉",
            message: "진짜취소할꺼?????",
            preferredStyle: .alert
        )
        let no = UIAlertAction(title: "아니 안할게", style: .default, handler: nil)
        let yes = UIAlertAction(title: "응 취소할꺼야", style: .destructive) {_ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(no)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editButtonDidTap() {
        
    }
    
    @IBAction func doneButtonDidTap() {
        /*guard let navigationController = self.presentingViewController as? UINavigationController, let taskListViewController = navigationController.viewControllers.first as? TaskListViewController, */
        guard let title = titleInput.text,
            !title.trimmingCharacters(in: .whitespaces).isEmpty else{
                self.shake(self.titleInput)
                return
        }
        let newTask = Task(title: title)
        self.TaskDidadd?(newTask)
        //taskListViewController.tasks.append(newTask)
        //taskListViewController.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    func shake(_ view: UIView){
        UIView.animate(
            withDuration: 0.05,
            animations: { view.frame.origin.x -= 10 },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.05,
                    animations: { view.frame.origin.x += 20 },
                    completion: { _ in
                        UIView.animate(
                            withDuration: 0.05,
                            animations: { view.frame.origin.x -= 20 },
                            completion: { _ in
                                UIView.animate(
                                    withDuration: 0.05,
                                    animations: { view.frame.origin.x += 10 },
                                    completion: { _ in
                                        view.becomeFirstResponder()
                                }
                                )
                        }
                        )
                }
                )
        }
        )

    }
}
