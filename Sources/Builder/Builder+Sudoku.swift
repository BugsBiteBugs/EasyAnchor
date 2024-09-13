#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public extension Builder {
    class Sudoku: ConstraintProducer {
        var container: View
        var views: [View]
        
        var itemWidth: CGFloat
        var itemHeight: CGFloat
        var fixedColumnSpacing: CGFloat
        var fixedRowSpacing: CGFloat
        var warpCount: Int
        var augmentWhenInsufficient: Bool?
        var topPadding: CGFloat
        var bottomPadding: CGFloat
        var leadingPadding: CGFloat
        var trailingPadding: CGFloat
        
        public init(container: View,
                    views: [View],
                    itemWidth: CGFloat,
                    itemHeight: CGFloat,
                    fixedColumnSpacing: CGFloat,
                    fixedRowSpacing: CGFloat,
                    warpCount: Int,
                    augmentWhenInsufficient: Bool? = false,
                    topPadding: CGFloat,
                    bottomPadding: CGFloat,
                    leadingPadding: CGFloat,
                    trailingPadding: CGFloat) {
            self.container = container
            self.views = views
            self.itemWidth = itemWidth
            self.itemHeight = itemHeight
            self.fixedRowSpacing = fixedRowSpacing
            self.fixedColumnSpacing = fixedColumnSpacing
            self.warpCount = warpCount
            self.augmentWhenInsufficient = augmentWhenInsufficient
            self.topPadding = topPadding
            self.bottomPadding = bottomPadding
            self.leadingPadding = leadingPadding
            self.trailingPadding = trailingPadding
        }
        
        public func constraints() -> [NSLayoutConstraint] {
            var anchors: [Anchor] = []
            
            guard self.views.count >= 1, warpCount >= 1 else {
                return []
            }
            
            var itemsArray: [View] = []
            itemsArray.append(contentsOf: self.views)
            if augmentWhenInsufficient == true && self.views.count < warpCount {
                for _ in 0..<(warpCount - self.views.count) {
                    let augment = View()
                    container.addSubview(augment)
                    itemsArray.append(augment)
                }
            }
            
            let quotient = itemsArray.count / warpCount
            let remainder = itemsArray.count % warpCount
            
            let rowCount = (remainder == 0) ? quotient : (quotient + 1)                         // 总行数
            let columnCount = (itemsArray.count >= warpCount) ? warpCount : itemsArray.count    // 总列数
            
            var prev: View!
            
            for (i, v) in itemsArray.enumerated() {
                
                let currentRow = i / warpCount
                let currentColumn = i % warpCount
                
                if prev == nil {
                    if itemWidth > 0 {
                        anchors.append(v.anchor.width.equal.to(itemWidth))
                    }
                    if itemHeight > 0 {
                        anchors.append(v.anchor.height.equal.to(itemHeight))
                    }
                } else {
                    anchors.append(v.anchor.size.equal.to(prev))
                }
                
                // 第 0 行
                if currentRow == 0 {
                    anchors.append(v.anchor.top.equal.to(container).offset(topPadding))
                }
                
                // 最后一行
                if currentRow == rowCount - 1 {
                    if currentRow != 0 {   // 如果不是第 0 行
                        let viewDirectlyAbove = itemsArray[i-columnCount]
                        anchors.append(v.anchor.top.equal.to(viewDirectlyAbove.anchor.bottom).offset(fixedRowSpacing))
                    }
                    anchors.append(v.anchor.bottom.equal.to(container).offset(-bottomPadding))
                }
                
                // 中间若干行 (既不是第 0 行，也不是最后一行)
                if currentRow != 0 && currentRow != (rowCount - 1) {
                    let viewDirectlyAbove = itemsArray[i-columnCount]
                    anchors.append(v.anchor.top.equal.to(viewDirectlyAbove.anchor.bottom).offset(fixedRowSpacing))
                }
                
                // 第 0 列
                if currentColumn == 0 {
                    anchors.append(v.anchor.left.equal.to(container).offset(leadingPadding))
                }
                
                // 最后一列
                if currentColumn == columnCount - 1 {
                    if currentColumn != 0 {   // 如果不是第 0 列
                        anchors.append(v.anchor.left.equal.to(prev.anchor.right).offset(fixedColumnSpacing))
                    }
                    anchors.append(v.anchor.right.equal.to(container).offset(-trailingPadding))
                }
                
                // 中间若干列 (既不是第 0 列，也不是最后一列)
                if currentColumn != 0 && currentColumn != (columnCount - 1) {
                    anchors.append(v.anchor.left.equal.to(prev.anchor.right).offset(fixedColumnSpacing))
                }
                
                prev = v
            }
            
            return Group(producers: anchors).constraints
        }
    }
}


public extension Builder {
    class Sudoku_dynamicSpacing: ConstraintProducer {
        var container: View
        var views: [View]
        
        var fixedItemWidth: CGFloat
        var fixedItemHeight: CGFloat
        var warpCount: Int
        var topPadding: CGFloat
        var bottomPadding: CGFloat
        var leadingPadding: CGFloat
        var trailingPadding: CGFloat
        
        public init(container: View,
                    views: [View],
                    fixedItemWidth: CGFloat,
                    fixedItemHeight: CGFloat,
                    warpCount: Int,
                    topPadding: CGFloat,
                    bottomPadding: CGFloat,
                    leadingPadding: CGFloat,
                    trailingPadding: CGFloat) {
            self.container = container
            self.views = views
            self.fixedItemWidth = fixedItemWidth
            self.fixedItemHeight = fixedItemHeight
            self.warpCount = warpCount
            self.topPadding = topPadding
            self.bottomPadding = bottomPadding
            self.leadingPadding = leadingPadding
            self.trailingPadding = trailingPadding
        }
        
        
        public func constraints() -> [NSLayoutConstraint] {
            var anchors: [Anchor] = []
            
            guard self.views.count >= 1, warpCount >= 1 else {
                return []
            }
            
            let quotient = self.views.count / warpCount
            let remainder = self.views.count % warpCount
            
            let rowCount = (remainder == 0) ? quotient : (quotient + 1)                         // 总行数
            let columnCount = (self.views.count >= warpCount) ? warpCount : self.views.count    // 总列数
            
            for (i, v) in self.views.enumerated() {
                
                let currentRow = i / warpCount
                let currentColumn = i % warpCount
                
                anchors.append(v.anchor.width.equal.to(fixedItemWidth))
                anchors.append(v.anchor.height.equal.to(fixedItemHeight))
                
                // 第 0 行
                if currentRow == 0 {
                    anchors.append(v.anchor.top.equal.to(container).offset(topPadding))
                }
                
                // 最后一行
                if currentRow == rowCount - 1 {
                    if currentRow != 0 {   // 如果不是第 0 行
                        anchors.append(v.anchor.bottom.equal.to(container).offset(-bottomPadding))
                    }
                }
                
                // 中间若干行 (既不是第 0 行，也不是最后一行)
                if currentRow != 0 && currentRow != (rowCount - 1) {
                    let factor: CGFloat = CGFloat(currentRow) / CGFloat((rowCount - 1))
                    let addend = (CGFloat(currentRow + 1)) * fixedItemHeight
                    let subtrahend = factor * (topPadding + bottomPadding + CGFloat(rowCount) * fixedItemHeight)
                    let offset = topPadding + addend - subtrahend
                    
                    anchors.append(v.anchor.bottom.equal.to(container).multiplier(factor).offset(offset))
                }
                
                // 第 0 列
                if currentColumn == 0 {
                    anchors.append(v.anchor.left.equal.to(container).offset(leadingPadding))
                }
                
                // 最后一列
                if currentColumn == columnCount - 1 {
                    if currentColumn != 0 {   // 如果不是第 0 列
                        anchors.append(v.anchor.right.equal.to(container).offset(-trailingPadding))
                    }
                }
                
                // 中间若干列 (既不是第 0 列，也不是最后一列)
                if currentColumn != 0 && currentColumn != (columnCount - 1) {
                    let factor: CGFloat = CGFloat(currentColumn) / CGFloat((columnCount - 1))
                    let addend = (CGFloat(currentColumn + 1)) * fixedItemWidth
                    let subtrahend = factor * (leadingPadding + trailingPadding + CGFloat(columnCount) * fixedItemWidth)
                    let offset = leadingPadding + addend - subtrahend
                    
                    anchors.append(v.anchor.right.equal.to(container).multiplier(factor).offset(offset))
                }
            }
            
            return Group(producers: anchors).constraints
        }
    }
}
