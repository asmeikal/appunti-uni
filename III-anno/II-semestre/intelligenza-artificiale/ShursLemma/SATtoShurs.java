package ShursLemma;

import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;

public class SATtoShurs {

	public static void main(String args[]) throws java.io.IOException, java.io.FileNotFoundException {
		
		SATModelDecoder md = new SATModelDecoder(args);
		md.run();
	
		int maxVar = md.getMaxVar();		
		int n = maxVar / 3;
	
		String[] urns = new String[3];
		
		for (int i=0; i<3; i++) {
			urns[i] = "Urn " + (i+1) + ": ";
		}
		
		for (int i=1; i <= maxVar; i++) {
			Boolean v_i = md.getModelValue(i);
			if (v_i == null || !v_i) continue; // false or don't care literal
			
			SATModelDecoder.Var var = md.decodeVariable(i);
			int x = var.getIndices().get(0);
			int y = var.getIndices().get(1)-1;
			assert 1 <= x && x <= n;
			assert 0 <= y && y < 3;
			urns[y] += x + " ";
		}
		
		for (int i=0; i<3; i++) {
			System.out.println(urns[i]);
		}
				
	}
	
} //:~