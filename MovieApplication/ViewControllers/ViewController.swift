//
//  ViewController.swift
//  MovieApplication
//
//  Created by Abhishek Arunkumar on 12/11/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var languageSelection: UISegmentedControl!
    @IBOutlet weak var locationtextField: UITextField!
    
    let pickerView = UIPickerView()
    
    var locationArray: [String] = []
    
    var movies : [Movie] = []
    var resultsController : NSFetchedResultsController <Movie>!
    var filteredMovieContent : [Movie] = []
    
    var theatres: [Theatre] = []
    var theatreResultsController: NSFetchedResultsController<Theatre>!

    var selectedLanguage=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        locationtextField.inputView = pickerView
        moviesCollection.dataSource = self
        moviesCollection.delegate = self
        
        moviesCollection.isHidden = true
        languageSelection.isHidden = true
        
        getData()
        for theatre in theatres {
            if locationArray.contains(theatre.tlocation!){
                continue
            } else{
                locationArray.append(theatre.tlocation!)
            }
        }
        print(movies.count)
        
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
            dismiss(animated: true, completion: nil)
        }
    
    func getData(){
        let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor : NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        //set the sortDescriptor for the fetchRequest
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Getting shared properties of present apps
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        resultsController.delegate = self
        
        do{
            try resultsController.performFetch()
            if let data = resultsController.fetchedObjects{
                movies = data
            }
        }
        catch{}
        
        
        let fetchRequest1 : NSFetchRequest<Theatre> = Theatre.fetchRequest()
        let sortDescriptor1 : NSSortDescriptor = NSSortDescriptor(key: "tname", ascending: true)
        //set the sortDescriptor for the fetchRequest
        fetchRequest1.sortDescriptors = [sortDescriptor1]
        
        theatreResultsController = NSFetchedResultsController(fetchRequest: fetchRequest1, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        theatreResultsController.delegate = self
        
        do{
            try theatreResultsController.performFetch()
            if let data = theatreResultsController.fetchedObjects{
                theatres = data
            }
        }
        catch{}
    }
    
    
    
    //MARK:- UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationtextField.text = locationArray[row]
        self.view.endEditing(true)
        
        languageSelection.isHidden = false
        moviesCollection.isHidden = false
        moviesCollection.reloadData()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails"{
            if let indexPath = moviesCollection.indexPathsForSelectedItems?.first {
                let destinationController = segue.destination as! MovieDetailViewController
                destinationController.movieDetail = filteredMovieContent[indexPath.row]
                
                destinationController.theatres = theatres.filter { theatreItem in
                    theatreItem.tlocation==locationtextField.text ? true : false
                }
            }
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch selectedLanguage{
        case 0:
            filteredMovieContent = movies.filter { movieItem in
                if movieItem.movieLanguage == "English"{
                    if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
            //return englishMovies.count
        case 1:
//            filteredMovieContent = movies.filter { movieItem in
//                movieItem.movieLanguage=="Hindi" ? true : false
//            }
            filteredMovieContent = movies.filter { movieItem in
                if movieItem.movieLanguage == "Hindi"{
                    if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
            //return hindiMovies.count
        case 2:
            filteredMovieContent = movies.filter { movieItem in
                if movieItem.movieLanguage == "Kannada"{
                    if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
            //return kannadaMovies.count
        case 3:
            filteredMovieContent = movies.filter { movieItem in
                if movieItem.movieLanguage == "Telugu"{
                    if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
            //return teluguMovies.count
        case 4:
            filteredMovieContent = movies.filter { movieItem in
                if movieItem.movieLanguage == "Tamil"{
                    if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
            //return tamilMovies.count
        default : filteredMovieContent = movies.filter { movieItem in
            if movieItem.movieLanguage == "English"{
                if movieItem.movieLocation!.contains("\(locationtextField.text!)"){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }
            
        }
        return filteredMovieContent.count
        //return movies.count
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        var array:[Movie]
        /*
        switch selectedLanguage{
        case 0:
            array = englishMovies
        case 1:
            array = hindiMovies
        case 2:
            array = kannadaMovies
        case 3:
            array = teluguMovies
        case 4:
            array = tamilMovies
        default : array =  englishMovies
            
        }
        */
        array = filteredMovieContent
        cell.movieLbl.text = array[indexPath.row].name
        cell.movieImg.image = UIImage(named: array[indexPath.row].movieImgName!)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    @IBAction func segmentControlChange(_ sender : UISegmentedControl){
        selectedLanguage = sender.selectedSegmentIndex
        moviesCollection.reloadData()
    }
}
