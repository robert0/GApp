package com.eeu.gapp.p3d;

public class Sample3D {

    public Float x = 0.0f;
    public Float y = 0.0f;
    public Float z = 0.0f;

    public Sample3D(Float x, Float y, Float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }


    public Sample3D() {
    }


    public Float getX() {
        return x;
    }

    public void setX(Float x) {
        this.x = x;
    }

    public Float getY() {
        return y;
    }

    public void setY(Float y) {
        this.y = y;
    }

    public Float getZ() {
        return z;
    }

    public void setZ(Float z) {
        this.z = z;
    }

    /**
     * case 0:
     *      return x;
     * case 1:
     *      return y;
     * case 2:
     *      return z;
     *
     * @param index
     * @return
     */
    public Float getByIndex(int index) {
        switch (index) {
            case 0:
                return x;
            case 1:
                return y;
            case 2:
                return z;
            default:
                return 0f;
        }
    }
}