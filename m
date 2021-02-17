Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9337DC433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:24:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FC964E45
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FC964E45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED01C8713A;
	Wed, 17 Feb 2021 19:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vd-sxDKorxMI; Wed, 17 Feb 2021 19:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4310A81D3F;
	Wed, 17 Feb 2021 19:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D3BC0174;
	Wed, 17 Feb 2021 19:24:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D52CC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68E0286FBA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dzYDq22TEjuZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0FD1681D3F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:24:40 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A4A83ABA2;
 Wed, 17 Feb 2021 19:24:38 +0000 (UTC)
Subject: Re: [PATCH v2 06/11] drm/qxl: add qxl_bo_vmap/qxl_bo_vunmap
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-7-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <7d179073-ca21-6ad0-699a-43e2c35b04fc@suse.de>
Date: Wed, 17 Feb 2021 20:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-7-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6338957394130538908=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6338957394130538908==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SAFvhfcL0oFalVHym6d93TRvJBXQaoEMq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAFvhfcL0oFalVHym6d93TRvJBXQaoEMq
Content-Type: multipart/mixed; boundary="i8f6yrMVv0kSjMjycxzd9pYGPUo8KnJYE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <7d179073-ca21-6ad0-699a-43e2c35b04fc@suse.de>
Subject: Re: [PATCH v2 06/11] drm/qxl: add qxl_bo_vmap/qxl_bo_vunmap
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-7-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-7-kraxel@redhat.com>

--i8f6yrMVv0kSjMjycxzd9pYGPUo8KnJYE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Add vmap/vunmap variants which reserve (and pin) the bo.
> They can be used in case the caller doesn't hold a reservation
> for the bo.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_object.h |  2 ++
>   drivers/gpu/drm/qxl/qxl_object.c | 36 +++++++++++++++++++++++++++++++=
+
>   2 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl=
_object.h
> index 2495e5cdf353..ee9c29de4d3d 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.h
> +++ b/drivers/gpu/drm/qxl/qxl_object.h
> @@ -64,7 +64,9 @@ extern int qxl_bo_create(struct qxl_device *qdev,
>   			 u32 priority,
>   			 struct qxl_surface *surf,
>   			 struct qxl_bo **bo_ptr);
> +int qxl_bo_vmap(struct qxl_bo *bo, struct dma_buf_map *map);
>   int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map);
> +int qxl_bo_vunmap(struct qxl_bo *bo);
>   void qxl_bo_vunmap_locked(struct qxl_bo *bo);
>   void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo =
*bo, int page_offset);
>   void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo=
 *bo, void *map);
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index f4a015381a7f..82c3bf195ad6 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -29,6 +29,9 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>  =20
> +static int __qxl_bo_pin(struct qxl_bo *bo);
> +static void __qxl_bo_unpin(struct qxl_bo *bo);
> +
>   static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct qxl_bo *bo;
> @@ -179,6 +182,25 @@ int qxl_bo_vmap_locked(struct qxl_bo *bo, struct d=
ma_buf_map *map)
>   	return 0;
>   }
>  =20
> +int qxl_bo_vmap(struct qxl_bo *bo, struct dma_buf_map *map)
> +{
> +	int r;
> +
> +	r =3D qxl_bo_reserve(bo);
> +	if (r)
> +		return r;
> +
> +	r =3D __qxl_bo_pin(bo);
> +	if (r) {
> +		qxl_bo_unreserve(bo);
> +		return r;
> +	}
> +
> +	r =3D qxl_bo_vmap_locked(bo, map);
> +	qxl_bo_unreserve(bo);
> +	return r;
> +}
> +
>   void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
>   			      struct qxl_bo *bo, int page_offset)
>   {
> @@ -223,6 +245,20 @@ void qxl_bo_vunmap_locked(struct qxl_bo *bo)
>   	ttm_bo_vunmap(&bo->tbo, &bo->map);
>   }
>  =20
> +int qxl_bo_vunmap(struct qxl_bo *bo)
> +{
> +	int r;
> +
> +	r =3D qxl_bo_reserve(bo);
> +	if (r)
> +		return r;
> +
> +	qxl_bo_vunmap_locked(bo);
> +	__qxl_bo_unpin(bo);
> +	qxl_bo_unreserve(bo);
> +	return 0;
> +}
> +
>   void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
>   			       struct qxl_bo *bo, void *pmap)
>   {
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--i8f6yrMVv0kSjMjycxzd9pYGPUo8KnJYE--

--SAFvhfcL0oFalVHym6d93TRvJBXQaoEMq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbXUFAwAAAAAACgkQlh/E3EQov+DV
cQ//eal4ZvQAYRdmRcwuX0jmd9Udx7/DSF+a7YZYDgEp8xN6d/TfZWTJ0GMJmIEKtCsB54X0tG48
vUTjAXS3waxCZ/YUPjPA5Rrb9uk+0FZ9im6DyAhN5RtMr4z8X61EheCMJAESrPC6zF9eqfFUFDw1
SgAxSw95+/Bu+ECmazwjZgahOKrpx9Tm/rSpNY/hrPll/dcdhh6PVzueM8zr3F6lXAuc4NDAP2Qy
pNCDGzFDlY+tiz53UTbiKrx4Pn7CayrL8o1NwnYi0imljvkO+1s6mCdq11Jl3t+MrxfsSmBHmsRq
1ywVyUYNUFCHM/lYBATeaDiXs2UJgm98OHrhd8puDePWGMzTlxWUNL8CbQzOt5GAGWv0CspiV2gP
vON6tKBDQ6BXGkXcabMaW07HIyiPQG8Ig3BwUHdFO2egPL19SEFA4bRavtDlTjZR0Ozh/B8dO4Uk
fS18rRBRsfvj3kpStFL3189qGmREie6KXduUVzC1IJdltJlno6iFoc1IQTE+QfOoX4++bCI3HlVw
6pSEyrQYZcZIj+1+JV2tN2DSlV4LDglYkb6x8/Fbc4BAYMN6X9yPQ9E/PdaHjk4FRlslOCbKlIaV
Jfn6G5X5525OCdVcg0fU2o4mw/NmsuIpMnRRImNVuXsJ8/1OI5DYHFO98teGT5HNQeIciWZxaF4F
B0k=
=r12Y
-----END PGP SIGNATURE-----

--SAFvhfcL0oFalVHym6d93TRvJBXQaoEMq--

--===============6338957394130538908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6338957394130538908==--
