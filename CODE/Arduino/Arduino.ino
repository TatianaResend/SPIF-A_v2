/*
 * This code was developed by Walid Khaled - Nile University graduating student 2021 
 * It is used to run 6DOF Manipulator with gripper attached.
 * You could run from Arduino Serial Monitor; just type the angles and coordinated time e.. -90 0 90 10 20 30 5
 * Also, it could be run from MATLAB e.. [-90 0 90 10 20 30 5], [-90, 0, 90, 10, 20, 30, 5]
*/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <MultiStepper.h>
#include <AccelStepper.h>

// Definition of pins
// Pul & Dir
#define Pul_YZ1 2 
#define Dir_YZ1 3
#define Pul_YZ2 4 
#define Dir_YZ2 5

// Enable
#define Ena_YZ1 6
#define Ena_YZ2 7

// Pend & Alarm
#define Pend_YZ1 8
#define Alarm_YZ1 9
#define Pend_YZ2 10
#define Alarm_YZ2 11

//Stepper Motors Pin Configuration
AccelStepper motor_YZ1 (AccelStepper::DRIVER, Pul_YZ1, Dir_YZ1);     //PULSE Pin, Direction Pin , Stepper 1
AccelStepper motor_YZ2 (AccelStepper::DRIVER, Pul_YZ2, Dir_YZ2);     //PULSE Pin, Direction Pin , Stepper 2

// Create at instance of MultiStepper to coordinate the motors
MultiStepper multiStepper; // upt to 10 steppers we can use MultiStepper

//Driver Mode
int DPulsePerRev[] = {400, 400}; //MicroStepping mode 400 is half-step, 800 is quarter-step
int PulPerRev = 400;

//Set Positions for Motors
long positions[2]; //Array of desired stepper positions
long prev_positions[2]; //Array of previous stepper positions

//Set Speeds for Motors
float n = 120;
float MotorSpeeds[] = {((n/60)*DPulsePerRev[0]), ((n/60)*DPulsePerRev[1])};
float TimeTaken;
float Actual_MotorSpeeds[2];
float Actual_n_RPM[2];

//Set Limit Switches 
//long LSwitchS[6];
//int Lswitch1 = 14;
//int Lswitch2 = 15;
//int Lswitch3 = 16;
//int Lswitch4 = 17;
//int Lswitch5 = 18;
//int Lswitch6 = 19;

//Set Inputs 
String MATLABdata;
char *arr_char_strings[3];
char *ptr = NULL;
byte index;
String arr_strings[3];
float arr_input[3];

//Set Gripper
//#include <Servo.h>
//Servo myservo;  
int pos = 0;    

// variables
int vel = 1500;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(10);

  // Set the inicial speeds of the motors
  motor_YZ1.setSpeed(vel); 
  motor_YZ2.setSpeed(vel); 
  
  //Add the motors to the Multistepper instance
  multiStepper.addStepper(motor_YZ1);
  multiStepper.addStepper(motor_YZ2);

  //myservo.attach(A6); 
  
  pinMode(Pul_YZ1, OUTPUT);
  pinMode(Pul_YZ2, OUTPUT);
  pinMode(Dir_YZ1, OUTPUT);
  pinMode(Dir_YZ2, OUTPUT);
  
  pinMode(Ena_YZ1, OUTPUT);
  pinMode(Ena_YZ2, OUTPUT);
  
  pinMode(Pend_YZ1, INPUT);
  pinMode(Pend_YZ2, INPUT);
  pinMode(Alarm_YZ1, INPUT);
  pinMode(Alarm_YZ2, INPUT);
  
  digitalWrite(Ena_YZ1, LOW);
  digitalWrite(Ena_YZ2, LOW);
  
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void loop() {
  if (Serial.available() > 0){
    MATLABdata=Serial.readString();                      // read data as string.
    //Serial.println("Data Received");
    
    if (MATLABdata == "1"){
      //Serial.println("Homing ....");
      homing();
    }
    
    else if (MATLABdata == "2"){
      //Serial.println("Zero Postions ....");
      automatic();
    }
    
    else if (MATLABdata == "3"){
      Serial.println("Homing ....");
      homing();
    }

    else if (MATLABdata == "4"){
      Serial.println("CG End Position");
      zeros();
    }

    else if (MATLABdata == "5"){
      Serial.println("Gripper Open");
      open_gripper();
    }

    else if (MATLABdata == "6"){
      Serial.println("Gripper Close");
      close_gripper();
    }

    else{
      char buf[MATLABdata.length()+1];                   // length (with one extra character for the null terminator, a null character (ASCII code 0) to tell where the end of a string is).
      MATLABdata.toCharArray(buf,MATLABdata.length()+1); // Copy it over in buffer, sizeof (buf) = MATLABdata.length()+1.
  
      index = 0;                                         // define index.
      ptr = strtok(buf, " ");                            // tokenizing of a string using the strtok() function that returns a variable of type char separated based on a delimiter (" ").
      while(ptr != NULL){                                // iterate the list until it is empty.
        arr_char_strings[index] = ptr;                   // append in array of type char.
        //Serial.print("arr_char_strings: ");
        //Serial.println(ptr);
        index++;                                         // increment index by 1.
        ptr = strtok(NULL, " ");                         // takes a list of delimiters.
      }
      
      
      for (int r = 0; r < index; r++){
        arr_strings[r]=String(arr_char_strings[r]);      // convert from char to string type.
        arr_input[r]=arr_strings[r].toFloat();           // convert from string to float type.
      }

   
      moving();                                          // calling moving function (RUN).
      //Serial.println("moving");
    }                                           
  }    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void calibration() {
  Serial.println("Calibration");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void zeros() {
  Serial.println("zeros");
  //int angle1 = 45;
  //axis1.move(angle1);
  //axis1.runToPosition();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void homing() {
  Serial.println("Homing"); 
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void automatic() {
  Serial.println("automaic");
  // open the file
  //ifstream input(filename);
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void moving() {
  int angle1 = arr_input[0];
  int angle2 = arr_input[1];

 Serial.print("moving- angle1:");
 Serial.print(angle1);
 Serial.print(" angle2:");
 Serial.println(angle2);
 
 // Create an array of positions for the motors
 long positions[] = {angle1, angle2};
 //long positions[] = {90, 90};

 // Move the motors to the desired positions in a coordinated fashion
 multiStepper.moveTo(positions);

 // Execute the movements
 while (multiStepper.run()) {
    // Nothing to do here, just wait until the motors reach the desired positions
 }

   //motor_YZ1.move(angle1);
   //motor_YZ1.runToPosition();
 //  multiStepper.moveTo(positions);
 //  multiStepper.run();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void close_gripper() {
  Serial.println("close_gripper");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void open_gripper() {
  Serial.println("open_gripper");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
