Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B5C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 10:46:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97028651A5
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 10:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97028651A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27864400AF;
	Mon,  8 Mar 2021 10:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TP4zYeysbf3X; Mon,  8 Mar 2021 10:46:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1385400A9;
	Mon,  8 Mar 2021 10:46:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74457C000B;
	Mon,  8 Mar 2021 10:46:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C770C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 10:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07BD183A66
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 10:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FaXl9zjedj4W
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 10:46:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F33283A61
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615200400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g1tKnkjJWrSFbX4H2YOn29SnfSqXEzlO7Rs0c3HSYCg=;
 b=MPsgFc98j/+zmoVS0yxgZ2/kpbQoWoQxqfM4cGQAF12JS6aJsuTQh/ziGGd63ndi9nLOSf
 1NxYyi9MhNsXyX38uOgIy+4oveEz6xWxwbpuaMEOkJTKrVzhFzwCphRbCS7We5+KWtxffC
 CS2wdNzDzN5oEKXhTSOfLkUYq2dL8gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-_B9xZ328Mo-9eLTY_ectPQ-1; Mon, 08 Mar 2021 05:46:24 -0500
X-MC-Unique: _B9xZ328Mo-9eLTY_ectPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ED641005D4A;
 Mon,  8 Mar 2021 10:46:21 +0000 (UTC)
Received: from localhost (ovpn-114-104.ams2.redhat.com [10.36.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D14719715;
 Mon,  8 Mar 2021 10:46:16 +0000 (UTC)
Date: Mon, 8 Mar 2021 10:46:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 06/27] virtio: Add virtio_queue_get_used_notify_split
Message-ID: <YEYAeGasxYD6ZheE@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-7-eperezma@redhat.com>
 <20201207165848.GM203660@stefanha-x1.localdomain>
 <CAJaqyWc4oLzL02GKpPSwEGRxK+UxjOGBAPLzrgrgKRZd9C81GA@mail.gmail.com>
 <YD4f4KEIYRlTUP4/@stefanha-x1.localdomain>
 <CAJaqyWd0iRUUW5Hu=U3mwQ4f43kA=bse3EkN4+QauFR4BJwObQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd0iRUUW5Hu=U3mwQ4f43kA=bse3EkN4+QauFR4BJwObQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0729918800785316124=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0729918800785316124==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wt/k06bIHv2D9AK7"
Content-Disposition: inline


--wt/k06bIHv2D9AK7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 07:34:20PM +0100, Eugenio Perez Martin wrote:
> On Tue, Mar 2, 2021 at 12:22 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >
> > On Tue, Jan 12, 2021 at 07:21:27PM +0100, Eugenio Perez Martin wrote:
> > > On Mon, Dec 7, 2020 at 5:58 PM Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> > > >
> > > > On Fri, Nov 20, 2020 at 07:50:44PM +0100, Eugenio P=E9rez wrote:
> > > > > This function is just used for a few commits, so SW LM is develop=
ed
> > > > > incrementally, and it is deleted after it is useful.
> > > > >
> > > > > For a few commits, only the events (irqfd, eventfd) are forwarded.
> > > >
> > > > s/eventfd/ioeventfd/ (irqfd is also an eventfd)
> > > >
> > >
> > > Oops, will fix, thanks!
> > >
> > > > > +bool virtio_queue_get_used_notify_split(VirtQueue *vq)
> > > > > +{
> > > > > +    VRingMemoryRegionCaches *caches;
> > > > > +    hwaddr pa =3D offsetof(VRingUsed, flags);
> > > > > +    uint16_t flags;
> > > > > +
> > > > > +    RCU_READ_LOCK_GUARD();
> > > > > +
> > > > > +    caches =3D vring_get_region_caches(vq);
> > > > > +    assert(caches);
> > > > > +    flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used, p=
a);
> > > > > +    return !(VRING_USED_F_NO_NOTIFY & flags);
> > > > > +}
> > > >
> > > > QEMU stores the notification status:
> > > >
> > > > void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > > > {
> > > >     vq->notification =3D enable; <---- here
> > > >
> > > >     if (!vq->vring.desc) {
> > > >         return;
> > > >     }
> > > >
> > > >     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> > > >         virtio_queue_packed_set_notification(vq, enable);
> > > >     } else {
> > > >         virtio_queue_split_set_notification(vq, enable);
> > > >
> > > > I'm wondering why it's necessary to fetch from guest RAM instead of
> > > > using vq->notification? It also works for both split and packed
> > > > queues so the code would be simpler.
> > >
> > > To use vq->notification makes sense at the end of the series.
> > >
> > > However, at this stage (just routing notifications, not descriptors),
> > > vhost device is the one updating that flag, not qemu. Since we cannot
> > > just migrate used ring memory to qemu without migrating descriptors
> > > ring too, qemu needs to check guest's memory looking for vhost device
> > > updates on that flag.
> > >
> > > I can see how that deserves better documentation or even a better
> > > name. Also, this function should be in the shadow vq file, not
> > > virtio.c.
> >
> > I can't think of a reason why QEMU needs to know the flag value that the
> > vhost device has set. This flag is a hint to the guest driver indicating
> > whether the device wants to receive notifications.
> >
> > Can you explain why QEMU needs to look at the value of the flag?
> >
> > Stefan
>=20
> My bad, "need" is not the right word: SVQ could just forward the
> notification at this point without checking the flag. Taking into
> account that it's not used in later series, and it's even removed in
> patch 14/27 of this series, I can see that it just adds noise to the
> entire patchset
>=20
> This function just allows svq to re-check the flag after the guest
> sends the notification. This way svq is able to drop the kick as a
> (premature?) optimization in case the device sets it just after the
> guest sends the kick.
>=20
> Until patch 13/27, only notifications are forwarded, not buffers. VM
> guest's drivers and vhost device still read and write at usual
> addresses, but ioeventfd and kvmfd are intercepted by qemu. This
> allows us to test if the notification forwarding part is doing ok.
> From patch 14 of this series, svq offers a new vring to the device in
> qemu's VAS, so the former does not need to check the guest's memory
> anymore, and this function can be dropped.
>=20
> Is it clearer now? Please let me know if I should add something else.

Thanks for explaining. You could drop it to simplify the code. If you
leave it in, please include a comment explaining the purpose.

Thanks,
Stefan

--wt/k06bIHv2D9AK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBGAHcACgkQnKSrs4Gr
c8hQIwgAtbmbXALP3b9YRiQjKcricWBmsnBRSrhFbwUMD9mB9CRdPsN8E0ylmqeD
vms6J1x3x93RXeeasCEJqrB6dhiy5d2b6PG0Lyab+vFnmygg6sBdLkGx5BErKIup
UpCWmxSJ9LtdFQYrjPQNH/wrBmQkOLp3uRpuYX3JIyNK+F/ReWcxPtAyjbGdFyaq
VN0yyFYI1EB/t+8E2W9YhhJxI8e5Vp1KL+tB6PpYMWGYBJ+OjbEGktQGEBCZhnrA
jBE2MmBNlE1tH3hvBplQotx1GMryQ49BoQ70IqVSw+gvdo6RJWZ20r37tgl0trk7
rCsji9cO4l8Fr1K5gJBDzJtYVuSBvw==
=Tm0W
-----END PGP SIGNATURE-----

--wt/k06bIHv2D9AK7--


--===============0729918800785316124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0729918800785316124==--

