package org.elasticsearchfr.jug;

import java.io.File;
import java.io.IOException;

import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.common.io.FileSystemUtils;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.node.Node;
import org.elasticsearch.node.NodeBuilder;

public class LaunchNode {
	protected static Node node;

	/**
	 * During the demo, we first build a client node and inject documents in the running cluster (4 nodes)
	 * Then we will create 10 nodes from the current jvm and generate more documents.
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// We remove old data before launching tests
		removeOldDataDir();
		
		// Let's generate 10 nodes (ignore it for the first time)
		
		// Create a client Node
		node = null;
		
		// Wait for healthy status
		
		// Let's index 10000 docs

		// Wait 10 minutes
		Thread.sleep(10 * 60 * 1000);
	}
	
	private static XContentBuilder jsonGenerator(int i, int j) {
		try {
			return XContentFactory.jsonBuilder()
				.startObject()
					.field("text","I'm the " + i + "th text entry of the " + j + "th iteration.")
				.endObject();
		} catch (IOException e) {
			System.err.println(e);
		}
		
		return null;
	}
	
	private static void removeOldDataDir() throws Exception {
		Settings settings = ImmutableSettings.settingsBuilder().loadFromClasspath("elasticsearch.yml").build();

		// First we delete old datas...
		File dataDir = new File(settings.get("path.data"));
		if (dataDir.exists()) {
			FileSystemUtils.deleteRecursively(dataDir, true);
		}
	}


}
