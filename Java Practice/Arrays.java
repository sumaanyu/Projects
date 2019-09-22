package arrays;

/* NOTE: The file Arrays/Utils.java contains some functions that may be useful
 * in testing your answers. */

/** HW #2 */

/** Array utilities.
 *  @author
 */
class Arrays {
    /* C. */
    /** Returns a new array consisting of the elements of A followed by the
     *  the elements of B. */
    static int[] catenate(int[] A, int[] B) {
        /* *Replace this body with the solution. */
        int[] catenated = new int[A.length + B.length];
        if(A.length == 0)
            catenated = B;
        if(B.length == 0)
            catenated = A;
        if(A.length == 0 && B.length == 0)
            catenated = null;
        int i;
        for(i = 0; i < A.length; i = i + 1){
            catenated[i] = A[i];
        }
        for(int j = 0; j < B.length; i += 1, j = j + 1){
            catenated[i] = B[j];
        }
        return catenated;
    }

    /** Returns the array formed by removing LEN items from A,
     *  beginning with item #START. */
    static int[] remove(int[] A, int start, int len) {
        if (A.length == 0)
            return null;

        int[] removed = new int[A.length - len];
        int toberem = len + start;
        System.arraycopy(A, 0, removed, 0, start);
        System.arraycopy(A, toberem, removed, start, A.length - toberem);
        return removed;
    }

    /* E. */
    /** Returns the array of arrays formed by breaking up A into
     *  maximal ascending lists, without reordering.
     *  For example, if A is {1, 3, 7, 5, 4, 6, 9, 10}, then
     *  returns the three-element array
     *  {{1, 3, 7}, {5}, {4, 6, 9, 10}}. */
    static int[][] naturalRuns(int[] A) {
        return null;
    }
}
