Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33BAC4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 18:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D19D61037
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 18:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D19D61037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 038BF60A61;
	Wed,  4 Aug 2021 18:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wXLPK52XrP1; Wed,  4 Aug 2021 18:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8125260776;
	Wed,  4 Aug 2021 18:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4349FC001A;
	Wed,  4 Aug 2021 18:22:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA2C1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5B68405D6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="N1LxScWX";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="KmkLhj4z"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d42wk1TZAYc2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:22:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECA5340596
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:22:21 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB2522234;
 Wed,  4 Aug 2021 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628101339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9jDiedw+rhSv4P352qoVoLjia/fj5ASAwBaVCXTCBLw=;
 b=N1LxScWXW3V8lDVQjD1RVfpBuqODiwOoYvR6oBRgqYJMaEgAy7vi2RgECieKdCZoMV6Ktq
 rZh15npJjdAciB8Qz56TLCNN5asLqq2Ddkj9612yBN/Pt3SMhAvttCblOnfDXRJKz3Oii6
 gJncyPUvgoazbA8MHAaJT+FNs8VhqE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628101339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9jDiedw+rhSv4P352qoVoLjia/fj5ASAwBaVCXTCBLw=;
 b=KmkLhj4zXeXWnvs21gfa9La4p40/Us9+J9iwic7OnKjgCIkQSjrEXW/58Gl3Lk6E+xnvL4
 V/tZpkG3dOwx3LBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B6411139B5;
 Wed,  4 Aug 2021 18:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id nAmeKtraCmEmEgAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Wed, 04 Aug 2021 18:22:18 +0000
To: Sam Ravnborg <sam@ravnborg.org>
References: <20210803125928.27780-1-tzimmermann@suse.de>
 <YQls/oxklkZWqEnD@ravnborg.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/11] Provide offset-adjusted framebuffer mappings
Message-ID: <d7b8b30c-8b14-b7a4-ab95-e3540da7ad3a@suse.de>
Date: Wed, 4 Aug 2021 20:22:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQls/oxklkZWqEnD@ravnborg.org>
Cc: linux-hyperv@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
 hdegoede@redhat.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, melissa.srw@gmail.com,
 drawat.floss@gmail.com, noralf@tronnes.org, daniel@ffwll.ch,
 airlied@redhat.com, sean@poorly.run
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
Content-Type: multipart/mixed; boundary="===============2568214665465066536=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2568214665465066536==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hMa9McatD2SOtJAoFSGNBpookPaXNVbbw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMa9McatD2SOtJAoFSGNBpookPaXNVbbw
Content-Type: multipart/mixed; boundary="swZwCKEjaaVmZFU89z5nUly1HAOaK3Wu4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, noralf@tronnes.org,
 drawat.floss@gmail.com, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Message-ID: <d7b8b30c-8b14-b7a4-ab95-e3540da7ad3a@suse.de>
Subject: Re: [PATCH 00/11] Provide offset-adjusted framebuffer mappings
References: <20210803125928.27780-1-tzimmermann@suse.de>
 <YQls/oxklkZWqEnD@ravnborg.org>
In-Reply-To: <YQls/oxklkZWqEnD@ravnborg.org>

--swZwCKEjaaVmZFU89z5nUly1HAOaK3Wu4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sam

Am 03.08.21 um 18:21 schrieb Sam Ravnborg:
> Hi Thomas,
>=20
> On Tue, Aug 03, 2021 at 02:59:17PM +0200, Thomas Zimmermann wrote:
>> A framebuffer's offsets field might be non-zero to make the BO data
>> start at the specified offset within the BO's memory. Handle this
>> case in drm_gem_fb_vmap() and update all callers. So far, many drivers=

>> ignore the offsets, which can lead to visual artifacts.
>>
>> Patch 1 adds an optional argument to drm_gem_fb_vmap() to return the
>> offset-adjusted data address for use with shadow-buffered planes.
>>
>> Patches 3 and 11 convert gud and vkms, which are the other callers of
>> drm_gem_fb_vmap(). For gud, it's just a cleanup. Vkms will handle the
>> framebuffer offsets correctly for its input and output framebuffers.
>>
>> The other patches convert users of shadow-buffered planes to use the
>> data address. After conversion, each driver will use the correct data
>> for non-zero offsets.
>>
>=20
>>    drm/ast: Use offset-adjusted shadow-plane mappings
>>    drm/gud: Get offset-adjusted mapping from drm_gem_fb_vmap()
>>    drm/hyperv: Use offset-adjusted shadow-plane mappings
>>    drm/mgag200: Use offset-adjusted shadow-plane mappings
>>    drm/cirrus: Use offset-adjusted shadow-plane mappings
>>    drm/gm12u320: Use offset-adjusted shadow-plane mappings
>>    drm/simpledrm: Use offset-adjusted shadow-plane mapping
>>    drm/udl: Use offset-adjusted shadow-plane mapping
>>    drm/vbox: Use offset-adjusted shadow-plane mappings
>>    drm/vkms: Use offset-adjusted shadow-plane mappings and output
> Everything looked good while reading through the patches.
> I cannot say if everything was properly converted but the patches looke=
d
> good.
>=20
> So they are all:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks!

>=20
> There was a few TODO comments visible aboput using the mapping api
> properly. I assume this is coming in a later patch set..

There are indeed quite a few such comments. When we introduced the=20
dma_buf_map type to solve the fbdev issue on sparc64, in many places I=20
simply put the existing vaddr pointers into the map structure, and vice=20
versa.

The code works as expected, but in the future we may want to use=20
dma_buf_map for all framebuffer pointers. This would, for example,=20
require format conversion helpers that operate on these structures.=20
Adding that will require a number of changes throughout these helpers.

Best regards
Thomas

>=20
> 	Sam
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--swZwCKEjaaVmZFU89z5nUly1HAOaK3Wu4--

--hMa9McatD2SOtJAoFSGNBpookPaXNVbbw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmEK2toFAwAAAAAACgkQlh/E3EQov+AC
3A/+NeTwv+p4m1iYfCA1BWox0XAFfhmcIZgkCCVSM1UXHKUJ3He/+m2vjUXjCcNN2hgBdUfwuSxD
mNt9/t6slQy1Vl6pI01SCPfFdLn6ERjUPprQ3l9GvJdNuwRm0vHNomONgqqEV0pcO2lu8ZmQLe45
3QcrWYbHY5ZHWG7x1mPazmxvdKIY4YzWn3RAv6CG6bofiQ9wUpu0ei+hHj35HdlpF1uVCZv3nq2H
g3uj+BaLtaXEmnvm/T+GSIVFxPCUlB7Vi7HRL30G85A605GDb8Z8JuOw82hr6/8x9/wZR4QOh4VQ
kYnzY33YYuCFDWJSjnKkWGm/mzrSc/r6aQaTMNYBu5ZAMuLfd2AGjO1pgU/ArN9xF5MHDEkRLhRF
wBE0uFHGMLIJPuyT0oT4c9H+823R94z3TpjewT293fPyqmGIjhozV4OcWw53qNliTbG8Rcvgr/Cg
fKwPpBIlDzJ+06EhAZkrPgF1Itcq9O1SdbTmxHfcdhsYro6ZB0LK8S2iLCfzuTopYSsqT3wTwpno
VMQXed01ItJduRCpIN4f5UrqYyVSwpPS5JihWaZdmwFRp521C84KyEFn4zq61lgoPn0j+w7cjN3Z
MvEb3AbG+rDqjPzQjf2VzFl2tvqRp8sT8uTikqPpZh8m1tWiDgW/GHfMTRZ9Luej3ubuZtXSUmt7
O+Y=
=aiSS
-----END PGP SIGNATURE-----

--hMa9McatD2SOtJAoFSGNBpookPaXNVbbw--

--===============2568214665465066536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2568214665465066536==--
