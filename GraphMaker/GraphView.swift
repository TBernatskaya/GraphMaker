//
//  GraphView.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    var graphPoints: [Int] = []
    
    let sideMargin: CGFloat = 20
    let topMargin: CGFloat = 150.0
    let bottomMargin: CGFloat = 40.0
    
    override func draw(_ rect: CGRect) {
        roundCorners(for: rect)
        addGradient()
        addLineGraph(for: rect)
    }
    
    fileprivate func roundCorners(for rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
    }
    
    fileprivate func addGradient() {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    
    fileprivate func addLineGraph(for rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let graphWidth = width - sideMargin * 2
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + self.sideMargin + 2
        }
        
        let graphHeight = height - topMargin - bottomMargin
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + self.topMargin - y
        }
        
        //UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
    }
}
