package pa3;
import java.util.*;
import java.io.*;
import java.io.FileNotFoundException;  // Import this class to handle errors

/**
 * Class to demonstrate Coin change DP algorithm
 */
public class EditDistance {
    // read 2 strings from standard input.
    // compute and print the edit distance between them and output an optimal
    // alignment and associated penalties.
    public static void main(String[] args) {
    try {
	File f = new File(args[0]);
        Scanner in = new Scanner(f);
        String a = in.next();
        String b = in.next();
        Match m = new Match();
        Path p = m.match(a,b);
        p.print(a,b);
      }
       catch (FileNotFoundException e) {
           System.out.println("An error occurred.");
           e.printStackTrace();
      }
    }
    
}
