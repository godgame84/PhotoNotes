//
//  SecondViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 16.02.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import UIKit
import MapKit

protocol SendTextProtocol: class{
    func didUpdateWithText (text:String?)
}

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
        //navigationItem.title = "Cell number \(((cellViewModelSecondVC?.getIndexPath.row ?? 0) + 1))"
        navigationItem.titleView = navLabel
       
        
       
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
        
        textView.text = cellViewModelSecondVC?.getDescription ?? "Default Text"
        
        if cellViewModelSecondVC?.getMapCoord != nil{
            mapView.setCenter((cellViewModelSecondVC?.getMapCoord)!, animated: true)
            centerMapOnLocation(location: (cellViewModelSecondVC?.getMapCoord)!)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    weak var sendTextDelegate:SendTextProtocol?
    
    
    @objc func saveButton() {
        sendTextDelegate?.didUpdateWithText(text: textView.text)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - SetNewCell
    func setCellSecondVC(cellFromFirstVC: CellViewModelSecondVC) {
        cellViewModelSecondVC = cellFromFirstVC
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textView: UITextView!
    
//    func make() {
//        textView.
//    }
    
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
}
