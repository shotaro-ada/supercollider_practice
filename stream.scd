s.boot;

p = Pseries(0, 2, 5).asStream;

p.next;
p.next;
p.next;
p.next;
p.next;



p = Pseq([6, 5, 1, 2.5, -100]).asStream;
20.do {p.next.postln;};





(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05, amp=0.1;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.2, amp), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)


(
var a;
a = Pgeom(300, 1.03, 70).asStream;
{
    a.do { |val|
        Synth(\help_sinegrain, [\freq, val]);
        0.02.wait;
    }
}.fork;
)

(
Pbind(
    \dur, 0.01,
    \instrument, \help_sinegrain,
    \freq, Pgeom(800, Pbrown(0.99, 1.01, 0.01, inf), inf)
).play;
)


(
SynthDef(\hat, { | amp = 0.1, pan = 0 |
	var sig, env;
	env = EnvGen.kr(Env.perc(0, 0.03), 1, amp, doneAction: 2);
	sig = WhiteNoise.ar;
	sig = HPF.ar(sig, 8000);
	sig = Pan2.ar(sig, pan, env);
	Out.ar(0, sig);
}).add;
)

~hatA = Pbind(\instrument, \hat, \dur, 0.25, \amp, Pseq([0.4, 0.2, 0.3, 0.2], inf));
~hatA.play;
