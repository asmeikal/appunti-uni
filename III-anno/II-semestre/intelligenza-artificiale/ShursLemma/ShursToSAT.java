package ShursLemma;

import it.uniroma1.di.tmancini.utils.*;
import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;
import java.util.*;

public class ShursToSAT {

	public static void main(String args[]) {
		
				
		// Defines the allowed/requested command-line options and flags
		CmdLineOptions clo = new CmdLineOptions("ShursToSAT",
				"2016-04-06",
				"Michele Laurenti",
				"SAT encoder for homework E.A.6.5"
			);
		
		// Second argument = true iff the option is mandatory. Default: false.
		clo.addOption("n", "Number of balls", true);
		clo.addOption("o", "The name of the output DIMACS file");
		clo.addFlag("debug", "Enable debug mode: output will NOT be in DIMACS format");
		
		// Parses the command-line arguments. It raises an error in case mandatory options are not given
		clo.parse(args);
		
		// Gets the value of an option
		int n = Integer.parseInt(clo.getOptionValue("n"));
		
		// Creates the encoder
		SATEncoder enc = new SATEncoder("ShursLemma (n=" + n + ")", clo.getOptionValue("o"));
		
		if (clo.isFlagSet("debug")) {
			enc.enableDebugMode(); // Enables debug mode: output is not in DIMACS format
		}
		
		// Defines integer ranges 1..n and 1..3
		IntRange ballsRange = new IntRange("ball", 1, n);
		IntRange urnsRange = new IntRange("urn", 1, 3);
		
		RangeProduct ballUrnRange = new RangeProduct("ballInUrn", ballsRange, urnsRange);
		
		// Defines the family of variables U_{i,j} with i ranging over 1..n and j in 1..3
		enc.defineFamilyOfVariables("U", ballsRange, urnsRange );	
	
		// Defines problem constraints:
		List<Integer> tuple = null;
		Iterator<List<Integer>> it = null;
		
		// 1. Each ball in exactly one urn
		for(int x : ballsRange.values()) {
			enc.addComment("Put in at least an urn ball " + x);
			for(int y : urnsRange.values()) {
				enc.addToClause("U", x, y);
			}
			enc.endClause();
			
			enc.addComment("Don't put in more than one urn ball " + x);
			it = ballUrnRange.iterator(RangeProduct.FILTER.ALLDIFF_ORDERED);
			while (it.hasNext()) {
				tuple = it.next();
				enc.addNegToClause("U", x, tuple.get(0));
				enc.addNegToClause("U", x, tuple.get(1));
				enc.endClause();
			}
		}
		
		// 2. Urn property: forall i, j in 1..N if U_{i, k} and U_{j, k} -> not U_{i+j, k}
		for(int y : urnsRange.values()) {
			for(int i : ballsRange.values()) {
				for (int j : ballsRange.values()) {
					if (i + j <= n) {
						enc.addComment("Property in urn " + y + " for balls " + i + " and " + j);
						enc.addNegToClause("U", i, y);
						enc.addNegToClause("U", j, y);
						enc.addNegToClause("U", i+j, y);
						enc.endClause();
					}
				}
			}
		}
		
		// Finalizes everything, frees-up temp memory and closes the output file.
		enc.end();
	}


} //:~