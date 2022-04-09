//
// Created by Augustin Monfret on 09/04/2022.
//

import SwiftUI

struct PositionView: View {
    var positionType: PositionType

    var height: CGFloat = 30
    var width: CGFloat = 30

    var body: some View {
        switch positionType {
        case .entry:
            Circle()
                .fill(Color.green)
                .frame(width: width, height: height)
        case .exit:
            Circle()
                .fill(Color.red)
                .frame(width: width, height: height)
        }
    }

}

enum PositionType{
    case entry
    case exit
}