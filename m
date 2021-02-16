Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E6C433E6
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:30:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2835464D73
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2835464D73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC4CA8684A;
	Tue, 16 Feb 2021 13:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukE6YL+RYWca; Tue, 16 Feb 2021 13:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E86EE86857;
	Tue, 16 Feb 2021 13:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFA67C0893;
	Tue, 16 Feb 2021 13:30:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0748C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BE71F85623
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PmdWT9c_q4NF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:30:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0AFEB853FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:30:42 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7E5E5ACBF;
 Tue, 16 Feb 2021 13:30:40 +0000 (UTC)
Subject: Re: [PATCH 10/10] drm/qxl: add lock asserts to qxl_bo_kmap_locked +
 qxl_bo_kunmap_locked
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-11-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <f61561a4-f6c7-9237-cd10-1c69016e6e45@suse.de>
Date: Tue, 16 Feb 2021 14:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-11-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6993936744263834983=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6993936744263834983==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tFhe9PKG2q0fqzqCD5MFXWxnTuigfR9oA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFhe9PKG2q0fqzqCD5MFXWxnTuigfR9oA
Content-Type: multipart/mixed; boundary="mHiYfAjZjkwogDjV1m7fAzeEA06jD8QEi";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <f61561a4-f6c7-9237-cd10-1c69016e6e45@suse.de>
Subject: Re: [PATCH 10/10] drm/qxl: add lock asserts to qxl_bo_kmap_locked +
 qxl_bo_kunmap_locked
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-11-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-11-kraxel@redhat.com>

--mHiYfAjZjkwogDjV1m7fAzeEA06jD8QEi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> Try avoid re-introducing locking bugs.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

IMHO this should eventually be done in the rsp TTM functions. But so=20
far, I'd expect this to break some drivers.

Best regards
Thomas

> ---
>   drivers/gpu/drm/qxl/qxl_object.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index 22748b9566af..90d5e5b7f927 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -162,6 +162,8 @@ int qxl_bo_kmap_locked(struct qxl_bo *bo, struct dm=
a_buf_map *map)
>   {
>   	int r;
>  =20
> +	dma_resv_assert_held(bo->tbo.base.resv);
> +
>   	if (bo->kptr) {
>   		bo->map_count++;
>   		goto out;
> @@ -236,6 +238,8 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qd=
ev,
>  =20
>   void qxl_bo_kunmap_locked(struct qxl_bo *bo)
>   {
> +	dma_resv_assert_held(bo->tbo.base.resv);
> +
>   	if (bo->kptr =3D=3D NULL)
>   		return;
>   	bo->map_count--;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--mHiYfAjZjkwogDjV1m7fAzeEA06jD8QEi--

--tFhe9PKG2q0fqzqCD5MFXWxnTuigfR9oA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAryP4FAwAAAAAACgkQlh/E3EQov+Da
lBAApClBe1Rptsp/Inp0yQSpt5brR4TNcD4dqXLn3k3TU5AiH7SlkhVt3h0s8aGDbq/NdSVvXwKF
/iQXwI3PNSi21+LaQmsVNGpJDSv40TyCbyJTyAWZXvn56xOH3NZqWqNvJgAIWUUDJghJyHLFmNTs
dBjvPAFAr7pJVIhDbKYubtUZMWd6Qn/rAaDDBWBkyVmApWmp972ZOU0GV/z9YHQEDiXD1QDh/lni
H4yaD1MQ/gO3gaN56THnLqvD9tThGAQnqI190PqaDSRJGbFjEYvxVbty3+wAx4OlYn0QYDCS0A8N
4wmn1t8UH1KzNDF4X5R1OgLjn9mwehFikDgHrJ7bJZ3U/uL7UpQp4vZxdfqodUfnYr1ohHvIYLEk
pAGI9pHVtaNkhcvBj0KQV3KHobWi6Y2F5JFtwg0nIgP/llkCYvkRsZ3tNt8DygsPO4Gnt/jNAYLy
ahgIxMDQlcgvJvdqo/NPoCINcZ1qGlE7WCYXn65u9aO/pTC7MzcgtWw6VdZF/BXNDDDFo5D2hNqc
t949uMtohBjs0yp+3QL+OvnwAnoAOWO9bBPnnGzgSU3hzch4WKpUM3O1EGUBX+Lzv18y2echDOFY
PsiDWolQQHH++DHwbQt6R7y1mruXLRQtlsWvVD9I506qKaZIeNEYGZJ106ue7MlHgrQabUNgkuX3
d/E=
=Kcjb
-----END PGP SIGNATURE-----

--tFhe9PKG2q0fqzqCD5MFXWxnTuigfR9oA--

--===============6993936744263834983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6993936744263834983==--
