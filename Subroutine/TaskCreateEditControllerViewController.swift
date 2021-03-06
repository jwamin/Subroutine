//
//  TaskCreateEditControllerViewController.swift
//  Subroutine
//
//  Created by Joss Manger on 7/3/18.
//  Copyright © 2018 Joss Manger. All rights reserved.
//

import UIKit

class TaskCreateEditControllerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var durationPicker: UIDatePicker!
    
    var parentView:DetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       titleField.delegate = self
       descriptionField.delegate = self
        durationPicker.datePickerMode = .countDownTimer
        durationPicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func datePickerChanged(_ sender:UIDatePicker){
        print(sender.countDownDuration)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        
        print("prepairing for segue")
        if let destination = parentView{
            print(durationPicker.countDownDuration)
            let task = TaskStruct(title: titleField.text ?? "default title", description: descriptionField.text ?? "default description", duration: durationPicker.countDownDuration)
            destination.addItem(task: task)
            navigationController?.popViewController(animated: true)
        }

    }
    
 
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */

 

}

struct TaskStruct{
    let title:String
    let description:String
    let duration:TimeInterval
}

