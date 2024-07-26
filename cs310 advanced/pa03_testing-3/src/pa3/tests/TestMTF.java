package pa3.tests;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.io.*;
import edu.princeton.cs.algs4.BinaryStdIn;
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;
import com.gradescope.jh61b.grader.GradedTest;
import pa3.*;



public class TestMTF {
	private static final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
	private final PrintStream originalOut = System.out;
	private static String s;
	
   @Before
     public void setUpStreams() {
       System.setOut(new PrintStream(outContent));
      }

  @After
	// Reset original stdout, flush existing contents.
  public void restoreStreams() throws IOException {                   
            String record; 
            synchronized(outContent) { 
                outContent.flush(); 
                record = outContent.toString(); 
                outContent.reset(); 
                
                if (record.length() == 0) {
                    // avoid empty records 
                    return; 
                } 
                
            }              
      System.setOut(originalOut);
     }

    // Helper - convert integer to hex string
    public String prettyHex(String s) {
	StringBuilder result = new StringBuilder();
        char[] chars = s.toCharArray();
	for (char aChar : chars) {
           result.append(
                   String.format("%2s", Integer.toHexString(aChar))   // char -> int, auto-cast
                            .replaceAll(" ", "0")                         // zero pads
            );
        }
         List<String> result1 = new ArrayList<>();
        int index = 0;
        while (index < result.length()) {
            result1.add(result.substring(index, Math.min(index + 2, result.length())));
            index += 2;
        }
	
        String str1 = result1.stream().collect(Collectors.joining(" "));
	return str1;
    }    

    @Test
    @GradedTest(name="Decoding test", max_score=7)
    public void test_mtf_encoding1() { 
	MoveToFront mtf = new MoveToFront();
	mtf.decode("test_cases/abra_dec.txt");
	s = outContent.toString();
	assertEquals("Test encoding","ABRACADABRA!", s);
    }
   
  @Test
    @GradedTest(name="Encoding test", max_score=7)
    public void test_mtf_encoding3() {  
	MoveToFront mtf1 = new MoveToFront();
	mtf1.encode("test_cases/abra.txt");
	s = outContent.toString();
	String str1 = prettyHex(s);
	assertEquals("Encoding error!","41 42 52 02 44 01 45 01 04 04 02 26", str1);
    }
}
