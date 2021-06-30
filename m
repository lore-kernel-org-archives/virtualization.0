Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F2C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 10:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D3F611CE
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 10:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D3F611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B6D283B24;
	Wed, 30 Jun 2021 10:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4qLql0A-Y91; Wed, 30 Jun 2021 10:06:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD6CE831B0;
	Wed, 30 Jun 2021 10:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E804C0010;
	Wed, 30 Jun 2021 10:06:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9AFC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 10:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CC5460650
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 10:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbwuVBTeRIwu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 10:06:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3FB7605E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625047576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LMceomtZpeBJxouu/8TZ2RWttETJTNeq4YrEIozF2xg=;
 b=cE2amUg7iEYisAUS0NZy9KpL/qSGt7epjlsoSxKBvN1Ix1Ry2iY/enqJWke0QedGNApUIS
 A+m84K5TRjwle6eqsfMpctQM4Ho5FNjH6Bc7GydGPqXns2jlHjgXejt1w69uTxxiFsR0f5
 SD+5rhJLQxNmcIqGotud33vyChEuLLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-eLpe537eMKuoj_qUhesd5w-1; Wed, 30 Jun 2021 06:06:15 -0400
X-MC-Unique: eLpe537eMKuoj_qUhesd5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65AB1084F4B;
 Wed, 30 Jun 2021 10:06:12 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B6621980E;
 Wed, 30 Jun 2021 10:06:07 +0000 (UTC)
Date: Wed, 30 Jun 2021 11:06:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
Message-ID: <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5079380060396574431=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5079380060396574431==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="geeWI88lXXlJDriY"
Content-Disposition: inline


--geeWI88lXXlJDriY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 01:43:11PM +0800, Yongji Xie wrote:
> On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Tue, Jun 15, 2021 at 10:13:31PM +0800, Xie Yongji wrote:
> > > +     static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *le=
n)
> > > +     {
> > > +             int fd;
> > > +             void *addr;
> > > +             size_t size;
> > > +             struct vduse_iotlb_entry entry;
> > > +
> > > +             entry.start =3D iova;
> > > +             entry.last =3D iova + 1;
> >
> > Why +1?
> >
> > I expected the request to include *len so that VDUSE can create a bounce
> > buffer for the full iova range, if necessary.
> >
>=20
> The function is used to translate iova to va. And the *len is not
> specified by the caller. Instead, it's used to tell the caller the
> length of the contiguous iova region from the specified iova. And the
> ioctl VDUSE_IOTLB_GET_FD will get the file descriptor to the first
> overlapped iova region. So using iova + 1 should be enough here.

Does the entry.last field have any purpose with VDUSE_IOTLB_GET_FD? I
wonder why userspace needs to assign a value at all if it's always +1.

>=20
> > > +             fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
> > > +             if (fd < 0)
> > > +                     return NULL;
> > > +
> > > +             size =3D entry.last - entry.start + 1;
> > > +             *len =3D entry.last - iova + 1;
> > > +             addr =3D mmap(0, size, perm_to_prot(entry.perm), MAP_SH=
ARED,
> > > +                         fd, entry.offset);
> > > +             close(fd);
> > > +             if (addr =3D=3D MAP_FAILED)
> > > +                     return NULL;
> > > +
> > > +             /* do something to cache this iova region */
> >
> > How is userspace expected to manage iotlb mmaps? When should munmap(2)
> > be called?
> >
>=20
> The simple way is using a list to store the iotlb mappings. And we
> should call the munmap(2) for the old mappings when VDUSE_UPDATE_IOTLB
> or VDUSE_STOP_DATAPLANE message is received.

Thanks for explaining. It would be helpful to have a description of
IOTLB operation in this document.

> > Should userspace expect VDUSE_IOTLB_GET_FD to return a full chunk of
> > guest RAM (e.g. multiple gigabytes) that can be cached permanently or
> > will it return just enough pages to cover [start, last)?
> >
>=20
> It should return one iotlb mapping that covers [start, last). In
> vhost-vdpa cases, it might be a full chunk of guest RAM. In
> virtio-vdpa cases, it might be the whole bounce buffer or one coherent
> mapping (produced by dma_alloc_coherent()).

Great, thanks. Adding something about this to the documentation would
help others implementing VDUSE devices or libraries.

> > > +
> > > +             return addr + iova - entry.start;
> > > +     }
> > > +
> > > +- VDUSE_DEV_GET_FEATURES: Get the negotiated features
> >
> > Are these VIRTIO feature bits? Please explain how feature negotiation
> > works. There must be a way for userspace to report the device's
> > supported feature bits to the kernel.
> >
>=20
> Yes, these are VIRTIO feature bits. Userspace will specify the
> device's supported feature bits when creating a new VDUSE device with
> ioctl(VDUSE_CREATE_DEV).

Can the VDUSE device influence feature bit negotiation? For example, if
the VDUSE virtio-blk device does not implement discard/write-zeroes, how
does QEMU or the guest find out about this?

> > > +- VDUSE_DEV_UPDATE_CONFIG: Update the configuration space and inject=
 a config interrupt
> >
> > Does this mean the contents of the configuration space are cached by
> > VDUSE?
>=20
> Yes, but the kernel will also store the same contents.
>=20
> > The downside is that the userspace code cannot generate the
> > contents on demand. Most devices doin't need to generate the contents
> > on demand, so I think this is okay but I had expected a different
> > interface:
> >
> > kernel->userspace VDUSE_DEV_GET_CONFIG
> > userspace->kernel VDUSE_DEV_INJECT_CONFIG_IRQ
> >
>=20
> The problem is how to handle the failure of VDUSE_DEV_GET_CONFIG. We
> will need lots of modification of virtio codes to support that. So to
> make it simple, we choose this way:
>=20
> userspace -> kernel VDUSE_DEV_SET_CONFIG
> userspace -> kernel VDUSE_DEV_INJECT_CONFIG_IRQ
>=20
> > I think you can leave it the way it is, but I wanted to mention this in
> > case someone thinks it's important to support generating the contents of
> > the configuration space on demand.
> >
>=20
> Sorry, I didn't get you here. Can't VDUSE_DEV_SET_CONFIG and
> VDUSE_DEV_INJECT_CONFIG_IRQ achieve that?

If the contents of the configuration space change continuously, then the
VDUSE_DEV_SET_CONFIG approach is inefficient and might have race
conditions. For example, imagine a device where the driver can read a
timer from the configuration space. I think the VIRTIO device model
allows that although I'm not aware of any devices that do something like
it today. The problem is that VDUSE_DEV_SET_CONFIG would have to be
called frequently to keep the timer value updated even though the guest
driver probably isn't accessing it.

What's worse is that there might be race conditions where other
driver->device operations are supposed to update the configuration space
but VDUSE_DEV_SET_CONFIG means that the VDUSE kernel code is caching an
outdated copy.

Again, I don't think it's a problem for existing devices in the VIRTIO
specification. But I'm not 100% sure and future devices might require
what I've described, so the VDUSE_DEV_SET_CONFIG interface could become
a problem.

Stefan

--geeWI88lXXlJDriY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDcQg4ACgkQnKSrs4Gr
c8h7hggAnQQOdWOGK8gte/C5wPC6wIaHByFsU4T4LRipSwLegybqDEkWufZOH+Sa
1xx1Jh7X2zc+VrfGU6jMXoejDqg/+powEv+AtJcm7EKUDOWNBpUK4e36qaxSjhqd
U2Gya8ZhM+qgGnxgEJPl1anLmISVmMHSnulGdPy5c7Lsf6qa8n3PrBYcKpiwaFcJ
keyHVt9KxkIJsV/2UVUsA+LzYL4H24FOyAllkjTRLm3wjqwsmciUELmvTvMKORu1
TeIVS7Mn7J10Fegx54MOlWakdPahmuXloGv/yhxR102k/9dieMeoE3N4H+30PaU9
IAuiYtoWhZNM5xwyR/ht7sVUVkOlQw==
=j8XL
-----END PGP SIGNATURE-----

--geeWI88lXXlJDriY--


--===============5079380060396574431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5079380060396574431==--

