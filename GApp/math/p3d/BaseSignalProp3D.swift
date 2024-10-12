package com.eeu.gapp.p3d;

import java.util.List;
/**
 * 
 */
public class BaseSignalProp3D {
    private int startIndex;
    private int endIndex;
    private double level;

    private int originalSignalLength;

    private List<Sample3D> base;


    /**
     * 
     */
    public BaseSignalProp3D() {
		// TODO Auto-generated constructor stub
	}
    
    
    public int getOriginalSignalLength() {
        return originalSignalLength;
    }

    public void setOriginalSignalLength(int originalSignalLength) {
        this.originalSignalLength = originalSignalLength;
    }
    public double getLevel() {
        return level;
    }

    public void setLevel(double level) {
        this.level = level;
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(int startIndex) {
        this.startIndex = startIndex;
    }

    public int getEndIndex() {
        return endIndex;
    }

    public void setEndIndex(int endIndex) {
        this.endIndex = endIndex;
    }

    public List<Sample3D> getBase() {
        return base;
    }

    public void setBase(List<Sample3D> base) {
        this.base = base;
    }

}