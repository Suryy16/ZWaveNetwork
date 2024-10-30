package zwavenetwork.zwave_test;
import ned.IdealChannel;

network ZWaveNetwork {
    parameters:
        int numNodes = default(20);
        double frequency @unit(MHz) = default(908.42MHz);
        double range @unit(m) = default(30m);
        double playgroundSizeX @unit(m) = default(200m); // Ukuran playground lebih besar
        double playgroundSizeY @unit(m) = default(200m);

    submodules:
        controller: ZWaveController {
            @display("p=100,100;i=device/antennatower");
        }

        node[numNodes]: ZWaveNode {
            @display("p=150+50*cos(index*3.1415/10),100+50*sin(index*3.1415/10);i=device/wifilaptop");
        }

    connections allowunconnected:
        // Menghubungkan controller ke setiap node
        for i=0..numNodes-1 {
            controller.gate++ <--> IdealChannel <--> node[i].gate++;
        }

        // Mesh connections antara node
        for i=0..numNodes-1, for j=i+1..numNodes-1 {
            node[i].gate++ <--> IdealChannel <--> node[j].gate++;
        }
}
