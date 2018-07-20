//
//  DetailViewController.swift
//  Subroutine
//
//  Created by Joss Manger on 7/3/18.
//  Copyright © 2018 Joss Manger. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var addButton: LargeButton!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                 var str = ""
                for item in detail.tasks as! NSOrderedSet{
                    let task = item as! Task
                    str += task.title! + "\n"
                    print("\(task.title!) \(detail.tasks?.index(of: item))")
                }
                label.text = str
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        //print(detailItem?.tasks, detailItem?.tasks?.count)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentTaskPicker))
        addButton.addGestureRecognizer(tap)
        //print(detailItem?.tasks)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! TaskCreateEditControllerViewController
        print("preparing for segue to \(destination)")
        destination.parentView = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func presentTaskPicker(){
        addButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 30,
                       options: [.beginFromCurrentState,.allowUserInteraction],
                       animations: {
            
            self.addButton.transform = .identity
            
        }) { (complete) in
            if (complete){
                self.performSegue(withIdentifier: "presentTaskPicker", sender: self)
            }
        }
        
        
    }
    
    func addItem(task:TaskStruct){
        print("adding item \(task)")
        let persistentTask = Task(context: context)
        persistentTask.title = task.title
        persistentTask.taskDescription = task.description
        persistentTask.duration = 20 //Int16(Int(task.duration))
        persistentTask.routine = detailItem
        
        detailItem?.addToTasks(persistentTask)
        context.refresh(detailItem!, mergeChanges: true)
        do {
            try context.save()
            print(detailItem?.tasks)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        configureView()
    }

    var detailItem: Routine? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        arbitraryReorder()
    }
    
    func arbitraryReorder(){
        if(detailItem!.tasks!.count>2){
            var mutable = NSMutableOrderedSet(orderedSet: (detailItem?.tasks)!)
        
        mutable.exchangeObject(at: 2, withObjectAt: 0)
        detailItem?.tasks = NSOrderedSet(orderedSet: mutable)
        context.refresh(detailItem!, mergeChanges: true)
        
        do {
            try context.save()
            configureView()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        }
    }

    lazy var context:NSManagedObjectContext = {
        
            let delegate =  UIApplication.shared.delegate as! AppDelegate
            return delegate.persistentContainer.viewContext
        
    }()

}

