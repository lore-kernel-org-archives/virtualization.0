From: =?ISO-8859-2?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
Subject: ping latency using vhost_net, macvtap and virtio
Date: Mon, 27 Aug 2012 18:09:27 +0200
Message-ID: <503B9BB7.6020509@uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hi all,

I have been testing network throughput and latency and I was wondering 
if my measurements are as expected.
For the test, I used Fedora 17 for both host and guest, using kernel 
3.5.2-3.fc17.86_64.

Pinging an external server on the LAN from the host, using a gigabit 
interface, the results are:
# ping -c 10 172.16.1.1
PING 172.16.1.1 (172.16.1.1) 56(84) bytes of data.
64 bytes from 172.16.1.1: icmp_req=1 ttl=64 time=0.109 ms
64 bytes from 172.16.1.1: icmp_req=2 ttl=64 time=0.131 ms
64 bytes from 172.16.1.1: icmp_req=3 ttl=64 time=0.145 ms
64 bytes from 172.16.1.1: icmp_req=4 ttl=64 time=0.116 ms
64 bytes from 172.16.1.1: icmp_req=5 ttl=64 time=0.110 ms
64 bytes from 172.16.1.1: icmp_req=6 ttl=64 time=0.114 ms
64 bytes from 172.16.1.1: icmp_req=7 ttl=64 time=0.112 ms
64 bytes from 172.16.1.1: icmp_req=8 ttl=64 time=0.117 ms
64 bytes from 172.16.1.1: icmp_req=9 ttl=64 time=0.119 ms
64 bytes from 172.16.1.1: icmp_req=10 ttl=64 time=0.128 ms

--- 172.16.1.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 8999ms
rtt min/avg/max/mdev = 0.109/0.120/0.145/0.011 ms


Pinging the same external host on the LAN from the guest, the latency 
seems to be much higher:
# ping -c 10 172.16.1.1
PING 172.16.1.1 (172.16.1.1) 56(84) bytes of data.
64 bytes from 172.16.1.1: icmp_req=1 ttl=64 time=0.206 ms
64 bytes from 172.16.1.1: icmp_req=2 ttl=64 time=0.352 ms
64 bytes from 172.16.1.1: icmp_req=3 ttl=64 time=0.518 ms
64 bytes from 172.16.1.1: icmp_req=4 ttl=64 time=0.351 ms
64 bytes from 172.16.1.1: icmp_req=5 ttl=64 time=0.543 ms
64 bytes from 172.16.1.1: icmp_req=6 ttl=64 time=0.387 ms
64 bytes from 172.16.1.1: icmp_req=7 ttl=64 time=0.348 ms
64 bytes from 172.16.1.1: icmp_req=8 ttl=64 time=0.364 ms
64 bytes from 172.16.1.1: icmp_req=9 ttl=64 time=0.345 ms
64 bytes from 172.16.1.1: icmp_req=10 ttl=64 time=0.334 ms

--- 172.16.1.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 8999ms
rtt min/avg/max/mdev = 0.206/0.374/0.543/0.093 ms


(The LAN, the host and guest are idle otherwise during the tests.)


The vhost_net and macvtap modules are loaded on the host, and qemu was 
started (by libvirtd) with the -netdev vhost=on option.

Is this expected and normal, or do others see better latencies? Can I 
try anything to make it better?

Thanks,
Balazs Pozsar
