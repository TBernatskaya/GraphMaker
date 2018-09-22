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
    @IBOutlet weak var graphContainerView: UIView!
    
    var graphData: GraphDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }

    func updateView() {
        guard let graphData = graphData else { return }
        dataLabel.text = graphData.graphType.rawValue + " graph"
        
        switch graphData.graphType {
        case .line:
            let lineGraphView = GraphView.init(frame: graphContainerView.bounds)
            lineGraphView.backgroundColor = .clear
            lineGraphView.graphPoints = graphData.values
            graphContainerView.addSubview(lineGraphView)
        }
    }
}

