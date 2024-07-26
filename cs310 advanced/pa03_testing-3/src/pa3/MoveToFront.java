package pa3;

import edu.princeton.cs.algs4.BinaryIn;
import edu.princeton.cs.algs4.BinaryOut;

/**
 * Class to Implement MTF
 */
public class MoveToFront {

    private static final int A = 256;

    public MoveToFront() {

    }

    public static void decode(String f) {

        //we have to initialize an array

        char[] Arra = new char[A];
        for (char a = 0; a < A; a++) {
            Arra[a] = a;
        }

        //this is when decoding

        BinaryIn in = new BinaryIn(f);
        BinaryOut out = new BinaryOut();
        while (!in.isEmpty()) {
            char index = in.readChar();
            char Ab = Arra[index];
            out.write(Ab);
            System.arraycopy(Arra, 0, Arra, 1, index);
            Arra[0] = Ab;
        }

        out.flush();
    }


    public static void encode(String f) {

        //we have to initialize an array

        char[] Arra = new char[A];
        for (char a = 0; a < A; a++) {
            Arra[a] = a;
        }

        //this is when encoding

        BinaryIn inp = new BinaryIn(f);
        BinaryOut outp = new BinaryOut();
        while (!inp.isEmpty()) {
            char Ab = inp.readChar();
            char indexof = 0;
            while (Ab != Arra[indexof]) {
                indexof++;

            }
            outp.write(indexof);
            System.arraycopy(Arra, 0, Arra, 1, indexof);
            Arra[0] = Ab;

        }
        outp.flush();

    }
}
