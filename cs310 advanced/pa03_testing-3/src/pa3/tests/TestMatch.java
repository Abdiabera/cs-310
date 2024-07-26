package pa3.tests;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import com.gradescope.jh61b.grader.GradedTest;
import pa3.*;


public class TestMatch {
    
    
    @Test
    @GradedTest(name="Edit Distance example 1", max_score=5)
    public void test_edit_dist() { 

	Match m = new Match();
        Path p1 = m.match("AACAGTTACC","TAAGGTCA");
	int d1 = p1.getCost();
	assertEquals("Cost of Entire example (Should be 7)", 7, d1);
    }
    @Test
    @GradedTest(name="Edit Distance partial cost 1", max_score=4)
    public void test_edit1() { 

	Match m = new Match();
        Path p1 = m.match("AACAGTTACC","TAAGGTCA");
	int c = p1.getNext().getCost(); // How much did we "pay" for this entry
	assertEquals("Cost of first entry (Should be 6)", 6, c);
    }
    @Test
    @GradedTest(name="Edit Distance row check", max_score=4)
    public void test_edit2() { 

	Match m = new Match();
        Path p1 = m.match("AACAGTTACC","TAAGGTCA");
	int c = p1.getNext().getNext().getRow(); // How much did we "pay" for this entry
	assertEquals("Row of third entry (Should be 8)", 8, c);
    }

   @Test
    @GradedTest(name="Edit Distance partial cost 2", max_score=4)
    public void test_edit4() { 
	Match m = new Match();
        Path p1 = m.match("AACAGTTACC","TAAGGTCA");
	int c = p1.getNext().getNext().getNext().getNext().getCost(); // How much did we "pay" for this entry
	assertEquals("Cost of fourth entry (should be 4)", 4, c);
    }
 
  @Test
    @GradedTest(name="Edit Distance column check", max_score=5)
    public void test_edit5() { 

	Match m = new Match();
        Path p1 = m.match("AACAGTTACC","TAAGGTCA");
	int c = p1.getNext().getNext().getNext().getNext().getCol(); // How much did we "pay" for this entry
	assertEquals("Column of fifth entry (Should be 5)", 5, c);
    } 
    
}
