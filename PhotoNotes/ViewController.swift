
//
//  ViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//


import UIKit
import MapKit

class ViewController: UIViewController{
    // - MARK: Public Properties
    
    var geoLocation: GeoLocation!
    var imagePicker: ImagePicker!
    var defaultPicture = #imageLiteral(resourceName: "Image")
    var textFromSecondVC:String = "Press to edit description"
    var higlightenIndex: IndexPath?
    
    // - MARK: Private Properties
    
    private var cellViewModel = CellViewModel()
    // - MARK: IBOutlets
    
    @IBOutlet weak var tableCellsView: UITableView!{
        didSet{
            
            cellViewModel.delegate = self
            tableCellsView.delegate = self
            tableCellsView.dataSource = self
            tableCellsView.rowHeight=UITableView.automaticDimension
            tableCellsView.estimatedRowHeight=600
            
            
        }
    }
 
    // - MARK: IBActions
    
    @IBAction func addPhotoNew(_ sender: UIButton) {
        geoLocation.checkAutorization()
        geoLocation.startGeoLocationProccess()
        imagePicker.present(from: tableCellsView)
        geoLocation.endGeoLocationProccess()
            //model.createCell()
    }

    // - MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.geoLocation = GeoLocation(delegate: self, presentationController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .default
        super.viewDidAppear(animated)
    }

    
}


// - MARK: Public methods


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
        cellViewModel.createCell(imageNew: image ?? defaultPicture, textNew: dateFormatter.string(from: Date()),  realAddress: geoLocation.formAddres(), realDescript: textFromSecondVC, realMapCoord: geoLocation.formCoordinates())
   
    }
}

extension ViewController: GeoLocationDelegate{
    func didselect(locatin: CLLocation) {
        print(locatin)
        print("aasdjkasjdkasjdlaslkdjaskdjlaskjdlkajsdkljaslkdja")
    }
}

    // -MARK: UITableViewDelegate, UITableViewDataSource

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
        secondViewController.sendTextButtonClosure = {[weak self] (index,text) -> ()  in
            self?.cellViewModel.updateDescript(newDescription: text, newIndex: index)
            return
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
        secondViewController.setCellSecondVC(cellFromFirstVC: cellViewModel.createDetailViewModel(for: indexPath)) 
    }
    
    
    
}





