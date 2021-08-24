Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E37C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 16:37:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C6D61357
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 16:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4C6D61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99E8880F07;
	Tue, 24 Aug 2021 16:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkeiJpnU2m-x; Tue, 24 Aug 2021 16:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1ECAD80F7D;
	Tue, 24 Aug 2021 16:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE727C001A;
	Tue, 24 Aug 2021 16:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50465C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 16:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30E7B40198
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 16:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4pdxz9yZigD8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 16:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4EDB40185
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629823010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0K35WU59VUaEjTZFBS7zwVipmEjRn/vqhiJ2hWX0q64=;
 b=UhDXwp/8/RYAiKLRsqh6mVjn4WHNuMaMsTaFesjLNQTlbaRCuWV4kQE+kFyTEGS1YeUzdn
 cf6WG5Bi9/NR/3JDoKw4cckha9Rr5hXspaOCbUO8XFQXfsUobX1g9voxeR7v1DxbLuNI1U
 BwLp/th0btnwp8T6xcaN/eYQTUVDuaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-6E4vG4g-MouidlIl3Qczng-1; Tue, 24 Aug 2021 12:36:46 -0400
X-MC-Unique: 6E4vG4g-MouidlIl3Qczng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6616802CB4;
 Tue, 24 Aug 2021 16:36:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C0E15D6CF;
 Tue, 24 Aug 2021 16:36:39 +0000 (UTC)
Date: Tue, 24 Aug 2021 17:36:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 0/1] virtio: false unhandled irqs from
 vring_interrupt()
Message-ID: <YSUgFsUm3h9A5csV@stefanha-x1.localdomain>
References: <20210824105944.172659-1-stefanha@redhat.com>
 <20210824072622-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210824072622-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, vgoyal@redhat.com
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
Content-Type: multipart/mixed; boundary="===============7808205849027110066=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7808205849027110066==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4r4BVJbjjn49EWr"
Content-Disposition: inline


--G4r4BVJbjjn49EWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 07:31:29AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 24, 2021 at 11:59:43AM +0100, Stefan Hajnoczi wrote:
> > While investigating an unhandled irq from vring_interrupt() with virtio=
fs I
> > stumbled onto a possible race that also affects virtio_gpu. This theory=
 is
> > based on code inspection and hopefully you can point out something that=
 makes
> > this a non-issue in practice :).
> >=20
> > The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt=
 is
> > taken with no used (completed) buffers in the virtqueue. The kernel dis=
ables
> > the irq and the driver is no longer receives irqs when this happens:
> >=20
> >   irq 77: nobody cared (try booting with the "irqpoll" option)
> >   ...
> >   handlers:
> >   [<00000000a40a49bb>] vring_interrupt
> >   Disabling IRQ #77
> >=20
> > Consider the following:
> >=20
> > 1. An virtiofs irq is handled and the virtio_fs_requests_done_work() wo=
rk
> >    function is scheduled to dequeue used buffers:
> >    vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()
> >=20
> > 2. The device adds more used requests and just before...
> >=20
> > 3. ...virtio_fs_requests_done_work() empties the virtqueue with
> >    virtqueue_get_buf().
> >=20
> > 4. The device raises the irq and vring_interrupt() is called after
> >    virtio_fs_requests_done_work emptied the virtqueue:
> >=20
> >    irqreturn_t vring_interrupt(int irq, void *_vq)
> >    {
> >        struct vring_virtqueue *vq =3D to_vvq(_vq);
> >=20
> >        if (!more_used(vq)) {
> >            pr_debug("virtqueue interrupt with no work for %p\n", vq);
> >            return IRQ_NONE;
> >            ^^^^^^^^^^^^^^^^
> >=20
> > I have included a patch that switches virtiofs from spin_lock() to
> > spin_lock_irqsave() to prevent vring_interrupt() from running while the
> > virtqueue is processed from a work function.
> >=20
> > virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and
> > virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().
> > I think this can result in the same false unhandled irq problem as virt=
iofs.
> >=20
> > This race condition could in theory affect all drivers. The VIRTIO
> > specification says:
> >=20
> >   Neither of these notification suppression methods are reliable, as th=
ey are
> >   not synchronized with the device, but they serve as useful optimizati=
ons.
> >=20
> > If virtqueue_disable_cb() is just a hint and might not disable virtqueu=
e irqs
> > then virtio_net and other drivers have a problem because because an irq=
 could
> > be raised while the driver is dequeuing used buffers. I think we haven'=
t seen
> > this because software VIRTIO devices honor virtqueue_disable_cb(). Hard=
ware
> > devices might cache the value and not disable notifications for some ti=
me...
> >=20
> > Have I missed something?
> >=20
> > The virtiofs patch I attached is being stress tested to see if the unha=
ndled
> > irqs still occur.
> >=20
> > Stefan Hajnoczi (1):
> >   fuse: disable local irqs when processing vq completions
> >=20
> >  fs/fuse/virtio_fs.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> Fundamentally it is not a problem to have an unhandled IRQ
> once in a while. It's only a problem if this happens time
> after time.
>=20
>=20
> Does the kernel you are testing include
> commit 8d622d21d24803408b256d96463eac4574dcf067
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Tue Apr 13 01:19:16 2021 -0400
>=20
>     virtio: fix up virtio_disable_cb
>=20
> ?
>=20
> If not it's worth checking whether the latest kernel still
> has the issue.
>=20
> Note cherry picking that commit isn't trivial there are
> a bunch of dependencies.
>=20
> If you want to try on an old kernel, disable event index.

Thanks for pointing out this commit. My kernel does not have it. The
device is using the split vring layout (probably with EVENT_IDX) so
virtqueue_disable_cb() has no effect.

kernel/irq/spurious.c:note_interrupt() disables the irq after 99.9k
unhandled irqs. It's surprising that virtiofs is hitting this limit
through the scenario I described, but maybe.

I'll try different kernel versions and/or disable EVENT_IDX as you
suggested. Thanks!

Stefan

--G4r4BVJbjjn49EWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmElIBYACgkQnKSrs4Gr
c8jqlAf+Ih/B6hV0FpES3P4yHLZUDZ/477pPCuls8u90T//EFrDoq0LUs0fCD6Au
t55D4ek9xM5Lwqy/4gqrRUK2b4j6Sb2o3TvEvkLZIhE1JCLeZugsFBkCWhEitzYc
95RFhBAm8+xlCBSbfvBukZrFgGNhp0Oo/SbVSl+T1ywMeiBgzcQhbhp+nV1p3AZO
O0k+QwdSZ+EKoVg5dwrH9YDx/LqO8u1HNems98B63GZ+co4v4SIp+E6Ejhy/3NVz
BxsGImE0dM+66Ro95qB3AwybEWnk3tMJxQ6ejHEX40hxWuD1W7pR0bLQjkJMaDYz
XcTumZXyJru7KzN9RXjK8HPnaLUtdA==
=T11b
-----END PGP SIGNATURE-----

--G4r4BVJbjjn49EWr--


--===============7808205849027110066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7808205849027110066==--

