import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class udpBaseClient_2 {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in);

        DatagramSocket ds = new DatagramSocket();

        InetAddress ip = InetAddress.getLocalHost();
        byte[] buf;

        System.out.println("Enter messages to send to server (type 'bye' to quit):");

        while (true) {
            String inp = sc.nextLine();
            buf = inp.getBytes();

            DatagramPacket DpSend = new DatagramPacket(buf, buf.length, ip, 1234);
            ds.send(DpSend);

            if (inp.trim().equals("bye")) {
                System.out.println("Sent 'bye', exiting client...");
                break;
            }
        }

        ds.close();
        sc.close();
    }
}
