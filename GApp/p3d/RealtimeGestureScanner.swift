//
//  RealtimeGestureScanner.swift
//  GApp
//
//  Created by Robert Talianu 
//


/**
 *
 */
public class RealtimeGestureScanner {
    private var listener: GestureScanningListener
    private var zeroesThresholdLevel:  Double = 0.0
    private var isGestureStarted:Bool = false
    private var lastSample:Sample5D = nil
    private var lastZeroesWindow:ZeroesWindow = ZeroesWindow(500);
    private var gestureWindow : GestureWindow = GestureWindow(100);
    private var prevGestureWindow:GestureWindow = GestureWindow(100);

    private var signalBuffer = RollingQueue<Sample5D>(100);


    /**
     * @param zeroesThresholdLevel
     */
    init(_ zeroesThresholdLevel:Double) {
        self.zeroesThresholdLevel = zeroesThresholdLevel;
    }

    /**
     * //TODO... only use one listener for now; expand it later if needed
     *
     * @param listener
     */
    public func registerListener(_ listener:GestureScanningListener) {
        //TODO... only use one listener for now; expand it later if needed
        self.listener = listener;
    }

    /**
     *
     * @return
     */
    public func getLastZeroesWindow()->ZeroesWindow {
        return lastZeroesWindow;
    }

    /**
     *
     * @return
     */
    public func getGestureWindow()->GestureWindow {
        return gestureWindow;
    }

    /**
     * @param x
     * @param y
     * @param z
     * @param time
     */
    public func eval(_ x:Double, _ y:Double, _ z:Double, _ time:Int64) {
        //eval if current sample is part of signal
        if (isGesture(x, y, z)) {
            //mark down the gesture start
            markGesture(x, y, z, time);
        } else {
            // mark down the next zero
            markZero(x, y, z, time);
        }
        self.signalBuffer.add(Sample5D(lastSample));
    }


    // true if any (x,y) lvl above ref level
    private func isGesture(_ x:Double, _ y:Double, _ z:Double) -> Bool{
        return x > zeroesThresholdLevel || -x > zeroesThresholdLevel || y > zeroesThresholdLevel || -y > zeroesThresholdLevel;
    }

    /**
     *
     * @param x
     * @param y
     * @param z
     * @param time
     */
    private func markGesture(_ x:Double, _ y:Double, _ z:Double, _ time:Int64) {
        if (lastSample != nil) {
            if (lastSample.getType() == 0 && lastZeroesWindow.isReference() && !isGestureStarted) {
                if (gestureWindow.getSamples().size() > 1) {
                    prevGestureWindow.from(gestureWindow);
                }
                gestureWindow.clear();
                gestureWindow.add(x, y, z, time);
                isGestureStarted = true;
                notifyZeroesEnded();
                notifyGestureStarted();
            } else {
                gestureWindow.add(x, y, z, time);//add starting point
                notifyGestureContinuation();
            }
            lastSample.setFrom(x, y, z, time, 1);
            
        }else {
            lastSample = Sample5D(x, y, z, time, 1);
        }
    }

    >> TODO ...
    
    
    /**
     *
     * @param x
     * @param y
     * @param z
     * @param time
     */
    private void markZero(float x, float y, float z, long time) {
        if (lastSample != null) {
            if (lastSample.getType() == 1){
                //if previous sample is not zero type, start new zeroes window
                lastZeroesWindow.setFrom(new Sample4D(x, y, z, time), new Sample4D(x, y, z, time));
                if (isGestureStarted) {
                    gestureWindow.add(new Sample4D(x, y, z, time));
                    notifyGestureContinuation();
                }
                notifyZeroesStarted();

            } else if (lastSample.getType() == 0) {
                self.lastZeroesWindow.setEnd(new Sample4D(x, y, z, time));
                if (isGestureStarted) {
                    gestureWindow.add(new Sample4D(x, y, z, time));
                    notifyGestureContinuation();
                }
                if (self.lastZeroesWindow.isReference() && isGestureStarted) {
                    isGestureStarted = false;
                    trimGesture();
                    notifyGestureEnded();
                    if (gestureWindow.getSamples().size() > 1) {
                        prevGestureWindow.from(gestureWindow);
                    }
                    gestureWindow.clear();

                }
            }
            lastSample.setFrom(x, y, z, time, 0);


        } else {
            //the very first zero sample
            lastZeroesWindow.setFrom(null);
            lastZeroesWindow.setStart(new Sample4D(x, y, z, time));
            lastSample = new Sample5D(x, y, z, time, 0);
        }
    }

    private void notifyGestureStarted() {
        if (self.listener != null) {
            self.listener.gestureStarted();
        }
    }

    private void notifyGestureEnded() {
        if (self.listener != null) {
            self.listener.gestureEnded();
        }
    }

    private void notifyGestureContinuation() {
        if (self.listener != null) {
            self.listener.gestureContinuation();
        }
    }

    private void notifyZeroesStarted() {
        if (self.listener != null) {
            self.listener.zeroesStarted();
        }
    }

    private void notifyZeroesEnded() {
        if (self.listener != null) {
            self.listener.zeroesEnded();
        }
    }

    /**
     * remove the zeroes from the end
     */
    private void trimGesture() {
    }

    /**
     *
     * @return
     */
    public GestureWindow getPreviousGesture(){
        return prevGestureWindow;
    }

    /**
     *
     * @return
     */
    public List<Sample5D> getDataBuffer(){
        return signalBuffer;
    }

}
