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
    private var cellViewModel = CellViewModel()
    
    override func viewDidLoad() {
        let firstVC = ViewController()
        firstVC.sendDescrDelegate = self
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    weak var sendTextDelegate:SendTextProtocol?
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        sendTextDelegate?.didUpdateWithText(text: textView.text)
        self.dismiss(animated: true, completion: nil)
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

extension SecondViewController:sendDescriptProtocol{
    func senDescr(Descr: String, nomerStroki: IndexPath) {
        textView.text! = Descr
        indexPath = nomerStroki
    }
    
    
}
