//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Abhishek Arunkumar on 13/11/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var headerView: MovieHeaderStackView!
    @IBOutlet var movieDesciption: UILabel!
    
    var movieDetail: Movie = Movie()
    var theatres: [Theatre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.movieImg.image = UIImage(named: movieDetail.movieImgName!)
        headerView.movieName.text = movieDetail.name
        headerView.movieRating.text = movieDetail.rating
        headerView.genre.text = movieDetail.genre
        headerView.hours.text = movieDetail.noOfHours
        headerView.releaseDate.text = movieDetail.releaseDate
        movieDesciption.text = movieDetail.movieDescription
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
            dismiss(animated: true, completion: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookTickets"{
            let destinationController = segue.destination as! BookTicketsViewController
            destinationController.theatres = theatres
        }
    }

}
