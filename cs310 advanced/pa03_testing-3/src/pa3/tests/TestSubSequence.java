package pa3.tests;
import org.junit.Test;
import static org.junit.Assert.*;
import com.gradescope.jh61b.grader.GradedTest;
import java.util.*;
import org.junit.Before;
import pa3.*;

public class TestSubSequence {
   private ArrayList<Integer> Seq;
   private ArrayList<Integer> output;		
   private DynamicSubsequence ds;

   @Before
    public void createSeq()
    {	
	Seq= new ArrayList<Integer>( Arrays.asList(0, 8 ,4, 12 ,2, 10 , 6 , 14,  1 , 9 , 5 , 13 , 3  ,11,  7  ,15));
	ds = new DynamicSubsequence(Seq);
	output = ds.maxSubsequence();
	
    }

    @Test
    @GradedTest(name="Test sequence position 1", max_score=4)
    public void test_first_position_sequence() {
	int firstn = output.get(0);
 	assertEquals("Should be 0!", 0, firstn);
    }

    @Test
    @GradedTest(name="Test sequence position 3", max_score=4)
    public void test_third_position_sequence() {
	int firstn = output.get(2);
 	assertEquals("Should be 6!", 6, firstn);
    }

 @Test
    @GradedTest(name="Test sequence position 4", max_score=4)
    public void test_fourth_position_sequence() {
	int firstn = output.get(3);
 	assertEquals("Should be 9!", 9, firstn);
    }

 @Test
    @GradedTest(name="Test sequence position 6", max_score=4)
    public void test_sixth_position_sequence() {
	int firstn = output.get(5);
 	assertEquals("Should be 15!", 15, firstn);
    }
}
