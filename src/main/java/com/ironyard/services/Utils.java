package com.ironyard.services;

/**
 * Created by wailm.yousif on 2/14/17.
 */
public class Utils
{
    public static String getFileNameWithoutExtension(String fileName)
    {
        String[] strArr = fileName.split("\\.");
        String fileNameWithoutExt = "";

        System.out.println("strArr.length=" + strArr.length + "#");
        if (strArr.length < 2)
        {
            fileNameWithoutExt = fileName;
        }
        else
        {
            int lastIdx = fileName.lastIndexOf(strArr[strArr.length-1]);
            fileNameWithoutExt = fileName.substring(0, lastIdx-1);
        }

        return fileNameWithoutExt;
    }
}
