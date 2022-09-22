Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F288ECAAD8
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 17:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2BAA400FD;
	Thu, 22 Sep 2022 17:45:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2BAA400FD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+FgiiTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qbbLQaNGcCSR; Thu, 22 Sep 2022 17:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9735400DB;
	Thu, 22 Sep 2022 17:45:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9735400DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90424C0033;
	Thu, 22 Sep 2022 17:45:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30292C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0CE981491
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:45:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0CE981491
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+FgiiTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NdRoCJa2I-S0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:45:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE2A0813EF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE2A0813EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663868725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDdQkas1ErrC0QJHZzVhzu6ND5Qku7l4OdUzUyfa03o=;
 b=Q+FgiiTgEFfFqOHExjuE0SWNrZNMmj043f9eF0xsuZoQbVoQpI6BY/n85CWzWmZ9jifUED
 L0sTx6zjHnATlSjduAocWasCRNl+l/Gf0mbkEaLK+IW5o+8NlykaHIdZIoFOsy4lNxGdS4
 dXUbwPK4E5NhSuBeC/YYHAeO6w3ba1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-_QbBW9FeOPa2Nb7apbcShg-1; Thu, 22 Sep 2022 13:45:22 -0400
X-MC-Unique: _QbBW9FeOPa2Nb7apbcShg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1811185A792;
 Thu, 22 Sep 2022 17:45:21 +0000 (UTC)
Received: from localhost (unknown [10.39.192.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70CF22027062;
 Thu, 22 Sep 2022 17:45:11 +0000 (UTC)
Date: Thu, 22 Sep 2022 13:45:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
Message-ID: <YyyfJQo7N/iMPLNP@fedora>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============4772726090582399695=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4772726090582399695==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u57i0+ccTSQPW8XL"
Content-Disposition: inline


--u57i0+ccTSQPW8XL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 11:27:29AM +0300, Alvaro Karsz wrote:
> Support for the VIRTIO_BLK_F_SECURE_ERASE VirtIO feature.
>=20
> A device that offers this feature can receive VIRTIO_BLK_T_SECURE_ERASE
> commands.
>=20
> A device which supports this feature has the following fields in the
> virtio config:
>=20
> - max_secure_erase_sectors
> - max_secure_erase_seg
> - secure_erase_sector_alignment
>=20
> max_secure_erase_sectors and secure_erase_sector_alignment are expressed
> in 512-byte units.
>=20
> Every secure erase command has the following fields:
>=20
> - sectors: The starting offset in 512-byte units.
> - num_sectors: The number of sectors.
>=20
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
> v2:
> 	- Set queue max discard segments as the minimum between
> 	  max_secure_erase_seg and max_discard_seg.
> 	- Set queue discard granularity as the minimum between
> 	  secure_erase_sector_alignment and discard_sector_alignment.
>=20
> v3:
> 	- Usage of min_not_zero.
> 	- Fail probe if any of the secure erase parameters in the virtio
> 	  config is 0.
> 	- Add a comment explaining why we use the minimum between the discard
> 	  and secure erase limits.
> ---
>  drivers/block/virtio_blk.c      | 110 ++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_blk.h |  19 ++++++
>  2 files changed, 111 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u57i0+ccTSQPW8XL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMsnyQACgkQnKSrs4Gr
c8h68QgAuu3G55GOjFIGzRL211jarWZn8uI81rhv7CZKD1vSDTw0VPNUHbSF5D6j
2uj9cQtt6QOb1Bsi4ydyYEHIVr9obq7Y3X130uWqfI+3exkV77/cKjUBQAQyM0u8
1fhJ2aGXuzGgW4iRCJmrVZk1qnIM/0EgiJ6jtL2dgeA+AI1cD96+mlAQ2oHG+noP
Z/uXgkXjcxW0Q3QS6AW7QAV3X4G8Ih5tttFqvPAycTpw8pQIMd8bR4Exio128+pT
YBsDDaCThl257uzPbsOJfT1yNIDBPLY2EFqaK+CdO97CR4FkCPv9DizjqgbJOwUR
DStNlQiDCOQfOCT+yzx6b/kq6a+HWg==
=JjfU
-----END PGP SIGNATURE-----

--u57i0+ccTSQPW8XL--


--===============4772726090582399695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4772726090582399695==--

