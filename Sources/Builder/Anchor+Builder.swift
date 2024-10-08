#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

/// Act as namespace for all the builders
public final class Builder {}

/// Extend Anchor to return builders
public extension Anchor {
    
    /// Add a ratio between width and height
    func ratio(_ value: CGFloat) -> Builder.Ratio {
        return Builder.Ratio(anchor: self, ratio: value)
    }
    
    /// Apply the same anchor to other views
    func apply(to views: [View]) -> Builder.Apply {
        return Builder.Apply(anchor: self, views: views)
    }
    
#if os(iOS) || os(tvOS)
    /// Build a paging scrollView horizontally
    func pagingHorizontally(togetherWith views: [View], in scrollView: UIScrollView) -> Builder.PagingHorizontally {
        var array: [View] = []
        array.append(contentsOf: [item as? View].compactMap({ $0 }))
        array.append(contentsOf: views)
        return Builder.PagingHorizontally(scrollView: scrollView, views: array)
    }
#endif
    
    /// Add fixed spacing. The views will resize
    func fixedSpacingHorizontally(togetherWith views: [View], spacing: CGFloat) -> Builder.FixedSpacingHorizontally {
        var array: [View] = []
        array.append(contentsOf: [item as? View].compactMap({ $0 }))
        array.append(contentsOf: views)
        return Builder.FixedSpacingHorizontally(views: array, spacing: spacing)
    }
    
    /// Add dynamic spacing using LayoutGuide. The spacing will resize
    func dynamicSpacingHorizontally(togetherWith views: [View]) -> Builder.DynamicSpacingHorizontally {
        var array: [View] = []
        array.append(contentsOf: [item as? View].compactMap({ $0 }))
        array.append(contentsOf: views)
        return Builder.DynamicSpacingHorizontally(views: array)
    }
}


public extension Anchor {
    func distribute(views: [View],
                    itemWidth: CGFloat,
                    itemHeight: CGFloat,
                    fixedColumnSpacing: CGFloat,
                    fixedRowSpacing: CGFloat,
                    warpCount: Int,
                    augmentWhenInsufficient: Bool = false,
                    topPadding: CGFloat,
                    bottomPadding: CGFloat,
                    leadingPadding: CGFloat,
                    trailingPadding: CGFloat) -> Builder.Sudoku {
        return Builder.Sudoku(container: (item as! View),
                              views: views,
                              itemWidth: itemWidth,
                              itemHeight: itemHeight,
                              fixedColumnSpacing: fixedColumnSpacing,
                              fixedRowSpacing: fixedRowSpacing,
                              warpCount: warpCount,
                              augmentWhenInsufficient: augmentWhenInsufficient,
                              topPadding: topPadding,
                              bottomPadding: bottomPadding,
                              leadingPadding: leadingPadding,
                              trailingPadding: trailingPadding)
    }
    
    func distribute(views: [View],
                    fixedItemWidth: CGFloat,
                    fixedItemHeight: CGFloat,
                    warpCount: Int,
                    topPadding: CGFloat,
                    bottomPadding: CGFloat,
                    leadingPadding: CGFloat,
                    trailingPadding: CGFloat) -> Builder.Sudoku_dynamicSpacing {
        return Builder.Sudoku_dynamicSpacing(container: (item as! View),
                                             views: views,
                                             fixedItemWidth: fixedItemWidth,
                                             fixedItemHeight: fixedItemHeight,
                                             warpCount: warpCount,
                                             topPadding: topPadding,
                                             bottomPadding: bottomPadding,
                                             leadingPadding: leadingPadding,
                                             trailingPadding: trailingPadding)
    }
}
