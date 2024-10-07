//
//  UIView+extension.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import UIKit
///
/// Defines the possible supported constraints.
///
public enum Constraint {
    case snap
    case leading
    case trailing
    case left
    case right
    case top
    case bottom
    case leadingBy(_ constant: Float = 0, safeArea: Bool = true)
    case trailingBy(_ constant: Float = 0, safeArea: Bool = true)
    case leftBy(_ constant: Float = 0, safeArea: Bool = true)
    case rightBy(_ constant: Float = 0, safeArea: Bool = true)
    case topBy(_ constant: Float = 0, safeArea: Bool = true)
    case bottomBy(_ constant: Float = 0, safeArea: Bool = true)
    case leadingTo(_ constant: Float, view: UIView)
    case trailingTo(_ constant: Float, view: UIView)
    case leftTo(_ constant: Float, view: UIView)
    case rightTo(_ constant: Float, view: UIView)
    case topTo(_ constant: Float, view: UIView)
    case bottomTo(_ constant: Float, view: UIView)
    case centerX
    case centerY
    case centerXBy(_ constant: Float = 0)
    case centerYBy(_ constant: Float = 0)
    case width(_ value: Float = 0)
    case height(_ value: Float = 0)
    case widthPercent(_ value: Float = 0)
    case heightPercent(_ value: Float = 0)
    case minWidth(_ value: Float = 0)
    case minHeight(_ value: Float = 0)
    case maxWidth(_ value: Float = 0)
    case maxHeight(_ value: Float = 0)
    case widthTo(_ view: UIView)
    case heightTo(_ view: UIView)
    case widthToSuperview
    case heightToSuperview
    case aspectWidth(_ value: Float = 1)
    case aspectHeight(_ value: Float = 1)
    case custom(_ constraint: NSLayoutConstraint)

    // swiftlint:disable function_body_length
    fileprivate func layout(from: UIView, to: UIView) -> [NSLayoutConstraint] {
        switch self {
        case .snap:
            let constraints: [Constraint] = [
                .leadingBy(0, safeArea: false),
                .topBy(0, safeArea: false),
                .trailingBy(0, safeArea: false),
                .bottomBy(0, safeArea: false)
            ]
            return constraints.flatMap { $0.layout(from: from, to: to) }

        case .top:
            return Constraint.topBy(0).layout(from: from, to: to)

        case .trailing:
            return Constraint.trailingBy(0).layout(from: from, to: to)

        case .leading:
            return Constraint.leadingBy(0).layout(from: from, to: to)

        case .left:
            return Constraint.leftBy(0).layout(from: from, to: to)

        case .right:
            return Constraint.rightBy(0).layout(from: from, to: to)

        case .bottom:
            return Constraint.bottomBy(0).layout(from: from, to: to)

        case let .leadingBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .leading, .equal, safeArea ? to.safeAreaLayoutGuide : to, .leading, 1, constant)
            } else {
                // Fallback on earlier versions
            }

        case let .trailingBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .trailing, .equal, safeArea ? to.safeAreaLayoutGuide : to, .trailing, 1, -constant)
            } else {
                // Fallback on earlier versions
            }

        case let .leftBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .left, .equal, safeArea ? to.safeAreaLayoutGuide : to, .left, 1, constant)
            } else {
                // Fallback on earlier versions
            }

        case let .rightBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .right, .equal, safeArea ? to.safeAreaLayoutGuide : to, .right, 1, -constant)
            } else {
                // Fallback on earlier versions
            }

        case let .topBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .top, .equal, safeArea ? to.safeAreaLayoutGuide : to, .top, 1, constant)
            } else {
                // Fallback on earlier versions
            }

        case let .bottomBy(constant, safeArea):
            if #available(iOS 11.0, tvOS 11.0, *) {
                return nslc(from, .bottom, .equal, safeArea ? to.safeAreaLayoutGuide : to, .bottom, 1, -constant)
            } else {
                // Fallback on earlier versions
            }

        case let .leadingTo(constant, view):
            return nslc(from, .leading, .equal, view, .trailing, 1, constant)

        case let .trailingTo(constant, view):
            return nslc(from, .trailing, .equal, view, .leading, 1, -constant)

        case let .leftTo(constant, view):
            return nslc(from, .left, .equal, view, .right, 1, constant)

        case let .rightTo(constant, view):
            return nslc(from, .right, .equal, view, .left, 1, -constant)

        case let .topTo(constant, view):
            return nslc(from, .top, .equal, view, .bottom, 1, constant)

        case let .bottomTo(constant, view):
            return nslc(from, .bottom, .equal, view, .top, 1, -constant)

        case .centerX:
            return Constraint.centerXBy(0).layout(from: from, to: to)

        case .centerY:
            return Constraint.centerYBy(0).layout(from: from, to: to)

        case let .centerXBy(constant):
            return nslc(from, .centerX, .equal, to, .centerX, 1, constant)

        case let .centerYBy(constant):
            return nslc(from, .centerY, .equal, to, .centerY, 1, constant)

        case let .width(value):
            return nslc(from, .width, .equal, nil, .notAnAttribute, 1, value)

        case let .height(value):
            return nslc(from, .height, .equal, nil, .notAnAttribute, 1, value)

        case let .widthPercent(value):
            return nslc(from, .width, .equal, to, .width, value / 100, 0)

        case let .heightPercent(value):
            return nslc(from, .height, .equal, to, .height, value / 100, 0)

        case let .minWidth(value):
            return nslc(from, .width, .greaterThanOrEqual, nil, .notAnAttribute, 1, value)

        case let .minHeight(value):
            return nslc(from, .height, .greaterThanOrEqual, nil, .notAnAttribute, 1, value)

        case let .maxWidth(value):
            return nslc(from, .width, .lessThanOrEqual, nil, .notAnAttribute, 1, value)

        case let .maxHeight(value):
            return nslc(from, .height, .lessThanOrEqual, nil, .notAnAttribute, 1, value)

        case let .widthTo(view):
            return nslc(from, .width, .equal, view, .width, 1, 0)

        case let .heightTo(view):
            return nslc(from, .height, .equal, view, .height, 1, 0)

        case .widthToSuperview:
            return Constraint.widthTo(to).layout(from: from, to: to)

        case .heightToSuperview:
            return Constraint.heightTo(to).layout(from: from, to: to)

        case let .custom(constraint):
            return [constraint]
        case let .aspectWidth(value):
            return nslc(from, .width, .equal, from, .height, value, 0)
        case let .aspectHeight(value):
            return nslc(from, .height, .equal, from, .width, 1.0 / value, 0)
        }
        return []
    }

    // swiftlint:enable function_body_length

    // swiftlint:disable function_parameter_count
    private func nslc(
        _ item: UIView,
        _ attr1: NSLayoutConstraint.Attribute,
        _ relatedBy: NSLayoutConstraint.Relation,
        _ toItem: Any?,
        _ attr2: NSLayoutConstraint.Attribute,
        _ multiplier: Float,
        _ constant: Float
    ) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(
                item: item,
                attribute: attr1,
                relatedBy: relatedBy,
                toItem: toItem,
                attribute: attr2,
                multiplier: CGFloat(multiplier),
                constant: CGFloat(constant)
            )
        ]
    }
    // swiftlint:enable function_parameter_count
}

///
/// Extension for UIView to manage autolayout activities.
///
public extension UIView {
    /// Add the given subview with given constraints to the current view.
    @discardableResult
    func add(subview: UIView, constraints: [Constraint]) -> Self {
        addSubview(subview)
        subview.set(constraints: constraints)
        return self
    }

    /// Snap the given subview to the current view.
    @discardableResult
    func snap(_ subview: UIView) -> Self {
        return add(subview: subview, constraints: [.snap])
    }

    /// Set list of constraints to the current view.
    func set(constraints: [Constraint]) {
        constraints.forEach {
            set(constraint: $0)
        }
    }

    // Set individual constraint, returning single NSLayoutConstraint.
    // Notes: sometimes, some constraint will setup several NSLayoutConstraint, so only the first one will return.
    @discardableResult
    func set(constraint: Constraint) -> NSLayoutConstraint {
        guard let superview = superview
        else {
            assert(false, "no superview")
            fatalError()
        }
        translatesAutoresizingMaskIntoConstraints = false
        var res: NSLayoutConstraint!
        constraint.layout(from: self, to: superview).forEach {
            if res == nil { res = $0 }
            superview.addConstraint($0)
        }
        return res
    }

    /// Add the given subview to the current view and prepare for autolayout.
    @discardableResult
    func addSubviewAutoLayout(_ subview: UIView) -> Self {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
