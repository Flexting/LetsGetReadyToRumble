
import java.awt.*;

class Config {
    // Window Settings
    int monitorWidth, monitorHeight, captureWidth, captureHeight, captureX, captureY;
    // Window Settings
   
    Config()
    {
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        monitorWidth = (int) screenSize.getWidth();
        monitorHeight = (int) screenSize.getHeight();
      
        captureWidth = monitorWidth/3;
        captureHeight = monitorHeight;
        captureX = monitorWidth/2 - captureWidth/2;
        captureY = monitorHeight/2 - captureHeight/2;
    }
   
}