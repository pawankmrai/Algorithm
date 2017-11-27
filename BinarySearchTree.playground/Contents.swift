//: Binary search tree

import UIKit
import Foundation

public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    // Insert tree
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    // Search
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self
        }
    }
    
    // Traversal
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
    
    // Map
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left  = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
    
    // Array
    public func toArray() -> [T] {
        return map { $0 }
    }
    
    // Deleting node
    private func reconnectParentToNode(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    // Minimum
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    // Maximum
    public func maximum() -> BinarySearchTree {
        var node = self
        while  let next = node.right {
            node = next
        }
        return node
    }
    
    // Remove
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement : BinarySearchTree?
        // Replacement for current node can be either biggest one left or
        // smallest one on the right, whichever is not nil
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        //
        replacement?.remove()
        
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentToNode(node: replacement)
        
        // Current node is no longer part of the tree
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    // Height
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description : String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    
    // Depth
    public func depth() -> Int {
        var node =  self
        var edges = 0
        while  let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    // Is Binary search tree
    public func isBST(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
}


let tree = BinarySearchTree(array: [7, 2, 5, 10, 9, 1, 6, 3])
print(tree)
tree.search(value: 7)

tree.traverseInOrder { value in print(value) }
tree.toArray()
tree.height()
if let node9 = tree.search(value: 9) {
    node9.depth()
}


