From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Mon, 21 Jan 2013 13:04:47 +1030
Message-ID: <877gn7w9fc.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130117112314.GA15504@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Jan 17, 2013 at 08:59:38PM +1030, Rusty Russell wrote:
>> +/* Returns vring->num if empty, -ve on error. */
>> +static inline int __vringh_get_head(const struct vringh *vrh,
>> +				    int (*getu16)(u16 *val, const u16 *p),
>
> I think int (*getu16)(const u16 *p) would be cleaner
> than returning through a pointer, then
> callers check that value < 0 for error.

I disagree: I dislike overloading the error code, and I like the
symmetry with other operations (getdesc, putu16).

>> +		/* Make sure it's OK, and get offset. */
>> +		if (!check_range(desc.addr, desc.len, &range, getrange)) {
>> +			err = -EINVAL;
>> +			goto fail;
>> +		}
>> +		addr = (void *)(long)desc.addr + range.offset;
>
> Should probably be (void *)(long)(desc.addr + range.offset).
> Otherwise we risk signed integer overflow.

Well, it's a noop.  Either a pointer and long are 64 bit (no overflow),
or they're not (we truncate anyway when we assign to addr).

>> +		iov->iov[iov->i].iov_base = (__force __user void *)addr;
>> +		iov->iov[iov->i].iov_len = desc.len;
>
> The following comment from the previous version still applies:
> 	> This looks like it won't do the right thing if desc.len spans multiple
> 	> ranges. I don't know if this happens in practice but this is something
> 	> vhost supports ATM.
> in otgher words, we might need to split a single desc to multiple
> iov entries.

Ah, separate offsets for consecutive ranges, right.  I'd prefer to say
"don't do that", but qemu is rarely sane.  I'll fix it.

>> +	err = putu16(&vrh->vring.used->idx, vrh->last_used_idx);
>> +	if (err) {
>> +		vringh_bad("Failed to update used index at %p",
>> +			   &vrh->vring.used->idx);
>> +		return err;
>
>
> One thing vhost does is roll back everything on error,
> so you can for example have an invalid range
> of memory and handle writes there in userspace.
> I think it's worth preserving though this is
> currently unused.

Indeed, that's a nice feature.  So is distinguishing a single bad
descriptor (which can be dropped, for vhost net) from a corrupt ring
(which means the device is useless).

>> +	/* They could have slipped one in as we were doing that: make
>> +	 * sure it's written, then check again. */
>> +	virtio_mb(vrh->weak_barriers);
>> +
>> +	if (getu16(&avail, &vrh->vring.avail->idx) != 0) {
>
> Hmm above has implicit != 0 why not here?

I didn't see the one above, but it's a clear nod that it doesn't return
a bool (yeah, it's nasty that we don't return the error in this case,
but in practice it's a tiny corner).

>> +static inline int getdesc_user(struct vring_desc *dst,
>> +			       const struct vring_desc *src)
>> +{
>> +	return copy_from_user(dst, (__force void *)src, sizeof(*dst)) == 0 ? 0 :
>> +		-EFAULT;
>
> confused about __force above. Shouldn't it cast to __user?
> I have not tried does this patch pass the checker?

You're right, I haven't run sparse across it yet...

>> +	vrh->vring.desc = (__force struct vring_desc *)desc;
>> +	vrh->vring.avail = (__force struct vring_avail *)avail;
>> +	vrh->vring.used = (__force struct vring_used *)used;
>
> I counted 3 separate chunks that do __force casts.
> Let's try to isolate them and comment why it's safe.

Yes, I want to look at using a union of kvec and iovec internally, but
I worry about breaking gcc's aliasing detection (the kernel compiles
with -fno-strict-aliasing but I hate relying on this).

Thanks,
Rusty.
