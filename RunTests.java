package pa2.tests;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import com.gradescope.jh61b.junit.TestRunnerPrintAll;
//import com.gradescope.jh61b.grader.GradedTestListenerJSON;

@RunWith(Suite.class)
@Suite.SuiteClasses({
        TestAStar.class,
	TestBacon.class,
            })
public class RunTests {
    public static void main(String[] args) {
        JUnitCore runner = new JUnitCore();
    //    runner.addListener(new GradedTestListenerJSON());
        runner.addListener(new TestRunnerPrintAll());
        Result r = runner.run(RunTests.class);
    }
}
