///////////////////////////////   INSTRUCTIONS   //////////////////////////////////////////
// The following instructions are meant to add as a readme.md of sorts;
// Said instcuctions elaborate on the basic functionality of the implementation
//
// To start the program, get the server running either via GUI from Server-> Boot Server;
// Using the corresponding key bind or running the following:
// Server.local.boot; or s.boot;
// To quit the server follow the instructions 5-6 or run the following:
// Server.local.quit; or s.quit
// To run a single line of code press Shift-Return
// To stop all sound: Language-> Stop or press the corresponding keybind; CTRL-.
// To run a section: Language-> Evaluate region or press the corresponding keybind; CTRL-RETURN
// 1.   Run the line -22, to define the net Adress to send a message.
// 2.   Run all the synthDefs ( \blipp, \blip, \tone ).
// 3.   Run the first routine ( 1st routine ).
// 4.   After 3-4 seconds elapse, run the 2nd routine ( 2nd routine ).
// 5.   After 6-7 seconds elapse, run the 3rd routine ( 3rd routine ) and listen to the whole thing for some seconds.
// 6.   Then, add the 4th routine ( 4th routine ).
// 7.   After 4-5 seconds, run the 5th routine ( 5th routine ).
// 8.   And after that, add the last routine ( 6th routine ).

~net = NetAddr("127.0.0.1", 47120);

///////////////////////////////     1st SynthDef     /////////////////////////////////////
(
SynthDef.new(\blipp, {
	arg freq =400, harm=4, atk=0.01, rel=1, amp=0.2, out=0;   // arguments to change later on
	var sig, env;                                             // variables to define the outcome ( signal, envelop )
	env = EnvGen.kr(Env.perc(atk,rel), doneAction:2);         // envelop to add on the existing signal
	sig = Saw.ar([freq, freq* 0.2.midiratio]);
	sig = RLPF.ar(sig, (freq *harm).clip(20,20000),0.5);      // define the harmonics of the sound
	sig = sig * env * amp;                                    // multiply by amplitute
	Out.ar(out, sig);                                         // define the chanel to send the sound ( 0,1 )
}).add;
)
///////////////////////////////     2nd SynthDef     /////////////////////////////////////
(
SynthDef(\blip, {|freq, amp|                                  // arguments to change later on
	var env  = Env.perc(level: 0.2, releaseTime: 0.2).        // envelop to add on the existing signal
	kr(doneAction: Done.freeSelf);                            // release itself
	var sig = Pulse.ar(freq: freq,width: 0.4) * env* amp;     // putting together the signal, envelop and multiply by amplitute
	Out.ar(0,[sig, sig])                                      // send to both channels ( 0,1 ) - stereo
}).add;
)
///////////////////////////////     3rd SynthDef     /////////////////////////////////////
(
SynthDef.new(\tone, {
    arg freq = 400, amp=0.2, out=0;                                   // arguments to change later on
	var sig, freqCtrl, env;                                           // variables to define the outcome ( signal, envelop, freqControl )
	env = EnvGen.kr(
		Env.new([0,1,0], [2,2], [2,-2]),                              // envelop - ( gate, scale, levelBias, timeScale), doneAction
		doneAction:2
	);
	freqCtrl = freq * LFNoise1.kr(2!8).range(-0.5,0.5).midiratio;     // adding a noise on the frequency
	sig = VarSaw.ar(freqCtrl) * env * amp;                            // defining the signal
	sig = Splay.ar(sig);
	Out.ar(out,sig);                                                  // define the chanel to send the sound ( 0,1 )
}).add;
)
///////////////////////////////     1st routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream = Pseq([50,54,64,67,72,74],inf).midicps.asStream;     // frequency stream (midi notes)
var dur_stream =  Pseq([0.1,0.1,1,0.4,0.7],inf).asStream;             // duration stream
var amp_stream =  Prand([0.4,0.1,0.2],inf).asStream;                  // amplitute stream
var out_stream =  Pseq([0,1],inf).asStream;                           // out stream

// The loop starts

fork{loop{
	var freq = freq_stream.next;  // Frequency
	var dur = dur_stream.next;    // Duration of the note
	var amp = amp_stream.next;    // Amplitute of the note
	var out = out_stream.next;    // Define the gate ( out )


	Synth(\tone, [\freq, freq, \dur, dur, \amp, amp, \out, out]);      // calling the synth with the above variables

	dur.wait;                     // wait dur to run the loop again
}}

)
///////////////////////////////     2nd routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream = Pseq([62,66,76,79,84,86],inf).midicps.asStream;      // frequency stream (midi notes)
var dur_stream =  Pseq([0.3,0.3,1,0.1,0.1],inf).asStream;              // duration stream
var amp_stream =  Prand([0.1,0.2,0.3],inf).asStream;                   // amplitute stream
var out_stream =  Pseq([0,1],inf).asStream;                            // out stream

// The loop starts

fork{loop{
	var freq = freq_stream.next;  // Frequency
	var dur = dur_stream.next;    // Duration of the note
	var amp = amp_stream.next;    // Amplitute of the note
	var out = out_stream.next;    // Define the gate


	Synth(\tone, [\freq, freq, \dur, dur, \amp, amp, \out, out]);      // calling the synth with the above variables

	dur.wait;                     // wait dur to run the loop again
}}

)
///////////////////////////////     3rd routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream   = Pseq([60,64,67],inf).midicps.asStream;             // frequency stream (midi notes)
var dur_stream    = Pseq([0.3,0.1,0.5],inf).asStream;                  // duration stream
var amp_stream    = Pseq([0.1,0.1,0.2],inf).asStream;                  // amplitute stream
var degree_stream = Pseq([-10,-5,0],inf).asStream;                     // degree stream
var harm_stream   = Pseq([2,4,8,12],inf).asStream;                     // harmonics stream
var rel_stream    = Pseq([0.5,0.7],inf).asStream;                      // release time stream
var atck_stream   = Pseq([0.4,0.2,0.7],inf).asStream;                  // atack value stream

// The loop starts

fork{loop{
	var freq   = freq_stream.next;                        // Frequency
	var dur    = 0.1;                                     // Duration of the note
	var amp    = amp_stream.next;                         // Amplitute of the note
	var atck   = 0.2;                                     // How much to extend the note
	var rel    = 0.1;                                     // when to release the note
	var scale  = Scale.minorPentatonic;                   // Scale during the loop
	var harm   = harm_stream.next;                        // secondary harmonics, defines the sound
	var degree = degree_stream.next;                      // degree of the nore

	var position_x = ControlSpec(0,450).map(freq/2000);   // maping the values for processing. PositionX
	var position_y = ControlSpec(0,450).map(dur);         // maping the values for processing. PositionY
	var size = ControlSpec(10,200).map(amp*2);            // maping the values for processing. Size

	Synth(\blipp, [\freq, freq, \dur, dur, \amp, amp, \atk, atck, \rel, rel, \harm, harm, \degree, degree, \scale, scale]);

	~net.sendMsg("/change_position", position_x, position_y, size);  // Send the message to processing
	dur.wait;
}}

)
///////////////////////////////     4th routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream = Pseq([150],inf).asStream;               // frequency stream
var dur_stream  = Pseq([0.5,0.5,1],inf).asStream;         // duration stream
var amp_stream  = Pseq([0.7,0.7,1],inf).asStream;         // amplitute stream

// The loop starts

fork{loop{
	var freq = freq_stream.next;   // Frequency
	var dur  = dur_stream.next;    // Duration of the note
	var amp  = amp_stream.next;    // Amplitute of the note


	Synth(\blip, [\freq, freq, \dur, dur, \amp, amp]);    // calling the synth with the above variables

	dur.wait;                      // wait dur to run the loop again
}}

)
///////////////////////////////     5th routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream   = Pseq([60,64,67],inf).midicps.asStream;         // frequency stream (midi notes)
var dur_stream    = Pseq([0.1,0.2,0.2],inf).asStream;              // duration stream
var amp_stream    = Pseq([0.1,0.1,0.3],inf).asStream;              // amplitute stream
var degree_stream = Pseq([-10,-5,0],inf).asStream;                 // degree stream
var harm_stream   = Pser([1,3,5,7,9, 11],inf).asStream;            // harmonics stream
var rel_stream    = Pseq([0.5,0.7],inf).asStream;                  // release time stream
var atck_stream   = Pseq([0.1,0.5,0.05],inf).asStream;             // atack value stream

// The loop starts

fork{loop{
	var freq   = freq_stream.next;           // Frequency
	var dur    = dur_stream.next;            // Duration of the note
	var amp    = 0.4;                        // Amplitute of the note
	var atck   = atck_stream.next;           // How much to extend the note
	var rel    = 0.01;                       // when to release the note
	var scale  = Scale.major;                // Scale during the loop
	var harm   = harm_stream.next;           // secondary harmonics, defines the sound
	var degree = degree_stream.next;         // degree of the nore
	var out    = Prand([0,1],inf);

	var position_x = ControlSpec(0,450).map(freq/2000);   // maping the values for processing. PositionX
	var position_y = ControlSpec(0,450).map(dur);         // maping the values for processing. PositionY
	var size = ControlSpec(10,200).map(amp*2);            // maping the values for processing. Size

	Synth(\blipp, [\freq, freq, \dur, dur, \amp, amp, \atk, atck, \rel, rel, \harm, harm, \degree, degree, \scale, scale,\out, out]);

	~net.sendMsg("/change_position", position_x, position_y, size);  // Send the message to processing

	dur.wait;              // wait dur to run the loop again
}}

)
///////////////////////////////     6th routine     /////////////////////////////////////
(
// define the streams for all the synthDef arguments

var freq_stream   = Pseq([72,64,67],inf).midicps.asStream;                           // frequency stream (midi notes)
var dur_stream    = Pseq([0.2,0.2,0.1,0.1,0.4],inf).asStream;                        // duration stream
var amp_stream    = Pseq([0.1,0.3,0.5],inf).asStream;                                // amplitute stream
var degree_stream = Pseq([-10,Prand([-8,-6,-4],2),0,-20],inf).asStream;              // degree stream
var harm_stream   = Pser([3,3,5,Prand([3,6,8,12],1),10,12],inf).asStream;            // harmonics stream
var rel_stream    = Pseq([0.2,0.2,Pseq([0.3,0.2,0.1],2),0.5,1,1],inf).asStream;      // release time stream
var atck_stream   = Pseq([0.1,0.1,0.5,0.1,0.1],inf).asStream;                        // atack value stream

// The loop starts

fork{loop{
	var freq   = freq_stream.next;      // Frequency
	var dur    = dur_stream.next;       // Duration of the note
	var amp    = amp_stream.next;       // Amplitute of the note
	var atck   = atck_stream.next;      // How much to extend the note
	var rel    = rel_stream.next;       // when to release the note
	var scale  = Scale.major;           // Scale during the loop
	var harm   = harm_stream.next;      // secondary harmonics, defines the sound
	var degree = degree_stream.next;    // degree of the nore
	var out    = Prand([0,1],inf);

	var position_x = ControlSpec(0,450).map(freq/2000);   // maping the values for processing. PositionX
	var position_y = ControlSpec(0,450).map(dur);         // maping the values for processing. PositionY
	var size = ControlSpec(10,200).map(amp*2);            // maping the values for processing. Size

	Synth(\blipp, [\freq, freq, \dur, dur, \amp, amp, \atk, atck, \rel, rel, \harm, harm, \degree, degree, \scale, scale,\out, out]);
	dur.wait;
}}

)






