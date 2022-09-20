Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C31C6FA82
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 18:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51CC4417AE;
	Tue, 20 Sep 2022 18:11:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51CC4417AE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VdsreP/A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6O6b_QG4za1d; Tue, 20 Sep 2022 18:11:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 936B2417BD;
	Tue, 20 Sep 2022 18:11:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 936B2417BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D84CC0033;
	Tue, 20 Sep 2022 18:11:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E47CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B20BD826B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B20BD826B0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VdsreP/A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1tvJkY14s6au
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:11:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0946282605
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0946282605
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663697508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+FuPAq/OgEzeUUcAT45hj6qmPe6Z6xy8JMCD4zCDyw=;
 b=VdsreP/AieM7Ei93XPUnfOFSe0BKWHCZdUwosSrVLJA5K6XLXpWIa2HXFY4ZPlpmZnyuwP
 z34GBCb7tXKUxNWTV+/WYb17iTrLlu5TgdSM9ZnwhfdttnuEHVGoHfhbLLTblT9uPxZEmw
 L9EumfklvnxKd9ZnRwPQ14maTM+fp1g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-ZjIsJDLyMvK4cf3Gaw7MfQ-1; Tue, 20 Sep 2022 14:11:43 -0400
X-MC-Unique: ZjIsJDLyMvK4cf3Gaw7MfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D899738149A8;
 Tue, 20 Sep 2022 18:11:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 255292166B26;
 Tue, 20 Sep 2022 18:11:41 +0000 (UTC)
Date: Tue, 20 Sep 2022 14:11:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <YyoCXOwRE7NLxTTH@fedora>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <Yyin8zSKJb3GPFno@fedora>
 <CAJs=3_ASjr0DF9MTvS=P-ZeJpC4nAH+2vkTjWROzQbS+mvLU4Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_ASjr0DF9MTvS=P-ZeJpC4nAH+2vkTjWROzQbS+mvLU4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============5724436776253708865=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5724436776253708865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/Ofkv9cTbQSikX8"
Content-Disposition: inline


--H/Ofkv9cTbQSikX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 09:09:05PM +0300, Alvaro Karsz wrote:
> Thanks for the reply.
>=20
> > This can be simplified with min_not_zero().
>=20
> Ok, I will do it in the next version.
>=20
> > It's worth including a comment here that the discard and secure erase
> > limits are combined because the Linux block layer only has one limit
> > value. If the block layer supported independent limit values we wouldn't
> > need to do this.
>=20
> Ok.
>=20
> I'll send a new version once we agree on the max_secure_erase_seg =3D 0 s=
cenario.
> Do you have an opinion on that?
> Do you think that using sg_elems as the number of secure erase/discard
> segments when the value in the virtio config is 0 is good enough?
>=20

Okay, I have replied in the max_secure_erase_seg sub-thread. I think
probing the device should fail if the value is 0. There are no existing
non-compliant devices that we need to be compatible with - let's
encourage device implementors to report usable max_secure_erase_seg
values.

Stefan

--H/Ofkv9cTbQSikX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMqAlwACgkQnKSrs4Gr
c8jz5QgArw+zZMDwYcGACB9Tkx1XhgYcONBrcTnhEnmAvA9Z9/vF0Vg3BrWxyGct
2bh589SFOpMyaUcFMJPIWgalQG0ROPjaSgni1nwnq/HDB+ffUBklW655C76y+sk6
wM2CA24/PnvLxz6l4rGioaqptcq5sm4Pw5G/7+KKncXjouPNdfFA9ifBlstYNS1T
Cl/z/B7mzuLNj12UPaNuvx5J1Iz988/iZqMNFu9lQccbdEwgpiaYmjbBWowU/Euj
PRwBwboX9Si6aPC+JojetzxvhswtEy71qLpc+nuFXHZF63PAQMLlm7icQfbmsQ6O
TLvC6oqsFwV/FzGbcO+SoMWew3afXg==
=Riwp
-----END PGP SIGNATURE-----

--H/Ofkv9cTbQSikX8--


--===============5724436776253708865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5724436776253708865==--

