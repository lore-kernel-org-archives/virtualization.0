Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5716C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:46:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA4664DBD
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4664DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D399850A8;
	Tue, 16 Feb 2021 13:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdWRlr8V0qD7; Tue, 16 Feb 2021 13:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 729058506A;
	Tue, 16 Feb 2021 13:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34EBBC0893;
	Tue, 16 Feb 2021 13:46:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60269C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4DA2086F12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y-nufWZ3IlJO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2DA2886BC1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:46:25 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2DAEADFB;
 Tue, 16 Feb 2021 13:46:23 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
 <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
Message-ID: <ab21d782-2627-7a68-8fab-0acfba416c86@suse.de>
Date: Tue, 16 Feb 2021 14:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============3584695790121749065=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3584695790121749065==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x9v9IxdRWQigs6L1TOinW9XyRZLUO4a8x"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x9v9IxdRWQigs6L1TOinW9XyRZLUO4a8x
Content-Type: multipart/mixed; boundary="Ntn8b3fwwJhazhId2T2oMQUzaoUmTo7m0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
Message-ID: <ab21d782-2627-7a68-8fab-0acfba416c86@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
 <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
In-Reply-To: <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>

--Ntn8b3fwwJhazhId2T2oMQUzaoUmTo7m0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 16.02.21 um 14:27 schrieb Thomas Zimmermann:
> Hi
>=20
> this is a shadow-buffered plane. Did you consider using the new helpers=
=20
> for shadow-buffered planes? They will map the user BO for you and=20
> provide the mapping in the plane state.
>=20
>  From there, you should implement your own plane state on top of struct=
=20
> drm_shadow_plane_state, and also move all the other allocations and=20
> vmaps into prepare_fb and cleanup_fb. Most of this is not actually=20
> allowed in commit tails. All we'd have to do is to export the reset,=20
> duplicate and destroy code; similar to what=20
> __drm_atomic_helper_plane_reset() does.

AFAICT the cursor_bo is used to implement double buffering for the=20
cursor image.

Ideally, you can do what ast does: pre-allocate/vmap 2 BOs at the end of =

the vram. Then pageflip between them in atomic_update(). Resolves all=20
the allocation and mapping headaches.

Best regards
Thomas

>=20
> Best regards
> Thomas
>=20
>=20
> Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
>> We don't have to map in atomic_update callback then,
>> making locking a bit less complicated.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> =C2=A0 drivers/gpu/drm/qxl/qxl_display.c | 14 +++++---------
>> =C2=A0 1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/qxl/qxl_display.c=20
>> b/drivers/gpu/drm/qxl/qxl_display.c
>> index 7500560db8e4..39b8c5116d34 100644
>> --- a/drivers/gpu/drm/qxl/qxl_display.c
>> +++ b/drivers/gpu/drm/qxl/qxl_display.c
>> @@ -584,7 +584,6 @@ static void qxl_cursor_atomic_update(struct=20
>> drm_plane *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qxl_bo *cursor_bo =3D NULL, *use=
r_bo =3D NULL, *old_cursor_bo=20
>> =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 struct dma_buf_map user_map;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_map cursor_map;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *user_ptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int size =3D 64*64*4;
>> @@ -599,11 +598,8 @@ static void qxl_cursor_atomic_update(struct=20
>> drm_plane *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 obj =3D fb->obj=
[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user_bo =3D gem=
_to_qxl_bo(obj);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* pinning is done in the =
prepare/cleanup framevbuffer */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qxl_bo_kmap_locked=
(user_bo, &user_map);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out_free_release;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user_ptr =3D user_map.vadd=
r; /* TODO: Use mapping abstraction=20
>> properly */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* mapping is done in the =
prepare/cleanup framevbuffer */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user_ptr =3D user_bo->map.=
vaddr; /* TODO: Use mapping=20
>> abstraction properly */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qxl_all=
oc_bo_reserved(qdev, release,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sizeof(struct qxl_cursor) + size,
>> @@ -639,7 +635,6 @@ static void qxl_cursor_atomic_update(struct=20
>> drm_plane *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor->chunk.d=
ata_size =3D size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(cursor->=
chunk.data, user_ptr, size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qxl_bo_kunmap_l=
ocked(cursor_bo);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qxl_bo_kunmap_locked(user_=
bo);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D (struct=
 qxl_cursor_cmd *) qxl_release_map(qdev, release);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd->u.set.visi=
ble =3D 1;
>> @@ -778,6 +773,7 @@ static int qxl_plane_prepare_fb(struct drm_plane=20
>> *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qxl_bo *user_bo;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qxl_surface surf;
>> +=C2=A0=C2=A0=C2=A0 struct dma_buf_map unused;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!new_state->fb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -815,7 +811,7 @@ static int qxl_plane_prepare_fb(struct drm_plane=20
>> *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 return qxl_bo_pin(user_bo);
>> +=C2=A0=C2=A0=C2=A0 return qxl_bo_kmap(user_bo, &unused);
>> =C2=A0 }
>> =C2=A0 static void qxl_plane_cleanup_fb(struct drm_plane *plane,
>> @@ -834,7 +830,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane =

>> *plane,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 obj =3D old_state->fb->obj[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user_bo =3D gem_to_qxl_bo(obj);
>> -=C2=A0=C2=A0=C2=A0 qxl_bo_unpin(user_bo);
>> +=C2=A0=C2=A0=C2=A0 qxl_bo_kunmap(user_bo);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (old_state->fb !=3D plane->state->fb=
 && user_bo->shadow) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qxl_bo_unpin(us=
er_bo->shadow);
>>
>=20
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


--Ntn8b3fwwJhazhId2T2oMQUzaoUmTo7m0--

--x9v9IxdRWQigs6L1TOinW9XyRZLUO4a8x
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmArzK0FAwAAAAAACgkQlh/E3EQov+Dh
WQ//fUuC7dIUW2wfGhqz/qBrTYHstG3t4bjZ5svg9dezZB3CccYP7BEx4UAjnLakEI3P9oxCyDAE
3eNt+JVA2+FeHplWREImJegTtHL6kdunRBUDDhbLGBHO0+lWS6FdA6sk6ayr9mx8a0CsSSbPRnvf
l0DQFghY6/DiRuWx9hGTupU0hwJ1+C3H1iJwEG4dBj5775CDTyzGbXMnii7WwelyVsCHsejM7d6Q
4CMRiosBk0iqiM0xogojNAQrzGRl9yhATJHccMvn+YD0WzL7DDpxelb/gaFBdDT2f6ZIioBNr9Xp
hzzLZw29ctfr0KYym7rEZI1awnDGJAZ2UDWDgEb8jYSgXNGYFMbHlweEXXzQIGIj0MWl4s0vNac8
hxxsParp/9ZJaiZDIosZDMMcntTfDIlZ+hI5d651jXD6vmLLIjcDpmU5ZuyMuGtiOzkroxapGa7q
ecd8FM1a4KLh63wiC1BREGZLOGDm5vdR/0aX91ozc01yRr6mg/0xc9zxwBMUFpeXdsEjiyjs1F4O
aAyH5o3qi1Cb867ynpZmHBwrU7Y1LOWXPGSj9tPJW6WZLyPQQ3Wh4T/mF4iNr7v8M7QpXstjoMB/
J+Q6+6Yw5E4O7S2AoHcLlfO3Ub1VdAjKKTngaEknAl8kbhg5MDCjTD0kTgt2utp3vzXNhI+VDAXl
KwY=
=sXRs
-----END PGP SIGNATURE-----

--x9v9IxdRWQigs6L1TOinW9XyRZLUO4a8x--

--===============3584695790121749065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3584695790121749065==--
