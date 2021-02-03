Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDBBC433E6
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:00:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A4964E4B
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A4964E4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60F0985F45;
	Wed,  3 Feb 2021 14:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E2kHj0Y9E6Ms; Wed,  3 Feb 2021 14:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B851B85F29;
	Wed,  3 Feb 2021 14:00:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6494C0174;
	Wed,  3 Feb 2021 14:00:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1DD0C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B922860F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjmA4eTHfiFk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8492185D5F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:00:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1A215ACBA;
 Wed,  3 Feb 2021 14:00:50 +0000 (UTC)
Subject: Re: [PATCH v5 2/6] drm/qxl: unpin release objects
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-3-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <0d852d0b-4142-50c1-065f-0fd5b14b17a1@suse.de>
Date: Wed, 3 Feb 2021 15:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-3-kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============4474926446949852088=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4474926446949852088==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="147yOX0GtdM3jPKqvLPAx9h80hVHKqJ7g"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--147yOX0GtdM3jPKqvLPAx9h80hVHKqJ7g
Content-Type: multipart/mixed; boundary="tuZNwHXxX3tyWjYURWnuiC68XZDdfrL3z";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <0d852d0b-4142-50c1-065f-0fd5b14b17a1@suse.de>
Subject: Re: [PATCH v5 2/6] drm/qxl: unpin release objects
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-3-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-3-kraxel@redhat.com>

--tuZNwHXxX3tyWjYURWnuiC68XZDdfrL3z
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> Balances the qxl_create_bo(..., pinned=3Dtrue, ...);
> call in qxl_release_bo_alloc().
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index c52412724c26..28013fd1f8ea 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -347,6 +347,7 @@ int qxl_alloc_release_reserved(struct qxl_device *q=
dev, unsigned long size,
>  =20
>   	mutex_lock(&qdev->release_mutex);
>   	if (qdev->current_release_bo_offset[cur_idx] + 1 >=3D releases_per_b=
o[cur_idx]) {
> +		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
>   		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
>   		qdev->current_release_bo_offset[cur_idx] =3D 0;
>   		qdev->current_release_bo[cur_idx] =3D NULL;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--tuZNwHXxX3tyWjYURWnuiC68XZDdfrL3z--

--147yOX0GtdM3jPKqvLPAx9h80hVHKqJ7g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAarJAFAwAAAAAACgkQlh/E3EQov+Dz
uQ//U1uTJoKsaLKOoS1MtBmpxmUkzEq79UWDKej0Ztr1GoESBn6ciRQSFHXIAe/7uS4a1VsmKctn
9tzo1qc7pU5JMmlm9a0tzgThX5i8uwA8kX43yvhZKyS22wOy4ED4s6hIbxIr/VsjpSpBBebmFi2s
4ruG8vmNOWwjZC0a9YPhcoAmaIA92OSI89yHmbX8Eng1wHEFaBc/E5x+FtKHJI4r65HcwicmN5ju
+4h47XWgZRjcRdbjcOK2t9fOOlwe7hrhiuVRIYOFZW5zwObe+2RiOIeR6bNAjGuRAKD91hgab0+O
/qO2weLPZv5RaJo1BRT7dGgSqJPsY7sW461Qaqm/A1wYMpl2QzxD4jVRNhLdx4MlKFMoYhPu/HsB
odabRkl5PEuU/ixB5ZqvpsaO6Jum3YGhAksv3ORp/Wx2vy2xtR5JKutvsDO6dzHDA6mCKltDEVEX
tSbQ7PMG5CHjSeejvJbPfmDFc01Km0t+moEqqnUc9F/gZZ9rc2DhzndhQP/OYUuiqyachR4BM3Zk
3ukuEBqjRJT32v09DvJMSngeIplz71qHHMyv4UzlI5pl9yujRyuicZphARk48KWBq/7kcM+APZoq
NRg6IqxUsuXrydppNtr8RxmuTAGKiNPRaMHXRdMJmy3A5gQebggnmBuGKky8vZikXHjzeDhwqR5O
jNU=
=l1Yg
-----END PGP SIGNATURE-----

--147yOX0GtdM3jPKqvLPAx9h80hVHKqJ7g--

--===============4474926446949852088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4474926446949852088==--
