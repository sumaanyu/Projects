public class LeapYear {
	public static Integer isleapyear (Integer year) {
		if(year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
			return 1;
		}
		return 0;
	}

	public static void main(String[] args) {
		int year = 2000;
		if (isleapyear(year) == 1) {
			System.out.println (year + " is a leap year.");
		}
		else {
			System.out.println (year + " is not a leap year.");
		}
	}
}
