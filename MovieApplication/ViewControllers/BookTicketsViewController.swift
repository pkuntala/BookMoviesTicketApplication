//
//  BookTicketsViewController.swift
//  MovieApplication
//
//  Created by Abhishek Arunkumar on 15/11/21.
//

import UIKit

class BookTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var chooseDate: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    var theatres : [Theatre] = []
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
            dismiss(animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDate()
        
        tableView.isHidden = true
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theatres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theatreCell", for: indexPath) as! TheatreTableViewCell
        
        cell.view = view
        cell.theatreName.text = theatres[indexPath.row].tname
    
        return cell
    }

    
    func showDate(){
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
            toolBar.setItems([doneBtn], animated: true)
            
            chooseDate.inputAccessoryView = toolBar
            chooseDate.inputView = datePicker
            
            datePicker.minimumDate = Date()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.timeZone = .none
        }
    
    @objc func doneButtonPressed(){
            chooseDate.text = "\(dateFormatter.string(from: datePicker.date))"
            self.view.endEditing(true)
        tableView.isHidden = false
        }
}
