package pa2.tests;
import edu.princeton.cs.algs4.In;
import edu.princeton.cs.algs4.EdgeWeightedDigraph;
import edu.princeton.cs.algs4.DijkstraSP;
import edu.princeton.cs.algs4.Edge;
import edu.princeton.cs.algs4.Stack;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import com.gradescope.jh61b.grader.GradedTest;
import pa2.*;

//import com.gradescope.pa0.*;
//import com.gradescope.intlist.RefIntList;
//import com.gradescope.intlist.AbstractIntList;

public class TestAStar {
    private AStar sp_A;
    private AStar sp_D;

    @Before
    public void createModel()
    {	
	sp_A = new AStar("test_cases/usa.txt",1);
	sp_D = new AStar("test_cases/usa.txt",1);
    }

    @Test
    @GradedTest(name="A-star path 1, 56011->56066", max_score=5)
    public void test_path1() { 
	int processed = sp_A.route(56011,56066);
	double d3 = sp_A.distTo(56066);
	assertEquals("Expected Distance 56011->56066 error!", 1280.38, d3, 0.1);
    }

  @Test
    @GradedTest(name="A-star path 2, 4073 to 66023", max_score=5)
    public void test_path2() { 
	int processed = sp_A.route(4073,66023);
	double d3 = sp_A.distTo(66023);
	assertEquals("Expected Distance 4073->66023 error!", 8099.51, d3, 0.1);
    }
 
@Test
    @GradedTest(name="A-star path 3, 4073 to 66023, check path", max_score=5)
    public void test_path3() { 
	int processed = sp_A.route(4073,66023);
	Iterable<Edge> ei = sp_A.pathTo(66023);
 	int i=0;
	Edge esp = new Edge(4073,1,0);
	for(Edge e : ei) {
	  if(i == 0) {
		esp = e;
		
	}
	++i;
    }
	assertEquals("Expected Distance 0->3 error!", 4071, esp.other(4073));
    }

@Test
    @GradedTest(name="A-star path 3, 4073 to 66023 Dijkstra, check path", max_score=5)
    public void test_path4() { 
	int processed = sp_D.route(4073,66023);
	Iterable<Edge> ei = sp_D.pathTo(66023);
	Edge esp = new Edge(4071,1,0);
 	int i=0;
	for(Edge e : ei) {
	  if(i == 1)
	  	esp = e;
		
	++i;
       }
	assertEquals("Expected 4063", 4063, esp.other(4071));
    }


}
