//
//  ViewController.swift
//  Gamyfy Life
//
//  Created by Vighnesh Vadiraja on 08/02/21.
//

import UIKit

class AllTasks: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {}
    
    var tasks = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = ModelManager.getInstance().getAllTasks()
        tblView.reloadData()
    }
}

extension AllTasks: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allTasksCell", for: indexPath) as! TaskCell
        cell.lblTaskName.text = tasks[indexPath.row].taskName
        cell.lblFrequency.text = tasks[indexPath.row].frequency
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(onClickEdit), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
        cell.backgroundColor = .cyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func onClickEdit(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddTaskViewController") as! AddTaskViewController
        vc.taskData = tasks[sender.tag]
        vc.headerTitle = "Update Task"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickDelete(_ sender: UIButton) {
        let isDelete = ModelManager.getInstance().deleteTask(task: tasks[sender.tag])
        tasks.remove(at: sender.tag)
        tblView.reloadData()
        print("isDelete: -\(isDelete)")
    }
}

