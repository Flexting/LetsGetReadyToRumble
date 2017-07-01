import java.awt.Robot;
import java.awt.event.KeyEvent;

class Movement
{
   int interval = 0, intervalMod = 5, safeDriveAngle = 10;
   boolean forward, left, right;
   
   Movement()
   {
      forward = false;
   }
   
   void drive(float direction) {
      
      if (interval < intervalMod) {
         if (direction > -50 && direction < 50) {
            setForward(true);
            
            if (direction > safeDriveAngle) 
               setTurnLeft(true);
            else
               setTurnLeft(false);
               
            if (direction < -safeDriveAngle) 
               setTurnRight(true);
            else
               setTurnRight(false);
            
         } else {
            setForward(false);
         }
      
      }
      interval %= intervalMod*2;
   }
   
   void setForward(boolean value) {
      if (value != forward) {
         forward(value);
         forward = value;
      }
   }
   
   void setTurnLeft(boolean value) {
      if (value != left) {
         turnLeft(value);
         left = value;
      }
   }
   
   void setTurnRight(boolean value) {
      if (value != right) {
         turnRight(value);
         right = value;
      }
   }
   
   void forward(boolean value)
   {
      try {
         Robot robot = new Robot();
         // Simulate a key press
         if (value)
            robot.keyPress(KeyEvent.VK_W);
         else
            robot.keyRelease(KeyEvent.VK_W);
      } catch (Exception e) {
         e.printStackTrace();
      } 
   }
   
   void turnLeft(boolean value)
   {
      try {
         Robot robot = new Robot();
         // Simulate a key press
         if (value)
            robot.keyPress(KeyEvent.VK_A);
         else
            robot.keyRelease(KeyEvent.VK_A);
      } catch (Exception e) {
         e.printStackTrace();
      } 
   }
   
   void turnRight(boolean value)
   {
      try {
         Robot robot = new Robot();
         // Simulate a key press
         if (value)
            robot.keyPress(KeyEvent.VK_D);
         else
            robot.keyRelease(KeyEvent.VK_D);
      } catch (Exception e) {
         e.printStackTrace();
      } 
   }
}