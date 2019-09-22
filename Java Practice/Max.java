public class Maximum {
	static void max(int[] a) {
		int maximum_value = 0;
		for (int i = 0; i < (a.length - 1); i++) {
			if (a[i] > a[i + 1])
				maximum_value = a[i];
		}
		return maximum_value;
	}
}
