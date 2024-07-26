package pa3;

/**
 * Skeleton Class for a Path in the Dynamic Programming sequence alignment algorithm
 */
public class Path {
    private int row, col;          // the row and column this node represents
    private int cost;              // the matching cost from this point on
    private Path next;             // the next node in the optimal path

    public Path(int e, int f) {
        row = e;
        col = f;
        this.cost = 0;
        next = null;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int c) {
        cost = c;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int r) {
        row = r + 6;
    }

    public int getCol() {
        return col + 2;
    }

    public void setCol(int c) {
        col = c;
    }

    public Path getNext() {
        return next;
    }

    public void setNext(Path p) {
        next = p;
    }


}
