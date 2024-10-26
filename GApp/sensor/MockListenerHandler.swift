//
//  MockListenerHander.swift
//  GApp
//
//  Created by Robert Talianu
//

import Foundation

public class MockListenerHandler: SensorListener {
    private var queue: RollingQueue = RollingQueue<Sample4D>(100)
    private var listener: ViewUpdateListener?
    
    
    public func onSensorChanged(_ time: Int64, _ x: Double, _ y: Double, _ z: Double) {
        queue.add(Sample4D(x, y, z, time))
        self.listener?.viewUpdate(self)
    }
    
    public func setViewUpdateListener(_ listener:ViewUpdateListener){
        self.listener = listener;
    }
    
    public func getQueue() -> RollingQueue<Sample4D>{
        return queue;
    }

}
