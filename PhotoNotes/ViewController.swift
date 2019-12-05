//
//  ViewController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
   // let pickerController = UIImagePickerController()
    
    
    var model = Model()
   // let picker = UIFontPickerViewController
    
    @IBOutlet weak var tableCellsView: UITableView!
    
    @IBAction func addPhotoNew(_ sender: UIButton) {
        //makePhoto()
         
          model.createCell()
    }

    override func viewDidLoad() {
      
        model.createCell()
       // tableCellsView.reloadData()
    
        // Do any additional setup after loading the view.
    }

    func makePhoto(){
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType(rawValue: 1)!)
        if isCameraAvailable == true {
            let whichTypeOfCamera = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType(rawValue: 1)!)
            print(whichTypeOfCamera!)
            if whichTypeOfCamera?[0] == "public.image" {

              //  UIImagePickerController.present(UIImagePickerController , _: animated:true ,completion:)
            }
        }
    }
   
}

// - MARK: public methods

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("123")//вот эта штука не пишется в консоли
     return   model.getCountOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellIdentifier") as? TableViewCell
        else {return UITableViewCell()}
        print("123123")
        cell.cellLabel.text = model.cells[indexPath.row]
        return cell
    }
    
}

extension ViewController: ModelDelegate {


    func cellsDidUpdate() {
        tableCellsView.reloadData()
    }

}


