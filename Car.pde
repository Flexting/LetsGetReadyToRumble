class Car {

    Movement movement;
    boolean autonomous;
    
    float carAlignment = 0;
  
    Car() {
        movement = new Movement();
        autonomous = false;
    }
    
    void toggleAutonomous() {
        autonomous = !autonomous;
        println("Toggled autonomous, now: " + autonomous);
    }
    
    void setAutonomous(boolean auto) {
        autonomous = auto;
    }
  
    void drive() {
        if (autonomous)
            movement.drive(carAlignment);
    }
}