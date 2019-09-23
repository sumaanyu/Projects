// Adaped from CS 61B Fall 2019 //
public class CompoundInterest {
    static final int THIS_YEAR = 2019;
    static int numYears(int targetYear) {
        return targetYear - THIS_YEAR;
    static double futureValue(double presentValue, double rate,
                              int targetYear) {
        float fval = (float)(presentValue * Math.pow((1 + rate/100), numYears(targetYear)));
        return fval;
    }
    static double futureValueReal(double presentValue, double rate,
                                  int targetYear, double inflationRate) {
        float fvalr = (float)futureValue(presentValue, rate, targetYear);
        return fvalr * Math.pow(1 - (inflationRate/100), numYears(targetYear));
    }
    static double totalSavings(double perYear, int targetYear, double rate) {
        double amt = 0;
        for (int x = 0; x < numYears(targetYear); x ++) {
            amt = (amt + perYear) * (1 + (rate/100));
        }
        amt = amt + perYear;
        return amt;
    }
    static double totalSavingsReal(double perYear, int targetYear, double rate,
                               double inflationRate) {
        double amt = 0;
        for (int y = 0; y < numYears(targetYear); y ++) {
            amt = (amt + perYear) * (1 + (rate/100) - (inflationRate/100));
        }
        amt = amt + perYear;
        return amt;
    }
    static void printDollarFV(int targetYear, double returnRate,
                              double inflationRate) {
        double nominalDollarValue = futureValue(1, returnRate, targetYear);
        double realDollarValue = futureValueReal(1, returnRate, targetYear, inflationRate);

        String dollarSummary =
            String.format("Assuming a %.2f%% rate of return,"
                          + " a dollar saved today would be worth"
                          + " %.2f dollars in the year %d, or %.2f dollars"
                          + " adjusted for inflation.", returnRate,
                          nominalDollarValue, targetYear, realDollarValue);

        System.out.println(dollarSummary);
    }
    static void printSavingsFV(int targetYear, double returnRate,
                               double inflationRate, double perYear) {

        double nominalSavings = totalSavings(perYear, targetYear, returnRate);
        double realSavings = totalSavingsReal(perYear, targetYear, returnRate, inflationRate);

        String savingsSummary =
            String.format("Assuming a %.2f%% rate of return,"
                          + " in the year %d, after saving %.2f"
                          + " dollars per year, you'll have %.2f dollars or"
                          + " %.2f dollars adjusted for inflation.",
                          returnRate, targetYear, perYear,
                          nominalSavings, realSavings);

        System.out.println(savingsSummary);
    }

    static final int TARGET_YEAR = 2059;
    static final double RETURN_RATE = 10,
        INFLATION_RATE = 3,
        PER_YEAR = 10000;

    public static void main(String[] ignored) {
        printDollarFV(TARGET_YEAR, RETURN_RATE, INFLATION_RATE);
        System.out.println();
        printSavingsFV(TARGET_YEAR, RETURN_RATE, INFLATION_RATE, PER_YEAR);
    }
}
