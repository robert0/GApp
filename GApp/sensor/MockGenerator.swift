//
//  MockGenerator.swift
//  GApp
//
//  Created by Robert Talianu on 19.10.2024.
//

import Foundation

/**
 *
 */
public class MockGenerator {
    static var listener: SensorListener?

    /**
     * @param listener
     */
    public static func toggleListener(_ listener: SensorListener) {
        if MockGenerator.listener == nil {
            MockGenerator.listener = listener
        } else {
            MockGenerator.listener = nil
        }
    }

    /**
     *
     */
    public static func start() {

        Timer.scheduledTimer(
            timeInterval: 0.05,  //20 times a second
            target: self,
            selector: #selector(handleTimerExecution),
            userInfo: nil,
            repeats: true)
    }

    /**
     *
     */
    @objc static func handleTimerExecution() {
        //GestureApp.logOnScreen("> new mock iteration...");
        if listener != nil {

            var x = Double.random(in: -10.0...10.0)  //[-10,+10]
            var y = Double.random(in: -10.0...10.0)  //[-10,+10]
            var z = Double.random(in: -1.0...1.0)  //[-1,+1]
            //GestureApp.logOnScreen("> notify listener...");
            listener!.onSensorChanged(Utils.getCurrentMillis(), x, y, z)
        }
    }

}
