/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.models
{
   public class ValueObject
   {
      public function ValueObject()
      {
      }

      public function serialize(title:String, props:Array):String
      {
         var arr:Array = [];
         for (var i:int = 0; i < props.length; i++)
         {
            var prop:String = props[i];
            if(!this.hasOwnProperty(prop)) {arr.push(prop + ": [n/a]"); continue; }
            arr.push(prop + ": " + this[prop]);
         }
         return "[" + title + "] {" + arr.join(", ") + "}";
      }

   }
}