public class 3SUM {
	static void threeSum(int[] a) {
		for (int f = 0; f < a.length - 1; f++) {
			for (int g = f + 1; g < a.length - 1; g++) {
				for (int h = f + 2; h < a.length - 1; h++) {
					if (a[f] + a[g] + a[h] == 0)
						return true;
				}
			}
		}
		return false;
	}
}
