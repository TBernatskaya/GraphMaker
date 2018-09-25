//
//  PieChart.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    var chartValues: [Int] = []
    
    let sectorWidth: CGFloat = 50.0
    
    override public func draw(_ rect: CGRect) {
        drawMainCircle(for: rect)
        drawSectors(for: rect)
    }
    
    fileprivate func centerPosition(for rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width/2, y: rect.height/2.5)
    }
    
    fileprivate func circleRadius(for rect: CGRect) -> CGFloat {
        return min(rect.width/3, rect.height/3)
    }
    
    fileprivate func drawMainCircle(for rect: CGRect) {
        
        let circlePath = UIBezierPath(arcCenter: centerPosition(for: rect),
                                      radius: circleRadius(for: rect),
                                      startAngle: 0,
                                      endAngle: 2 * .pi,
                                      clockwise: true)
        
        circlePath.lineWidth = sectorWidth
        UIColor.lightGray.setStroke()
        circlePath.stroke()
    }
    
    fileprivate func drawSectors(for rect: CGRect) {
        
        let sumOfChartValues = CGFloat(chartValues.reduce(0, +))
        let angles: [CGFloat] = chartValues.compactMap{ 2 * .pi  * CGFloat($0)/sumOfChartValues }
        var startAngle: CGFloat = 0
        var paths: [UIBezierPath] = []
        
        for (index, angle) in angles.enumerated() {
            if index != 0 {
                startAngle += angles[index - 1]
            }
            
            let circlePath = UIBezierPath(arcCenter: centerPosition(for: rect),
                                          radius: circleRadius(for: rect),
                                          startAngle: startAngle,
                                          endAngle: startAngle + angle,
                                          clockwise: true)
            
            circlePath.lineWidth = sectorWidth
            circlePath.stroke()
            paths.append(circlePath)
        }
        
        let layers = paths.map { path -> CAShapeLayer in
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeEnd = 0
            layer.strokeColor = UIColor.random.cgColor
            layer.lineWidth = sectorWidth
            layer.fillColor = UIColor.clear.cgColor
            return layer
        }
        
        /*let textLayers = paths.map { path -> CATextLayer in
            let textlayer = CATextLayer()
            textlayer.string = "BLAH"
            textlayer.font = UIFont(name: "Helvetica-Bold", size: 8)
            textlayer.isWrapped = true
            textlayer.frame = path.bounds
            
            return textlayer
        }*/
        
        layers.enumerated().forEach { offset, layer in
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 2
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.repeatCount = 1
            animation.isRemovedOnCompletion = false
            
            layer.add(animation, forKey: "group")
            self.layer.addSublayer(layer)
        }
        
       /* textLayers.enumerated().forEach { offset, layer in
            self.layer.addSublayer(layer)
        }*/
    }
}
