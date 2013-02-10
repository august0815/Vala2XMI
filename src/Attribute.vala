/*
* src/Attribute.vala
* Copyright (C) 2012, Mairo Marcec <mario.marce42@googlmail.com>
*
* Valama is free software: you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Valama is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
* See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
using GLib;
using Gee;

/**
 * Attribute /Variablen der Klasse
 */
public class Attribute : Object
{

	

  /**
   * Speichert DATATYP für umbrello
   */
  public string typ {get;set;}
   /**
   * Speichert orginal string , nötig für 2-ten Durchlauf
   */
  public string typ_org {get;set;}
    /**
   * IdentNR 
   */
  public string xmi_id {get;set;}
   /**
   * kann folgebde Zustände annehmen:
   * public,privat,protectet,implementation
   */
  public string visibility {get;set;} 
   /**
   * Ist eigentlich static
   */
  public bool statik {get;set;}
   /**
   * Name 
   */
  public string name {get;set;}
  
  /**
   * TODO: Add documentation here.
   */
  public Attribute(string  visibility,string name,string? xmi_id ,string typ,string typ_org){
		this. visibility= visibility;
		this.name=name;
		this.xmi_id=xmi_id;
		this.typ=typ;
		this.typ_org=typ_org;
		}


}

