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


(
SynthDef(\hat, { | amp=0.1 |
	var sig;
	sig = WhiteNoise.ar;
	sig = HPF.ar(sig, 8000);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)
Synth(\hat); //8000Hz以下の低い音が消える


(
SynthDef(\hat, { | amp=0.1 |
	var sig, env;
	//パーカッションっぽい音の減衰を作る
	env = EnvGen.kr(Env.perc(0, 0.03), doneAction: 2);
	sig = WhiteNoise.ar;
	sig = HPF.ar(sig, 8000);
	sig = sig * amp * env;
	Out.ar(0, sig);
}).add;
)
Synth(\hat); //短い音


(
SynthDef(\hat, { | amp=0.1 |
	var sig, env;
	env = EnvGen.kr(Env.perc(0, 0.03), doneAction: 2);
	sig = WhiteNoise.ar;
	sig = HPF.ar(sig, 8000);
	sig = sig * amp * env;
	sig = Pan2.ar(sig, pan);
	Out.ar(0, sig);
}).add;
)
//シンセに引数をわたす
Synth(\hat, [pan: 0]); //ステレオの中央
Synth(\hat, [pan: -1]); //ステレオの左
Synth(\hat, [pan: 1]); //ステレオの右


SynthDef(\snr, { |amp=0.1|
	var sig, env, snr, mem;
	env = EnvGen.kr(Env.perc(0, 0.05), 1, amp, doneAction: 2);
	snr = WhiteNoise.ar;
	mem = FSinOsc.ar(200);
	sig = LPF.ar(snr + mem, 12000);
	sig = Pan2.ar(sig, 0, env);
	Out.ar(0, sig);
}).add;


~snrA = Pbind(\instrument, \snr, \dur, 1).play;
~snrA.stop;


(
SynthDef(\kik, {|amp=0.3, sustain=1, freq=30|
	var sig, frqEnv, ampEnv;
	frqEnv = EnvGen.kr(Env.perc, 1, freq*10, freq, 0.023);
	ampEnv = EnvGen.kr(Env.linen(0.01, 0.1, 0.3, 1, [-5, 1, -4]), 1, amp, 0, sustain, 2);
	sig = SinOsc.ar(frqEnv, 0, ampEnv);
	sig = Pan2.ar(sig, 0);
	Out.ar(0, sig);
}).add;
)
~kikA = Pbind(\instrument, \kik, \dur, 1, \amp, 0.8, \freq, 50).play;
~kikA.stop;


(
SynthDef(\prc, {| out=0, amp=0.1 |
	var sig, env;
	env = EnvGen.kr(Env.perc(0, 0.08), 1, amp, doneAction: 2);
	sig = WhiteNoise.ar;
	sig = sig * env;
	Out.ar(out, sig);
}).add;


SynthDef(\chorus, {| out=0 |
	var sig;
	sig = In.ar(out, 1) * 0.5;
	sig = DelayC.ar(sig, 1, FSinOsc.kr(0.25, [0, pi]).range(0.02, 0.03), 0.5, sig);
	ReplaceOut.ar(out, sig);
}).add;
)
