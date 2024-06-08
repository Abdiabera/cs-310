package pa3;
import edu.princeton.cs.algs4.BinaryIn;
import edu.princeton.cs.algs4.StdOut;
import java.util.*;

/**
 * Class to Implement MTF
 */
public class MoveToFront {
    ArrayList<Character> seq;
    public MoveToFront() {
        seq = new ArrayList<Character>();
        for(char i=0;i<255;i++)
            seq.add(i);
    }
    public static void decode(String f) {
	MoveToFront mtf = new MoveToFront();
	BinaryIn b = new BinaryIn(f);
        while(!b.isEmpty()) {
            // Read an index
            char c = b.readChar();
            char now = mtf.seq.get(c);
            StdOut.printf("%c",now);
            mtf.seq.remove(c);
            mtf.seq.add(0,now);
        }
	return;
    }
    // Read from stdin
    public static void encode(String f) {
        MoveToFront mtf = new MoveToFront();
	BinaryIn b = new BinaryIn(f);
       	while(!b.isEmpty()) { 
            // Read a character and move to front
            char c = b.readChar();
            // Search in sequence
            ListIterator l = mtf.seq.listIterator();
            while(l.hasNext()) {
                Character n = (Character)l.next();
                if(n==c) {
                    StdOut.printf("%c", l.previousIndex());
                    l.remove();
                    mtf.seq.add(0,c); // Add to beginning of list
                    break;
                }
            }
        }
	return;
    }
    
    public static void main(String[] args) {
        MoveToFront mtf = new MoveToFront();
        if(args.length != 2) {
            System.out.println("Usage: MoveToFront <+,-> <String name>");
            return;
        }
        String operation = args[0];
	String f = args[1];
	
        if(operation.equals("-")) {
            mtf.encode(f);
	   // System.out.println(result);
	}
        else if(operation.equals("+"))
 	{
            mtf.decode(f);
	   // System.out.println(result);
	}
        else
            System.out.println("Usage: MoveToFront <+,-> <File name>");
	
    }
        
}
