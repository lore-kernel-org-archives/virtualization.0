Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF31C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:21:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E7C64E4A
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E7C64E4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A35285CB8;
	Wed, 17 Feb 2021 19:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fx+-nFxBJbLQ; Wed, 17 Feb 2021 19:21:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D0BC785B6F;
	Wed, 17 Feb 2021 19:21:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2B3BC0174;
	Wed, 17 Feb 2021 19:21:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ACD1C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53696600BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DDcrgt1ot_zg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:21:31 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 58DAA6059D; Wed, 17 Feb 2021 19:21:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDCE7600BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 19:21:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9A3C7AC97;
 Wed, 17 Feb 2021 19:21:27 +0000 (UTC)
Subject: Re: [PATCH v2 02/11] drm/qxl: more fence wait rework
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-3-kraxel@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <11f0d3e5-8823-212f-0f4e-83a639a1d476@suse.de>
Date: Wed, 17 Feb 2021 20:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-3-kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============7244101678299652642=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7244101678299652642==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="85GU1GqhvOPcBOU6e0aBenn292yxkgXpN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN
Content-Type: multipart/mixed; boundary="ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <11f0d3e5-8823-212f-0f4e-83a639a1d476@suse.de>
Subject: Re: [PATCH v2 02/11] drm/qxl: more fence wait rework
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-3-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-3-kraxel@redhat.com>

--ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Move qxl_io_notify_oom() call into wait condition.
> That way the driver will call it again if one call
> wasn't enough.
>=20
> Also allows to remove the extra dma_fence_is_signaled()
> check and the goto.
>=20
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 6ed673d75f9f..579c6de10c8e 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -62,16 +62,12 @@ static long qxl_fence_wait(struct dma_fence *fence,=
 bool intr,
>  =20
>   	qdev =3D container_of(fence->lock, struct qxl_device, release_lock);=

>  =20
> -	if (dma_fence_is_signaled(fence))
> -		goto signaled;
> -
> -	qxl_io_notify_oom(qdev);
>   	if (!wait_event_timeout(qdev->release_event,
> -				dma_fence_is_signaled(fence),
> +				(dma_fence_is_signaled(fence) ||
> +				 (qxl_io_notify_oom(qdev), 0)),
>   				timeout))
>   		return 0;
>  =20
> -signaled:
>   	cur =3D jiffies;
>   	if (time_after(cur, end))
>   		return 0;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9--

--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbLYFAwAAAAAACgkQlh/E3EQov+Dn
hA//SQHbXUJsbtp0KvlZ1STFVXxrBy4T7K2vJFVCkFS5KxHjl/ewgKFx1YSSHayz0p+QFON+7eC/
F/pdyiv3ydbHfs60QJ1D68i1NeG9hs7XKId5m8wZFxGTXgBXmiBZ1r+VEzkH6QX5gwTC98+E2Mdy
NZUE0gVtsq8iMnDyzu9BuFnQVHduz8xNSaIwuZRORyDvptIw87+JIOiOEE3y8YtU6Q38itW3DF/k
RIgd8+ZQ86mrtZKsyi3KUX14c2sj2G5haGXwYGXWnWbNJQ/2HeHrLDiT450FgPYde7epPJnACx+e
/a2txg0G476R4Lh4CVLvf0UdSvaaUoWJW2+rVbMBGHM+NgREOvvo8uYA8iCKw36GZn5suagsJoTY
U1QolQA2aPjl7EFNeNFf/0M+gJ1WRd2367Stt3rcQcQ5ZOlR4KilWg7xQZ3ZFCGX2O5Tlh2yNYdX
VWWQWOr8Te5FktOWLVjNN5Vw8QnuRdnGnQGqDIJQSXYgQq2k5CFQW9yLHTj5X7+K+JBaBSudWUGQ
HzJnqS114c4F/Baiwe8NUi4yl0tf38VBefHIhUD0CEfJw+QwiqGG2z4Eeu0zz9zxlH+4eXGA+NIc
ZUJEbw22lzJ3FdInNML0CDZFa4cYsPVaTATziPeAVDl9nqWCos3b0Dq/8un4ga3yRG25YQZAUVyu
4B0=
=J1s4
-----END PGP SIGNATURE-----

--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN--

--===============7244101678299652642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7244101678299652642==--
