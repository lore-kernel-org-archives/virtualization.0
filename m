From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost questions.
Date: Wed, 13 Mar 2013 17:59:16 +0200
Message-ID: <20130313155916.GC14892@redhat.com>
References: <874ngfvlo0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <874ngfvlo0.fsf@rustcorp.com.au>
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

On Wed, Mar 13, 2013 at 05:19:51PM +1030, Rusty Russell wrote:
> OK, I've been trying to read the vhost and vhost net code, and I'm
> struggling with basic questions.
> 
> 1) Why do we allow userspace to change an already-set-up vhost device?
>    Why not have:
>         open()
>         ioctl(VHOST_GET_FEATURES)
>         ioctl(VHOST_SET_VRING) x n (sets num, addresses, kick/call/err fds)
>         ioctl(VHOST_NET_SETUP)
>         ...
>         close()
> 
>    You're not allowed to call things twice: to reset, you close and
>    reopen.  That would save a lot of code which I'm not sure is correct
>    anyway.

This won't work for the usecases we have in qemu.
The way things are setup currently, qemu typically does not have
the rights to open any char devices, instead it is passed an fd.


> 2) Why do we implement write logging?  Shouldn't qemu just switch to
>    emulation if it wants to track writes?

We could do it this way.  Originally vhost didn't do logging,
but Anthony felt it's cleaner this way.  We argued this way and that, in
the end I agreed it's better to always process rings in vhost, leave
userspace alone. For example this allows a simpler userspace that does
not implement tx/rx ring processing at all.

> 3) Why do we have our own workqueue implementation?

We used to use a workqueue, but Tejun Heo required this switch.
Basically we want everything run from one thread so we
can apply cgroup limits to this thread. workqueue does not
guarantee it - one thread is an implementation detail.

> vhost/net.c questions:
> 
> 1) Why do we wake the net tx worker every time the reference count of
>    the number of outstanding DMAs is a multiple of 16?

Waking every time turns out to be wasteful. Waking only when nothing is
outstanding turns out to be slow. The comment says it all really:

+        * We also trigger polling periodically after each 16 packets
+        * (the value 16 here is more or less arbitrary, it's tuned to trigger
+        * less than 10% of times).

If you have any suggestions on how to improve this,

> 
> 3) Why don't we simply use a slab allocator to allocate a structure for
>    outstanding xmit dmas?  Wouldn't that be far simpler?  Would it be
>    slower?

Which structure for outstanding xmit dmas? ubufs?  We could use a cache
maybe, plan slab is usually pretty slow.

I think what you are really worried about is the upend/done index thing?
It's not really there because of the array really.
It's because we try to order the completion of zero copy buffers
in the same order they are submitted. This was because I was worried about
triggering fragmentation of the descriptor ring (Avi kept raising this
concern).


> 4) Why are the following fields in struct vhost_virtqueue, not struct
>    vhost_net?
> 
> 	/* hdr is used to store the virtio header.
> 	 * Since each iovec has >= 1 byte length, we never need more than
> 	 * header length entries to store the header. */
> 	struct iovec hdr[sizeof(struct virtio_net_hdr_mrg_rxbuf)];
> 	size_t vhost_hlen;
> 	size_t sock_hlen;
> 	struct vring_used_elem *heads;
> 
>         ...

Because these are used for both tx and rx.  While we handle both from
the same thread at the moment, so we could reuse same fields, there are
some patches by Anthony that process tx and rx in separate threads and
sometimes it's a win. So I don't want to close the door on that.

> 
> 	/* vhost zerocopy support fields below: */
> 	/* last used idx for outstanding DMA zerocopy buffers */
> 	int upend_idx;
> 	/* first used idx for DMA done zerocopy buffers */
> 	int done_idx;
> 	/* an array of userspace buffers info */
> 	struct ubuf_info *ubuf_info;
> 	/* Reference counting for outstanding ubufs.
> 	 * Protected by vq mutex. Writers must also take device mutex. */
> 	struct vhost_ubuf_ref *ubufs;

Only used from tx. I was trying to keep the option of multiple
tx rings in one vhost, and the option of rx zero copy open, but it's not
a must.

> 5) Why does vhost_net use the sendmsg interface for tun (and macvlan?)?
>    It's not usable from userspace (it looks like if you can sendmsg to a
>    tun device you can make it call an arbitrary pointer though).

Yes we could switch to some other interface, but only if we
deprecate the packet socket backend and remove it at some point.

>    It would be better for us to create the skb, and have a special
>    interface to inject it directly.  This way we can handle the
>    UIO_MAXIOV limit ourselves (eg. by not doing zero copy on such stupid
>    cases).

Basically because userspace already configures the backend with existing
tun ioctls. This way we don't need to introduce new interfaces for this,
just virtio stuff for vhost net.  It's also good that we share code with
tun, often both vhost and virtio processing can gain from same
optimizations and new features. Happened in the past already.

Basically not many people care about virt. The less virt specific
code we have the better.  I lost count of times I had this dialog when I
needed some help
- we see this problem XYZ in host net stack
- oh it's vhost I don't know what it does, sorry
- actually it only builds up iovecs all networking is done by tun that
  everyone uses
- ok then let me take a look

> 6) By calling tun_get_socket() and macvtap_get_socket() we are forcing
>    those modules to load.  We should use symbol_get() to avoid this.

Good idea.

> In short, this code is a mess.  Assuming we can't just break the API,
> we've got a long process ahead of us to get it into shape :(
> 
> Thanks,
> Rusty.

Zerocopy path is the most messy I think.  We should really consider
removing the ordering of zero copy buffers. The rest I don't consider
so messy, and it should be easy to cleanup zerocopy without
breaking the API.

-- 
MST
