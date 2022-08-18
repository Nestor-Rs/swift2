//
//  ViewController.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 17/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var contrasena: UITextField!
    @IBOutlet weak var viewText: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.cornerRadius=logo.layer.bounds.width/2
        logo.clipsToBounds = true
        viewText.layer.borderWidth=1
        viewText.layer.borderColor=CGColor.init(red: 200/225, green: 200/225, blue: 200/225, alpha: 1)
        viewText.layer.cornerRadius=5
    }


}

