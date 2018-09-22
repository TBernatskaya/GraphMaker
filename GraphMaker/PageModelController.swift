//
//  PageModelController.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class PageModelController: NSObject {

    var pageData: [GraphDataModel] = []
    
    var mockData: [GraphDataModel] {
        let lineGraph = GraphDataModel.init(graphType: .line,
                                            values: [3, 7, 4, 6, 8, 7])
        
        let lineGraph2 = GraphDataModel.init(graphType: .line,
                                            values: [7, 3, 6, 4, 9, 6])
        return [lineGraph, lineGraph2]
    }

    override init() {
        super.init()
       
        pageData.append(contentsOf: mockData)
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> GraphViewController? {
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        let dataViewController = storyboard.instantiateViewController(withIdentifier: "GraphViewController") as! GraphViewController
        dataViewController.graphData = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(_ viewController: GraphViewController) -> Int {
        guard
            let graphData = viewController.graphData,
            let index = pageData.index(of: graphData)
        else {
            return NSNotFound
        }
        return index
    }
}

extension PageModelController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! GraphViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! GraphViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageData.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let presentedVC = pageViewController.viewControllers?.last as? GraphViewController else { return NSNotFound }
        return self.indexOfViewController(presentedVC)
    }
}
