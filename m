Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B3C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 15:58:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446492310E
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 15:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446492310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1568887A12;
	Wed,  9 Dec 2020 15:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id We6oGFoi5OHr; Wed,  9 Dec 2020 15:58:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 37A1C879CD;
	Wed,  9 Dec 2020 15:58:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C35C0893;
	Wed,  9 Dec 2020 15:58:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626B0C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FCE58690F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7H-bEO9uZ0vn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:58:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2D3B9868D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607529520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBr32EfwjraHmhGUU1qWmpGQu6trXhEY+c3U2JTdT58=;
 b=Cae9WGaouIuQalqCvNagq8SRtMfMkFnpwJ1q+pltPZWHNpPKySvRtA/jpT4ycxocZXzq8N
 31kJgEo0SPGv4wO7YME+RBF1QuJZFs4cqAlZQ/WCaEfoSVSNc7xuLz5PaMW+cg3XE7tJpW
 eCENZzox7vazQiMgzoRvTYhV0B2mWh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-2pOf97PaMRukBQZCgWs7BA-1; Wed, 09 Dec 2020 10:58:35 -0500
X-MC-Unique: 2pOf97PaMRukBQZCgWs7BA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE23180DE10;
 Wed,  9 Dec 2020 15:57:31 +0000 (UTC)
Received: from localhost (ovpn-115-48.ams2.redhat.com [10.36.115.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD6786064B;
 Wed,  9 Dec 2020 15:57:30 +0000 (UTC)
Date: Wed, 9 Dec 2020 15:57:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
Message-ID: <20201209155729.GB396498@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201208093715.GX203660@stefanha-x1.localdomain>
 <1410217602.34486578.1607506010536.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1410217602.34486578.1607506010536.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Content-Type: multipart/mixed; boundary="===============1719845293749785858=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1719845293749785858==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 04:26:50AM -0500, Jason Wang wrote:
> ----- Original Message -----
> > On Fri, Nov 20, 2020 at 07:50:38PM +0100, Eugenio P=E9rez wrote:
> > > This series enable vDPA software assisted live migration for vhost-ne=
t
> > > devices. This is a new method of vhost devices migration: Instead of
> > > relay on vDPA device's dirty logging capability, SW assisted LM
> > > intercepts dataplane, forwarding the descriptors between VM and devic=
e.
> >=20
> > Pros:
> > + vhost/vDPA devices don't need to implement dirty memory logging
> > + Obsoletes ioctl(VHOST_SET_LOG_BASE) and friends
> >=20
> > Cons:
> > - Not generic, relies on vhost-net-specific ioctls
> > - Doesn't support VIRTIO Shared Memory Regions
> >   https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex
>=20
> I may miss something but my understanding is that it's the
> responsiblity of device to migrate this part?

Good point. You're right.

> > - Performance (see below)
> >=20
> > I think performance will be significantly lower when the shadow vq is
> > enabled. Imagine a vDPA device with hardware vq doorbell registers
> > mapped into the guest so the guest driver can directly kick the device.
> > When the shadow vq is enabled a vmexit is needed to write to the shadow
> > vq ioeventfd, then the host kernel scheduler switches to a QEMU thread
> > to read the ioeventfd, the descriptors are translated, QEMU writes to
> > the vhost hdev kick fd, the host kernel scheduler switches to the vhost
> > worker thread, vhost/vDPA notifies the virtqueue, and finally the
> > vDPA driver writes to the hardware vq doorbell register. That is a lot
> > of overhead compared to writing to an exitless MMIO register!
>=20
> I think it's a balance. E.g we can poll the virtqueue to have an
> exitless doorbell.
>=20
> >=20
> > If the shadow vq was implemented in drivers/vhost/ and QEMU used the
> > existing ioctl(VHOST_SET_LOG_BASE) approach, then the overhead would be
> > reduced to just one set of ioeventfd/irqfd. In other words, the QEMU
> > dirty memory logging happens asynchronously and isn't in the dataplane.
> >=20
> > In addition, hardware that supports dirty memory logging as well as
> > software vDPA devices could completely eliminate the shadow vq for even
> > better performance.
>=20
> Yes. That's our plan. But the interface might require more thought.
>=20
> E.g is the bitmap a good approach? To me reporting dirty pages via
> virqueue is better since it get less footprint and is self throttled.
>=20
> And we need an address space other than the one used by guest for
> either bitmap for virtqueue.
>=20
> >=20
> > But performance is a question of "is it good enough?". Maybe this
> > approach is okay and users don't expect good performance while dirty
> > memory logging is enabled.
>=20
> Yes, and actually such slow down may help for the converge of the
> migration.
>=20
> Note that the whole idea is try to have a generic solution for all
> types of devices. It's good to consider the performance but for the
> first stage, it should be sufficient to make it work and consider to
> optimize on top.

Moving the shadow vq to the kernel later would be quite a big change
requiring rewriting much of the code. That's why I mentioned this now
before a lot of effort is invested in a QEMU implementation.

> > I just wanted to share the idea of moving the
> > shadow vq into the kernel in case you like that approach better.
>=20
> My understanding is to keep kernel as simple as possible and leave the
> polices to userspace as much as possible. E.g it requires us to
> disable doorbell mapping and irq offloading, all of which were under
> the control of userspace.

If the performance is acceptable with the QEMU approach then I think
that's the best place to implement it. It looks high-overhead though so
maybe one of the first things to do is to run benchmarks to collect data
on how it performs?

Stefan

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/Q8+kACgkQnKSrs4Gr
c8gzgwf/R8XyRehTNARVsYQYQS8pC8vzoJcb4LMSB4/opM4DdNb2gIFzVOzHt7am
ibFu8Wyl3C2txGaFCh4YlGIwVkGTdAp++Dwhl9wWZaVA0vvjv/yxR/r82IIid7oR
tLb5LibQ19LXmVdFgAfGaT3dXSIkPG38RECJZwSk3QBrgXfsKclGZHRpnPGsK0B3
3PIQtGy3wjJIuVXoknfAXjThXpzXmwlc/EHQnBSajm9byvMVWzlHb2Kirc5PO0xP
Vrg2wdmUUwnVgSC2n9DgEjb1IRyVWEW9dsF+8QdmBnPtYSOJ74EekvFkn6fKWd2A
/NyM+ry+1zHgomC5WqzC9bKCp+KacQ==
=WM5k
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--


--===============1719845293749785858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1719845293749785858==--

