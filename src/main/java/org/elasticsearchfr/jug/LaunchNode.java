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
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// We remove old data before launching tests
		removeOldDataDir();
		
		// Let's generate some nodes
		for (int i = 0; i < 10; i++) {
			NodeBuilder.nodeBuilder().node();
		}
		
		Node node = NodeBuilder.nodeBuilder().client(true).node();
		node.client().admin().cluster().prepareHealth()
				.setWaitForYellowStatus().execute().actionGet();
		
		// Let's index some docs
		String source = null;
		BulkRequestBuilder brb = null;
		
		for (int j = 0; j < 30; j++) {
			brb = node.client().prepareBulk();
			for (int i = 0; i < 10000; i++) {
				source = jsonGenerator(i,j).string();
				brb.add(new IndexRequest("montpellier", "jug", "talk_"+j+"_"+i).source(source));
			}
			brb.execute().actionGet();
		}
		
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
