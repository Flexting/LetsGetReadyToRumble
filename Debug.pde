import java.util.*;
import java.lang.*;

class Debug 
{
    ArrayList<String> tasks;
    ArrayList<Long> tasksDuration;
    
    Debug() {
        resetTracking();
    }
    
    void display() {
        stroke(100,100,100);
        int y = 0;
        fill(200, 100);
        rect(0, 0, 140, 85);
        
        fill(0);
        y += 16;
        text("FPS: " + floor(frameRate), 8, y);
        y += 16;
        text("Car Alignment: " + floor(car.carAlignment), 8, y);
        y += 16;
        text("Direction: " + car.movement.direction, 8, y);
        y += 16;
        text("Acceleration: " + car.movement.acceleration, 8, y);
        y += 16;
        text("Team: " + car.team, 8, y);
        
        drawPieChart();
        mouseColour();
    }
    
    void drawPieChart() {
        int x, y, w, h;
        float currentAngle = 0;
        long totalTime = 0;
        
        w = 100;
        h = 100;
        x = width - w;
        y = 0;
        
        fill(200, 200);
        rect(x, y, w, h + 200);
        
        
        stopTracking("Other");
        
        for (int i = 1; i < tasksDuration.size(); i++) {
            totalTime += tasksDuration.get(i);
            tasksDuration.set(0, tasksDuration.get(0) - tasksDuration.get(i));
        }
        totalTime += tasksDuration.get(0);
        
        colorMode(HSB, tasks.size(), 1, 1);
        for (int i = 0; i < tasks.size(); i++) {
            noStroke();
            fill(i, 1, 1);
            text(tasks.get(i) + ": " + (tasksDuration.get(i)), x, y + h + 24 * (i+1));   
            arc(x + w/2, y + h/2, w, h, currentAngle, currentAngle + (TWO_PI * tasksDuration.get(i)/totalTime)); 
            currentAngle = currentAngle + (TWO_PI * tasksDuration.get(i)/totalTime);
        }
        
        colorMode(RGB, 255, 255, 255);
        debug.resetTracking();
    }
    
    void resetTracking() {
        tasks = new ArrayList<String>();
        tasksDuration = new ArrayList<Long>();
        
        // Calculates all the 'Other' processes not being tracked individually
        startTracking("Other");
    }
    
    // Start tracking a given task by recording the name and start time
    void startTracking(String task) {
        tasks.add(task);
        tasksDuration.add(System.currentTimeMillis());
    }
    
    // Stop tracking a given task and calculate the duration of the task
    void stopTracking(String task) {
        int index = tasks.indexOf(task);
        long startTime;
        
        startTime = tasksDuration.get(index);
        tasksDuration.set(index, System.currentTimeMillis() - startTime);
    }
    
    void mouseColour() {
        float x, y, w, h;
        color colour;
        
        w = 50;
        h = 100;
        x = width - 100 - w;
        y = 0;
        
        colour = capture.pixels[mouseX + mouseY * config.captureWidth];
        
        fill(colour);
        rect(x, y, w, h);
        String text = "R: " + floor(red(colour)) +
                        "\nG: " + floor(green(colour)) + 
                        "\nB: " + floor(blue(colour)) +
                        "\nH: " + floor(hue(colour)) +
                        "\nS: " + floor(saturation(colour)) +
                        "\nB: " + floor(brightness(colour));
        fill(255/2+hue(colour));
        text(text, x + 4, y + 16);
        
    }
}