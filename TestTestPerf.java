package pa1.tests;

import com.gradescope.jh61b.grader.GradedTest;
import org.junit.Before;
import org.junit.Test;
import pa1.TestPerf;

import static org.junit.Assert.assertEquals;


public class TestTestPerf {

    private TestPerf test1;

    @Before
    public void createModel() {
        test1 = new TestPerf("test_cases/tale.txt");

    }

    @Test
    @GradedTest(name = "Test No. Words Tale.txt", max_score = 5)
    public void test_no_words_tale() {
        int MaxW = test1.getTotalWords();
        assertEquals("Should be 139,043", 139043, MaxW);
    }

    @Test
    @GradedTest(name = "Test No. Unique Words Tale.txt", max_score = 5)
    public void test_unique_words_tale() {
        int MaxW = test1.getUniqueWords();
        assertEquals("Should be 19,695", 19695, MaxW);
    }

    @Test
    @GradedTest(name = "Test Most Common word Tale.txt", max_score = 5)
    public void test_common_word_tale() {
        String MaxW = test1.getMostUsedWord();
        assertEquals("Should be \"the\" ", MaxW, "the");
    }

    @Test
    @GradedTest(name = "Test Most Common Word's occurrence Tale.txt", max_score = 5)
    public void test_common_tale() {
        int MaxW = test1.getMaxOccurrence();
        assertEquals("Should be 7515", 7515, MaxW);
    }

}
