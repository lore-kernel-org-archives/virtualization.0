From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 20 Aug 2009 20:00:28 +0300
Message-ID: <20090820170028.GA8908__7872.91282690621$1250787941$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A808840.70704@codemonkey.ws>
	<20090812173548.GA29981@redhat.com>
	<200908201649.48082.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908201649.48082.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 20, 2009 at 04:49:47PM +0930, Rusty Russell wrote:
> On Thu, 13 Aug 2009 03:05:48 am Michael S. Tsirkin wrote:
> > On Mon, Aug 10, 2009 at 03:51:12PM -0500, Anthony Liguori wrote:
> > > Any rough idea on performance?  Better or worse than userspace?
> > 
> > Well, I definitely see some gain in latency.
> ...
> > Part of it might be that tx mitigation does not come into play with vhost. I
> > need to disable it in qemu and see.
> 
> A simple test I've found reasonably indicative when looking at base performance (before stuff like TSO get involved) is to do pings.  Throughput with "ping -s 1024 -l 120 -c 1000000 -f -q" and latency with "ping -c 1000000 -f -q".
> 
> (You may need to cut -l down if your ring is too small).
> 
> Cheers,
> Rusty.

Surprisingly, I seem to get better-than-userspace throughput with this
benchmark as well.  Here's a test run locally, host-to-guest,
over a veth link:

vhost:
[root@qus19 ~]# ping -c 1000000 -f -q 11.0.0.4
PING 11.0.0.4 (11.0.0.4) 56(84) bytes of data.

--- 11.0.0.4 ping statistics ---
1000000 packets transmitted, 1000000 received, 0% packet loss, time 10230ms
rtt min/avg/max/mdev = 0.005/0.006/0.035/0.000 ms, ipg/ewma 0.010/0.006 ms
[root@qus19 ~]# ping -s 1024 -l 120 -c 1000000 -f -q 11.0.0.4
PING 11.0.0.4 (11.0.0.4) 1024(1052) bytes of data.

--- 11.0.0.4 ping statistics ---
1000000 packets transmitted, 1000000 received, 0% packet loss, time 11270ms
rtt min/avg/max/mdev = 0.006/0.006/0.022/0.002 ms, pipe 120, ipg/ewma 0.011/0.007 ms

qemu:

[root@qus19 ~]# ping -c 1000000 -f -q 12.0.0.2
PING 12.0.0.2 (12.0.0.2) 56(84) bytes of data.

--- 12.0.0.2 ping statistics ---
1000000 packets transmitted, 1000000 received, 0% packet loss, time 59974ms
rtt min/avg/max/mdev = 0.025/0.044/8.076/0.012 ms, pipe 2, ipg/ewma 0.059/0.045 ms

[root@qus19 ~]# ping -s 1024 -l 120 -c 1000000 -f -q 12.0.0.2
PING 12.0.0.2 (12.0.0.2) 1024(1052) bytes of data.

--- 12.0.0.2 ping statistics ---
1000000 packets transmitted, 833496 received, 16% packet loss, time 38841ms
rtt min/avg/max/mdev = 0.133/4.482/9.728/0.771 ms, pipe 120, ipg/ewma 0.038/4.144 ms

Will try over an external link next week when I get access to
a back-to-back setup (don't want to bother with external
switches at this point).

-- 
MST
