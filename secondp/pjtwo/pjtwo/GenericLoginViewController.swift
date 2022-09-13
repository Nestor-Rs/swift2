//
//  GenericLoginViewController.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 12/09/22.
//

import UIKit

class GenericLoginViewController: UIViewController {

    @IBOutlet weak var backgraund: UIView!
    
    let colorTop = UIColor.init(red: 49/255, green: 128/255, blue: 128/255, alpha: 1).cgColor
    let colorButtom = UIColor.init(red: 86/255, green: 77/255, blue: 194/255, alpha: 1).cgColor
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.colors = [colorTop,colorButtom]
        gradient.frame = backgraund.bounds
        gradient.shouldRasterize = true
        backgraund.layer.addSublayer(gradient)

    }

}
