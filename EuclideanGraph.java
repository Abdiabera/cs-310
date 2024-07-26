package pa2;
/*************************************************************************
 *  Compilation:  javac EuclideanGraph.java
 *  Execution:    java EuclideanGraph
 *  Dependencies: In.java IntIterator.java
 *
 *  Undirected graph of points in the plane, where the edge weights
 *  are the Euclidean distances.
 *
 *************************************************************************/

import edu.princeton.cs.algs4.Bag;
import edu.princeton.cs.algs4.Edge;
import edu.princeton.cs.algs4.In;
import edu.princeton.cs.algs4.Point2D;

public class EuclideanGraph {

    private static final String NEWLINE = System.getProperty("line.separator");

    private int V;
    private int E;
    private Point2D[] points;
    private Bag<Edge>[] adj;

    /*******************************************************************
     *  Read in a graph from a file, bare bones error checking.
     *  V E
     *  node: id x y
     *  edge: from to
     *******************************************************************/

    public EuclideanGraph(In in) {
        V = in.readInt();
        E = in.readInt();

        points = new Point2D[V];
        adj = (Bag<Edge>[]) new Bag[V];
        for (int i = 0; i < V; i++) {
            int v = in.readInt();
            double x = in.readDouble();
            double y = in.readDouble();
            points[v] = new Point2D(x, y);
            adj[v] = new Bag<Edge>();
        }

        for (int i = 0; i < E; i++) {
            int v = in.readInt();
            int w = in.readInt();
            double weight = points[v].distanceTo(points[w]);
            Edge e = new Edge(v, w, weight);
            addEdge(e);
        }
    }

    // this is used add edge
    public void addEdge(Edge e) {
        int v = e.either();
        int w = e.other(v);
        adj[v].add(e);
        adj[w].add(e);

    }

    //retruning v for vertex
    public int V() {
        return V;
    }

    //returning E for Edge
    public int E() {
        return E;
    }

    //2Dimentiona point
    public Point2D points(int i) {

        return points[i];
    }

    //distance to
    public double disTo(int v, int w) {
        return points[v].distanceTo(points[w]);
    }

    public Iterable<Edge> neighbor(int v) {
        return adj[v];
    }

    //main
    public static void main(String[] args) {
        In in = new In(args[0]);
        EuclideanGraph G = new EuclideanGraph(in);
        System.out.println(G);
    }

    public double disTo(EuclideanGraph point) {
        return 0;
    }
}


/* I have added and copied from  https://algs4.cs.princeton.edu
        and
        https://www.cs.umb.edu/cs310/. Aslo I have used  some google resources.

        */
