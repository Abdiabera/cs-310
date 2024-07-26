package pa2;

import edu.princeton.cs.algs4.*;

// A* algorithm
public class AStar {

    private int h; // Regular dijkstra or A*
    private double[] distTo;
    private Edge[] edgeTo;
    private IndexMinPQ<Double> pq;
    private double threshold = 0.0001;
    private EuclideanGraph G;


    /**
     * Computes a shortest-paths tree from the source vertex {@code s} to every
     * other vertex in the edge-weighted graph {@code G}.
     * <p>
     * param G the edge-weighted digraph
     *
     * @param s the source vertex, t is target
     * @throws IllegalArgumentException if an edge weight is negative
     * @throws IllegalArgumentException unless {@code 0 <= s < V}
     */
    public AStar(String s, int h) {

        In in = new In(s);
        G = new EuclideanGraph(in);

        distTo = new double[G.V()];
        this.h = h;
        pq = new IndexMinPQ<Double>(G.V());

    }

    private void addVertextQueue(int v, double p) {

        pq.insert(v, p);

    }

    private void decreevertex(int v, double p) {
        pq.decreaseKey(v, p);

    }

    // Reset dists for new query
    public void reset() {

        for (int v = 0; v < distTo.length; v++) {
            distTo[v] = Double.POSITIVE_INFINITY;
            edgeTo = new Edge[G.V()];


        }
        pq = new IndexMinPQ<Double>(G.V());


    }


    // Perform a query on specific start and target nodes
    public int route(int s, int t) {
        reset();

        pq.insert(s, distTo[s] + h(G, s, t));
        distTo[s] = 0.0;


        while (!pq.isEmpty()) {
            int v = pq.delMin();
            if (v == t) {
                break;

            }
            for (Edge e : G.neighbor(v)) {
                relax(e, t);

            }
        }

        return -1;
    }


    // relax class
    private void relax(Edge e, int t) {

        int v = e.either(), w = e.other(v);
        double weight = e.weight();
        double priority = distTo[v] + weight + h(G, w, t);

        if (distTo[w] - distTo[v] - e.weight() > threshold) {
            distTo[w] = priority;
            edgeTo[w] = e;
            if (pq.contains(w)) {
                decreevertex(w, distTo[w]);
            } else {
                pq.insert(w, distTo[w]);


            }
        }
    }


    // The function to  search
    private double heuristic(EuclideanGraph G, int v, int w) {


        return G.disTo(v, w);
    }

    //the distance
    private double h(EuclideanGraph G, int v, int w) {

        if (h == 0) {
            return 0.0;

        } else if (h == 1) {

            return G.disTo(v, w);

        } else {
            return -1;

        }
    }

    /**
     * Returns the length of a shortest path between the source vertex {@code s} and
     * vertex {@code v}.
     *
     * @param v the destination vertex
     * @return the length of a shortest path between the source vertex {@code s} and
     * the vertex {@code v}; {@code Double.POSITIVE_INFINITY} if no such path
     * @throws IllegalArgumentException unless {@code 0 <= v < V}
     */
    public double distTo(int v) {

        return distTo[v];
    }

    /**
     * Returns true if there is a path between the source vertex {@code s} and
     * vertex {@code v}.
     *
     * @param v the destination vertex
     * @return {@code true} if there is a path between the source vertex
     * {@code s} to vertex {@code v}; {@code false} otherwise
     * @throws IllegalArgumentException unless {@code 0 <= v < V}
     */
    public boolean hasPathTo(int v) {
        return distTo[v] < Double.POSITIVE_INFINITY;

    }

    /**
     * Returns a shortest path between the source vertex {@code s} and vertex {@code v}.
     *
     * @param v the destination vertex
     * @return a shortest path between the source vertex {@code s} and vertex {@code v};
     * {@code null} if no such path
     * @throws IllegalArgumentException unless {@code 0 <= v < V}
     */
    public Iterable<Edge> pathTo(int v) {

        Stack<Edge> path = new Stack<Edge>();

        return path;
    }

    // check optimality conditions:
    // (i) for all edges e = v-w:            distTo[w] <= distTo[v] + e.weight()
    // (ii) for all edge e = v-w on the SPT: distTo[w] == distTo[v] + e.weight()
    private boolean check(EuclideanGraph G, int s) {

        return false;
    }


    // Main testing
    public static void main(String[] args) {
        // Build the graph
        int heuristic = Integer.parseInt(args[2]);
        AStar sp = new AStar(args[0], heuristic);
        In paths = new In(args[1]);
        // Now run queries
        int processed = 0;
        long startTime = System.currentTimeMillis();
        while (!paths.isEmpty()) {
            int s = paths.readInt();
            int t = paths.readInt();
            StdOut.println(s + " " + t);

            processed = sp.route(s, t);
            if (sp.hasPathTo(t)) {
                StdOut.printf("Printing path! %d to %d (%.2f)  ", s, t, sp.distTo(t));
                for (Edge e : sp.pathTo(t)) {
                    StdOut.println(e + "   ");
                }
                StdOut.println();
            } else {
                StdOut.printf("%d to %d         no path\n", s, t);
            }
            sp.reset();
            StdOut.println("Processed " + processed);
        }
        long endTime = System.currentTimeMillis();
        long tm = endTime - startTime;
        StdOut.println(tm);
    }

}


/* I have added and copied from  https://algs4.cs.princeton.edu/44sp/DijkstraSP.java
and from class https://www.cs.umb.edu/cs310/
*/
