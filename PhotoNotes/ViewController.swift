
//
//  ViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    // - MARK: image controller
    
  var imagePicker: ImagePicker!
         
   private var model = Model()
    
    @IBOutlet weak var tableCellsView: UITableView!{
        didSet{
            
            model.delegate = self
            tableCellsView.delegate = self
            tableCellsView.dataSource = self
            
        }
    }
    
    @IBAction func addPhotoNew(_ sender: UIButton) {
        model.createCell(sender)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    

//   private func makePhoto(){
//        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType(rawValue: 1)!)
//        if isCameraAvailable == true {
//            let whichTypeOfCamera = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType(rawValue: 1)!)
//            print(whichTypeOfCamera!)
//            if whichTypeOfCamera?[0] == "public.image" {
//
//              //  UIImagePickerController.present(UIImagePickerController , _: animated:true ,completion:)
//            }
//        }
//    }
   
}


// - MARK: public methods

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return   model.getCountOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellIdentifier") as? TableViewCell
        else {return UITableViewCell()}
        cell.cellLabel.text = model.cells[indexPath.row]
        if (model.cellImage[0]==nil){
            return cell}
        cell.cellImageView.image = model.cellImage[indexPath.row]
        return cell
    }
    
    
}


extension ViewController: ModelDelegate {
    
    func cellsDidUpdate() {
        tableCellsView.reloadData()
    }

}
extension ViewController: ImagePickerDelegate{
func didSelect(image: UIImage) {
      
  }
}




