import UIKit

enum GraphType: String {
    case line = "Line"
}

struct GraphDataModel: Equatable {
    var graphType: GraphType
    var points: [CGPoint]
}
