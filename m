From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: TODO list for qemu+KVM networking performance v2
Date: Thu, 4 Jun 2009 19:43:20 +0300
Message-ID: <20090604164320.GB14592__14371.2173369297$1244134309$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dor Laor <dlaor@redhat.com>
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, Yaron Haviv <yaronh@voltaire.com>, Shahar Klein <shahark@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

As I'm new to qemu/kvm, to figure out how networking performance can be improved, I
went over the code and took some notes.  As I did this, I tried to record ideas
from recent discussions and ideas that came up on improving performance. Thus
this list.

This includes a partial overview of networking code in a virtual environment, with
focus on performance: I'm only interested in sending and receiving packets,
ignoring configuration etc.

I have likely missed a ton of clever ideas and older discussions, and probably
misunderstood some code. Please pipe up with corrections, additions, etc. And
please don't take offence if I didn't attribute the idea correctly - most of
them are marked mst by I don't claim they are original. Just let me know.

And there are a couple of trivial questions on the code - I'll
add answers here as they become available.

I out up a copy at http://www.linux-kvm.org/page/Networking_Performance as
well, and intend to dump updates there from time to time.

Thanks,
MST

---

There are many ways to set up networking in a virtual machone.
here's one: linux guest -> virtio-net -> virtio-pci -> qemu+kvm -> tap -> bridge.
Let's take a look at this one.

Virtio is the guest side of things.

Guest kernel virtio-net:

TX:
	- Guest kernel allocates a packet (skb) in guest kernel memory
          and fills it in with data, passes it to networking stack.
	- The skb is passed on to guest network driver
          (hard_start_xmit)
	- skbs in flight are kept in send queue linked list,
	  so that we can flush them when device is removed
	  [ mst: optimization idea: virtqueue already tracks
            posted buffers. Add flush/purge operation and use that instead? ]
        - skb is reformatted to scattergather format
          [ mst: idea to try: this does a copy for skb head,
            which might be costly especially for small/linear packets.
	    Try to avoid this? Might need to tweak virtio interface.
          ]
        - network driver adds the packet buffer on TX ring
	- network driver does a kick which causes a VM exit
          [ mst: any way to mitigate # of VM exits here?
            Possibly could be done on host side as well. ]
	  [ markmc: All of our efforts there have been on the host side, I think
            that's preferable than trying to do anything on the guest side. ]

	- Full queue:
		we keep a single extra skb around:
			if we fail to transmit, we queue it
			[ mst: idea to try: what does it do to
                          performance if we queue more packets? ]
		if we already have 1 outstanding packet,
		we stop the queue and discard the new packet
		[ mst: optimization idea: might be better to discard the old
                  packet and queue the new one, e.g. with TCP old one
                  might have timed out already ]
	        [ markmc: the queue might soon be going away:
                   200905292346.04815.rusty@rustcorp.com.au
                   http://archive.netbsd.se/?ml=linux-netdev&a=2009-05&m=10788575
                ]

	- We get each buffer from host as it is completed and free it
        - TX interrupts are only enabled when queue is stopped,
          and when it is originally created (we disable them on completion)
          [ mst: idea: second part is probably unintentional.
            todo: we probably should disable interrupts when device is created. ]
        - We poll for buffer completions:
	  1. Before each TX 2. On a timer tasklet (unless 3 is supported)
          3. When host sends us interrupt telling us that the queue is empty
	  [ mst: idea to try: instead of empty, enable send interrupts on xmit when
            buffer is almost full (e.g. at least half empty): we are running out of
            buffers, it's important to free them ASAP. Can be done
            from host or from guest. ]
          [ Rusty proposing that we don't need (2) or (3) if the skbs are orphaned
            before start_xmit(). See subj "net: skb_orphan on dev_hard_start_xmit".]
          [ rusty also seems to be suggesting that disabling VIRTIO_F_NOTIFY_ON_EMPTY
	    on the host should help the case where the host out-paces the guest
          ]
	  4. when queue is stopped or when first packet was sent after device
             was created (interrupts are enabled then)


RX:
	- There are really 2 mostly separate code paths: with mergeable
          rx buffers support in host and without. I focus on mergeable
          buffers here since this is the default in recent qemu.
	  [mst: optimization idea: mark mergeable_rx_bufs as likely() then?]
        - Each skb has a 128 byte buffer at head and a single page for data.
          Only full pages are passed to virtio buffers.
          [ mst: for large packets, managing the 128 head buffers is wasted
            effort. Try allocating skbs on rcv path when needed. ].
	    [ mst: to clarify the previos suggestion: I am talking about
	    merging here.  We currently allocate skbs and pages for them. If a packet
	    spans multiple pages, we discard the extra skbs.  Instead, let's allocate
	    pages but not skbs. Allocate and fill skbs on receive path. ]

          Pages are allocate from our private buffer before fallback to alloc_page.
          See below.

	- Buffers are replenished after packet is received,
          when number of buffers becomes low (below 1/2 max).
          This serves to reduce the number of kicks (VMexits) for RX.
          [ mst: code might become simpler if we add buffers
            immediately, but don't kick until later]
	  [ markmc: possibly. batching this buffer allocation might be
	    introducing more unpredictability to benchmarks too - i.e. there isn't a
	    fixed per-packet overhead, some packets randomly have a higher overhead]
	  on failure to allocate in atomic context we simply stop
          and try again on next recv packet.
          [mst: there's a fixme that this fails if we complete run out of buffers,
                should be handled by timer. could be a thread as well
                (allocate with GFP_KERNEL).
                idea: might be good for performance anyway. ]
	  After adding buffers, we do a kick.
          [ mst: test whether this optimization works: recv kicks should be rare ]
           Outstanding buffers are kept on recv linked list.
	  [ mst: optimization idea: virtqueue already tracks
            posted buffers. Add flush operation and use that instead. ]

	- recv is done with napi: on recv interrupt, disable interrupts
          poll until queue is empty, enable when it's empty
         [mst: test how well does this work. should get 1 interrupt per
          N packets. what is N?]
         [mst: idea: implement interrupt coalescing? ]

	- when recv packet is polled, first 128 bytes are copied out,
          the rest is collected in the array of frags.
          if packet spans multiple buffers, unused skbs are discarded.
          If packet is < 128, the page is added to pool, see below.
          The packet is then sent up the networking stack.

	- we have a pool of pages (LIFO) which are left unused
          at the tail of the buffer for short packets (< 128)
         [mst: test how common is it for poll to be nonempty.]
	 [mst: for short skbs, the new buffer we will allocate
          and re-add is identical to the old one. try just copying
          the sg over instead of re-formatting.
	]
        [mst: try using circular buffer instead of linked list for pool ]
        [mst: is it a good idea to limit pool size? ]
        [mst: need to measure: for large messages, the pool might become empty fast.
         replenish it from thread context with GFP_KERNEL pages?]
	[mst: some architectures (with expensive unaligned DMA) override NET_IP_ALIGN.
         since we don't really do DMA, we probably should use alignment of 2 always]

Guest kernel virtio-ring:
	Adding buffer:
		the ring keeps a LIFO free list of ring entries
		[ mst: idea to try: it should be pretty common
                  for entries to complete in-order.
                  use circular buffer to optimize for that case,
		  and fall back on free list if not. ]
		[ mst: question: there's a FIXME to avoid modulus in the math.
                  since num is a power of 2, isn't this just & (num - 1)?]
	Polling buffer:
		we look at vq index and use that to find the next completed buffer
		the pointer to data (skb) is retrieved and returned to user
		[ mst: clearing data is only needed for debugging.
                  try removing this write - cache will be cleaner? ]

Guest kernel virtio-pci:
	notify (kick):
		to notify host of ring activity, we perform pio write
		[ mst: hypercalls are reported to be slightly cheaper ... ]
	interrupt:
		on interrupt, we invoke the callback for the relevant vq
                for regular interrupts, we clear the interrupt, and scan
                list of vqs invoking callbacks
		[ mst: test whether msi-x/msi works better ]


Host qemu:

TX:
	We poll for TX packets in 2 ways
	- On timer event (see below)
	- When we get a kick from guest
	  At this point, we disable further notifications,
	  and start a timer. Notifications are reenabled after this.
	  This is designed to reduce the number of VMExits due to TX.
	  [ markmc: tried removing the timer.
            It seems to really help some workloads. E.g. on RHEL:
            http://markmc.fedorapeople.org/virtio-netperf/2009-04-15/
            on fedora removing timer has no major effect either way:
	    http://markmc.fedorapeople.org/virtio-netperf/2008-11-06/g-h-tput-04-no-tx-timer.html
	  ]
	  [ markmc: had patches moving the "flush tx queue on ring full" into the I/O thread.
	  http://markmc.fedorapeople.org/virtio-netperf/2008-11-06/g-h-tput-02-flush-in-io-thread.html
          the graph seems to show no effect on performance.
	  ]
	  [ mst: it is interesting that to start timer,
	    we use qemu_get_clock which does a systemcall. ]
	  [ mst: test how well does this work. We should get
            a kick once for N packets. ]
	  [ mst: idea: instead of enabling interrupts after draining the queue,
            try waiting another timer tick ... ]
	  [ mst: test whether the queue gets full. It will if timer is too
	    large. If yes we might ask the guest to force notification so we drain the
	    queue ASAP. ]
          [ markmc: I actually don't think we hit ring-full often ]
	  [ mst: it would be easy to kill the timer in host and never
            disable interrupts, do all decisions on notification in guest.
	    However timers are more costly there. ]
	  [ avi: short timers are very expensive in the guest: need to exit to
	    set the timer, another to fire, yet another to to EOI ]
	Packets are polled from virtio ring, walking descriptor linked list.
	[ mst: optimize for completing in order? ]
	Packet addresses are converted to guest iovec, using
	cpu_physical_memory_map
	[ mst: cpu_physical_memory_map could be optimized
          to only handle what we actually use this for:
          single page in RAM ]
	With tap, we pass this to vlan and eventually call writev
	on tap device
	[ mst: if there's a single vlan, as is common,
	  we could optimize the vlan scan and pass packets to
	  final destination directly ]
	[ rusty: write system call could be optimized out
          by implementing a virtio server in kernel ]
        [ markmc: vlans just should not be used in common case ]

	An interesting thing to note here is that we don't
	try to limit the number of packets outstanding on tap
	device. So there's never "full queue".
	[ mst: with UDP this likely leads to overruns and packet drops.
	  what about TCP?]
        [ markmc: probably just UDP: we hit the TCP window size first. ]
	[ mst: 2.6.30-rcX kernels let us limit the number of packets outstanding
          on tap. Use this? ]
	[ markmc: see my patches (subj: Add generic packet buffering API)
          on qemu mailing list which will allow us
          to hanle -EAGAIN from tap without having to unpop the buffer
          from the virtio ring or poll()ing the fd for each packet. ]

	[ avi: tap could implement an option to send multiple packets
          with a single write]

	Finally, we deliver queue interrupt if the guest asked for it.

RX:
	RX is done from IO thread. We get notification that more buffers
        have been posted and wake that thread.
	[ mst: test how common this is. should be once per many packets ]
	[ mst: would it be better to extend tap to consume packets on the same
          CPU which got them? ]
	When a packet arrives at the network interface, we read it in,
	and then copy over into virtio buffer.
	[ dlaor: reading directly into the virtio buffer would be
	  a low-hanging fruit ]
	[ markmc: anthony had patches to do this a long time ago but they were
	  fairly ugly. Should be easier to do when we remove VLANs from the common
	  case - i.e. only copy if a VLAN is used ]
	[ rusty: read system call could be optimized out
          by implementing a virtio server in kernel ]
	While we copy, we implement a work around for dhclient there.
	[ mst: for zero copy will need a flag to disable it.
	  or just make header not zero copy? ]
	[ mst: we can implement a kind of interrupt coalescing scheme,
          where we don't send an RX interrupt until
          we start getting low on RX buffers, or until
          tap device recv queue is empty ]
	[ avi: tap could implement an option to recv multiple packets
          with a single read]

Host kernel networking stack with tap and bridge:
This is not specific to virtualization so just some notes:

- There are packet copies from/to userspace in both TX and RX paths.
  [mst: TX might be addressable with aio and data destructors.
        RX is known as a hard problem]
- If the real TX queue packets are sent on is full and is stopped,
  this fact does not propagate to tap and to the user.
  This will result in more packets being sent and lost.
	[ mst: as mentioned above, one way to address this is
	  to limit the number of packets outstanding on
	  tap. Note that this might not fully solve the
	  problem as the queue could get used by other applications.
	  Is there some flow control mechanism in bridge we could use?].
- markmc: another thing we need to do is to disable bridge-nf-call-iptables by
  default at the distro level. It defeats the tap send buffer accounting
  and probably hurts performance.
- bridging in host is unnecessary if have a dedicated network device.
  it might be interesting to support binding to raw sockets
  instead of tap.
  [ mst: what is the overhead of bridging isn't it negligeable? ]
  [ mst: for this, it might be interesting to suport aio in raw sockets,
    which will make it possible to pre-post RX buffers in raw sockets ]

---

Short term plans: I plan to start out with trying out the following ideas:

save a copy in qemu on RX side in case of a single nic in vlan
implement virtio-host kernel module

*detail on virtio-host-net kernel module project*

virtio-host-net is a simple character device which gets memory layout information
from qemu, and uses this to convert between virtio descriptors to skbs.
The skbs are then passed to/from raw socket (or we could bind virtio-host
to physical device like raw socket does TBD).

Interrupts will be reported to eventfd descriptors, and device will poll
eventfd descriptors to get kicks from guest.

-- 
MST
