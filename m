From: Rusty Russell <rusty@rustcorp.com.au>
Subject: vhost questions.
Date: Wed, 13 Mar 2013 17:19:51 +1030
Message-ID: <874ngfvlo0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

OK, I've been trying to read the vhost and vhost net code, and I'm
struggling with basic questions.

1) Why do we allow userspace to change an already-set-up vhost device?
   Why not have:
        open()
        ioctl(VHOST_GET_FEATURES)
        ioctl(VHOST_SET_VRING) x n (sets num, addresses, kick/call/err fds)
        ioctl(VHOST_NET_SETUP)
        ...
        close()

   You're not allowed to call things twice: to reset, you close and
   reopen.  That would save a lot of code which I'm not sure is correct
   anyway.

2) Why do we implement write logging?  Shouldn't qemu just switch to
   emulation if it wants to track writes?

3) Why do we have our own workqueue implementation?

vhost/net.c questions:

1) Why do we wake the net tx worker every time the reference count of
   the number of outstanding DMAs is a multiple of 16?

2) Why is vhost_ubuf_ref kmalloced, rather than a structure member?

3) Why don't we simply use a slab allocator to allocate a structure for
   outstanding xmit dmas?  Wouldn't that be far simpler?  Would it be
   slower?

4) Why are the following fields in struct vhost_virtqueue, not struct
   vhost_net?

	/* hdr is used to store the virtio header.
	 * Since each iovec has >= 1 byte length, we never need more than
	 * header length entries to store the header. */
	struct iovec hdr[sizeof(struct virtio_net_hdr_mrg_rxbuf)];
	size_t vhost_hlen;
	size_t sock_hlen;
	struct vring_used_elem *heads;

        ...

	/* vhost zerocopy support fields below: */
	/* last used idx for outstanding DMA zerocopy buffers */
	int upend_idx;
	/* first used idx for DMA done zerocopy buffers */
	int done_idx;
	/* an array of userspace buffers info */
	struct ubuf_info *ubuf_info;
	/* Reference counting for outstanding ubufs.
	 * Protected by vq mutex. Writers must also take device mutex. */
	struct vhost_ubuf_ref *ubufs;

5) Why does vhost_net use the sendmsg interface for tun (and macvlan?)?
   It's not usable from userspace (it looks like if you can sendmsg to a
   tun device you can make it call an arbitrary pointer though).

   It would be better for us to create the skb, and have a special
   interface to inject it directly.  This way we can handle the
   UIO_MAXIOV limit ourselves (eg. by not doing zero copy on such stupid
   cases).

6) By calling tun_get_socket() and macvtap_get_socket() we are forcing
   those modules to load.  We should use symbol_get() to avoid this.

In short, this code is a mess.  Assuming we can't just break the API,
we've got a long process ahead of us to get it into shape :(

Thanks,
Rusty.
