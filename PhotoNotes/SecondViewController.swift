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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton))
        
        textView.text = cellViewModelSecondVC?.getDescription() ?? "Default Text"
        // Do any additional setup after loading the view.
    }
    
    weak var sendTextDelegate:SendTextProtocol?
    
    
    @objc func saveButton() {
        sendTextDelegate?.didUpdateWithText(text: textView.text)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.popViewController(animated: true)
    }
    
    func setCellSecondVC(cellFromFirstVC: CellViewModelSecondVC) {
        cellViewModelSecondVC = cellFromFirstVC
    }
    
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


