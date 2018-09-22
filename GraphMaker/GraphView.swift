//
//  GraphView.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class GraphView: UIView {
    var graphPoints: [Int] = []
    
    let cgColors = [UIColor.green.cgColor, UIColor.blue.cgColor]
    let colorLocations: [CGFloat] = [0.0, 1.0]
    let colorSpace = CGColorSpaceCreateDeviceRGB()
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
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: cgColors as CFArray,
                                  locations: colorLocations)!
        
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    
    fileprivate func addLineGraph(for rect: CGRect) {
        guard
            let context = UIGraphicsGetCurrentContext(),
            let maxValue = graphPoints.max()
        else { return }
        
        let width = rect.width
        let height = rect.height
        let graphPath = UIBezierPath()
        let graphHeight = height - topMargin - bottomMargin
        let graphWidth = width - sideMargin * 2
        
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + self.sideMargin + 2
        }
        
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + self.topMargin - y
        }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y:height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y:height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: sideMargin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: sideMargin, y: bounds.height)
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: cgColors as CFArray,
                                  locations: colorLocations)!
        
        context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
    }
}
