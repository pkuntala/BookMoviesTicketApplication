//
//  TheatreTableViewCell.swift
//  MovieApplication
//
//  Created by Preetika Kuntala on 16/11/21.
//

import UIKit

class TheatreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var theatreName: UILabel!
    
    @IBOutlet var bookTicketsView: PayAndBookCell!

    var view: UIView!
    
    @IBAction func timeSlotButtonTapped(_ sender: UIButton){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        bookTicketsView.backgroundColor = .systemGray6
        bookTicketsView.insetsLayoutMarginsFromSafeArea = true
        //bookTicketsView.alignmentRect(forFrame: CGRect(origin: view.center, size: view.intrinsicContentSize))
        bookTicketsView.frame = CGRect(x: view.center.x - 180 , y: view.center.y - 160,width: 360, height: 320)
        bookTicketsView.parentController = blurEffectView
        
        view.addSubview(bookTicketsView)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
