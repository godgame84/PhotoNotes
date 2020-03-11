//
//  SecondViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 16.02.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import UIKit
import MapKit



class SecondViewController: UIViewController {
    
    private var indexPath:IndexPath?
    private var cellViewModelSecondVC: CellViewModelSecondVC?
    private let regionRadius: CLLocationDistance = 1000
    
    //private let index: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let navLabel = UILabel()
        self.navigationController?.navigationBar.barStyle = .black
        
        let firstPartOfTitleCell = "Cell "
        let secondPartOfTitleNumber = "number "
              
        let attributeForCell: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.green,
            .font: UIFont(name: "SFProDisplay-Regular" , size: 32) ?? UIFont.systemFont(ofSize: 22)
            
        ]
        let attributeForNumber: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont(name: "SFProDisplay-Regular" , size: 15) ?? UIFont.systemFont(ofSize: 22)
        ]
        let attributeForIndex: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "SFProDisplay-Regular" , size: 22) ?? UIFont.systemFont(ofSize: 22),]
        
        let firstPartAfterChangeCell = NSMutableAttributedString(string: firstPartOfTitleCell, attributes: attributeForCell)
        let secondPartAfterChangeNumber = NSAttributedString(string: secondPartOfTitleNumber, attributes: attributeForNumber)
        let thiredPartafterChangeIndex = NSAttributedString(string: "\(((cellViewModelSecondVC?.getIndexPath.row ?? 0) + 1))", attributes: attributeForIndex)
        
        
        let finalString:NSMutableAttributedString = firstPartAfterChangeCell
        finalString.append(secondPartAfterChangeNumber)
        finalString.append(thiredPartafterChangeIndex)
        
        navLabel.attributedText = finalString
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton))
        
        navigationItem.titleView = navLabel
       
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        textView.text = cellViewModelSecondVC?.getDescription ?? "Default Text"
        
        imageView.image = cellViewModelSecondVC?.getImage
        imageView.contentMode = .scaleToFill
        
        if cellViewModelSecondVC?.getMapCoord != nil{
            mapView.setCenter((cellViewModelSecondVC?.getMapCoord)!, animated: true)
            centerMapOnLocation(location: (cellViewModelSecondVC?.getMapCoord)!)
            createAnnotation(location: (cellViewModelSecondVC?.getMapCoord)!, name: (cellViewModelSecondVC?.getAddress ?? "Street isn't identified"))
        }
        
        // Do any additional setup after loading the view.
    }
    
    public var sendTextButtonClosure: ((_ indexToUpdate:IndexPath,_ textToUpdate:String) -> ())?  //Пора попробовать закинуть замыкания хых бля
    

    
    
    @objc func saveButton() {
        if cellViewModelSecondVC?.getIndexPath != nil{
//            sendTextDelegate?.didUpdateWithText(text: textView.text, index: cellViewModelSecondVC!.getIndexPath)
            sendTextButtonClosure!((cellViewModelSecondVC?.getIndexPath)!,textView.text)
            
        }
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - SetNewCell
    func setCellSecondVC(cellFromFirstVC: CellViewModelSecondVC) {
        cellViewModelSecondVC = cellFromFirstVC
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SecondViewController{
func centerMapOnLocation(location: CLLocationCoordinate2D) {
    let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
  mapView.setRegion(coordinateRegion, animated: true)
}
    
    func createAnnotation(location: CLLocationCoordinate2D, name:String) {
        let annotation = AnnotationForMap(coordinate: location, title: name, subtitle: "")
        mapView.addAnnotation(annotation)
    }
}

extension SecondViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "MapPinAnnot")
      annotationView.canShowCallout = true
      return annotationView
    }
}
