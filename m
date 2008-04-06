From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Sun, 6 Apr 2008 13:03:32 +1000
Message-ID: <200804061303.32692.rusty__5117.22281012243$1207451170$gmane$org@rustcorp.com.au>
References: <200804052202.09157.rusty__7324.67876882783$1207397085$gmane$org@rustcorp.com.au>
	<47F7B345.1080200@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F7B345.1080200@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 April 2008 03:13:41 Anthony Liguori wrote:
> > +	void *buf = calloc(vring_size(256, getpagesize()), 0);
>
> Shouldn't this be calloc(1, vring_size(256, getpagesize()));?

Heh, yes... spot the last minute change from malloc to calloc.

> > +	if (r != 0)
> > +		err(1, "poll after used incremented gave %i", r);
>
> I have a tough time seeing what you're demonstrating here.  Perhaps some
> comments?

Well, not I have lguest working, I can just blow away the test program.  It
just tests poll.

> > +config VRINGFD
> > +       bool "vring fd support (EXPERIMENTAL)"
> > +       depends on EXPERIMENTAL
> > +       help
> > +         vring is a ringbuffer implementation for efficient I/O.  It is
> > +	 currently used by virtualization hosts (lguest, kvm) for efficient
> > +	 networking using the tun driver.
> > +
> > +	 If unsure, say N.
> > +
>
> Should select VIRTIO && VIRTIO_RING

I don't think so.  It doesn't depend on either.

> > +/* Returns an error, or 0 (no buffers), or an id for vring_used_buffer()
> > */ +int vring_get_buffer(struct vring_info *vr,
> > +		     struct iovec *in_iov,
> > +		     unsigned int *num_in, unsigned long *in_len,
> > +		     struct iovec *out_iov,
> > +		     unsigned int *num_out, unsigned long *out_len)
> > +{
>
> It seems unlikely that a caller could place both in_iov/out_iov on the
> stack since to do it safely, you would have to use vring.num which is
> determined by userspace.  Since you have to kmalloc() the buffers
> anyway, why not just allocate a single data structure within this
> function and return it.

This needs a comment. num_out and num_in are in parameters specifying the 
maximum of each.

> > +	/* If they want to use atomically, we have to map the page. */
> > +	if (atomic_use) {
> > +		if (get_user_pages(current, current->mm,
> > +				   (unsigned long)vr->ring.used, 1, 1, 1,
> > +				   &vr->used_page, NULL) != 1) {
> > +			vr = ERR_PTR(-EFAULT);
> > +			goto unlock;
> > +		}
>
> Oh, this is when it's safe to use.  You don't seem to be acquiring
> current->mm->mmap_sem here.  Also, this assumes the used ring fits
> within a single page which isn't true with a ring > 512 elements.

Yes, this is a hack.  It actually means ring <= 256 for PAGE_SIZE 4096.  I'm 
not entirely comfortable with it.

> A consequence of this is that devices that interact with a ring queue
> atomically now have an additional capability: pinning an arbitrary
> amount of physical memory.

Erk, the size check that was supposed to be here got lost in the reshuffle :(.

One option is to use a sliding window, but better is to do best effort and 
have the tun driver fall back (this is actually possible with a slight 
change).

Thanks,
Rusty.
