package com.rees.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class QueryLoader {
    private static Properties queries = new Properties();

    static {
        try (InputStream input = QueryLoader.class.getClassLoader().getResourceAsStream("queries.properties")) {
            if (input != null) {
                queries.load(input);
            } else {
                throw new RuntimeException("queries.properties not found");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getQuery(String key) {
        return queries.getProperty(key);
    }
}
