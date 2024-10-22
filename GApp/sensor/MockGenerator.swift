//
//  MockGenerator.swift
//  GApp
//
//  Created by Robert Talianu
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
            timeInterval: 1.00005,  //20 times a second
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

            let x = Double.random(in: -10.0...10.0)  //[-10,+10]
            let y = Double.random(in: -10.0...10.0)  //[-10,+10]
            let z = Double.random(in: -1.0...1.0)  //[-1,+1]
            //GestureApp.logOnScreen("> notify listener...");
            listener!.onSensorChanged(Utils.getCurrentMillis(), x, y, z)
        }
    }

}
