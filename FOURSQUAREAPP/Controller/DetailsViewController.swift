//
//  DetailsViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 02/01/23.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var typePlace: UILabel!
    @IBOutlet weak var ratingsButton: UIButton!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var ratingsPopUpView: UIView!
    
    var detailViewModel: PlaceDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.ratingsPopUpView.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        detailViewModel?.fetchPlaceDetails { success,error  in
            DispatchQueue.main.async {
                if success ?? false {
                    self.assignValueToFields()
                }
                else {
                    print("errroooorrr")
                }
            }
        }
    }
    
    func assignValueToFields() {
        if let place = detailViewModel?.currentPlace {
            placeName.text = place.placeName
            overViewLabel.text = place.overview
            typePlace.text = place.placeType
            let imageUrl = URL(string: place.placePhoto)
            let data = try? Data(contentsOf: imageUrl!)
            placeImage.image = UIImage(data: data!)
            let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            addPin(coordinate: coordinate)
        }
    }
    
    func addPin(coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        self.mapView.addAnnotation(pin)
        
    }
    
    @IBAction func onClickRatings(_ sender: Any) {
        self.ratingsPopUpView.isHidden = false
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        self.ratingsPopUpView.isHidden = true
    }
    @IBAction func onClickReview(_ sender: Any) {
        print("reviewClicked")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onClickPhotosButton(_ sender: Any) {
        print("PhotosClicked")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func configure() {
        
    }
    @IBAction func onClickAddReview(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddReviewViewController") as? AddReviewViewController{
            let addReviewVM = AddReviewViewModel()
            addReviewVM.placeId = detailViewModel?.placeId ?? ""
            vc.addReviewViewModel = addReviewVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
