package org.elasticsearchfr.jug;

import org.apache.log4j.Logger;
import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.common.io.FileSystemUtils;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.node.Node;

import java.io.File;
import java.io.IOException;

public class LaunchNode {
    private static final Logger logger = Logger.getLogger(LaunchNode.class);

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
        for (int i = 0; i < 10; i++) {
            // TODO Add nodes
        }

        // TODO Create a client Node
		node = null;

		// TODO Wait for healthy status

        logger.info("Start indexing");

        // TODO Prepare a Bulk
        BulkRequestBuilder brb = null;

        // TODO Let's index 10000 docs
        for (int i = 0; i < 10000; i++) {
            // TODO Add index operation to bulk
         }

        // TODO Execute the bulk

        logger.info("End of indexing");

		// Wait 10 minutes
        // TODO Uncomment when using 10 embedded nodes
		// Thread.sleep(10 * 60 * 1000);
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
