import java.io {
	File,
	FileWriter,
	FileInputStream
}
import org.antlr.v4.runtime {
	ANTLRInputStream,
	CommonTokenStream,
	ParserRuleContext
}

"Converts the given Java file to Ceylon."
shared void convert(String? sourceFile, String? targetFile, Boolean transformGetters = false,
	 Boolean useValues = false) {
	
	File f = File(sourceFile);
	
	ANTLRInputStream input = ANTLRInputStream(FileInputStream(f));
	Java8Lexer lexer = Java8Lexer(input);
	CommonTokenStream tokens = CommonTokenStream(lexer);
	Java8Parser parser = Java8Parser(tokens);
	
	ParserRuleContext tree = parser.compilationUnit();
	
	FileWriter fw = FileWriter(File(targetFile));
	
	ScopeTree scopeTree = ScopeTree();
	
	tree.accept(scopeTree);
	
	JavaToCeylonConverter converter = JavaToCeylonConverter(fw, transformGetters, useValues, scopeTree);
	
	tree.accept(converter);
	
	fw.flush();
	fw.close();
}

"Run the module `com.redhat.ceylon.converter`."
shared void run() {
	if (process.arguments.size == 2) {
		convert(process.arguments[0], process.arguments[1]);
	} else {
		print("Wrong options. Try `ceylon convert --help` for help.");
	}
}
