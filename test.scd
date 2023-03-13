s.boot;

s.waitForBoot{
    //ハイハットを作る
    SynthDef("hat", { | amp=0.1 |
        var sig;
        sig = WhiteNoise.ar;
        sig = sig *amp;
        Out.ar(0, sig);
    }).add;
    
    Synth("hat");
}



 




