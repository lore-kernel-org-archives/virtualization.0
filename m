Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2EC433E0
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 08:14:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF50423358
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 08:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF50423358
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7846827428;
	Fri, 22 Jan 2021 08:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eAqP9ZmxLE0k; Fri, 22 Jan 2021 08:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6E60322F26;
	Fri, 22 Jan 2021 08:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 647ABC088B;
	Fri, 22 Jan 2021 08:14:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CBCCC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 08:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE8B187330
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 08:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEPVHknzFXy5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 08:14:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 248EE8732E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 08:14:49 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B21B8AB9F;
 Fri, 22 Jan 2021 08:14:47 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] drm/qxl: release shadow on shutdown
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-4-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <fbc21376-bb8b-58e8-5ff6-5c644bfeae03@suse.de>
Date: Fri, 22 Jan 2021 09:14:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120111240.2509679-4-kraxel@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0891064909754096471=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0891064909754096471==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BHM8OTILCRQMltYlRHrPRsJeGbbtEpZjb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHM8OTILCRQMltYlRHrPRsJeGbbtEpZjb
Content-Type: multipart/mixed; boundary="cLBy6hjRREc7smgQM8lhwvfJEt4CYYBBI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <fbc21376-bb8b-58e8-5ff6-5c644bfeae03@suse.de>
Subject: Re: [PATCH v3 3/4] drm/qxl: release shadow on shutdown
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-4-kraxel@redhat.com>
In-Reply-To: <20210120111240.2509679-4-kraxel@redhat.com>

--cLBy6hjRREc7smgQM8lhwvfJEt4CYYBBI
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.01.21 um 12:12 schrieb Gerd Hoffmann:
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

Wrt to my comment on patch 2, this might be the place to unpin the BO.

> +		drm_gem_object_put(&qdev->dumb_shadow_bo->tbo.base);
> +		qdev->dumb_shadow_bo =3D NULL;
> +	}
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


--cLBy6hjRREc7smgQM8lhwvfJEt4CYYBBI--

--BHM8OTILCRQMltYlRHrPRsJeGbbtEpZjb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAKiXYFAwAAAAAACgkQlh/E3EQov+CQ
cw//Z/zn8O5Z7aQqXJbqzjKl8N0/MhAdsp+Tws2mP16RQSTAKFaoGsLEghTXg2H5+9ZiQRxFnvmZ
XvvfDkvLkg49VZp6kH5C48xd7OqkFSq7wfE32NrGjsG2DtkCT6rbsD8nqmsOqegCEHdjgXW08ln4
ucmbdn6RBK5N/Qlq8+OojoFGg+J+e/CrbfDG3bOSHtdW1uwXc237oMWaMIEfPKRvOKS84acBw8Mq
1aAvkIMddAnjw4Dw8b114Uj8USxa2xv69V3gU5bss3IhQAcF6jsRDunZKuSlzPlPmNRSe+IJar7F
LwR8i+UCT5/XoNvla0pSh8F0nb6sgA2yesGiktmsYC0AgoOiqAF/0JT9b3OWWoL5nxqh83+ez9Z/
vXHtjizay4whuS5AYp+ULuOmQNzNCMoGNamwt/yDrqhpIpVVnkKTDMiwba7CZUzDgzuJRPstyBIm
Z7Q+JC06qTduWae6yHNxhodQburqLaxKKKTevXom/F2rbhr4uNZF32cpAFsYX70Fn6EVGL3TOAUq
vJNlmMw/Yka019C/mNQvtGakfSbWKKMLs9ssMFzVGvLSQsYCDGup4DM7P7paJrAUaAZAd8SOQpO5
T/oylBM8qFj8u6aDoTWr9deOaHm40Ai2gygwWLA4SbrNlMA6Xk64gTL0JjdB286xnjnIkyY328N1
o1w=
=Nuo2
-----END PGP SIGNATURE-----

--BHM8OTILCRQMltYlRHrPRsJeGbbtEpZjb--

--===============0891064909754096471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0891064909754096471==--
