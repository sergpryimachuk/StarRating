// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  Created with ♥ by Serhii Pryimachuk on 12.11.2023.
//

import SwiftUI

@available(iOS 16, *)
public struct StarRatingView: View {
    
    let size: Double
    let color: Color
    @Binding var rating: Double?
    
    public init(rating: Binding<Double?>, size: Double = 44, color: Color = .yellow) {
        self._rating = rating
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: makeStar(for: index))
                    .resizable()
                    .scaledToFit()
                    .frame(width: size)
                    .onTapGesture(coordinateSpace: .local) { location in
                        handleTap(at: index, for: location)
                    }
            }
        }
        .foregroundStyle(color)
        .animation(.linear, value: rating)
    }
    
    private func handleTap(at index: Int, for location: CGPoint) {
        let doubleIdex = Double(index)
        let isTappedOnLeftSide = location.x < (size / 2)
        rating = isTappedOnLeftSide ? doubleIdex - 0.5 : doubleIdex
    }
    private func makeStar(for index: Int) -> String {
    
        if let rating {
            
            let roundedRating = Int(ceil(rating))
            if index <= roundedRating {
                if index <= Int(rating) {
                    return "star.fill"
                } else {
                    return "star.leadinghalf.fill"
                }
            } else {
                return "star"
            }
            
        } else {
            return "star"
        }
    }
}

@available(iOS 16, *)
fileprivate struct PreviewWrapper: View {
    @State private var rating: Double?
    var body: some View {
        StarRatingView(rating: $rating)
    }
}

@available(iOS 16, *)
struct Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}
