From: Brian Rak <brak@vultr.com>
Subject: virtio-net TSO Lockup
Date: Fri, 10 Jul 2015 12:29:52 -0400
Message-ID: <559FF300.1060107@vultr.com>
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

We've been encountering an issue in the virtio-net driver that cause it 
to become unresponsive after a period of high load.  This issue goes 
away if we disable TSO on the interface.

Once this issue has been triggered, the interface can still receive 
traffic, but will not transmit anything.

Specifically:
* Initially the machine will still try to respond to packets (I say try, 
because I see the packets in tcpdump, but the counters shown by 'ip -s 
-d link show eth1' do not increment.  I also do not see the packets make 
it to the upstream network interface)
* After a little while (1-2 minutes), I stop seeing the response packets 
in tcpdump.  (In this case I'm looking for ARP request/replies, so the 
requests still come in, but the responses do not go out.  This is not 
limited to just ARP, the interface will not respond at all)
* If I leave a ping running while the interface is broken, eventually I 
start seeing 'ping: sendmsg: No buffer space available'

I've reproduced this on a few Ubuntu kernel builds (3.13.0-53-generic 
and 4.0.7-040007-generic), and a few CentOS kernels 
(2.6.32-504.16.2.el6.x86_64, 4.1.1-1.el6.elrepo.x86_64) so I do not 
believe this to be distribution specific.

If I restart the machine (just issuing a server level 'reboot' command, 
not restarting qemu itself), the adapter starts working properly again.

Interestingly, these machines have two virtio NICs, and this only seems 
to occur for one of them (by this, I mean eth0 always works, and eth1 
always breaks.  If I remove eth0 from the machine, eth1 still breaks). 
On the host level, the broken one is a macvtap interface, while the 
working one is an tap device.   We've seen this in the past with a 
different interface type (the qemu multicast NIC type), so I do not 
believe this is really relevant.  If I switch the machines to using 
emulated e1000 nics, I can no longer reproduce the issue.

Reproduction is fairly easy, with two machines run `nc -lk 1818 | pv > 
/dev/null` on one, and `cat /dev/zero | pv | nc 10.99.0.100 1818` (the 
machine sending traffic will break within a minute or two).  I can 
easily provide access to machines where the problem manifests, if that 
would be helpful.

I'm not really sure where to go from here.  Tracking down a bug in the 
virtio driver is a bit above my skill level.
