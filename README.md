# FPGA-Programmed-Integrated-Circuit
# Finite-State Machine (FSM) Door Lock Control

This document outlines the design specifications for a Finite-State Machine (FSM) intended to control the lock of a door based on certain characteristics.

## Specifications

1. **Password Requirements:**
   - The password must consist of 3 numeric digits ranging from 0 to 9 (e.g., 123).

2. **Numeric Keypad Input:**
   - A numeric keypad with digits from 0 to 9 (BCD representation) is utilized to generate the input signal.
   - When no key is pressed, the keypad displays the number 15 (binary: 1111).

3. **Door Status LED:**
   - An LED is used to indicate the STATUS of the door:
     - Closed = LED is on.
     - Open = LED is off.

4. **Maximum Keypad Touch Interval:**
   - The maximum interval between keypad touches should be 3 seconds (timer1).

5. **Lock Opening After Password Acceptance:**
   - After the password is accepted, the lock must be opened, and the LED turned off, remaining in this state for 5 seconds (timer2).

6. **Password Attempts:**
   - There are no limits on the number of password attempts.
  
## Finite State Machine
![finite_state_machine](https://github.com/andre-diass/FPGA-Programmed-Integrated-Circuit/assets/117690410/5d983422-b021-4b25-ac26-c95fefca3b75)

## Output
![output](https://github.com/andre-diass/FPGA-Programmed-Integrated-Circuit/assets/117690410/f7dbb237-e346-4ee4-851b-2069a8c51877)

## RTL View
![rtl_view](https://github.com/andre-diass/FPGA-Programmed-Integrated-Circuit/assets/117690410/08c66f0d-7c53-4e25-910a-6eeb3a5b35f3)



## Conclusion
This FSM design ensures secure and efficient control of the door lock system, incorporating features such as password authentication, keypad input handling, LED status indication, and timer-based operations to meet the specified requirements.

