package pa1;

import edu.princeton.cs.algs4.*;

import java.io.File;


public class TestPerf {

    // we have to define the four tables
    private ST<String, Integer> sm;
    private SeparateChainingHashST<String, Integer> sepch;
    private LinearProbingHashST<String, Integer> lpro;
    private SequentialSearchST<String, Integer> seqs;
    private long symTime, sepTime, lTime, SeqTime;


    public TestPerf(String filename) {
//this is used to read a file and build table

        sm = new ST<>();
        sepch = new SeparateChainingHashST<>();
        seqs = new SequentialSearchST<String, Integer>();
        lpro = new LinearProbingHashST<String, Integer>();
        File file = new File(filename);
        In in = new In(file);


        String[] words = in.readAllStrings();
        symTime = buildTable1(sm, words);
        sepTime = buildTableSCHT(sepch, words);
        lTime = buildTable3(lpro, words);
        SeqTime = buildTable2(seqs, words);
    }


    // then we have to build the symboll table
    private <T extends ST<String, Integer>> long buildTable1(T sm, String[] words) {
        long startingTime = System.currentTimeMillis();
        for (String word : words) {

            if (!sm.contains(word)) sm.put(word, 1);


            else
                sm.put(word, sm.get(word) + 1);
        }
        //this substruct the start time
        return (System.currentTimeMillis() - startingTime);


    }

    //then we have to build the sequencialSearch table
    private <T extends SequentialSearchST<String, Integer>
            > long buildTable2(T sm, String[] words) {
        long startingTime = System.currentTimeMillis();
        for (String word : words) {

            if (!sm.contains(word)) sm.put(word, 1);


            else
                sm.put(word, sm.get(word) + 1);
        }
        //this use to substruct the endtime and start time
        return (System.currentTimeMillis() - startingTime);


    }


    //then we have to build the separatechain table
    private <T extends SeparateChainingHashST<String, Integer>
            > long buildTableSCHT(T sm, String[] words) {
        long startingTime = System.currentTimeMillis();
        for (String word : words) {

            if (!sm.contains(word)) sm.put(word, 1);


            else
                sm.put(word, sm.get(word) + 1);
        }
        //this substruct the start time
        return (System.currentTimeMillis() - startingTime);


    }


    //then we have to build the linearSearch table
    private <T extends LinearProbingHashST<String, Integer>
            > long buildTable3(T sm, String[] words) {
        long staringtTime = System.currentTimeMillis();
        for (String word : words) {

            if (!sm.contains(word)) sm.put(word, 1);


            else
                sm.put(word, sm.get(word) + 1);
        }
        //this substruct the start time
        return (System.currentTimeMillis() - staringtTime);


    }
    //we have to return the total number of words which in file

    public int getTotalWords() {

        int c = 0;

        for (String key : sm.keys()) {
            c += sm.get(key);

        }
        return c;

    }

    public int getUniqueWords() {
        return sm.size();
    }

    //this will return the most used words
    public String getMostUsedWord() {

        String maximumKey = "";
        int maximumValue = Integer.MIN_VALUE;
        for (String key : sm.keys()) {
            if (sm.get(key) > maximumValue) {
                maximumKey = key;
                maximumValue = sm.get(key);

            }

        }


        return maximumKey;


    }

    //this will itreturns the maximum occurence
    public int getMaxOccurrence() {

        int maximumValue = Integer.MIN_VALUE;
        for (String key : sm.keys()) {
            if (sm.get(key) > maximumValue) {
                maximumValue = sm.get(key);


            }


        }


        return maximumValue;


    }

    // This prints the output
    public void printStats() {

        System.out.println(symTime);
        System.out.println(sepTime);
        System.out.println(lTime);
        System.out.println(SeqTime);
        System.out.println(getTotalWords());
        System.out.println(getUniqueWords());
        System.out.println(getMostUsedWord() + " " + getMaxOccurrence());

    }

    //main function
    public static void main(String[] args) {

        TestPerf test = new TestPerf(args[0]);


        test.printStats();
    }

}


//source: https://algs4.cs.princeton.edu/code/edu/princeton/cs/algs4/LinearProbingHashST.java




