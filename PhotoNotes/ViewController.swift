
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
    // - MARK: image controller
    
 
    var imagePicker: ImagePicker!
    var defaultPicture = #imageLiteral(resourceName: "Image")
    private var cellViewModel = CellViewModel()
    
    @IBOutlet weak var tableCellsView: UITableView!{
        didSet{
            
            cellViewModel.delegate = self
            tableCellsView.delegate = self
            tableCellsView.dataSource = self
            
        }
    }
 
    
    @IBAction func addPhotoNew(_ sender: UIButton) {
        imagePicker.present(from: tableCellsView)
            //model.createCell()
    }
//    @IBAction func addPhotoNew(_ sender: UIButton) {
//
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
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
        return cell
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
        cellViewModel.createCell(imageNew: image ?? defaultPicture, textNew: dateFormatter.string(from: Date()),  realAddress: "dad")
    }
}



