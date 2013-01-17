From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Thu, 17 Jan 2013 14:08:55 +0200
Message-ID: <20130117120855.GA16311@redhat.com>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2013 at 12:49:25PM +0100, Sjur Br=E6ndeland wrote:
> On Thu, Jan 17, 2013 at 12:23 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > On Thu, Jan 17, 2013 at 08:59:38PM +1030, Rusty Russell wrote:
> ...
> >> +static inline int
> >> +__vringh_iov(struct vringh *vrh, u16 i,
> >> +          struct vringh_iov *riov,
> >> +          struct vringh_iov *wiov,
> >> +          bool (*getrange)(u64 addr, struct vringh_range *r),
> >> +          gfp_t gfp,
> >> +          int (*getdesc)(struct vring_desc *dst, const struct vring_d=
esc *s))
> >> +{
> >> +     int err, count =3D 0, up_next, desc_max;
> >> +     struct vring_desc desc, *descs;
> >> +     struct vringh_range range =3D { -1ULL, 0 };
> >> +
> >> +     /* We start traversing vring's descriptor table. */
> >> +     descs =3D vrh->vring.desc;
> >> +     desc_max =3D vrh->vring.num;
> >> +     up_next =3D -1;
> >> +
> >> +     riov->i =3D wiov->i =3D 0;
> >> +     for (;;) {
> >> +             void *addr;
> >> +             struct vringh_iov *iov;
> >> +
> >> +             err =3D getdesc(&desc, &descs[i]);
> >> +             if (unlikely(err))
> >> +                     goto fail;
> >> +
> >> +             /* Make sure it's OK, and get offset. */
> >> +             if (!check_range(desc.addr, desc.len, &range, getrange))=
 {
> >> +                     err =3D -EINVAL;
> >> +                     goto fail;
> >> +             }
> >> +             addr =3D (void *)(long)desc.addr + range.offset;
> >
> > Should probably be (void *)(long)(desc.addr + range.offset).
> > Otherwise we risk signed integer overflow.
> >
> >> +
> >> +             if (unlikely(desc.flags & VRING_DESC_F_INDIRECT)) {
> >> +                     err =3D move_to_indirect(&up_next, &i, addr, &de=
sc,
> >> +                                            &descs, &desc_max);
> >> +                     if (err)
> >> +                             goto fail;
> >> +                     continue;
> >> +             }
> >> +
> >> +             if (count++ =3D=3D vrh->vring.num) {
> >> +                     vringh_bad("Descriptor loop in %p", descs);
> >> +                     err =3D -ELOOP;
> >> +                     goto fail;
> >> +             }
> >> +
> >> +             if (desc.flags & VRING_DESC_F_WRITE)
> >> +                     iov =3D wiov;
> >> +             else {
> >> +                     iov =3D riov;
> >> +                     if (unlikely(wiov->i)) {
> >> +                             vringh_bad("Readable desc %p after writa=
ble",
> >> +                                        &descs[i]);
> >> +                             err =3D -EINVAL;
> >> +                             goto fail;
> >> +                     }
> >> +             }
> >> +
> >> +             if (unlikely(iov->i =3D=3D iov->max)) {
> >> +                     err =3D resize_iovec(iov, gfp);
> >> +                     if (err)
> >> +                             goto fail;
> >> +             }
> >> +
> >> +             iov->iov[iov->i].iov_base =3D (__force __user void *)add=
r;
> >> +             iov->iov[iov->i].iov_len =3D desc.len;
> >
> > The following comment from the previous version still applies:
> >         > This looks like it won't do the right thing if desc.len spans=
 multiple
> >         > ranges. I don't know if this happens in practice but this is =
something
> >         > vhost supports ATM.
> > in otgher words, we might need to split a single desc to multiple
> > iov entries.
> =

> Splitting descriptors doesn't work for me. As described earlier, I
> receive one IP-frame for each descriptor. So I need to keep
> the original boundaries.
> =

> Regards,
> Sjur

Hmm this kind of conflicts with the description we were
going into with virtio generally.
Other side should be free to lay out request any way it
wants to.
Anyway, in this case this is splitting iovecs really not descriptors.

-- =

MST
