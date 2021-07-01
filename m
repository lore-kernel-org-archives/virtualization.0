Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10FC11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 13:16:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132666140D
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 13:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132666140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBBA183C8A;
	Thu,  1 Jul 2021 13:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeOpT9xwm9jz; Thu,  1 Jul 2021 13:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B9E2F83C88;
	Thu,  1 Jul 2021 13:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E44BC001A;
	Thu,  1 Jul 2021 13:16:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41632C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 13:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F19560AAE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 13:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oN0a7F2zfRJD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 13:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F32F060AAD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625145358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FzcUtZnWf2crS3Iy4vIMzI/4b5Wprx4OSu15nOYlXM=;
 b=VW0GpvflP+NpfNsq5OrFmBU4yB7Of+8H/V0blfnQ+68Ro6jtMijUZmyIaS4PGmRg4k4o/I
 rKwUrWyqtnKc6dFOPasBkY51xlL8DKIuv4qZHoD8emlBnxbNL8BvAw1iZOIf9VUcfifluM
 xwzARhjZxZOI76jq26lMGVqR6JHPZOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-pE_8q3jJN4uiIjQ-fSeD2Q-1; Thu, 01 Jul 2021 09:15:55 -0400
X-MC-Unique: pE_8q3jJN4uiIjQ-fSeD2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40EF802E66;
 Thu,  1 Jul 2021 13:15:52 +0000 (UTC)
Received: from localhost (ovpn-115-84.ams2.redhat.com [10.36.115.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A06C60862;
 Thu,  1 Jul 2021 13:15:51 +0000 (UTC)
Date: Thu, 1 Jul 2021 14:15:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: Re: [PATCH v8 10/10] Documentation: Add documentation for
 VDUSE
Message-ID: <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Content-Type: multipart/mixed; boundary="===============5354237858828376327=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5354237858828376327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IKAacefjibf5YNdD"
Content-Disposition: inline


--IKAacefjibf5YNdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 06:00:48PM +0800, Yongji Xie wrote:
> On Wed, Jun 30, 2021 at 6:06 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Tue, Jun 29, 2021 at 01:43:11PM +0800, Yongji Xie wrote:
> > > On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > > On Tue, Jun 15, 2021 at 10:13:31PM +0800, Xie Yongji wrote:
> > > > > +     static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t=
 *len)
> > > > > +     {
> > > > > +             int fd;
> > > > > +             void *addr;
> > > > > +             size_t size;
> > > > > +             struct vduse_iotlb_entry entry;
> > > > > +
> > > > > +             entry.start =3D iova;
> > > > > +             entry.last =3D iova + 1;
> > > >
> > > > Why +1?
> > > >
> > > > I expected the request to include *len so that VDUSE can create a b=
ounce
> > > > buffer for the full iova range, if necessary.
> > > >
> > >
> > > The function is used to translate iova to va. And the *len is not
> > > specified by the caller. Instead, it's used to tell the caller the
> > > length of the contiguous iova region from the specified iova. And the
> > > ioctl VDUSE_IOTLB_GET_FD will get the file descriptor to the first
> > > overlapped iova region. So using iova + 1 should be enough here.
> >
> > Does the entry.last field have any purpose with VDUSE_IOTLB_GET_FD? I
> > wonder why userspace needs to assign a value at all if it's always +1.
> >
>=20
> If we need to get some iova regions in the specified range, we need
> the entry.last field. For example, we can use [0, ULONG_MAX] to get
> the first overlapped iova region which might be [4096, 8192]. But in
> this function, we don't use VDUSE_IOTLB_GET_FD like this. We need to
> get the iova region including the specified iova.

I see, thanks for explaining!

> > > > > +             return addr + iova - entry.start;
> > > > > +     }
> > > > > +
> > > > > +- VDUSE_DEV_GET_FEATURES: Get the negotiated features
> > > >
> > > > Are these VIRTIO feature bits? Please explain how feature negotiati=
on
> > > > works. There must be a way for userspace to report the device's
> > > > supported feature bits to the kernel.
> > > >
> > >
> > > Yes, these are VIRTIO feature bits. Userspace will specify the
> > > device's supported feature bits when creating a new VDUSE device with
> > > ioctl(VDUSE_CREATE_DEV).
> >
> > Can the VDUSE device influence feature bit negotiation? For example, if
> > the VDUSE virtio-blk device does not implement discard/write-zeroes, how
> > does QEMU or the guest find out about this?
> >
>=20
> There is a "features" field in struct vduse_dev_config which is used
> to do feature negotiation.

This approach is more restrictive than required by the VIRTIO
specification:

  "The device SHOULD accept any valid subset of features the driver
  accepts, otherwise it MUST fail to set the FEATURES_OK device status
  bit when the driver writes it."

  https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html=
#x1-130002

The spec allows a device to reject certain subsets of features. For
example, if feature B depends on feature A and can only be enabled when
feature A is also enabled.

=46rom your description I think VDUSE would accept feature B without
feature A since the device implementation has no opportunity to fail
negotiation with custom logic.

Ideally VDUSE would send a SET_FEATURES message to userspace, allowing
the device implementation full flexibility in which subsets of features
to accept.

This is a corner case. Many or maybe even all existing VIRTIO devices
don't need this flexibility, but I want to point out this limitation in
the VDUSE interface because it may cause issues in the future.

> > > > > +- VDUSE_DEV_UPDATE_CONFIG: Update the configuration space and in=
ject a config interrupt
> > > >
> > > > Does this mean the contents of the configuration space are cached by
> > > > VDUSE?
> > >
> > > Yes, but the kernel will also store the same contents.
> > >
> > > > The downside is that the userspace code cannot generate the
> > > > contents on demand. Most devices doin't need to generate the conten=
ts
> > > > on demand, so I think this is okay but I had expected a different
> > > > interface:
> > > >
> > > > kernel->userspace VDUSE_DEV_GET_CONFIG
> > > > userspace->kernel VDUSE_DEV_INJECT_CONFIG_IRQ
> > > >
> > >
> > > The problem is how to handle the failure of VDUSE_DEV_GET_CONFIG. We
> > > will need lots of modification of virtio codes to support that. So to
> > > make it simple, we choose this way:
> > >
> > > userspace -> kernel VDUSE_DEV_SET_CONFIG
> > > userspace -> kernel VDUSE_DEV_INJECT_CONFIG_IRQ
> > >
> > > > I think you can leave it the way it is, but I wanted to mention thi=
s in
> > > > case someone thinks it's important to support generating the conten=
ts of
> > > > the configuration space on demand.
> > > >
> > >
> > > Sorry, I didn't get you here. Can't VDUSE_DEV_SET_CONFIG and
> > > VDUSE_DEV_INJECT_CONFIG_IRQ achieve that?
> >
> > If the contents of the configuration space change continuously, then the
> > VDUSE_DEV_SET_CONFIG approach is inefficient and might have race
> > conditions. For example, imagine a device where the driver can read a
> > timer from the configuration space. I think the VIRTIO device model
> > allows that although I'm not aware of any devices that do something like
> > it today. The problem is that VDUSE_DEV_SET_CONFIG would have to be
> > called frequently to keep the timer value updated even though the guest
> > driver probably isn't accessing it.
> >
>=20
> OK, I get you now. Since the VIRTIO specification says "Device
> configuration space is generally used for rarely-changing or
> initialization-time parameters". I assume the VDUSE_DEV_SET_CONFIG
> ioctl should not be called frequently.

The spec uses MUST and other terms to define the precise requirements.
Here the language (especially the word "generally") is weaker and means
there may be exceptions.

Another type of access that doesn't work with the VDUSE_DEV_SET_CONFIG
approach is reads that have side-effects. For example, imagine a field
containing an error code if the device encounters a problem unrelated to
a specific virtqueue request. Reading from this field resets the error
code to 0, saving the driver an extra configuration space write access
and possibly race conditions. It isn't possible to implement those
semantics suing VDUSE_DEV_SET_CONFIG. It's another corner case, but it
makes me think that the interface does not allow full VIRTIO semantics.

> > What's worse is that there might be race conditions where other
> > driver->device operations are supposed to update the configuration space
> > but VDUSE_DEV_SET_CONFIG means that the VDUSE kernel code is caching an
> > outdated copy.
> >
>=20
> I'm not sure. Should the device and driver be able to access the same
> fields concurrently?

Yes. The VIRTIO spec has a generation count to handle multi-field
accesses so that consistency can be ensured:
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x=
1-180004

>=20
> > Again, I don't think it's a problem for existing devices in the VIRTIO
> > specification. But I'm not 100% sure and future devices might require
> > what I've described, so the VDUSE_DEV_SET_CONFIG interface could become
> > a problem.
> >
>=20
> If so, maybe a new interface can be added at that time. The
> VDUSE_DEV_GET_CONFIG might be better, but I still did not find a good
> way for failure handling.

I'm not aware of the details of why the current approach was necessary,
so I don't have any concrete suggestions. Sorry!

Stefan

--IKAacefjibf5YNdD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDdwAYACgkQnKSrs4Gr
c8jehAgAnluXJzRbFUuK89b8dvdKf3FY6Lv1D9Kt6Wr/asGLoWxeorzLE3QiA8Ao
x24ZIi8kSiLVTJ79hVdtkQAKeRbL8KXzRiCdxWmVRI6dTik6VCuewC2tjjJi1i0w
yryJff3u3EimSMmxAnAkjP5mL5ed821qmydnLX4oxSXjvoBPF10g4rX4pORIfGva
3iDlvFNbXQPGZS/J+LXE6QDTg52QaVExKwRWcZVyO/6ZF4CKud3QVHTrPjnNS4ny
3ZubmWb2U0byyX+dqox47Ldq5B5arWwxDdO80KP4IqqG+PItumN36tm/KqTI6+89
cmt6ky4mmI9qrVLmYo2+MOGwCUEisA==
=ktns
-----END PGP SIGNATURE-----

--IKAacefjibf5YNdD--


--===============5354237858828376327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5354237858828376327==--

