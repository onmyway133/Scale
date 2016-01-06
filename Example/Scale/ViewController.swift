//
//  ViewController.swift
//  Scale
//
//  Created by Khoa Pham on 01/06/2016.
//  Copyright (c) 2016 Khoa Pham. All rights reserved.
//

import UIKit
import Scale

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let length = 5.kilometer + 7.meter
        print(length)
        let weight = 10.0.kilogram * 5.gram
        print(weight)

        let dekameter = length.to(unit: .dekameter)
        print(dekameter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

