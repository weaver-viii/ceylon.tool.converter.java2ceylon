package com.redhat.ceylon.test;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

import com.redhat.ceylon.converter.Main;

public class VariableDeclarationTest {
	String workingDir = System.getProperty("user.dir");
	String testFile = workingDir + "/src/test/java/com/redhat/ceylon/testFiles/";
	String convertedFile = "src/test/java/com/redhat/ceylon/testFiles/testConvertedFile.ceylon";
	File file1 = new File(convertedFile);
	String ceylonFile = "src/test/java/com/redhat/ceylon/testFiles/";

	// Test for multiple line variable declaration
	@Test
	public void testVariableDeclarationTest() throws IOException {
		Main.main(new String[] { testFile + "TestVariableDeclaration.java", convertedFile });
		File file2 = new File(ceylonFile + "testVariableDeclaration.ceylon");
		assertTrue("Variable Declaration test failed", FileUtils.contentEquals(file1, file2));
	}
}