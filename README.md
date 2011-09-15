MaoriDictionary
=====================================================

Author: Marielle Lange
Version: 0.1.1

Copyright 2010 Marielle Lange
Dual licensed under MIT and GPL

Description
-----------

A port to small screen Mobile devices of Herbert Willliams' Dictionary of the Maori Language, published by  [NZETC](http://www.nzetc.org/tm/scholarly/tei-WillDict.html "NZETC") under a Creative Commons Attribution-Share Alike 3.0 New Zealand Licence.


Requirements
-------------

Code written in Flex. The easiest way to run it is by using Flash Builder, a paying IDE provided by Adobe. There is a free 30 day trial version available. 

Flex is open source. It is possible to package AIR applications for Android from the command line ([commandLine](http://help.adobe.com/en_US/air/build/WS901d38e593cd1bac25d3d8c712b2d86751e-8000.html "Creating an Air application from the command line").

If using Flash Builder, use project import on ``MaoriDictMobile.fxp``.

Content
--------

Two applications are available in the archive. 

``MaoriDictParser`` is a small utility to convert some random xml file that contains data entries that can be isolated into fields (as columns in a database) into other formats (tabbed, JSON, SQLlite). See ``maoriDictionary.dictionary.parser.WilliamDictParser`` for parsing the original TIE.xml and ``maoriDictionary.dictionary.parser.WilliamXmlParser`` for parsing the reworked one. It is ultimately used to convert the xml data into a SQLlite datbase. 

``MaoriDict`` is a mobile application for browsing the dictionary. It reads the data from the SQLlite database at runtime.

TODO
-----

``etc/xml/maori_dict.xml`` needs further proof checking to ensure that all items are marked fully and correctly. A lot of the transformation from print rendering markup to linguistically meaningful one has been automated using regular expressions but it cannot detect all Maori words and sentences correctly. Easiest way to get this done is to use the TextMate DictMaori Bundle, available in the "tools" folder.

``MaoriDict`` was implemented using views, as recommended. However, views are managed by saving any data in a cache and destroying and reinstantiating the visual display component any time a new view is navigated. This causes a real delay for the dictionary view. It would be better to use popup panels instead of view navigation for the display of the WordItems. 

