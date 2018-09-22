import UIKit

enum GraphType: String {
    case line = "Line graph"
    case pie = "Pie chart"
}

struct GraphDataModel: Equatable {
    var graphType: GraphType
    var values: [Int]
}
