package pa1;

import java.util.LinkedList;
import java.util.Queue;

public class LinearProbingHashST2<Key, Value> {
    /**
     * Initializes an empty symbol table.
     */
// must be a power of 2
    private static final int INIT_CAPACITY = 4;

    private int n;           // number of key-value pairs in the symbol table
    private int m;           // size of linear probing table
    private Key[] keys;      // the keys
    private Value[] vals;
    private boolean[] active;    //this is the active key


    public LinearProbingHashST2() {
        this(INIT_CAPACITY);


    }

    public LinearProbingHashST2(int capacity) {
        m = capacity;
        n = 0;
        keys = (Key[]) new Object[m];
        vals = (Value[]) new Object[m];


    }

    public int size() {

        return n;
    }


    public boolean isEmpty() {

        return size() == 0;
    }

    public int numberOfOverallKeys() {

        return n;
    }

    private int hash(Key key) {
        return (key.hashCode() & 0x7fffffff) % m;
    }

    // resize the hash table to have the given number of chains,
    // rehashing  keys
    private void resize(int capacity) {
        LinearProbingHashST2<Key, Value> Ab = new LinearProbingHashST2<>(capacity);
        for (int i = 0; i < m; i++) {
            if (keys[i] != null) {
                //this will insert only active object
                Ab.put(keys[i], vals[i]);
            }
        }
        keys = Ab.keys;
        vals = Ab.vals;
        m = Ab.m;
    }

    // hash function for keys - returns value between 0 and m-1

    // hash function for keys - returns value between 0 and m-1 (assumes m is a power of 2)
    // (from Java 7 implementation, protects against poor quality hashCode() implementations)
    /*private int hashTextbook(Key key) {
        int h = key.hashCode();
        h ^= (h >>> 20) ^ (h >>> 12) ^ (h >>> 7) ^ (h >>> 4);
        return h & (m - 1);
    }*/
    // hash function for keys - returns value between 0 and m-1

    public void put(Key key, Value val) {
        if (key == null) throw new IllegalArgumentException("first argument to put() is null");

        if (val == null) {
            delete(key);
            return;
        }

        // double table size if 50% full
        if (n >= m / 2) resize(2 * m);

        int i;
        for (i = hash(key); keys[i] != null; i = (i + 1) % m) {
            if (keys[i].equals(key)) {
                vals[i] = val;
                return;
            }
        }
        keys[i] = key;
        vals[i] = val;
        n++;
    }


    public Value get(Key key) {
        if (key == null) throw new IllegalArgumentException("argument to get() is null");
        for (int i = hash(key); keys[i] != null; i = (i + 1) % m)
            if (keys[i].equals(key))
                return vals[i];

        return null;
    }

    public boolean contains(Key key) {
        if (key == null) throw new IllegalArgumentException("argument to contains() is null");
        return get(key) != null;
    }

    private boolean check() {

        // check that hash table is at most 50% full
        if (m < 2 * n) {
            System.err.println("Hash table size m = " + m + "; array size n = " + n);
            return false;
        }

        // check that each key in table can be found by get()
        for (int i = 0; i < m; i++) {
            if (keys[i] == null) continue;
            else if (get(keys[i]) != vals[i]) {
                System.err.println("get[" + keys[i] + "] = " + get(keys[i]) + "; vals[i] = " + vals[i]);
                return false;
            }
        }
        return true;
    }


    public void delete(Key key) {

        if (key == null) throw new IllegalArgumentException("argument to delete() is null");
        if (!contains(key)) return;

        // find position i of key
        int i = hash(key);
        while (!key.equals(keys[i])) {
            i = (i + 1) % m;
        }

        // delete key and associated value
        keys[i] = null;
        vals[i] = null;

        // rehash all keys in same cluster
        i = (i + 1) % m;
        while (keys[i] != null) {
            // delete keys[i] and vals[i] and reinsert
            Key keyToRehash = keys[i];
            Value valToRehash = vals[i];
            keys[i] = null;
            vals[i] = null;
            n--;
            put(keyToRehash, valToRehash);
            i = (i + 1) % m;
        }

        n--;

        // halves size of array if it's 12.5% full or less
        if (n > 0 && n <= m / 8) resize(m / 2);

        assert check();
    }

    public Iterable<Key> keys() {
        Queue<Key> queue = new LinkedList<>();
        for (int i = 0; i < m; i++)
            if (keys[i] != null) queue.offer(keys[i]);
        return queue;
    }

    public int tableSize() {
        return m;
    }
}


//source: https://algs4.cs.princeton.edu/code/edu/princeton/cs/algs4/LinearProbingHashST.java
// I used and copied in a given function from the above website.
