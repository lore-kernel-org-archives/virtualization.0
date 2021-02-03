Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D240C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:06:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73EE64DDA
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73EE64DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 949BC87103;
	Wed,  3 Feb 2021 14:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNT1GEDi1mWn; Wed,  3 Feb 2021 14:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CB5CB85191;
	Wed,  3 Feb 2021 14:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9933C0174;
	Wed,  3 Feb 2021 14:05:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 827F9C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 686B5859BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTi7WKL-M7qr
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E3DCC868B6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:05:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7B8BCACB0;
 Wed,  3 Feb 2021 14:05:52 +0000 (UTC)
Subject: Re: [PATCH v5 3/6] drm/qxl: release shadow on shutdown
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-4-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <1eb3e4ed-59e5-bb06-1250-973a3df575be@suse.de>
Date: Wed, 3 Feb 2021 15:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-4-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8116587655943394677=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8116587655943394677==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk
Content-Type: multipart/mixed; boundary="PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <1eb3e4ed-59e5-bb06-1250-973a3df575be@suse.de>
Subject: Re: [PATCH v5 3/6] drm/qxl: release shadow on shutdown
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-4-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-4-kraxel@redhat.com>

--PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> In case we have a shadow surface on shutdown release
> it so it doesn't leak.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 38d6b596094d..60331e31861a 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1229,5 +1229,9 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  =20
>   void qxl_modeset_fini(struct qxl_device *qdev)
>   {
> +	if (qdev->dumb_shadow_bo) {
> +		drm_gem_object_put(&qdev->dumb_shadow_bo->tbo.base);
> +		qdev->dumb_shadow_bo =3D NULL;
> +	}

In qxl_plane_prepare_fb(), qdev->dumb_shadow_bo is being created as=20
pinned object. Wouldn't it have to be unpinned here and during the=20
release in qxl_plane_prepare_fb()?

Best regards
Thomas

>   	qxl_destroy_monitors_object(qdev);
>   }
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj--

--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAarb8FAwAAAAAACgkQlh/E3EQov+AC
dw//YIjQM9+UQ6YEOTFclxVumzNIR/1B7MQxhCImAAgboACDyhWpcRrQ0XiixXw100IS0IIvE2rH
3sHu/zVvwT5Kr7M6AtR4x90pMR4NKM7wp+Ffm5F2GqUYQteW6fBB2ahHmu+XtvRfkmKyJcs9NzDX
rOP6LgVZSCvGaFaMGYC4veZh12gIitPDmqyLgp3t6ChNUOcQXCx6Sf+cPzM8054+vYkYsSuDVWqS
ZjixZau+Eb8M59eYcP5RFRkImgxpS70gAJg0xOmyH/USnXHtwPKyJovQVR6lnxXHTPOBlnidXU7d
nIPTimKw3lwBvuQTZpggiXTW5V36WYf7bX/ybAMlM/+4JfK1CECKQ5cKu1gT2UGw7asVfYU4xTP3
b44tqJToefnterytaQfpzPOxrwXhYsklcU+jjzNWPuWc1jKsSimPcva3xSqJl3TUA353UAFbFuKV
82MMmyvveePWjIw1Tw1zhJvf13feNEy8igA8ZeqAOGxomvj8RBVj7LjLaMhddkLXPh1VsB5MSDjY
LWL1J+D02fvePgHik2HuRKGFx46FA78weWhrS5szw2BkTu8fZyY7u9Ecfok/R16GQZZj7KEbR/F8
K/7amY5blEpV7QIRiR1Ifv4h0shSWjtVkQTfSe1cbSfnSvReq/5h7+Oe3DNNn+XnB9WVCQql4FtO
QDw=
=k6RT
-----END PGP SIGNATURE-----

--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk--

--===============8116587655943394677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8116587655943394677==--
