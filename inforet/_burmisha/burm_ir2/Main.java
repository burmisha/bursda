import java.io.BufferedReader;
import java.io.FileReader;
import java.io.PrintWriter;

public class Main {

public static void main(String[] args) {
        try {
            KrovetzStemmer stemmer = new KrovetzStemmer();
            BufferedReader br = new BufferedReader(new FileReader("eng_words.txt"));
            PrintWriter writer = new PrintWriter("both_stemmers.txt", "UTF-8");
            String line;
            while ((line = br.readLine()) != null) {
                writer.println(line + '\t' + stemmer.stem(line.split("\t")[0], true));
            }
            br.close();
            writer.close();
//            String ret = stemmer.stem("internationalization", true);
//            System.out.println(ret);
        } catch (Exception e) {
                e.printStackTrace();
        }
    }
}
