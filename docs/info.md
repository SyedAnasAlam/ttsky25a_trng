<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

A ring oscillator and clock divider is used to generate random numbers by exploiting phase noise in the ring oscillator output. 

## How to test

Connect oscilloscope probe to uo_out[0] and observe random bits. 
For more rigorous test, sample this pin using raspberry pi and log them in a file.

## External hardware

Oscilloscope and probes
