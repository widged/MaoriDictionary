package com.widged.io.service.test.comps
{
    import mx.containers.VBox;
    
    public class ServiceVBox extends VBox
    {
        public function ServiceVBox()
        {
            super();
            this.setStyle("backgroundColor", "#CCCCCC");
            this.setStyle("borderStyle", "solid");
            this.setStyle("cornerRadius", 5);
            this.setStyle("verticalGap", 10);
            this.setStyle("horizontalAlign", "right");
            this.setStyle("paddingLeft", 6);
            this.setStyle("paddingTop", 6);
            this.setStyle("paddingBottom", 6);
            this.setStyle("paddingRight", 6);
            this.percentHeight = 100;
            this.width = 375;
        }
    }
}