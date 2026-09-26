package com.alzikrayat.util;

public class HtmlUtil {

    private HtmlUtil() {
        // Utility class - no objects needed
    }

    public static String escape(String text) {

        if (text == null) {
            return "";
        }

        return text
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
