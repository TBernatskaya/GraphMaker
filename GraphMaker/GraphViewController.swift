//
//  GraphViewController.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    var graphData: GraphDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        guard let graphData = graphData else { return }
        
        dataLabel.text = graphData.graphType.rawValue + " graph"
    }
}

