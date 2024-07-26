package pa2.tests;
import edu.princeton.cs.algs4.In;
import edu.princeton.cs.algs4.Stack;
import edu.princeton.cs.algs4.Graph;
import edu.princeton.cs.algs4.SymbolGraph;
import edu.princeton.cs.algs4.BreadthFirstPaths;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import com.gradescope.jh61b.grader.GradedTest;
import pa2.*;


public class TestBacon {
    private DegreesOfSeparationBFS baconGraph;
    private SymbolGraph sg;
    @Before
    public void createModel()
    {	
	baconGraph = new DegreesOfSeparationBFS("test_cases/movies.txt", "/", "Bacon, Kevin");
	sg = baconGraph.getSymbolGraph();
    }

    @Test
    @GradedTest(name="Degrees of Separation graph distance Bacon", max_score=3)
    public void test_dist_graph_bacon() { 
	int d1 = baconGraph.baconNumber("Bacon, Kevin");
	assertEquals("Distance 0 of Bacon from himself", 0, d1);
    }
    
    @Test
    @GradedTest(name="Degrees of Separation graph distance Dane", max_score=3)
    public void test_dist_graph_dane() { 
	int d1 = baconGraph.baconNumber("Dane, Cynthia");
	assertEquals("Distance -1 for Cynthia Dane", -1, d1);
    }

    @Test
    @GradedTest(name="Degrees of Separation graph distance Nicholson", max_score=3)
    public void test_dist_graph_nicholson() { 
	int d1 = baconGraph.baconNumber("Nicholson, Jack");
	assertEquals("Distance 1 for Jack Nicholson", 1, d1);
    }

    @Test
    @GradedTest(name="Degrees of Separation graph path Kidman", max_score=3)
    public void test_dist_path_kidman() { 
	Stack<Integer> kidmanPath = baconGraph.graphPath("Kidman, Nicole");
	int v_ac = kidmanPath.pop(); 
	assertEquals("Should be Kidman, Nicole", "Kidman, Nicole", sg.nameOf(v_ac));
    }

    @Test
    @GradedTest(name="Degrees of Separation graph path My Life", max_score=3)
       public void test_dist_path_myLife() { 
       Stack<Integer> kidmanPath = baconGraph.graphPath("Kidman, Nicole");
        int v_ac = kidmanPath.pop(); 	
        int v_m = kidmanPath.pop();
	int v_next = kidmanPath.pop();
	assertEquals("Should be My Life (1993 I)", "My Life (1993 I)", sg.nameOf(v_m));
    }

    @Test
    @GradedTest(name="Degrees of Separation graph path Ruth de Sosa", max_score=3)    
    public void test_dist_path_deSosa() { 
       Stack<Integer> kidmanPath = baconGraph.graphPath("Kidman, Nicole");
        int v_ac = kidmanPath.pop(); 	
        int v_m = kidmanPath.pop();
	int v_next = kidmanPath.pop();
	assertEquals("Should be de Sosa, Ruth", "de Sosa, Ruth", sg.nameOf(v_next));
    }

}
