From: Dor Laor <dlaor@redhat.com>
Subject: Re: TODO list for qemu+KVM networking performance v2
Date: Wed, 10 Jun 2009 09:26:31 +0300
Message-ID: <4A2F5217.9090401__11066.1502382301$1244615221$gmane$org@redhat.com>
References: <20090604164320.GB14592@redhat.com>
	<200906101309.14532.rusty@rustcorp.com.au>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906101309.14532.rusty@rustcorp.com.au>
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
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, Yaron Haviv <yaronh@voltaire.com>, Shahar Klein <shahark@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Fri, 5 Jun 2009 02:13:20 am Michael S. Tsirkin wrote:
>   
>> I out up a copy at http://www.linux-kvm.org/page/Networking_Performance as
>> well, and intend to dump updates there from time to time.
>>     
>
> Hi Michael,
>
>   Sorry for the delay.  I'm weaning myself off my virtio work, but virtio_net 
> performance is an issue which still needs lots of love.  
>
> BTW a non-wiki on the wiki?.  You should probably rename it to 
> "MST_Networking_Performance" or allow editing :)
>
>   
>> 	- skbs in flight are kept in send queue linked list,
>> 	  so that we can flush them when device is removed
>> 	  [ mst: optimization idea: virtqueue already tracks
>>             posted buffers. Add flush/purge operation and use that instead?
>>     
>
> Interesting idea,  but not really an optimization.  (flush_buf() which does a 
> get_buf() but for unused buffers).
>
>   
>> ] - skb is reformatted to scattergather format
>>           [ mst: idea to try: this does a copy for skb head,
>>             which might be costly especially for small/linear packets.
>> 	    Try to avoid this? Might need to tweak virtio interface.
>>           ]
>>     
>
> There's no copy here that I can see?
>
>   
>>         - network driver adds the packet buffer on TX ring
>> 	- network driver does a kick which causes a VM exit
>>           [ mst: any way to mitigate # of VM exits here?
>>             Possibly could be done on host side as well. ]
>> 	  [ markmc: All of our efforts there have been on the host side, I think
>>             that's preferable than trying to do anything on the guest side.
>> ]
>>     
>
> The current theoretical hole is that the host suppresses notifications using 
> the VIRTIO_AVAIL_F_NO_NOTIFY flag, but we can get a number of notifications in 
> before it gets to that suppression.  You can use a counter to improve this: 
> you only notify when they're equal, and inc when you notify.  That way you 
> suppress further notifications even if the other side takes ages to wake up.  
> In practice, this shouldn't be played with until we have full aio (or equiv in 
> kernel) for other side: host xmit tends to be too fast at the moment and we 
> get a notification per packet anyway.
>   
Xen ring has the exact optimization for ages. imho we should have it 
too, regardless of aio.
It reduces #vmexits/spurious wakeups and it is very simple to implement.

>   
>> 	- Full queue:
>> 		we keep a single extra skb around:
>> 			if we fail to transmit, we queue it
>> 			[ mst: idea to try: what does it do to
>>                           performance if we queue more packets? ]
>>     
>
> Bad idea!!  We already have two queues, this is a third.  We should either 
> stop the queue before it gets full, or fix TX_BUSY handling.  I've been arguing 
> on netdev for the latter (see thread"[PATCH 2/4] virtio_net: return 
> NETDEV_TX_BUSY instead of queueing an extra skb.").
>
>   
>> 	        [ markmc: the queue might soon be going away:
>>                    200905292346.04815.rusty@rustcorp.com.au
>>     
>
> Ah, yep, that one.
>
>   
>> http://archive.netbsd.se/?ml=linux-netdev&a=2009-05&m=10788575 ]
>>
>> 	- We get each buffer from host as it is completed and free it
>>         - TX interrupts are only enabled when queue is stopped,
>>           and when it is originally created (we disable them on completion)
>>           [ mst: idea: second part is probably unintentional.
>>             todo: we probably should disable interrupts when device is
>> created. ]
>>     
>
> Yep, minor wart.
>
>   
>> - We poll for buffer completions:
>> 	  1. Before each TX 2. On a timer tasklet (unless 3 is supported)
>>           3. When host sends us interrupt telling us that the queue is
>> empty [ mst: idea to try: instead of empty, enable send interrupts on xmit
>> when buffer is almost full (e.g. at least half empty): we are running out
>> of buffers, it's important to free them ASAP. Can be done from host or from
>> guest. ]
>>           [ Rusty proposing that we don't need (2) or (3) if the skbs are
>> orphaned before start_xmit(). See subj "net: skb_orphan on
>> dev_hard_start_xmit".] [ rusty also seems to be suggesting that disabling
>> VIRTIO_F_NOTIFY_ON_EMPTY on the host should help the case where the host
>> out-paces the guest ]
>>     
>
> Yes, that's more fruitful.
>
>   
>>         - Each skb has a 128 byte buffer at head and a single page for
>> data. Only full pages are passed to virtio buffers.
>>           [ mst: for large packets, managing the 128 head buffers is wasted
>>             effort. Try allocating skbs on rcv path when needed. ].
>> 	    [ mst: to clarify the previos suggestion: I am talking about
>> 	    merging here.  We currently allocate skbs and pages for them. If a
>> packet spans multiple pages, we discard the extra skbs.  Instead, let's
>> allocate pages but not skbs. Allocate and fill skbs on receive path. ]
>>     
>
> Yep.  There's another issue here, which is alignment: packets which get placed 
> into pages are misaligned (that 14 byte ethernet header).  We should add a 
> feature to allow the host to say "I've skipped this many bytes at the front".
>
>   
>> 	- Buffers are replenished after packet is received,
>>           when number of buffers becomes low (below 1/2 max).
>>           This serves to reduce the number of kicks (VMexits) for RX.
>>           [ mst: code might become simpler if we add buffers
>>             immediately, but don't kick until later]
>> 	  [ markmc: possibly. batching this buffer allocation might be
>> 	    introducing more unpredictability to benchmarks too - i.e. there isn't
>> a fixed per-packet overhead, some packets randomly have a higher overhead]
>> on failure to allocate in atomic context we simply stop
>>           and try again on next recv packet.
>>           [mst: there's a fixme that this fails if we complete run out of
>> buffers, should be handled by timer. could be a thread as well (allocate
>> with GFP_KERNEL).
>>                 idea: might be good for performance anyway. ]
>>     
>
> Yeah, this "batched packet add" is completely unscientific.  The host will be 
> ignoring notifications anyway, so it shouldn't win anything AFAICT.  Ditch it 
> and benchmark.
>
>   
>> 	  After adding buffers, we do a kick.
>>           [ mst: test whether this optimization works: recv kicks should be
>> rare ] Outstanding buffers are kept on recv linked list.
>> 	  [ mst: optimization idea: virtqueue already tracks
>>             posted buffers. Add flush operation and use that instead. ]
>>     
>
> Don't understand this comment?
>
>   
>> 	- recv is done with napi: on recv interrupt, disable interrupts
>>           poll until queue is empty, enable when it's empty
>>          [mst: test how well does this work. should get 1 interrupt per
>>           N packets. what is N?]
>>     
>
> It works if the guest is outpacing the host, but in practice I had trouble 
> getting above about 2:1.  I've attached a spreadsheet showing the results of 
> various tests using lguest.  You can see the last one "lguest:net-delay-for-
> more-output.patch" where I actually inserted a silly 50 usec delay before 
> sending the receive interrupt: 47k irqs for 1M packets is great, too bad about 
> the latency :)
>
>   
>>          [mst: idea: implement interrupt coalescing? ]
>>     
>
> lguest does this in the host, with mixed results.  Here's the commentry from 
> my lguest:reduce_triggers-on-recv.patch (which is queued for linux-next as I 
> believe it's the right thing even though win is in the noise).
>
> lguest: try to batch interrupts on network receive
>
> Rather than triggering an interrupt every time, we only trigger an
> interrupt when there are no more incoming packets (or the recv queue
> is full).
>
> However, the overhead of doing the select to figure this out is
> measurable: 1M pings goes from 98 to 104 seconds, and 1G Guest->Host
> TCP goes from 3.69 to 3.94 seconds.  It's close to the noise though.
>
> I tested various timeouts, including reducing it as the number of
> pending packets increased, timing a 1 gigabyte TCP send from Guest ->
> Host and Host -> Guest (GSO disabled, to increase packet rate).
>
> // time tcpblast -o -s 65536 -c 16k 192.168.2.1:9999 > /dev/null
>
> Timeout		Guest->Host	Pkts/irq	Host->Guest	Pkts/irq
> Before		11.3s		1.0		6.3s		1.0
> 0		11.7s		1.0		6.6s		23.5
> 1		17.1s		8.8		8.6s		26.0
> 1/pending	13.4s		1.9		6.6s		23.8
> 2/pending	13.6s		2.8		6.6s		24.1
> 5/pending	14.1s		5.0		6.6s		24.4
>
>   
>> 	[mst: some architectures (with expensive unaligned DMA) override
>> NET_IP_ALIGN. since we don't really do DMA, we probably should use
>> alignment of 2 always]
>>     
>
> That's unclear: what if the host is doing DMA?
>
>   
>> 		[ mst: question: there's a FIXME to avoid modulus in the math.
>>                   since num is a power of 2, isn't this just & (num - 1)?]
>>     
>
> Exactly.
>
>   
>> 	Polling buffer:
>> 		we look at vq index and use that to find the next completed buffer
>> 		the pointer to data (skb) is retrieved and returned to user
>> 		[ mst: clearing data is only needed for debugging.
>>                   try removing this write - cache will be cleaner? ]
>>     
>
> It's our only way of detecting issues with hosts.  We have reports of BAD_RING 
> being triggered (unf. not reproducible).
>
>   
>> TX:
>> 	We poll for TX packets in 2 ways
>> 	- On timer event (see below)
>> 	- When we get a kick from guest
>> 	  At this point, we disable further notifications,
>> 	  and start a timer. Notifications are reenabled after this.
>> 	  This is designed to reduce the number of VMExits due to TX.
>> 	  [ markmc: tried removing the timer.
>>             It seems to really help some workloads. E.g. on RHEL:
>>             http://markmc.fedorapeople.org/virtio-netperf/2009-04-15/
>>             on fedora removing timer has no major effect either way:
>> 	   
>> http://markmc.fedorapeople.org/virtio-netperf/2008-11-06/g-h-tput-04-no-tx-
>> timer.html ]
>>     
>
> lguest went fully multithreaded, dropped timer hack.  Much nicer, and faster.  
> (See second point on graph).  Timers are a hack because we're not async, so 
> fixing the real problem avoids that optimization guessing game entirely.
>
>   
>> 	Packets are polled from virtio ring, walking descriptor linked list.
>> 	[ mst: optimize for completing in order? ]
>> 	Packet addresses are converted to guest iovec, using
>> 	cpu_physical_memory_map
>> 	[ mst: cpu_physical_memory_map could be optimized
>>           to only handle what we actually use this for:
>>           single page in RAM ]
>>     
>
> Anthony had a patch for this IIRC.
>
>   
>> Interrupts will be reported to eventfd descriptors, and device will poll
>> eventfd descriptors to get kicks from guest.
>>     
>
> This is definitely a win.  AFAICT you can inject interrupts into the guest from 
> a separate thread today in KVM, too, so there's no core reason why devices 
> can't be completely async with this one change.
>
> Cheers,
> Rusty.
>
>
>   
