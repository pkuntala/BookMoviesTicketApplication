//
//  PayAndBookCell.swift
//  MovieApplication
//
//  Created by Abhishek Arunkumar on 16/11/21.
//

import UIKit

class PayAndBookCell: UIView {

    @IBOutlet weak  var selectedSeats: UITextField!
        
        @IBOutlet weak var totalCost: UITextField!
        
        var parentController: UIVisualEffectView!
    
        @IBAction func sliderValueChange(_ sender: UISlider){
            selectedSeats.text = String(Int(sender.value))
            
            totalCost.text = "\(Int(sender.value) * 150)"
          
        }
        
        @IBAction func payAndBookButton(_ sender: UIButton){
            print("PAY AND BOOK TAPPED...")
            self.removeFromSuperview()
            parentController.removeFromSuperview()
            
            let alertController = UIAlertController(title: "Yay! Tickets Confirmed", message: "A message will be sent to your registered mobile number", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            //present(alertController, animated: true, completion: nil)
            alertController.addAction(okAction)
            
        }
        
        @IBAction func cancelAction(_ sender: UIButton){
            self.removeFromSuperview()
            parentController.removeFromSuperview()
            //superview?.removeFromSuperview()
            //superview?.reloadInputViews()
            //parentController.dismiss(animated: true, completion: nil)
        }
}


