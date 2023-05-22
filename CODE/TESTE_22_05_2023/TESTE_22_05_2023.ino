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
MultiStepper YZaxis; // upt to 10 steppers we can use MultiStepper

//Driver Mode: like all drives, just a common variable for all
int PulPerRev = 400;
float ConvPul = 1.11; // PulPerRev/360;

//Set Positions for Motors
long positions[2]; //Array of desired stepper positions
long prev_positions[2]; //Array of previous stepper positions

//Set Speeds for Motors
int MAX_SPEED = 1000;
int ACCELERATION = 500;

//Set Inputs
String MATLABdata;
char *arr_char_strings[3];
char *ptr = NULL;
byte index;
String arr_strings[3];
float arr_input[3];

//start functions
void CinInv(long coordY_CI, long coordZ_CI);
void homing();
void automatic();
void moving();

int angle1 = 0;
int angle2 = 0;

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(10);

  pinMode(Pul_YZ1, OUTPUT);
  pinMode(Pul_YZ2, OUTPUT);
  pinMode(Dir_YZ1, OUTPUT);
  pinMode(Dir_YZ2, OUTPUT);

  // Initialize enable pin of the drivers as output
  pinMode(Ena_YZ1, OUTPUT);
  pinMode(Ena_YZ2, OUTPUT);
  digitalWrite(Ena_YZ1, LOW); // Start with motors enabled
  digitalWrite(Ena_YZ2, LOW); // Start with motors enabled

  // Set the inicial speeds and acceleration of the motors
  motor_YZ1.setMaxSpeed(MAX_SPEED);
  motor_YZ1.setAcceleration(ACCELERATION);
  motor_YZ2.setMaxSpeed(MAX_SPEED);
  motor_YZ2.setAcceleration(ACCELERATION);

  //Add the motors to the Multistepper instance
  YZaxis.addStepper(motor_YZ1);
  YZaxis.addStepper(motor_YZ2);

}


void loop() {

    if (Serial.available() > 0){
     MATLABdata=Serial.readString();                      // read data as string.

     if (MATLABdata == "1"){
       homing();
     }

     else if (MATLABdata == "2"){
       automatic();
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
    }
  }
}


// ################################################################################################################################################################
// Function Homing
// ################################################################################################################################################################
void homing() {
  Serial.println("Homing");
}

// ################################################################################################################################################################
// Function Automatic
// ################################################################################################################################################################
void automatic() {
  Serial.println("automaic");
  // open the file
  //ifstream input(filename);
}

// ################################################################################################################################################################
// Function Moving
// ################################################################################################################################################################
void moving() {
  int coordX = arr_input[0];
  int coordY = arr_input[1];
  int coordZ = arr_input[2];
  // int coordX = 10;
  // int coordY = -73;
  // int coordZ = 250;

  static int realPosY = 0;
  static int realPosZ = 150;
  double alphaRAD = 0.00;
  double dist = 0.00;
  int inc = 0;
  double DeltaS = 5;
  long PrevPosY;
  long PrevPosZ;

  float yy = coordY - realPosY; //YF - Y0
  float zz = coordZ - realPosZ; //ZF - Z0

  if (yy != 0 || zz != 0) {
    dist = sqrt((pow(coordY - realPosY, 2)) + (pow(coordZ - realPosZ, 2))); //length of displacement vector
    //Change angle according to forward or retreat
    if (coordY > realPosY) {
      alphaRAD = atan((zz) / (yy)); //displacement vector angle
    } else {
      alphaRAD = atan((zz) / (yy)) + PI; //displacement vector angle + PI
    }

    inc = round(dist / DeltaS);

    for (int i = 0; i <= (inc); i++) {
      if (i < inc) {
        PrevPosY =  realPosY + (i * DeltaS * cos(alphaRAD)); //New position Y
        PrevPosZ =  realPosZ + (i * DeltaS * sin(alphaRAD)); //New position Z
      } else {
        PrevPosY = coordY;
        PrevPosZ = coordZ;
      }
      
      CinInv(PrevPosY, PrevPosZ);

      // Create an array of positions for the motors
      //long positions[] = {angle1, angle2};
      //long positions[] = {90, 90};
      
      // Move the motors to the desired positions in a coordinated fashion
      //multiStepper.moveTo(positions);
      motor_YZ1.moveTo(angle1);


      // Wait until the stepper motor has reached the position
      while (motor_YZ1.distanceToGo() != 0) {
        motor_YZ1.runSpeedToPosition();
      }
      // Execute the movements
      //while (multiStepper.run()) {
      // Nothing to do here, just wait until the motors reach the desired positions
      //}
    }
    realPosY = coordY;
    realPosZ = coordZ;
  }
}


// ################################################################################################################################################################
// Function Inverse Kinematics
// ################################################################################################################################################################
void CinInv (long coordY, long coordZ) {

  // Constants
  int L1 = 120; // upper arm length (equal to L4)
  int L2 = 150; // lower arm length (equal to L3)
  int L5 = 50;  // distance between motors
  int L6 = 50;

  // common to both sigmas
  float A = pow(coordY, 2) + pow(coordZ, 2) + pow(L1, 2) - pow(L2, 2) + 0.25 * pow(L5, 2) + 0.25 * pow(L6, 2);
  float C = -2 * coordZ * L1;
  
  // sigma1
  float B_t1 = 2 * coordY * L1 + L1 * L5 - L1 * L6;
  float D_t1 = coordY * L5 - coordY * L6 - 0.5 * L5 * L6;
  float sigma1 = (-B_t1 + sqrtf(pow(B_t1, 2) - (A - C + D_t1) * (A + C + D_t1))) / (A - C + D_t1);
 
  // sigma2
  float B_t2 = -2 * coordY * L1 + L1 * L5 - L1 * L6;
  float D_t2 = -coordY * L5 + coordY * L6 - 0.5 * L5 * L6;
  float sigma2 = (-B_t2 + sqrtf(pow(B_t2, 2) - (A - C + D_t2) * (A + C + D_t2))) / (A - C + D_t2);
  
  // thetas
  float theta1 = 2 * atan(sigma1);
  float theta2 = 2 * atan(sigma2);

  //converte to DEG
  theta1 = theta1 * (180 / PI);
  theta2 = theta2 * (180 / PI);

  // determine pulses to be executed by the motor
  angle1 = round(theta1 * PulPerRev / 360); // 100 * PulPerRev/360 conversão para pulsos com redutora de 100:1
  angle2 = round(theta2 * PulPerRev / 360);
}
