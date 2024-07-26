package pa3;

import java.util.ArrayList;

public class DynamicSubsequence {
    private ArrayList<Integer> inputArr;
    private ArrayList<Integer> sizes; // Size of longest sequence ending at each index
    private ArrayList<Integer> previous; // Track back sequence to previous index
    private ArrayList<Integer> output; // Track back sequence to previous index

    public DynamicSubsequence(ArrayList<Integer> Inp) {
        inputArr = Inp;
        sizes = new ArrayList<>(); // we have to intiailize with size 1
        previous = new ArrayList<>();
        output = new ArrayList<>();

        for (int a = 0; a < inputArr.size(); a++) {
            sizes.add(1);
            previous.add(-1);
        }
    }

    public ArrayList maxSubsequence() {

        int MAXlen = 0;
        int MAXIn = 0;
        for (int b = 0; b < inputArr.size(); b++) {
            for (int prev = 0; prev < b; prev++) {
                if (inputArr.get(prev) < inputArr.get(b) &&
                        sizes.get(prev) + 1 > sizes.get(b)) {
                    sizes.set(b, sizes.get(prev) + 1);
                    previous.set(b, prev);

                }

            }
            if (sizes.get(b) > MAXlen) {
                MAXlen = sizes.get(b);
                MAXIn = b;

            }
        }


        for (int a = MAXIn; a >= 0; a--) {
            if (sizes.get(a) == MAXlen) {
                output.add(0, inputArr.get(a));
                MAXlen--;
            }

        }
        return output;
    }

    //main
    public static void main(String[] args) {
        int len = args.length;
        ArrayList<Integer> Inp = new ArrayList<>();
        for (int a = 0; a < len; a++)
            Inp.add(Integer.parseInt(args[a]));
        DynamicSubsequence d = new DynamicSubsequence(Inp);
        if (len == 0) return;
        ArrayList<Integer> Outp = d.maxSubsequence();
        System.out.println(Outp);
    }
}


