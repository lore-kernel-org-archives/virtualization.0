Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF69C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 17:47:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B48613CD
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 17:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B48613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7077F405AA;
	Tue, 20 Apr 2021 17:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7XuIBs7eURK; Tue, 20 Apr 2021 17:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C4EE40225;
	Tue, 20 Apr 2021 17:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48571C000E;
	Tue, 20 Apr 2021 17:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEACAC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DB816080A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CA_2z5wfaTcx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97A5E60636
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:47:34 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 85D7FAE93;
 Tue, 20 Apr 2021 17:47:32 +0000 (UTC)
Subject: Re: [PATCH] drm/bochs: Add screen blanking support
To: Takashi Iwai <tiwai@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
References: <20210420165659.23163-1-tiwai@suse.de>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <6d2f59c0-113f-2d9e-1fb3-a794dafbd74a@suse.de>
Date: Tue, 20 Apr 2021 19:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210420165659.23163-1-tiwai@suse.de>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============7267291722178932919=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7267291722178932919==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="upFGBTJuhzTG1kLZEuVD8z83NERT1gLUE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--upFGBTJuhzTG1kLZEuVD8z83NERT1gLUE
Content-Type: multipart/mixed; boundary="aHJGaqLLv0JPrVs0jpLkJ6GVyLewlwkMf";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Takashi Iwai <tiwai@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <6d2f59c0-113f-2d9e-1fb3-a794dafbd74a@suse.de>
Subject: Re: [PATCH] drm/bochs: Add screen blanking support
References: <20210420165659.23163-1-tiwai@suse.de>
In-Reply-To: <20210420165659.23163-1-tiwai@suse.de>

--aHJGaqLLv0JPrVs0jpLkJ6GVyLewlwkMf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.04.21 um 18:56 schrieb Takashi Iwai:
> On bochs DRM driver, the execution of "setterm --blank force" results
> in a frozen screen instead of a blank screen.  It's due to the lack of
> the screen blanking support in its code.
>=20
> Actually, the QEMU bochs vga side can switch to the blanking mode when
> the bit 0x20 is cleared on VGA_ATT_IW register (0x3c0), which updates
> ar_index in QEMU side.  So, essentially, we'd just need to clear the
> bit at pipe disable callback; that's what this patch does essentially.
>=20
> However, a tricky part is that the QEMU vga code does treat VGA_ATT_IW
> register always as "flip-flop"; the first write is for index and the
> second write is for the data like palette.  Meanwhile, in the current
> bochs DRM driver, the flip-flop wasn't considered, and it calls only
> the register update once with the value 0x20.
>=20

Unless bochs does things very different, the index should first be reset =

by reading 0x3da. Then write the index, then the data.

https://web.stanford.edu/class/cs140/projects/pintos/specs/freevga/vga/vg=
areg.htm#attribute

Best regards
Thomas

> So, in this patch, we fix the behavior by simply writing the
> VGA_ATT_IW register value twice at each place as well.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/gpu/drm/bochs/bochs_hw.c  | 13 ++++++++++++-
>   drivers/gpu/drm/bochs/bochs_kms.c |  8 ++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/b=
ochs_hw.c
> index 2d7380a9890e..9a6f90216d6c 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -213,6 +213,14 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>   	if (!drm_dev_enter(bochs->dev, &idx))
>   		return;
>  =20
> +	if (!mode) {
> +		DRM_DEBUG_DRIVER("crtc disabled\n");
> +		/* set to blank mode; send twice for ar_flip_flop */
> +		bochs_vga_writeb(bochs, 0x3c0, 0);
> +		bochs_vga_writeb(bochs, 0x3c0, 0);
> +		goto exit;
> +	}
> +
>   	bochs->xres =3D mode->hdisplay;
>   	bochs->yres =3D mode->vdisplay;
>   	bochs->bpp =3D 32;
> @@ -223,7 +231,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>   			 bochs->xres, bochs->yres, bochs->bpp,
>   			 bochs->yres_virtual);
>  =20
> -	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
> +	/* unblank; send twice for ar_flip_flop */
> +	bochs_vga_writeb(bochs, 0x3c0, 0x20);
> +	bochs_vga_writeb(bochs, 0x3c0, 0x20);
>  =20
>   	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
>   	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
> @@ -239,6 +249,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>   	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
>   			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
>  =20
> + exit:
>   	drm_dev_exit(idx);
>   }
>  =20
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/=
bochs_kms.c
> index 853081d186d5..b0d77d6d3ae4 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -57,6 +57,13 @@ static void bochs_pipe_enable(struct drm_simple_disp=
lay_pipe *pipe,
>   	bochs_plane_update(bochs, plane_state);
>   }
>  =20
> +static void bochs_pipe_disable(struct drm_simple_display_pipe *pipe)
> +{
> +	struct bochs_device *bochs =3D pipe->crtc.dev->dev_private;
> +
> +	bochs_hw_setmode(bochs, NULL);
> +}
> +
>   static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
>   			      struct drm_plane_state *old_state)
>   {
> @@ -67,6 +74,7 @@ static void bochs_pipe_update(struct drm_simple_displ=
ay_pipe *pipe,
>  =20
>   static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs =3D=20
{
>   	.enable	    =3D bochs_pipe_enable,
> +	.disable    =3D bochs_pipe_disable,
>   	.update	    =3D bochs_pipe_update,
>   	.prepare_fb =3D drm_gem_vram_simple_display_pipe_prepare_fb,
>   	.cleanup_fb =3D drm_gem_vram_simple_display_pipe_cleanup_fb,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--aHJGaqLLv0JPrVs0jpLkJ6GVyLewlwkMf--

--upFGBTJuhzTG1kLZEuVD8z83NERT1gLUE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmB/E7MFAwAAAAAACgkQlh/E3EQov+D6
FxAAuT0d/eBrm30dkVWuMrQ1Vk0j4VGdJ7WwuDe/mpeDgwx0MYsbkk8P3kAjESM7qcfMLZa5oluz
Xj5bk+o1+bGYp110rhz5NgVOlYllWJ/FHRfeGoDWPJKRqeUwYgPycPKu7rc9VKKvjxJjLdzJ8Uku
NrZcqL3i9NDjKASk70YD2DByjpEm8oowgvB8QAc1bMpf9BO8wpLJTXZBjNRteKAcunDe+jeuR4KH
D9ZTJ+DMyDkjYegDvb/yj0YeLkPyTpwnTGdra958+AkhhLLkL1NE7YFPRN97jXc3oJC8JdOIQ0Rj
lMh5soym8MD/Z3yKM5nO4GC5qsoUBm4+7F5atyZtilvKEGY/vsIWLmaAAsF5hAKIl2Rj4Fud9Kg0
0IeUGGT0LXulOy40zKpAdnie3YuLqL3O9C19/wvhjhInfOG9YfNQz4pl0ZN7JNFOCWUJnB3cJizc
HEHjBrMryNW9mZkr+OHd9tSHQfGz/q4P8EWJotJ37ExxMN5cwXQ2mZoCCRJJs2CcJMRP0vLYzEK3
v0CyRX7iedrzYcL/zvSI9SNbMSmL9r2+ntm8ld+vxHFOXQmbeeqzYrpRi43/gc7BaJw2ibHOP0eF
v4+QbaDvtygv8eLmBLPCZoKM8wOtG2hA8YPCAVjGEsy1JRqFuAOzPai+Qj04MriypXkGxdpZrhCy
YPk=
=Co6c
-----END PGP SIGNATURE-----

--upFGBTJuhzTG1kLZEuVD8z83NERT1gLUE--

--===============7267291722178932919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7267291722178932919==--
