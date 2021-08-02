//
//  TagLayoutView.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct TagLayoutView<Content>: View where Content: View {
    
    private let tags: [String]
    private var tagFont: UIFont
    private let padding: CGFloat
    private let parentWidth: CGFloat
    private let content: (String) -> Content
    private var elementsCountByRow: [Int] = []
    
    public init(_ tags: [String],
                tagFont: UIFont = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold),
                padding: CGFloat,
                parentWidth: CGFloat,
                content: @escaping (String) -> Content) {
        self.tags = tags
        self.tagFont = tagFont
        self.padding = padding
        self.parentWidth = parentWidth
        self.content = content
        self.elementsCountByRow = self.getElementsCountByRow(self.parentWidth)
    }
    
    private func getElementsCountByRow(_ rowSize: CGFloat) -> [Int] {
        let tagWidths = self.tags.map{$0.widthOfString(usingFont: self.tagFont)}

        var currentRowTotalWidth: CGFloat = 0.0
        var currentRowElementsCount: Int = 0
        var result: [Int] = []
        
        for tagWidth in tagWidths {
            let fixedTagWidth = tagWidth + (2 * self.padding)
            if currentRowTotalWidth + fixedTagWidth <= rowSize {
                currentRowTotalWidth += fixedTagWidth
                currentRowElementsCount += 1
                guard result.count != 0 else { result.append(1); continue }
                result[result.count - 1] = currentRowElementsCount
            } else {
                currentRowTotalWidth = fixedTagWidth
                currentRowElementsCount = 1
                result.append(1)
            }
        }
        return result
    }
    
    private func getTag(elementsCountByRow: [Int], rowIndex: Int, elementIndex: Int) -> String {
        let sumOfPreviousRows = elementsCountByRow.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + elementIndex
        guard self.tags.count > orderedTagsIndex else { return "" }
        return self.tags[orderedTagsIndex]
    }
    
    public var body : some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0 ..< self.elementsCountByRow.count, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< self.elementsCountByRow[rowIndex], id: \.self) { elementIndex in
                        self.content(self.getTag(elementsCountByRow: self.elementsCountByRow, rowIndex: rowIndex, elementIndex: elementIndex))
                    }
                    Spacer()
                }.padding(.vertical, 4)
            }
        }
    }
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

}


struct FlowLayout<B, T: Hashable, V: View>: View {
  let mode: Mode
  @Binding var binding: B
  let items: [T]
  let viewMapping: (T) -> V

  @State private var totalHeight: CGFloat

  init(mode: Mode, binding: Binding<B>, items: [T], viewMapping: @escaping (T) -> V) {
    self.mode = mode
    _binding = binding
    self.items = items
    self.viewMapping = viewMapping
    _totalHeight = State(initialValue: (mode == .scrollable) ? .zero : .infinity)
  }

  var body: some View {
    let stack = VStack {
       GeometryReader { geometry in
         self.content(in: geometry)
       }
    }
    return Group {
      if mode == .scrollable {
        stack.frame(height: totalHeight)
      } else {
        stack.frame(maxHeight: totalHeight)
      }
    }
  }

  private func content(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    return ZStack(alignment: .topLeading) {
      ForEach(self.items, id: \.self) { item in
        self.viewMapping(item)
          .padding([.horizontal, .vertical], 4)
          .alignmentGuide(.leading, computeValue: { d in
            if (abs(width - d.width) > g.size.width) {
              width = 0
              height -= d.height
            }
            let result = width
            if item == self.items.last {
              width = 0
            } else {
              width -= d.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: { d in
            let result = height
            if item == self.items.last {
              height = 0
            }
            return result
          })
        }
      }
      .background(viewHeightReader($totalHeight))
  }

  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geo -> Color in
      DispatchQueue.main.async {
        binding.wrappedValue = geo.frame(in: .local).size.height
      }
      return .clear
    }
  }

  enum Mode {
    case scrollable, vstack
  }
}
