//
//  Node.swift
//  GApp
//
//  Created by Robert Talianu on 15.10.2024.
//


public class Node<T> {
  var value: T
  var next: Node?
  weak var previous: Node?

  public init(value: T) {
    self.value = value
  }
}
