/**
 *
 */
public class Sample5D extends Sample4D {
    public int type = 0;

    /**
     *
     * @param x
     * @param y
     * @param z
     * @param time
     * @param type
     */
    public Sample5D(Float x, Float y, Float z, long time, int type) {
        super(x, y, z, time);
        this.type = type;
    }

    /**
     *
     * @param sample
     */
    public Sample5D(Sample5D sample) {
        super(sample.x, sample.y, sample.z, sample.time);
        this.type = sample.type;
    }

    /**
     * @param x
     * @param y
     * @param z
     * @param time
     * @param type
     */
    public void setFrom(Float x, Float y, Float z, long time, int type) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.time = time;
        this.type = type;
    }

    /**
     *
     * @return
     */
    public int getType() {
        return type;
    }
}