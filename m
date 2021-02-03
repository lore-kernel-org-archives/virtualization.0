Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D345C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 16:46:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B9B64F7C
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B9B64F7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A33FA204F3;
	Wed,  3 Feb 2021 16:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9alq7rbNbWD6; Wed,  3 Feb 2021 16:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 74D7A22B6D;
	Wed,  3 Feb 2021 16:46:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB6AC0FA8;
	Wed,  3 Feb 2021 16:46:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3267C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9331422B6D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i43KYs8JYpPT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3304A204F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612370759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IpYhJIVwRhODxe05ALBJDVQ3g0p1rJxJONUIEZyW1I=;
 b=HH12mkqmbzQq86FK7kA9oYBGEiaLCKi+7BK1RdFZ+CTbUtTgqeWhXsZO10qVJCi6Q4JY5N
 Km1lwdde8uX1B1Y6KBp+rQ2FeeNs+E3AQaNSlx6SQb3RXHgrik8p7TuLBuwxsW8/OgfGXp
 budkOAYToEeBYVxL802Bqq+pc1Z95KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-u7Oarx0dNVeYmPRidIlOFg-1; Wed, 03 Feb 2021 11:45:57 -0500
X-MC-Unique: u7Oarx0dNVeYmPRidIlOFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5230D1E19;
 Wed,  3 Feb 2021 16:45:56 +0000 (UTC)
Received: from localhost (ovpn-115-141.ams2.redhat.com [10.36.115.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13D941971C;
 Wed,  3 Feb 2021 16:45:52 +0000 (UTC)
Date: Wed, 3 Feb 2021 16:45:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Message-ID: <20210203164551.GG74271@stefanha-x1.localdomain>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
 <20210202093412.GA243557@stefanha-x1.localdomain>
 <20210202154950.g3rclpigyaigzfgo@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210202154950.g3rclpigyaigzfgo@steredhat>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============0554445548806989567=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0554445548806989567==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 04:49:50PM +0100, Stefano Garzarella wrote:
> On Tue, Feb 02, 2021 at 09:34:12AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 28, 2021 at 03:41:25PM +0100, Stefano Garzarella wrote:
> > > +static void vdpasim_blk_work(struct work_struct *work)
> > > +{
> > > +	struct vdpasim *vdpasim =3D container_of(work, struct vdpasim, work=
);
> > > +	u8 status =3D VIRTIO_BLK_S_OK;
> > > +	int i;
> > > +
> > > +	spin_lock(&vdpasim->lock);
> > > +
> > > +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		goto out;
> > > +
> > > +	for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> > > +		struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> > > +
> > > +		if (!vq->ready)
> > > +			continue;
> > > +
> > > +		while (vringh_getdesc_iotlb(&vq->vring, &vq->out_iov,
> > > +					    &vq->in_iov, &vq->head,
> > > +					    GFP_ATOMIC) > 0) {
> > > +			int write;
> > > +
> > > +			vq->in_iov.i =3D vq->in_iov.used - 1;
> > > +			write =3D vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
> > > +						      &status, 1);
> > > +			if (write <=3D 0)
> > > +				break;
> >=20
> > This code looks fragile:
> >=20
> > 1. Relying on unsigned underflow and the while loop in
> >   vringh_iov_push_iotlb() to handle the case where in_iov.used =3D=3D 0=
 is
> >   risky and could break.
> >=20
> > 2. Does this assume that the last in_iov element has size 1? For
> >   example, the guest driver may send a single "in" iovec with size 513
> >   when reading 512 bytes (with an extra byte for the request status).
> >=20
> > Please validate inputs fully, even in test/development code, because
> > it's likely to be copied by others when writing production code (or
> > deployed in production by unsuspecting users) :).
>=20
> Perfectly agree on that, so I addressed these things, also following your
> review on the previous version, on the next patch of this series:
> "vdpa_sim_blk: implement ramdisk behaviour".
>=20
> Do you think should I move these checks in this patch?
>=20
> I did this to leave Max credit for this patch and add more code to emulat=
e a
> ramdisk in later patches.

You could update the commit description so it's clear that input
validation is missing and will be added in the next commit.

Stefan

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAa0z8ACgkQnKSrs4Gr
c8gfeAf+KJnbrDqgPwA7UnFlz8Vzfoi8tWfYt0wDorjtnjO0BmxywU4lo4ruVui5
PM5ofCTMTdCWC1+fpZkFuJr3md8MQ8l/loQgm1h6R2FUC5ch8MJWspP5fEbC1cJL
DevHe2XjGmiJwqJFudMDuWXYYMC8XdGzxnQuRXR/8adH0blrA8iRi98K/NVexQ5l
TB/aN2ymwY2+8zRJetD2bk/ECpQYYoLEwBNBJ7VMyalnn77avf7Z9i0X8GeylmZQ
mmcxs5BmSljciCuHi66qcUlgmdrHpDw9OO6ETWZ2vo424e9foP20+gLybW8p+lDJ
cmrxN9N8P1781eXozZdVgklesyU1Ow==
=Ruvz
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--


--===============0554445548806989567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0554445548806989567==--

