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

