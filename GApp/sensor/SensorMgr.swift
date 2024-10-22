//
//  SensorMgr.swift
//  GApp
//
//  Created by Robert Talianu
//
import Foundation
import CoreMotion

public class SensorMgr {
    private let motion = CMMotionManager()
    private var listener: SensorListener?

    public func startAccelerometers() {
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 20.0  // 20 Hz
            self.motion.startAccelerometerUpdates()

            // Configure a timer to fetch the data.
            self.timer = Timer(
                fire: Date(),
                interval: (1.0 / 20.0),
                repeats: true,
                block: { (timer) in
                    // Get the accelerometer data.
                    if let data = self.motion.accelerometerData {
                        let x = data.acceleration.x
                        let y = data.acceleration.y
                        let z = data.acceleration.z

                        // Use the accelerometer data
                        self.listener?.onSensorChanged(Date().timeIntervalSince1970, x, y, z)
                    }
                })

            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: .defaultRunLoopMode)
        }
    }

    /*
     * @param listener
     */
    public func registerListener(_ listener: SensorListener) {
        //TODO... only one listener for now; expand it later if needed
        self.listener = listener
    }
}
