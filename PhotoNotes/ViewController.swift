
//
//  ViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//


import UIKit
import MapKit

protocol sendDescriptProtocol:class {
    func senDescr(Descr:String,nomerStroki:IndexPath) 
}

class ViewController: UIViewController{
    // - MARK: image controller
    
    var geoLocation: GeoLocation!
    var imagePicker: ImagePicker!
    var defaultPicture = #imageLiteral(resourceName: "Image")
    private var cellViewModel = CellViewModel()
    var textFromSecondVC:String = "Press to edit description"
    var higlightenIndex: IndexPath?
    
    weak var sendDescrDelegate: sendDescriptProtocol?
    
    @IBOutlet weak var tableCellsView: UITableView!{
        didSet{
            
            cellViewModel.delegate = self
            tableCellsView.delegate = self
            tableCellsView.dataSource = self
            tableCellsView.rowHeight=UITableView.automaticDimension
            tableCellsView.estimatedRowHeight=600
            
        }
    }
 
    
    @IBAction func addPhotoNew(_ sender: UIButton) {
        geoLocation.checkAutorization()
        geoLocation.startGeoLocationProccess()
        imagePicker.present(from: tableCellsView)
        geoLocation.endGeoLocationProccess()
            //model.createCell()
    }
//    @IBAction func addPhotoNew(_ sender: UIButton) {
//
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.geoLocation = GeoLocation(delegate: self, presentationController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //checkLocationEnabled()
    }

    
}


// - MARK: public methods

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return   cellViewModel.getCountOfRows()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellIdentifier") as? TableViewCell
        else {return UITableViewCell()}
        
        cell.cellLabel.text = cellViewModel.getDate(for: indexPath)
        cell.cellImageView.image = cellViewModel.getImage(for: indexPath)
        cell.cellGeo.text = cellViewModel.getAddress(for: indexPath)
        cell.cellDescription.text=cellViewModel.getDescript(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SecondViewController.self)) as? SecondViewController else {
            return
        }
        secondViewController.sendTextDelegate = self
        higlightenIndex=indexPath
        print(indexPath)
        
        self.present(secondViewController, animated: true, completion: nil)
        sendDescrDelegate?.senDescr(Descr: cellViewModel.getDescript(for: indexPath), nomerStroki: indexPath)
    }
    
    
    
}


extension ViewController:SendTextProtocol{
    func didUpdateWithText(text: String?) {
        if text == nil {
            return
        }
        print(text!)
        cellViewModel.updateDescript(newDescription: textFromSecondVC)
    }
    
    
}
extension ViewController: ModelDelegate {
    
    func cellsDidUpdate() {
        tableCellsView.reloadData()
        
    }

}
extension ViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        if image == nil {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RUS")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-YYYY-MM")
        cellViewModel.createCell(imageNew: image ?? defaultPicture, textNew: dateFormatter.string(from: Date()),  realAddress: geoLocation.formatadrress(), realDescript: textFromSecondVC)
   
    }
}

extension ViewController: GeoLocationDelegate{
    func didselect(locatin: CLLocation) {
        print(locatin)
        print("aasdjkasjdkasjdlaslkdjaskdjlaskjdlkajsdkljaslkdja")
    }
}



