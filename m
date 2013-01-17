From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Thu, 17 Jan 2013 12:49:25 +0100
Message-ID: <CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
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

On Thu, Jan 17, 2013 at 12:23 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jan 17, 2013 at 08:59:38PM +1030, Rusty Russell wrote:
...
>> +static inline int
>> +__vringh_iov(struct vringh *vrh, u16 i,
>> +          struct vringh_iov *riov,
>> +          struct vringh_iov *wiov,
>> +          bool (*getrange)(u64 addr, struct vringh_range *r),
>> +          gfp_t gfp,
>> +          int (*getdesc)(struct vring_desc *dst, const struct vring_desc *s))
>> +{
>> +     int err, count = 0, up_next, desc_max;
>> +     struct vring_desc desc, *descs;
>> +     struct vringh_range range = { -1ULL, 0 };
>> +
>> +     /* We start traversing vring's descriptor table. */
>> +     descs = vrh->vring.desc;
>> +     desc_max = vrh->vring.num;
>> +     up_next = -1;
>> +
>> +     riov->i = wiov->i = 0;
>> +     for (;;) {
>> +             void *addr;
>> +             struct vringh_iov *iov;
>> +
>> +             err = getdesc(&desc, &descs[i]);
>> +             if (unlikely(err))
>> +                     goto fail;
>> +
>> +             /* Make sure it's OK, and get offset. */
>> +             if (!check_range(desc.addr, desc.len, &range, getrange)) {
>> +                     err = -EINVAL;
>> +                     goto fail;
>> +             }
>> +             addr = (void *)(long)desc.addr + range.offset;
>
> Should probably be (void *)(long)(desc.addr + range.offset).
> Otherwise we risk signed integer overflow.
>
>> +
>> +             if (unlikely(desc.flags & VRING_DESC_F_INDIRECT)) {
>> +                     err = move_to_indirect(&up_next, &i, addr, &desc,
>> +                                            &descs, &desc_max);
>> +                     if (err)
>> +                             goto fail;
>> +                     continue;
>> +             }
>> +
>> +             if (count++ == vrh->vring.num) {
>> +                     vringh_bad("Descriptor loop in %p", descs);
>> +                     err = -ELOOP;
>> +                     goto fail;
>> +             }
>> +
>> +             if (desc.flags & VRING_DESC_F_WRITE)
>> +                     iov = wiov;
>> +             else {
>> +                     iov = riov;
>> +                     if (unlikely(wiov->i)) {
>> +                             vringh_bad("Readable desc %p after writable",
>> +                                        &descs[i]);
>> +                             err = -EINVAL;
>> +                             goto fail;
>> +                     }
>> +             }
>> +
>> +             if (unlikely(iov->i == iov->max)) {
>> +                     err = resize_iovec(iov, gfp);
>> +                     if (err)
>> +                             goto fail;
>> +             }
>> +
>> +             iov->iov[iov->i].iov_base = (__force __user void *)addr;
>> +             iov->iov[iov->i].iov_len = desc.len;
>
> The following comment from the previous version still applies:
>         > This looks like it won't do the right thing if desc.len spans multiple
>         > ranges. I don't know if this happens in practice but this is something
>         > vhost supports ATM.
> in otgher words, we might need to split a single desc to multiple
> iov entries.

Splitting descriptors doesn't work for me. As described earlier, I
receive one IP-frame for each descriptor. So I need to keep
the original boundaries.

Regards,
Sjur
