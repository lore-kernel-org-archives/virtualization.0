From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost questions.
Date: Mon, 18 Mar 2013 10:06:56 +0200
Message-ID: <20130318080656.GA4512@redhat.com>
References: <874ngfvlo0.fsf@rustcorp.com.au>
	<20130313155916.GC14892@redhat.com>
	<87wqtatrj5.fsf@rustcorp.com.au>
	<20130314093342.GC14977@redhat.com>
	<87y5dlsf8e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87y5dlsf8e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 18, 2013 at 11:20:41AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, Mar 14, 2013 at 05:08:22PM +1030, Rusty Russell wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> > On Wed, Mar 13, 2013 at 05:19:51PM +1030, Rusty Russell wrote:
> >> >> OK, I've been trying to read the vhost and vhost net code, and I'm
> >> >> struggling with basic questions.
> >> >> 
> >> >> 1) Why do we allow userspace to change an already-set-up vhost device?
> >> >>    Why not have:
> >> >>         open()
> >> >>         ioctl(VHOST_GET_FEATURES)
> >> >>         ioctl(VHOST_SET_VRING) x n (sets num, addresses, kick/call/err fds)
> >> >>         ioctl(VHOST_NET_SETUP)
> >> >>         ...
> >> >>         close()
> >> >> 
> >> >>    You're not allowed to call things twice: to reset, you close and
> >> >>    reopen.  That would save a lot of code which I'm not sure is correct
> >> >>    anyway.
> >> >
> >> > This won't work for the usecases we have in qemu.
> >> > The way things are setup currently, qemu typically does not have
> >> > the rights to open any char devices, instead it is passed an fd.
> >> 
> >> Ah, because creating a vhost fd is privileged?  Why?  Because it creates
> >> a kernel thread?  Why?
> >> 
> >> Using a model where a userspace process/thread manages the ring (even if
> >> it spends 99.99% of its time in the kernel) would avoid this.  This is
> >> how KVM itself works, it's no longer privileged.
> >
> > KVM kind of has to have a thread per VCPU, no other options.
> 
> Not at all!  It could spin off a helper kernel thread to do the work and
> come up with some IPC.  But there's a damn good reason that it didn't,
> nor did lguest.
> 
> That same reasoning applies here, too.  The fact that you create a
> kernel thread then give it the same context and cgroup etc should be the
> clue!
> 
> > Here I don't think we know what the best threading model is.
> > We used to have a per-CPU thread, switched to thread pair vq *pair* and
> > there are patches to go back to per-CPU threads, they seem to improve
> > scalability though there are still some open issues wrt cgroups.
> > Using a kernel thread means we can control this without touching userspace.
> 
> But kernelspace is the wrong place to make these decisions.
> 
> Let's try to imagine what it'd be like if we didn't do it this way, say
> a /dev/vhost-net2 device.  You use an ioctl to set up the memory
> mapping, the (tun) fd, the location of a xmit ring and a recv ring (you
> specify one or both... we could have separate xmit and recv devices, but
> that seems a bit overkill).
> 
> Now:
> 1) Simplest case, you want a dumb implementation with no extra threads
>    in your code.  Using select(), if tun fd is readable and vhost-net2 fd is
>    writable, call ioctl(VHOST_NET_RECV), which processes as many packets
>    as it can.  If tun fd is writable and vhost-net2 fd is readable, call
>    ioctl(VHOST_NET_XMIT).
> 
> 2) You want an I/O thread in your code?  That's easy, too.  You might
>    skip the writable fd checks, and just let the ioctl() block.
> 
> 3) Want separate I/O threads?  Separate /dev/vhost-net2 fds, one one
>    only sets the xmit ring, one only sets the recv ring.  They just
>    call ioctl() over and over.
> 
> 4) Multiqueue comes along?  It only makes sense with separate threads
>    per queue, so open /dev/vhost-net2 and tunfd once for each thread.
>    Do your per-cpu binding here.
> 
> Now, there may be issues if we actually coded this, but it *seems* sane.

Doing a per-cpu thread (without multiqueue) may be harder though.  Or at
least I don't see a nice way to do it. This is what we started with, and
the interface to allow it stayed around to avoid breaking userspace.

> >> A simple implementation which supports live migration would have to have
> >> enough understanding to save and restore the net state.  With a tun
> >> device (which handles all the header stuff), supporting networking is
> >> *trivial*: see lguest (though it needs MRG_RXBUF support).  It's about
> >> 100 lines.
> >
> > You assume networking is stopped while we migrate but this doesn't work
> > as migration might take a long time.  So you have to have the full
> > device, processing rings and sending/receiving packets all in userspace.
> 
> No I don't: 100 lines of code *is* a full networking device.
> 
> >> > +        * We also trigger polling periodically after each 16 packets
> >> > +        * (the value 16 here is more or less arbitrary, it's tuned to trigger
> >> > +        * less than 10% of times).
> >> >
> >> > If you have any suggestions on how to improve this,
> >> 
> >> But this code does *not* wake every 16 packets.
> 
> It wakes when the reference count hits 16, 32, etc.  But that reference
> count will go up and down as packets are processed: in theory, it might
> go 0, 1, 2, 3, 2, 3, 2, 3, 2, 3, 2, 3, 2, 3... ?

I see. True. But it's just an optimization, cnt <= 2 makes sure there's
no deadlock.

> >> Anyway, what happens when we wake it?  I'm assuming it's the net tx
> >> worker, which will just return the used bufs to the guest?  Wouldn't it
> >> be better to do that directly?  Maybe wake the tx worker if it needs to
> >> wake the guest, if we can't do that here.
> >
> > Sorry I don't get what you mean here.
> 
> Let's check I've got this straight:
> 
> Packet is fully xmitted:
>        -> skb_release_data -> vhost_zerocopy_callback -> vhost_poll_queue()
> 
>        Wakes up tx thread -> handle_tx_kick -> handle_tx
>              -> vhost_zerocopy_signal_used -> vhost_add_used_and_signal()

Exactly.

> But what if we kmapped the ring so we could access it in
> vhost_zerocopy_callback?  We could skip the wakeup altogether, right?
>
> And it happens that I just wrote vringh accessors that work on
> kernelspace, so it should be easier than it was before... :)
> 

Hmm this should be better for a latency test where we wake up every time,
but could worse for a bandwidth test.

One thing making it a bit harder is the need to implement flush for when
memory mappings change. I guess we could make the tx_flush flag atomic.

> >> But most importantly, it's *not* the host's problem to fix!  Just keep
> >> the damn latency low.
> >
> > OK, let's try to rip it out and see what happens.
> 
> Thanks!  That'll make things much simpler for me to understand :)
> 
> >> >> 4) Why are the following fields in struct vhost_virtqueue, not struct
> >> >>    vhost_net?
> >> >> 
> >> >> 	/* hdr is used to store the virtio header.
> >> >> 	 * Since each iovec has >= 1 byte length, we never need more than
> >> >> 	 * header length entries to store the header. */
> >> >> 	struct iovec hdr[sizeof(struct virtio_net_hdr_mrg_rxbuf)];
> >> >> 	size_t vhost_hlen;
> >> >> 	size_t sock_hlen;
> >> >> 	struct vring_used_elem *heads;
> >> >> 
> >> >>         ...
> >> >
> >> > Because these are used for both tx and rx.  While we handle both from
> >> > the same thread at the moment, so we could reuse same fields, there are
> >> > some patches by Anthony that process tx and rx in separate threads and
> >> > sometimes it's a win. So I don't want to close the door on that.
> >> 
> >> But they're *net* specific: They don't belong in the vhost structure.
> >
> > Ah, I see what you mean. Yes, we really need vhost_net_virtqueue,
> > we didn't have one and I let some net specific stuff seep through.
> > We should do something like
> 
> Thanks.  I'll put that in my tree and start playing with it.

Hmm no need to keep it out of upstream I think.

> >> We do something like:
> >> 
> >>         err = tun_inject_skb(sock, skb);
> >> 
> >> Because the zerocopy_sg_from_iovec() in tun.c already has a comment
> >> about putting it in the network core... in fact, it's cut & pasted into
> >> macvtap :(
> >
> > Right. There's lots of code duplication in tun, macvtap and af_packet,
> > we could factor code out, and then use it everywhere.
> >
> >> The msg thing for the callback is a nasty hack, AFAICT...
> >
> > Yes it's not pretty.
> 
> OK, I'll see what I can do.
> 
> > Sure, we have lots going on with vhost scsi ATM, but as long as changes
> > are done in small steps I'll figure out conflicts if any without much
> > trouble.
> 
> Yep, I think it can be done.  I've done some patches so far, and the
> impact on tcm_vhost has been minimal...
> 
> Thanks,
> Rusty.
