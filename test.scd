s.waitForBoot{
    s.boot;
    { BrownNoise.ar * 0.1 }.play;
}

// // 関数で音を鳴らす
// f = { SinOsc.ar * 0.1 };

// // 実行 -> 音が鳴る

// f.play;

//     // 違う音．実行後、止める

{ BrownNoise.ar * 0.1 }.play;
