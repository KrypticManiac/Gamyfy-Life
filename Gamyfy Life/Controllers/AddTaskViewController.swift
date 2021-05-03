//
//  AddTaskViewController.swift
//  Gamyfy Life
//
//  Created by Vighnesh Vadiraja on 24/02/21.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtFrequency: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblErr: UILabel!
    
    let datePickerForStartDate = UIDatePicker()
    let datePickerForEndDate = UIDatePicker()
    var startDateFromPicker = Date()
    var endDateFromPicker = Date()
    var taskData: TaskModel?
    var headerTitle = ""
    let frequencies = ["Daily", "Weekly", "Monthly"]
    let pickerView = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStartDatePicker()
        createEndDatePicker()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        txtFrequency.inputView = pickerView
        
        if headerTitle != "" {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.title = headerTitle
            txtTaskName.text = taskData!.taskName
            txtStartDate.text = formatter.string(from: taskData!.startDate)
            txtEndDate.text = formatter.string(from: taskData!.endDate)
            txtFrequency.text = taskData!.frequency
        }
        
        
    }
    
    func createStartDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForStartDate))
        toolbar.setItems([doneBtn], animated: true)
        txtStartDate.inputAccessoryView = toolbar
        txtStartDate.inputView = datePickerForStartDate
        datePickerForStartDate.datePickerMode = .date
    }
    
    @objc func donePressedForStartDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        startDateFromPicker = datePickerForStartDate.date
        txtStartDate.text = dateFormatter.string(from: datePickerForStartDate.date)
        self.view.endEditing(true)
    }
    
    func createEndDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForEndDate))
        toolbar.setItems([doneBtn], animated: true)
        txtEndDate.inputAccessoryView = toolbar
        txtEndDate.inputView = datePickerForEndDate
        datePickerForEndDate.datePickerMode = .date
    }
    
    @objc func donePressedForEndDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        endDateFromPicker = datePickerForEndDate.date
        txtEndDate.text = dateFormatter.string(from: datePickerForEndDate.date)
        self.view.endEditing(true)
    }
    @IBAction func saveBtnPressed(_ sender: Any) {
        let calender = Calendar.current
        if txtTaskName.text == "" || txtStartDate.text == "" || txtEndDate.text == "" || txtFrequency.text == "" {
            lblErr.textColor = .red
            lblErr.text = "Please fill all fields"
        }else if calender.compare(startDateFromPicker, to: endDateFromPicker, toGranularity: .day) == .orderedDescending {
            lblErr.textColor = .red
            lblErr.text = "The start date sould be smaller than the end date"
        } else {
            if headerTitle != "" {
                let task = TaskModel(id: taskData!.id, taskName: txtTaskName.text!, startDate: startDateFromPicker, endDate: endDateFromPicker, frequency: txtFrequency.text!)
                let isUpdated = ModelManager.getInstance().updateTask(task: task)
                print("isUpdate: -\(isUpdated)")
                performSegue(withIdentifier: "unwindToHome", sender: self)
            } else {
                let task = TaskModel(id: "", taskName: txtTaskName.text!, startDate: startDateFromPicker, endDate: endDateFromPicker, frequency: txtFrequency.text!)
                let isSave = ModelManager.getInstance().saveTask(task: task)
                print("isSave:- \(isSave)")
                performSegue(withIdentifier: "unwindToHome", sender: self)
            }
        }
        
    }
    
}

extension AddTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFrequency.text = frequencies[row]
        txtFrequency.resignFirstResponder() 
        
    }
    
}



