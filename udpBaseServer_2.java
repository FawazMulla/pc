import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class udpBaseServer_2 {
    public static void main(String[] args) throws IOException {
        DatagramSocket ds = new DatagramSocket(1234);
        byte[] receive = new byte[65535];

        System.out.println("Server is running. Waiting for messages...");

        while (true) {
            DatagramPacket DpReceive = new DatagramPacket(receive, receive.length);
            ds.receive(DpReceive);

            String message = data(receive, DpReceive.getLength());
            System.out.println("Client:- " + message);

            if (message.trim().equals("bye")) {
                System.out.println("Client sent bye.....EXITING");
                break;
            }

            // No need to reassign `receive` buffer
        }
        ds.close();
    }

    public static String data(byte[] a, int length) {
        return new String(a, 0, length);
    }
}
