public class Ecd_accelerate_version {
    public int ecd_accelerate_version(int s, int t){
        int k = 1;
        int sk = (int) Math.pow(s, k);
        while(sk <= t){
            k++;
            sk = (int) Math.pow(s, k);
        }
        sk -= s;
        t -= sk;
        while(t > 0){
            if(t > s){
                k --;
                sk = (int) Math.pow(s, k);
                while(sk > t){
                    k --;
                    sk = (int) Math.pow(s, k);
                }
                t -= sk;
            }
            else{
                int temp = s;
                s = t;
                t = temp;
            }
        }
        return s;
    }
}
