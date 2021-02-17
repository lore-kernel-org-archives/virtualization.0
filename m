Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B563C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 10:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A223964E68
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 10:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A223964E68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F07C6F594
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 10:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XvwVp0UbndJZ for <virtualization@archiver.kernel.org>;
	Wed, 17 Feb 2021 10:23:51 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 791B96F5D9; Wed, 17 Feb 2021 10:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E28166F4D3;
	Wed, 17 Feb 2021 10:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEEA6C0893;
	Wed, 17 Feb 2021 10:23:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAC62C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 10:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CEE5E85FB6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 10:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tOj90-3tTn9l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 10:23:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CDCC85F95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 10:23:44 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2B120B141;
 Wed, 17 Feb 2021 10:23:42 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
 <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
 <ab21d782-2627-7a68-8fab-0acfba416c86@suse.de>
 <20210217100206.fh5422uz4gnixyif@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
Message-ID: <e46a8494-b3f2-40ba-2625-05c13c47e769@suse.de>
Date: Wed, 17 Feb 2021 11:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217100206.fh5422uz4gnixyif@sirius.home.kraxel.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
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
Content-Type: multipart/mixed; boundary="===============1278026773458351650=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1278026773458351650==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h0WnoFNYi1f9XmooDNTQLjyMjFkKtPyL9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h0WnoFNYi1f9XmooDNTQLjyMjFkKtPyL9
Content-Type: multipart/mixed; boundary="LnSnfig26KmIAW6LDR29DlBQ6koKWqp5s";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Dave Airlie
 <airlied@redhat.com>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>
Message-ID: <e46a8494-b3f2-40ba-2625-05c13c47e769@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
 <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
 <ab21d782-2627-7a68-8fab-0acfba416c86@suse.de>
 <20210217100206.fh5422uz4gnixyif@sirius.home.kraxel.org>
In-Reply-To: <20210217100206.fh5422uz4gnixyif@sirius.home.kraxel.org>

--LnSnfig26KmIAW6LDR29DlBQ6koKWqp5s
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 17.02.21 um 11:02 schrieb Gerd Hoffmann:
> On Tue, Feb 16, 2021 at 02:46:21PM +0100, Thomas Zimmermann wrote:
>>
>>
>> Am 16.02.21 um 14:27 schrieb Thomas Zimmermann:
>>> Hi
>>>
>>> this is a shadow-buffered plane. Did you consider using the new helpe=
rs
>>> for shadow-buffered planes? They will map the user BO for you and
>>> provide the mapping in the plane state.
>>>
>>>   From there, you should implement your own plane state on top of str=
uct
>>> drm_shadow_plane_state, and also move all the other allocations and
>>> vmaps into prepare_fb and cleanup_fb. Most of this is not actually
>>> allowed in commit tails. All we'd have to do is to export the reset,
>>> duplicate and destroy code; similar to what
>>> __drm_atomic_helper_plane_reset() does.
>>
>> AFAICT the cursor_bo is used to implement double buffering for the cur=
sor
>> image.
>>
>> Ideally, you can do what ast does: pre-allocate/vmap 2 BOs at the end =
of the
>> vram. Then pageflip between them in atomic_update(). Resolves all the
>> allocation and mapping headaches.
>=20
> Just waded through the ast patches.

I just received your ack. Thanks a lot for looking at the ast patches.

>=20
> It is not that simple for qxl.  You have to send a command to the
> virtualization host and take care of the host accessing that memory
> when processing the command, so you can't reuse the memory until the
> host signals it is fine to do so.
>=20
> But, yes, it should be possible to handle cursor_bo creation in
> prepare_fb without too much effort.

I've been thinking about this issue and here's an idea:

If you take the ast code as a blueprint, you'd store two cursor bo in a=20
cursor-plane structure. Aditionally each of these BOs would have a=20
pointer to a fence associated with it.

One idea for the fencing code would be to allocate each new fence in=20
prepare_fb and store it in the cursor plane state. In atomic_update,=20
pick the unused BO in the cursor plane and wait on its fence. This=20
should guarantee that the BO is available. (?) Then swap the BO's fence=20
with the one in the cursor plane state. Setup the new fence for=20
synchronization with the host. Next time you pick this cursor BO, the=20
fence will be there for synchronization. The old fence from the cursor=20
BO will now be stored in the cursor-plane state and can be freed in=20
cleanup_fb().

My main interest here is to move all fail-able/locking calls out of the=20
atomic_update function. I might be missing some crucial corner case, but =

this should resolve the issue. (?) In any case, it's maybe worth a=20
separate patchset.

Best regards
Thomas

>=20
> take care,
>    Gerd
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--LnSnfig26KmIAW6LDR29DlBQ6koKWqp5s--

--h0WnoFNYi1f9XmooDNTQLjyMjFkKtPyL9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAs7q0FAwAAAAAACgkQlh/E3EQov+DV
7g//UOrMSWgXBRPsci1jInSlvHBHkSG+Nszzjkh4QC5ipANPk4Too/BNFHrXMMM2Ase+jthizq7I
1pxbiXRfg6sY/6oqieukJpvDLWx/DYZyhLVISr978Wbr/5ZKqDdf1bm0xQwCmnGqTxQM2qyoXhKr
+uXr64a9oaUFZar1jfEJ2GLqQc5PDhk52pZck49EGnasfg9XBk/CWvLq5qXp4YdQz4eZeBQCHtGP
R9jFPA6tWWGTFO8ozLPDoyaA34z741aFTDWgFPjxWb2uhooprmVONEwfAUBHNYw7rqRhXXHTxZXc
SO8jzJKu5+0gvvfQaE2qF1x7pxDHPJwqqcfYYOvzPXq9iHfEoIiBUvhtn3bjyvoBgahsY9LG/GUJ
hR3DsuMNledIR/V9Qr6n/Fcui2ZivVkgSVhxrwaTUSzKYfzR1yxgZUay4Cq7teL26P2J4V96fnAj
94wQCxyp+p0osecAtsdkEAYswUzsYyRgSK3vnA17DVAnHWHHojH8yPr2Rf0PiMfXqPsZ93g8l7my
5xretITk7n8a4E1I00SHKwM+TW3jZcZil6czWkPaosV00KNnnJWqPe+0ole8dx9vhlf7av5ql7iD
QVVZPQEWhHONTKCYH+Oql9maQLyL8PUWBrRbmHEdfj5cMyxKbuW6MKLCITYr98XL1RCKTZLNiR25
aMk=
=i3Bx
-----END PGP SIGNATURE-----

--h0WnoFNYi1f9XmooDNTQLjyMjFkKtPyL9--

--===============1278026773458351650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1278026773458351650==--
