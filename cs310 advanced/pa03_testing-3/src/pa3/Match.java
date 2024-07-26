package pa3;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.Stack;

/**
 * Skeleton match class
 */

public class Match {


    public Match() {
    }

    // return the optimal match between the strings a and b
// return null if either string is null or if either string is length 0
    public Path match(String a, String b) {
        // Code here.


        // this will return if the string is null or lenght is 0

        if (a == null || b == null || a.length() == 0 || b.length() == 0) {

            return null;
        }
        //we have to initialize the variables
        int e, f, g;
        int Ab = a.length();
        int Bc = b.length();
        Path[][] opt = new Path[Ab + 1][Bc + 1];

        //this will help us to create paths
        for (int ab = 0; ab <= Ab; ab++) {
            for (int bc = 0; bc <= Bc; bc++) {
                opt[ab][bc] = new Path(ab, bc);
                opt[ab][bc].setRow(ab);
                opt[ab][bc].setCol(bc);

            }
        }
        //we have to initailize path
        opt[Ab][Bc].setCost(0);
        opt[Ab][Bc].setNext(null);
        int min = 0;

        for (int ab = Ab - 1; ab >= 0; ab--) {
            opt[ab][Bc].setCost(opt[ab + 1][Bc].getCost() + 2);
            for (int bc = Bc - 1; bc >= 0; bc--) {

                opt[Ab][bc].setCost(opt[Ab][bc + 1].getCost() + 2);

                // this will add 1 (diffrent )  same(0)

                if (a.charAt(ab) == b.charAt(bc)) {
                    e = opt[ab + 1][bc + 1].getCost();

                } else {
                    e = opt[ab + 1][bc + 1].getCost() + 1;
                }
                // or add 2 if there is a gap
                f = opt[ab + 1][bc].getCost() + 2;
                g = opt[ab][bc + 1].getCost() + 2;

                //this will get minimum cost

                int abc = (Math.min(e, f));
                int abc1 = (Math.min(abc, f));
                opt[ab][bc].setCost(abc1);
                min = opt[ab][bc].getCost();


                if (min == e) {
                    opt[ab][bc].setNext(opt[ab + 1][bc + 1]);
                    continue;
                }
                if (min == f) {
                    opt[ab][bc].setNext(opt[ab + 1][bc]);
                }
                if (min == g) {
                    opt[ab][bc].setNext(opt[ab][bc + 1]);
                }

            }

        }

        return opt[0][0];
    }


    public static void main(String[] args) {
        File file = new File(" ");
        try {
            Scanner read = new Scanner(file);
            String a = read.nextLine();
            String b = read.nextLine();
            Match test = new Match();
            Path red = test.match(a, b);
            Stack<Integer> path = new Stack<>();

            while (red.getRow() >= 0 && red.getCol() >= 0) {
                path.push(red.getCost());
                if (red.getNext() == null) {
                    break;
                }
                ;

                red = red.getNext();

            }
            while (!path.empty()) {
                System.out.println(path.pop());
            }


        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

}

