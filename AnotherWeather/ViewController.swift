//
//  ViewController.swift
//  AnotherWeather
//
//  Created by Никита Зюзин on 11.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatData()
        currentData.text = String(describing: Currentdata!)
    }


}

