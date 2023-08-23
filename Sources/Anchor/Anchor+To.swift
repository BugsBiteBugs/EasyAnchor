#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public extension Anchor {
    func to(_ anchor: Anchor) -> Anchor {
        toValue = .anchor(anchor)
        return self
    }
    
    func to(_ size: CGFloat) -> Anchor {
        toValue = .size
        updateIfAny(.width, size)
        updateIfAny(.height, size)
        return self
    }
    
    func to(_ view: View) -> Anchor {
        toValue = .anchor(view.anchor)
        return self
    }
    
    func to(_ cgSize: CGSize) -> Anchor {
        toValue = .size
        updateIfAny(.width, cgSize.width)
        updateIfAny(.height, cgSize.height)
        return self
    }
}
