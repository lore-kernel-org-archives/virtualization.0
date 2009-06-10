From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: TODO list for qemu+KVM networking performance v2
Date: Wed, 10 Jun 2009 13:09:13 +0930
Message-ID: <200906101309.14532.rusty__36365.4790832244$1244605214$gmane$org@rustcorp.com.au>
References: <20090604164320.GB14592@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iryLKA3fIJRePPN"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090604164320.GB14592@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, Dor Laor <dor@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, Yaron Haviv <yaronh@voltaire.com>, Shahar Klein <shahark@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

--Boundary-00=_iryLKA3fIJRePPN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 5 Jun 2009 02:13:20 am Michael S. Tsirkin wrote:
> I out up a copy at http://www.linux-kvm.org/page/Networking_Performance as
> well, and intend to dump updates there from time to time.

Hi Michael,

  Sorry for the delay.  I'm weaning myself off my virtio work, but virtio_net 
performance is an issue which still needs lots of love.  

BTW a non-wiki on the wiki?.  You should probably rename it to 
"MST_Networking_Performance" or allow editing :)

> 	- skbs in flight are kept in send queue linked list,
> 	  so that we can flush them when device is removed
> 	  [ mst: optimization idea: virtqueue already tracks
>             posted buffers. Add flush/purge operation and use that instead?

Interesting idea,  but not really an optimization.  (flush_buf() which does a 
get_buf() but for unused buffers).

> ] - skb is reformatted to scattergather format
>           [ mst: idea to try: this does a copy for skb head,
>             which might be costly especially for small/linear packets.
> 	    Try to avoid this? Might need to tweak virtio interface.
>           ]

There's no copy here that I can see?

>         - network driver adds the packet buffer on TX ring
> 	- network driver does a kick which causes a VM exit
>           [ mst: any way to mitigate # of VM exits here?
>             Possibly could be done on host side as well. ]
> 	  [ markmc: All of our efforts there have been on the host side, I think
>             that's preferable than trying to do anything on the guest side.
> ]

The current theoretical hole is that the host suppresses notifications using 
the VIRTIO_AVAIL_F_NO_NOTIFY flag, but we can get a number of notifications in 
before it gets to that suppression.  You can use a counter to improve this: 
you only notify when they're equal, and inc when you notify.  That way you 
suppress further notifications even if the other side takes ages to wake up.  
In practice, this shouldn't be played with until we have full aio (or equiv in 
kernel) for other side: host xmit tends to be too fast at the moment and we 
get a notification per packet anyway.

> 	- Full queue:
> 		we keep a single extra skb around:
> 			if we fail to transmit, we queue it
> 			[ mst: idea to try: what does it do to
>                           performance if we queue more packets? ]

Bad idea!!  We already have two queues, this is a third.  We should either 
stop the queue before it gets full, or fix TX_BUSY handling.  I've been arguing 
on netdev for the latter (see thread"[PATCH 2/4] virtio_net: return 
NETDEV_TX_BUSY instead of queueing an extra skb.").

> 	        [ markmc: the queue might soon be going away:
>                    200905292346.04815.rusty@rustcorp.com.au

Ah, yep, that one.

> http://archive.netbsd.se/?ml=linux-netdev&a=2009-05&m=10788575 ]
>
> 	- We get each buffer from host as it is completed and free it
>         - TX interrupts are only enabled when queue is stopped,
>           and when it is originally created (we disable them on completion)
>           [ mst: idea: second part is probably unintentional.
>             todo: we probably should disable interrupts when device is
> created. ]

Yep, minor wart.

> - We poll for buffer completions:
> 	  1. Before each TX 2. On a timer tasklet (unless 3 is supported)
>           3. When host sends us interrupt telling us that the queue is
> empty [ mst: idea to try: instead of empty, enable send interrupts on xmit
> when buffer is almost full (e.g. at least half empty): we are running out
> of buffers, it's important to free them ASAP. Can be done from host or from
> guest. ]
>           [ Rusty proposing that we don't need (2) or (3) if the skbs are
> orphaned before start_xmit(). See subj "net: skb_orphan on
> dev_hard_start_xmit".] [ rusty also seems to be suggesting that disabling
> VIRTIO_F_NOTIFY_ON_EMPTY on the host should help the case where the host
> out-paces the guest ]

Yes, that's more fruitful.

>         - Each skb has a 128 byte buffer at head and a single page for
> data. Only full pages are passed to virtio buffers.
>           [ mst: for large packets, managing the 128 head buffers is wasted
>             effort. Try allocating skbs on rcv path when needed. ].
> 	    [ mst: to clarify the previos suggestion: I am talking about
> 	    merging here.  We currently allocate skbs and pages for them. If a
> packet spans multiple pages, we discard the extra skbs.  Instead, let's
> allocate pages but not skbs. Allocate and fill skbs on receive path. ]

Yep.  There's another issue here, which is alignment: packets which get placed 
into pages are misaligned (that 14 byte ethernet header).  We should add a 
feature to allow the host to say "I've skipped this many bytes at the front".

> 	- Buffers are replenished after packet is received,
>           when number of buffers becomes low (below 1/2 max).
>           This serves to reduce the number of kicks (VMexits) for RX.
>           [ mst: code might become simpler if we add buffers
>             immediately, but don't kick until later]
> 	  [ markmc: possibly. batching this buffer allocation might be
> 	    introducing more unpredictability to benchmarks too - i.e. there isn't
> a fixed per-packet overhead, some packets randomly have a higher overhead]
> on failure to allocate in atomic context we simply stop
>           and try again on next recv packet.
>           [mst: there's a fixme that this fails if we complete run out of
> buffers, should be handled by timer. could be a thread as well (allocate
> with GFP_KERNEL).
>                 idea: might be good for performance anyway. ]

Yeah, this "batched packet add" is completely unscientific.  The host will be 
ignoring notifications anyway, so it shouldn't win anything AFAICT.  Ditch it 
and benchmark.

> 	  After adding buffers, we do a kick.
>           [ mst: test whether this optimization works: recv kicks should be
> rare ] Outstanding buffers are kept on recv linked list.
> 	  [ mst: optimization idea: virtqueue already tracks
>             posted buffers. Add flush operation and use that instead. ]

Don't understand this comment?

> 	- recv is done with napi: on recv interrupt, disable interrupts
>           poll until queue is empty, enable when it's empty
>          [mst: test how well does this work. should get 1 interrupt per
>           N packets. what is N?]

It works if the guest is outpacing the host, but in practice I had trouble 
getting above about 2:1.  I've attached a spreadsheet showing the results of 
various tests using lguest.  You can see the last one "lguest:net-delay-for-
more-output.patch" where I actually inserted a silly 50 usec delay before 
sending the receive interrupt: 47k irqs for 1M packets is great, too bad about 
the latency :)

>          [mst: idea: implement interrupt coalescing? ]

lguest does this in the host, with mixed results.  Here's the commentry from 
my lguest:reduce_triggers-on-recv.patch (which is queued for linux-next as I 
believe it's the right thing even though win is in the noise).

lguest: try to batch interrupts on network receive

Rather than triggering an interrupt every time, we only trigger an
interrupt when there are no more incoming packets (or the recv queue
is full).

However, the overhead of doing the select to figure this out is
measurable: 1M pings goes from 98 to 104 seconds, and 1G Guest->Host
TCP goes from 3.69 to 3.94 seconds.  It's close to the noise though.

I tested various timeouts, including reducing it as the number of
pending packets increased, timing a 1 gigabyte TCP send from Guest ->
Host and Host -> Guest (GSO disabled, to increase packet rate).

// time tcpblast -o -s 65536 -c 16k 192.168.2.1:9999 > /dev/null

Timeout		Guest->Host	Pkts/irq	Host->Guest	Pkts/irq
Before		11.3s		1.0		6.3s		1.0
0		11.7s		1.0		6.6s		23.5
1		17.1s		8.8		8.6s		26.0
1/pending	13.4s		1.9		6.6s		23.8
2/pending	13.6s		2.8		6.6s		24.1
5/pending	14.1s		5.0		6.6s		24.4

> 	[mst: some architectures (with expensive unaligned DMA) override
> NET_IP_ALIGN. since we don't really do DMA, we probably should use
> alignment of 2 always]

That's unclear: what if the host is doing DMA?

> 		[ mst: question: there's a FIXME to avoid modulus in the math.
>                   since num is a power of 2, isn't this just & (num - 1)?]

Exactly.

> 	Polling buffer:
> 		we look at vq index and use that to find the next completed buffer
> 		the pointer to data (skb) is retrieved and returned to user
> 		[ mst: clearing data is only needed for debugging.
>                   try removing this write - cache will be cleaner? ]

It's our only way of detecting issues with hosts.  We have reports of BAD_RING 
being triggered (unf. not reproducible).

> TX:
> 	We poll for TX packets in 2 ways
> 	- On timer event (see below)
> 	- When we get a kick from guest
> 	  At this point, we disable further notifications,
> 	  and start a timer. Notifications are reenabled after this.
> 	  This is designed to reduce the number of VMExits due to TX.
> 	  [ markmc: tried removing the timer.
>             It seems to really help some workloads. E.g. on RHEL:
>             http://markmc.fedorapeople.org/virtio-netperf/2009-04-15/
>             on fedora removing timer has no major effect either way:
> 	   
> http://markmc.fedorapeople.org/virtio-netperf/2008-11-06/g-h-tput-04-no-tx-
>timer.html ]

lguest went fully multithreaded, dropped timer hack.  Much nicer, and faster.  
(See second point on graph).  Timers are a hack because we're not async, so 
fixing the real problem avoids that optimization guessing game entirely.

> 	Packets are polled from virtio ring, walking descriptor linked list.
> 	[ mst: optimize for completing in order? ]
> 	Packet addresses are converted to guest iovec, using
> 	cpu_physical_memory_map
> 	[ mst: cpu_physical_memory_map could be optimized
>           to only handle what we actually use this for:
>           single page in RAM ]

Anthony had a patch for this IIRC.

> Interrupts will be reported to eventfd descriptors, and device will poll
> eventfd descriptors to get kicks from guest.

This is definitely a win.  AFAICT you can inject interrupts into the guest from 
a separate thread today in KVM, too, so there's no core reason why devices 
can't be completely async with this one change.

Cheers,
Rusty.



--Boundary-00=_iryLKA3fIJRePPN
Content-Type: application/x-gnumeric;
  name="results3.gnumeric"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="results3.gnumeric"

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

--Boundary-00=_iryLKA3fIJRePPN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--Boundary-00=_iryLKA3fIJRePPN--
