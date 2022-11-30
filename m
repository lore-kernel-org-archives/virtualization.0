Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10965C4321E
	for <virtualization@archiver.kernel.org>; Wed, 30 Nov 2022 20:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EB7860F64;
	Wed, 30 Nov 2022 20:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EB7860F64
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NiNSDBRl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsQc6npVTvIb; Wed, 30 Nov 2022 20:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D73060AF2;
	Wed, 30 Nov 2022 20:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D73060AF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D795FC0032;
	Wed, 30 Nov 2022 20:51:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0919C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 20:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A953C417BD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 20:51:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A953C417BD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NiNSDBRl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSlWeLyMkcDU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 20:51:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FC86417C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FC86417C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669841493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQgAOvEZVM6ximlp/shF5gDfXHjOpS9Wecui6IHnldg=;
 b=NiNSDBRlE1vBA/LIICE6Rq0BDTb0dJtg/Hon1K4llViz1678Ev1HLOYvu9Xu2HRaNCT5mV
 fh859JpEtDU/iVJNlFcW1ygUeiqXJ5dPXCgdcGBWougiLzqMovFQLHosUA/PQV5fUZBgiW
 JGppnl0SA4IjycKOEGysm5jYGkUNE9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-DB69oWysORGQKIlKbJtf0A-1; Wed, 30 Nov 2022 15:51:29 -0500
X-MC-Unique: DB69oWysORGQKIlKbJtf0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 983D485A5B6;
 Wed, 30 Nov 2022 20:51:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F03BFC15BB4;
 Wed, 30 Nov 2022 20:51:27 +0000 (UTC)
Date: Wed, 30 Nov 2022 15:51:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Message-ID: <Y4fCS2d2r1YvSExI@fedora>
References: <CGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2@eucas1p2.samsung.com>
 <20221130123001.25473-1-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20221130123001.25473-1-p.raghav@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: axboe@kernel.dk, Pankaj Raghav <pankydev8@gmail.com>, mst@redhat.com,
 gost.dev@samsung.com, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============8576825145995899737=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8576825145995899737==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHTxRgQR67n6DBCs"
Content-Disposition: inline


--nHTxRgQR67n6DBCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 01:30:03PM +0100, Pankaj Raghav wrote:
> ida_simple[get|remove] are deprecated, and are just wrappers to
> ida_[alloc_range|free]. Replace ida_simple[get|remove] with their
> corresponding counterparts.
>=20
> No functional changes.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/virtio_blk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Chaitanya proposed a similar patch in the past:
https://lore.kernel.org/all/20220420041053.7927-5-kch@nvidia.com/

Your patch calculates the max argument correctly. Looks good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nHTxRgQR67n6DBCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOHwksACgkQnKSrs4Gr
c8gQuAf9H2mnAIrELNShopJ32U5cjYPwqU2Bu2qZ5RfQxU83eCwJp7kyw922O4ng
AOEQx/BV8cXytlv54kXWF2h4AKOAB/vGiIu1yZgF/Bfos9z8mKc9zjgV9G4vdKwf
NTKrINoBHl1NnSiTDKrA/i1s4rgHU8asU7GcfO0UpX+QBKhM5gG3QYBw6zU4eD2x
9lQ6S8DIvY16upOMwynUSiZ8ltUVAyBuRq6REZ5H0JtBz6nwvgLR+o344iVDxF6M
Cl7oWdVVBslv2R+ExTo9zQW8naerHkFGIqrsTKcTcgIPEaVexyL95FcTB7g49wOV
cfqQpZ04GJz3eDUDd59UWXlcDmcc3w==
=SjCs
-----END PGP SIGNATURE-----

--nHTxRgQR67n6DBCs--


--===============8576825145995899737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8576825145995899737==--

