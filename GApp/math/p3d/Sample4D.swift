package com.eeu.gapp.p3d;

/**
 *
 */
public class Sample4D extends Sample3D {
    public long time = 0;

    public Sample4D(Float x, Float y, Float z, long time) {
        super(x, y, z);
        this.time = time;
    }

    /**
     *
     * @return
     */
    public long getTime() {
        return time;
    }
}