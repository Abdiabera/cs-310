package pa3;
import java.util.*;
import java.io.*;
import java.io.FileNotFoundException;  // Import this class to handle errors

/**
 * Class to demonstrate Coin change DP algorithm
 */
public class Coins {
    // Can use a simple array if you want
    private ArrayList<Integer> denominations;
    private HashMap<Integer,Integer> coinTree;
    private int sum;
    
    public Coins(String s){
        denominations = new ArrayList<Integer>();
	coinTree = new HashMap<Integer,Integer>();
	try {
	  File f = new File(s);
          Scanner in = new Scanner(f);
          // First read sum
          sum = in.nextInt();
          while(in.hasNextInt()){
              int coin = in.nextInt();
              addDenomination(coin);
          } 
	}
	catch (FileNotFoundException e) {
           System.out.println("An error occurred.");
           e.printStackTrace();
      }
    }
    
    public ArrayList<Integer> getDenominations(){ return denominations; }

    public int getAmount() { return sum; }

    public void addDenomination(int coin) {
        int lastCoin;
        int sz = denominations.size();
        if(sz == 0)
            lastCoin=0;
        else {
            lastCoin = denominations.get(sz-1);
        }
        // Make sure denominations are sorted, optional
        if(coin < lastCoin) {
            System.out.println("Denominations not sorted!");
            System.exit(1);
        }
        denominations.add(coin);
    }
    
    // This function returns the minimum number of coins, not the coins themselves
    public int makeChange()
    {
        // What's the minimum number of coins for each number from 1 to sum.
        // We start from 0 so we need one more index
        int [] coinsUsed = new int[sum+1];
        // What was the last coin used, so we can retrieve the solution
        int [] lastCoin = new int[sum+1];
        coinsUsed[ 0 ] = 0; lastCoin[ 0 ] = 1;

        for( int cents = 1; cents <= sum; cents++ ){
            int minCoins = cents;
            int newCoin  = 1;

            int differentCoins = denominations.size();
            for( int j = 0; j < differentCoins; j++ ) {
                if( denominations.get(j) > cents )   // Cannot use coin j
                    continue;
                if( coinsUsed[ cents - denominations.get(j) ] + 1 < minCoins ) { // Found a better solution
                    minCoins = coinsUsed[ cents - denominations.get(j) ] + 1;
                    newCoin  = denominations.get(j);
                }
            }

            coinsUsed[ cents ] = minCoins; // Set minimum number of coins
            lastCoin[ cents ]  = newCoin; // Set last coin we used. 
        }
       // printCoins(sum, coinsUsed[sum], lastCoin);
	backtrack(sum, coinsUsed[sum], lastCoin);
	return coinsUsed[sum];
    }
    
    public void backtrack(int sum, int noCoins, int[] lastCoin)
    {
        // How many coins from each denomination. Tree Map to keep sorted
	// The reverse is because we go from large to small (optional)
        for(int i=0;i<denominations.size();i++) // Keeps track on how many coins each
            coinTree.put(denominations.get(i),0);
        // Backtrack
        int s = sum;
        while(s > 0) {
            int coin = lastCoin[s];
            int freq = coinTree.get(coin);
            coinTree.put(coin,freq+1);
            s -= coin;
        }
        // Print only non-zeros
   	//    for (Map.Entry<Integer,Integer> entry : howMany.entrySet()) {
        //    if(entry.getValue() > 0)
        //        System.out.println(entry.getKey() + " X " + entry.getValue() );
      //  }
	return;
    }
    
	// returns the amount of coins we use of a specific denomination
    public int howMany(int coin){
	Integer use = coinTree.get(coin);
	if(use != null)
		return use;
	return 0;
    }
 
    public void printSolution() {
	   System.out.println(sum + " " + denominations);
	   System.out.println("For " + sum + " We use " + makeChange() + " coins as follows:");
	   System.out.println(coinTree);
    }

    public static void main(String[] args)  {
        // Read coins from file
 	   Coins c = new Coins(args[0]);   
           int no_coins = c.makeChange();
	   c.printSolution();
    }
        
}
