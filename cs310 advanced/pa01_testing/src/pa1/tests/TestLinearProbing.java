package pa1.tests;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import edu.princeton.cs.algs4.In;
import com.gradescope.jh61b.grader.GradedTest;

import pa1.*;

public class TestLinearProbing {
	LinearProbingHashST2 st = new LinearProbingHashST2<String,Integer>();;
   @Before
    public void createModel()
    {	


	In filen = new In("test_cases/tinyST.txt");
	String[] line = filen.readAllStrings();
	filen.close();
	int i = 0;
        for (String s : line) {
            st.put(s, i++);
        }	
    }
  @Test
    @GradedTest(name="Test Hash Table - get E (12)", max_score=5)
    public void test_Hash_performance() { 
	assertEquals("Should be 12", 12, st.get("E"));
    }

 @Test
    @GradedTest(name="Test Hash Table - get N (null)", max_score=5)
    public void test_Hash_performance2() { 
	assertEquals("Should be null", null, st.get("N"));
    }
@Test
    @GradedTest(name="Test Hash Table - size of table", max_score=5)
    public void test_table_size() { 
	assertEquals("Should be 32", 32, st.tableSize());
    }

 @Test
    @GradedTest(name="Test Hash Table - number of valid keys before deletion", max_score=5)
    public void test_Hash_valid_keys() { 
	assertEquals("Should be 10", 10, st.size());
    }
@Test
    @GradedTest(name="Test Hash Table - number of overall keys before deletion", max_score=5)
    public void test_Hash_overall_keys() { 
	assertEquals("Should be 10", 10, st.numberOfOverallKeys());
    }

 @Test
    @GradedTest(name="Test Hash Table - number of valid keys after deletion", max_score=5)
    public void test_Hash_valid_keys_after() { 
	st.delete("S");
	st.delete("A");
	assertEquals("Should be 8", 8, st.size());
    }
@Test
    @GradedTest(name="Test Hash Table - number of overall keys before deletion", max_score=5)
    public void test_Hash_overall_keys_after() { 
	st.delete("S");
	st.delete("A");
	assertEquals("Should be 10", 10, st.numberOfOverallKeys());
    }
}
