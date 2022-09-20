Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4273AC54EE9
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 18:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8CF360F8C;
	Tue, 20 Sep 2022 18:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8CF360F8C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZ7gO1WL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDxu_BPgH-d2; Tue, 20 Sep 2022 18:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DDB960E89;
	Tue, 20 Sep 2022 18:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DDB960E89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1634DC0033;
	Tue, 20 Sep 2022 18:10:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F6CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA35360F82
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA35360F82
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XINwyIxw6mPR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:10:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B89F60E89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B89F60E89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663697445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vykNClOr/xDfvjX9gTYYDd1VSKkb/kTPVk9zayw8eeQ=;
 b=WZ7gO1WL2mK/V/1Bv4oyGI6HMMvosjVLc5VE8EOdlPRhHHPI1OIDM6lAn72GHIYYBtSZVJ
 6cKKKpGLso7KRAx1PMKlieBODU/UBVdkp8WaJNRLq5V0CtVeq3qo9jO1mQZc/IydX9t7Ca
 U2A+8C5HtqN28OrWKwzGbBLL/hn3Ads=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-ig7j0cygOvqrusKgFepMTA-1; Tue, 20 Sep 2022 14:10:40 -0400
X-MC-Unique: ig7j0cygOvqrusKgFepMTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DBB8811E81;
 Tue, 20 Sep 2022 18:10:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E13CE1759F;
 Tue, 20 Sep 2022 18:10:39 +0000 (UTC)
Date: Tue, 20 Sep 2022 14:10:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <YyoCHV3s0kd0e3aG@fedora>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <20220918091848-mutt-send-email-mst@kernel.org>
 <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
 <20220918110951-mutt-send-email-mst@kernel.org>
 <CAJs=3_AdHBZZKXypXh=wZDB58jADyoec6RnH42b_-UphPqFGSA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AdHBZZKXypXh=wZDB58jADyoec6RnH42b_-UphPqFGSA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4499853538652107588=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4499853538652107588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vTaeoVIugHViNEBr"
Content-Disposition: inline


--vTaeoVIugHViNEBr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2022 at 07:07:34PM +0300, Alvaro Karsz wrote:
> > sounds good. Add a code comment?
>=20
> I will.
>=20
> >  yes but I now see two places that seem to include this logic.
>=20
>=20
> Yes, this is because the same logic is applied on 2 different pairs.
>=20
> * secure_erase_sector_alignment and discard_sector_alignment are used
> to calculate  q->limits.discard_granularity.
> * max_discard_seg and max_secure_erase_seg are used to calculate
> max_discard_segments.
>=20
> > I am not 100% sure. Two options:
> > 1- Add a validate callback and clear VIRTIO_BLK_F_SECURE_ERASE.
> > 2- Alternatively, fail probe.
>=20
>=20
> Good ideas.
> 2- Do you think that something like that should be mentioned in the
> spec? or should be implementation specific?
>=20
> How about setting the value to 1? (which is the minimum usable value)
>=20
> > which is preferable depends on how bad is it if host sets
> > VIRTIO_BLK_F_SECURE_ERASE but guest does not use it.
>=20
>=20
> I'm not sure if it is that bad.
> If the value is 0, sg_elems is used.
> sg_elems is either 1 (if VIRTIO_BLK_F_SEG_MAX is not negotiated), or
> seg_max (virtio config).
>=20
> """
> err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
>                                           struct virtio_blk_config, seg_m=
ax,
>                                           &sg_elems);
> /* We need at least one SG element, whatever they say. */
> if (err || !sg_elems)
>          sg_elems =3D 1;
> """
>=20
> So the only "danger" that I can think of is if a device negotiates
> VIRTIO_BLK_F_SEG_MAX and  VIRTIO_BLK_F_SECURE_ERASE, sets
> max_secure_erase_seg to 0 (I'm not sure what is the purpose, since
> this is meaningless), and can't handle secure erase commands with
> seg_max segments.

Given that SECURE ERASE is new and the VIRTIO spec does not define
special behavior for 0, I think the virtio_blk driver should be strict.

There's no need to work around existing broken devices. I would fail
probing the device. This will encourage device implementors to provide a
usable value instead of 0.

Stefan

--vTaeoVIugHViNEBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMqAh0ACgkQnKSrs4Gr
c8hWywf9FWHewHlszwrXDjThRsKnx0FcWWV7I2XS9tU4XRhH/FzDmT1KtnE3xBH5
eIq2KES0V0Wk9PfdHT41/W5RokQzb6zrnX7aCRXZZXvuoqI7qdXfFwc7SlKIj5g9
kLT64z6MMktfIwFq6dAbbQLCGLa6I2bC29VrdD5Xl0YaPdYtDQBcqEOUynZluVzh
ciPKeDzX/cso5BpnH9TjBcLB4VQb2ShLNG4H1hCxH/Vnj+Gv8qoYBKdQ7YaBTt9q
AHN071C3C/aqjwMyPOoO1fcznVpq0eKyz8vpluyh31WnYir4cOKjeiNVKIE43PyC
qbM0XhYXw3bMrlupQ/Lf2Jk2svcgHg==
=u64i
-----END PGP SIGNATURE-----

--vTaeoVIugHViNEBr--


--===============4499853538652107588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4499853538652107588==--

