/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.uprm.gaming.graphic.nifty.controls;
/**
 *
 * @author David
 */
public class ListBoxMessages_Assembly {
    private String part;
    private String value;
    
    public ListBoxMessages_Assembly(final String part, final String value){
        this.part = part;
        this.value = value;
    }
    
    public String getPart() {
        return  part;
    }
    
    public String getValue() {
        return  value;
    }
}
