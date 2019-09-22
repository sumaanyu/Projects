public class 3SUMDIST {
	static void threeSumDist(int[] a) {
		for (int f = 0; f < a.length - 1; f++) {
			for (int g = f + 1; g < a.length - 1; g++) {
				for (int h = f + 2; h < a.length - 1; h++) {
					if ((a[f] + a[g] + a[h] == 0) && (a[f] != a[g]) && (a[g] != a[h]) && (a[f] != a[h]))
						return true;
				}
			}
		}
		return false;
	}
}
