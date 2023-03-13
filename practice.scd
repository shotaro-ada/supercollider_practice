s.kill;

play({SinOsc.ar(LFNoise0.ar(12, mul: 600, add: 1000), 0.3)});

play({RLPF.ar(Dust.ar([12, 15], LFNoise1.ar(1/[3, 4], 1500, 1600,), 0,02))});

play({
	var sines = 10, speed = 6;
	Mix.fill(sines,
		{arg x;
			Pan2.ar(
				SinOsc.ar(x + 1 * 100,
					mul: max(0,
						LFNoise1.kr(speed) +
						Line.kr(1, -1, 30)
					)
				), rand2(1,0)
			)
		}
	) / sines
})


play({
	LFNoise0.kr(10, 100);
})


{LFNoise0.ar}.play;
{LFNoise0.ar(19999)}.plot;
{SinOsc.ar(1000)}.plot;
{100.rand}.dup(10).postln.plot // 10個の数を選択し、表示した後プロット
