//
//  ArrayMath4D.swift
//  GApp
//
//  Created by Robert Talianu
//
import Foundation

public class ArrayMath4D {

    /**
     *
     * @param signal
     * @param absMaxNorm
     * @return
     */
    public static List<Sample4D> normalizeToNew(List<Sample4D> signal, Float absMaxNorm) {
        //maximus
        Float maxVx = signal.stream().map(s -> s.x).map(Math::abs).reduce(Float::max).get();
        Float maxVy = signal.stream().map(s -> s.y).map(Math::abs).reduce(Float::max).get();
        //Float maxVz = signal.stream().map(s -> s.z).map(Math::abs).reduce(Float::max).get();
        Float maxTotAbs = Math.max(Math.abs(maxVx), Math.abs(maxVy));
        //minimums
        Float minVx = signal.stream().map(s -> s.x).map(Math::abs).reduce(Float::min).get();
        Float minVy = signal.stream().map(s -> s.y).map(Math::abs).reduce(Float::min).get();
        Float minTotAbs = Math.max(Math.abs(minVx), Math.abs(minVy));

        //Float minVz = signal.stream().map(s -> s.z).map(Math::abs).reduce(Float::min).get();
        Float factor = absMaxNorm / Math.max(maxTotAbs, minTotAbs);
        List<Sample4D> result = signal.stream().map(s -> {
            return new Sample4D(s.x * factor, s.y * factor, s.z * factor, s.time);
        }).collect(Collectors.toList());
        return result;
    }

    /**
     *
     * @param signal
     * @param levelFactor
     * @param isCartesianProduct
     * @return
     */
    public static BaseSignalProp<Sample4D> extractBaseAboveLevelFactor(List<Sample4D> signal, double levelFactor, boolean isCartesianProduct) {
        return isCartesianProduct? extractBaseAboveLevelFactorCartesian(signal, levelFactor): extractBaseAboveLevelFactorSum(signal, levelFactor);
    }

    /**
     *
     * @param signal
     * @param levelFactor
     * @return
     */
    private static BaseSignalProp<Sample4D> extractBaseAboveLevelFactorSum(List<Sample4D> signal, double levelFactor) {
        BaseSignalProp<Sample4D> bprop = new BaseSignalProp();
        bprop.setLevelFactor(levelFactor);
        bprop.setOriginalSignalLength(signal.size());

        Float maxVx = signal.stream().map(s -> s.x).map(Math::abs).reduce(Float::max).get();
        Float maxVy = signal.stream().map(s -> s.y).map(Math::abs).reduce(Float::max).get();
        Float maxV = Math.max(maxVx, maxVy);

        int beginIndex = 0;
        for (int i = 0; i < signal.size(); i++) {
            Sample4D sp = signal.get(i);
            if (sp.x > levelFactor * maxV || sp.x < -levelFactor * maxV ||
                    sp.y > levelFactor * maxV || sp.y < -levelFactor * maxV) {
                beginIndex = i;
                break;
            }
        }
        int endIndex = signal.size() - 1;
        for (int i = 0; i < signal.size(); i++) {
            int lastix = signal.size() - 1 - i;
            Sample4D sp = signal.get(lastix);
            if (sp.x > levelFactor * maxV || sp.x < -levelFactor * maxV ||
                    sp.y > levelFactor * maxV || sp.y < -levelFactor * maxV) {
                endIndex = lastix;
                break;
            }
        }
        bprop.setStartIndex(beginIndex);
        bprop.setEndIndex(endIndex);
        bprop.setBase(new ArrayList<Sample4D> (signal.subList(beginIndex, endIndex)));
        return bprop;
    }

    /**
     *
     * @param signal
     * @param levelFactor
     * @return
     */
    private static BaseSignalProp<Sample4D> extractBaseAboveLevelFactorCartesian(List<Sample4D> signal, double levelFactor) {
        //TODO ...
        return null;
    }


    /**
     *
     * @param signal
     * @param level
     * @param isCartesianProduct
     * @return
     */
    public static BaseSignalProp4D extractBaseAboveLevel(List<Sample4D> signal, double level, boolean isCartesianProduct) {
        return isCartesianProduct? extractBaseAboveLevelCartesian(signal, level): extractBaseAboveLevelSum(signal, level);
    }

    /**
     *
     * @param signal
     * @param level
     * @return
     */
    private static BaseSignalProp4D extractBaseAboveLevelSum(List<Sample4D> signal, double level) {
        BaseSignalProp4D bprop = new BaseSignalProp4D();
        bprop.setLevel(level);
        bprop.setOriginalSignalLength(signal.size());

        int beginIndex = 0;
        for (int i = 0; i < signal.size(); i++) {
            Sample4D sp = signal.get(i);
            if (sp.x > level || sp.x < -level ||
                    sp.y > level || sp.y < -level) {
                beginIndex = i;
                break;
            }
        }
        int endIndex = signal.size() - 1;
        for (int i = 0; i < signal.size(); i++) {
            int lastix = signal.size() - 1 - i;
            Sample4D sp = signal.get(lastix);
            if (sp.x > level || sp.x < -level ||
                    sp.y > level || sp.y < -level) {
                endIndex = lastix;
                break;
            }
        }
        bprop.setStartIndex(beginIndex);
        bprop.setEndIndex(endIndex);
        bprop.setBase(new ArrayList (signal.subList(beginIndex, endIndex)));
        return bprop;
    }

    /**
     *
     * @param signal
     * @param level
     * @return
     */
    private static BaseSignalProp4D extractBaseAboveLevelCartesian(List<Sample4D> signal, double level) {
        //TODO ...
        return null;
    }

    /**
     *
     * @param base
     * @param data
     * @return
     */
    public static List<Float> phasedCorrelation(List<Sample4D> base, List<Sample4D> data) {
        int reLen = data.size() - base.size();
        List<Float> res = new ArrayList(reLen);
        for (int i = 0; i < reLen; i++) {
            res.add(correlationIn(base, data, i));
        }

        return res;
    }

    /**
     *
     * @param base
     * @param data
     * @return
     */
    public static double correlation(List<Sample4D> base, List<Sample4D> data) {
        //TODO: check here that arrays are not null, of the same length etc

        return correlationIn(base, data, 0);
    }

    public static float correlationIn(List<Sample4D> base, List<Sample4D> data, int startPos) {
        double xsx = 0.0, ysx = 0.0;
        double xsy = 0.0, ysy = 0.0;
        double xsxx = 0.0, ysxx = 0.0;
        double xsyy = 0.0, ysyy = 0.0;
        double xsxy = 0.0, ysxy = 0.0;
        Sample4D ZERO = new Sample4D(0f,0f,0f, 0);

        int n = base.size();
        for (int i = 0; i < n; i++) {
            Sample4D basep =  base.get(i);
            Sample4D datap = (i + startPos) >= data.size() ? ZERO : data.get(i + startPos);

            //first axis
            double xx = basep.x;
            double xy = datap.x;

            xsx += xx;
            xsy += xy;
            xsxx += xx * xx;
            xsyy += xy * xy;
            xsxy += xx * xy;

            //second axis
            double yx = basep.y;
            double yy = datap.y;

            ysx += yx;
            ysy += yy;
            ysxx += yx * yx;
            ysyy += yy * yy;
            ysxy += yx * yy;
        }

        // covariation
        double dn = n;

        //*** first axis
        double xcov = xsxy / dn - xsx * xsy / dn / dn;
        // standard error of x
        double xsigmax = Math.sqrt(xsxx / dn - xsx * xsx / dn / dn);
        // standard error of y
        double xsigmay = Math.sqrt(xsyy / dn - xsy * xsy / dn / dn);
        // correlation is just a normalized covariation
        double cx = xcov / xsigmax / xsigmay;

        //*** second axis
        double ycov = ysxy / dn - ysx * ysy / dn / dn;
        // standard error of x
        double ysigmax = Math.sqrt(ysxx / dn - ysx * ysx / dn / dn);
        // standard error of y
        double ysigmay = Math.sqrt(ysyy / dn - ysy * ysy / dn / dn);
        // correlation is just a normalized covariation
        double cy = ycov / ysigmax / ysigmay;

       // return (float) (cx * cy);

        return 0.5f * ((float) (cx + cy));
    }

}
