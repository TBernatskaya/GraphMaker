//
//  DataViewController.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataLabel.text = dataObject
    }
}

