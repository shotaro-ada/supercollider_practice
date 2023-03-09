s.boot;

{SinOsc.ar * 0.1 }.play;
// 上と下は同じ
{SinOsc.ar(ml: 0.1)}.play;

// 音がおおきくなる
{SinOsc.ar(ml: 0.2)}.play;

{SinOsc.ar(880, 0, 0.1)}.play;

{SinOsc.ar(880, mul: 0.1)}.play;


//XLineについて https://doc.sccode.org/Classes/XLine.html
{SinOsc.ar(XLine.kr(440, 5000, 2), mul: 0.1)}.play;


//ハイハットを作る
(
SynthDef("hat", { | amp=0.1 |
	var sig;
	sig = WhiteNoise.ar;
	sig = sig *amp;
	Out.ar(0, sig);
}).add;
)

Synth("hat");