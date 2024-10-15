//
//  t.swift
//  GApp
//
//  Created by Robert Talianu
//


/**
 *
 */
public protocol GestureScanningListener {

    public func gestureStarted();

    public func gestureEnded();

    public func gestureContinuation();

    public func zeroesStarted();

    public func zeroesEnded();
}
