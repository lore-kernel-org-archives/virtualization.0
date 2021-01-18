Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABEC433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 09:31:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92612245C
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 09:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92612245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68DC2865AB;
	Mon, 18 Jan 2021 09:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfho9QIbuaaI; Mon, 18 Jan 2021 09:31:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 86EFD865A1;
	Mon, 18 Jan 2021 09:31:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DEBCC08A1;
	Mon, 18 Jan 2021 09:31:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB707C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 09:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ADFC620104
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 09:31:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4LoH9Ej5ZvAu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 09:31:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 1896720035
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 09:31:00 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 12FC0B742;
 Mon, 18 Jan 2021 09:30:58 +0000 (UTC)
Subject: Re: Change eats memory on my server
To: Eli Cohen <elic@nvidia.com>
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
Date: Mon, 18 Jan 2021 10:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
Cc: daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, sam@ravnborg.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
Content-Type: multipart/mixed; boundary="===============3123721763127645862=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3123721763127645862==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9UpJC8ZdoigN9CO2MkMVSol5rGhzyvYL4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9UpJC8ZdoigN9CO2MkMVSol5rGhzyvYL4
Content-Type: multipart/mixed; boundary="sej5FWBvejTI7A9zd1duKNlOupZxNZRwY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Eli Cohen <elic@nvidia.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 daniel.vetter@ffwll.ch, sam@ravnborg.org, linux-kernel@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org
Message-ID: <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
Subject: Re: Change eats memory on my server
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>

--sej5FWBvejTI7A9zd1duKNlOupZxNZRwY
Content-Type: multipart/mixed;
 boundary="------------AC837D0F559BA27412AF7141"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AC837D0F559BA27412AF7141
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.01.21 um 10:13 schrieb Eli Cohen:
> On Mon, Jan 18, 2021 at 08:54:07AM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 18.01.21 um 08:43 schrieb Christian K=C3=B6nig:
>>> Hi Eli,
>>>
>>> have you already tried using kmemleak?
>>>
>>> This sounds like a leak of memory allocated using kmalloc(), so kmeml=
eak
>>> should be able to catch it.
>>
>> I have an idea what happens here. When the refcount is 0 in kmap, a ne=
w page
>> mapping for the BO is being established. But VRAM helpers unmap the pr=
evious
>> pages only on BO moves or frees; not in kunmap. So the old mapping mig=
ht
>> still be around. I'll send out a test patch later today.
>>
>=20
> Great! Looking forward to test it.

Here's the patch against the latest DRM tree. v5.11-rc3 should work as we=
ll.

I was able to reproduce the memory leak locally and found that the patch =

fixes it. Please give it a try.

Best regards
Thomas

>=20
>> Best regards
>> Thomas
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 17.01.21 um 06:08 schrieb Eli Cohen:
>>>> On Fri, Jan 15, 2021 at 10:03:50AM +0100, Thomas Zimmermann wrote:
>>>>> Could you please double-check that 3fb91f56aea4 ("drm/udl: Retrieve=
 USB
>>>>> device from struct drm_device.dev") works correctly
>>>> Checked again, it does not seem to leak.
>>>>
>>>>> and that 823efa922102
>>>>> ("drm/cma-helper: Remove empty drm_gem_cma_prime_vunmap()") is brok=
en?
>>>>>
>>>> Yes, this one leaks, as does the one preceding it:
>>>>
>>>> 1086db71a1db ("drm/vram-helper: Remove invariant parameters from
>>>> internal kmap function")
>>>>> For one of the broken commits, could you please send us the output =
of
>>>>>
>>>>>  =C2=A0=C2=A0 dmesg | grep -i drm
>>>>>
>>>>> after most of the memory got leaked?
>>>>>
>>>> I ran the following script in the shell:
>>>>
>>>> while true; do cat /proc/meminfo | grep MemFree:; sleep 5; done
>>>>
>>>> and this is what I saw before I got disconnected from the shell:
>>>>
>>>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14820=
8 kB
>>>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14830=
4 kB
>>>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14666=
0 kB
>>>> Connection to nps-server-24 closed by remote host.
>>>> Connection to nps-server-24 closed.
>>>>
>>>>
>>>> I also mointored the output of dmesg | grep -i drm
>>>> The last output I was able to save on disk is this:
>>>>
>>>> [=C2=A0=C2=A0 46.140720] ast 0000:03:00.0: [drm] Using P2A bridge fo=
r configuration
>>>> [=C2=A0=C2=A0 46.140737] ast 0000:03:00.0: [drm] AST 2500 detected
>>>> [=C2=A0=C2=A0 46.140754] ast 0000:03:00.0: [drm] Analog VGA only
>>>> [=C2=A0=C2=A0 46.140772] ast 0000:03:00.0: [drm] dram MCLK=3D800 Mhz=
 type=3D7
>>>> bus_width=3D16
>>>> [=C2=A0=C2=A0 46.153553] [drm] Initialized ast 0.1.0 20120228 for 00=
00:03:00.0
>>>> on minor 0
>>>> [=C2=A0=C2=A0 46.165097] fbcon: astdrmfb (fb0) is primary device
>>>> [=C2=A0=C2=A0 46.391381] ast 0000:03:00.0: [drm] fb0: astdrmfb frame=
 buffer device
>>>> [=C2=A0=C2=A0 56.097697] systemd[1]: Starting Load Kernel Module drm=
=2E..
>>>> [=C2=A0=C2=A0 56.343556] systemd[1]: modprobe@drm.service: Succeeded=
=2E
>>>> [=C2=A0=C2=A0 56.350382] systemd[1]: Finished Load Kernel Module drm=
=2E
>>>> [13319.469462] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0=
 55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 7372=
8
>>>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 tdrm
>>>> [13320.658386] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0=
 55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 7372=
8
>>>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 tdrm
>>>> [13321.800970] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0=
 55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 7372=
8
>>>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 tdrm
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

--------------AC837D0F559BA27412AF7141
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-vram-helper-Reuse-existing-page-mappings-in-vmap.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-drm-vram-helper-Reuse-existing-page-mappings-in-vmap.pa";
 filename*1="tch"

=46rom e8462600662621db47bccf8174bf683513aa7102 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 18 Jan 2021 09:58:07 +0100
Subject: [PATCH] drm/vram-helper: Reuse existing page mappings in vmap

For performance, BO page mappings can stay in place even if the
map counter has returned to 0. In these cases, the existing page
mapping has to be reused by the next vmap operation. Otherwise
a new mapping would be installed and the old mapping's pages leak.

Fix the issue by reusing existing page mappings for vmap operations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Eli Cohen <elic@nvidia.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_=
gem_vram_helper.c
index 02ca22e90290..a57790b0d985 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -387,9 +387,16 @@ static int drm_gem_vram_kmap_locked(struct drm_gem_v=
ram_object *gbo,
 	if (gbo->vmap_use_count > 0)
 		goto out;
=20
-	ret =3D ttm_bo_vmap(&gbo->bo, &gbo->map);
-	if (ret)
-		return ret;
+	/*
+	 * VRAM helpers unmap the BO only on demand. So the previous
+	 * page mapping might still be arround. Only vmap if the there's
+	 * no mapping present.
+	 */
+	if (dma_buf_map_is_null(&gbo->map)) {
+		ret =3D ttm_bo_vmap(&gbo->bo, &gbo->map);
+		if (ret)
+			return ret;
+	}
=20
 out:
 	++gbo->vmap_use_count;
@@ -577,6 +584,7 @@ static void drm_gem_vram_bo_driver_move_notify(struct=
 drm_gem_vram_object *gbo,
 		return;
=20
 	ttm_bo_vunmap(bo, &gbo->map);
+	dma_buf_map_clear(&gbo->map); /* explicitly clear mapping for next vmap=
 call */
 }
=20
 static int drm_gem_vram_bo_driver_move(struct drm_gem_vram_object *gbo,
--=20
2.29.2


--------------AC837D0F559BA27412AF7141--

--sej5FWBvejTI7A9zd1duKNlOupZxNZRwY--

--9UpJC8ZdoigN9CO2MkMVSol5rGhzyvYL4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAFVVAFAwAAAAAACgkQlh/E3EQov+A0
uQ//Zj4RwM6ddlRdnDxGBYOc3A/f6yvayznmYkWLmj56cYa/vHTiPgSxpCjzuNc0Md//4tO6h3SG
cgIsL8MNXTH73THYqxj61QL8SAuxsKw2l3G73eDWOUMJ+1c3jN96SUidQ7SQzwY+F9/Alx8fCnXy
h1ZfFXYPXSuCxmsXzVLWYe2ad7RRqYX/wBFnC6l6FRP4G2c+CMgVbITTe0iEch8YeOoYSOxSdI51
xwapwzH9kstIp5Yr+8W6JQKtFRmAVLYwKX4/fFd0K9cIWnNGx9ocpzQBZsjgct0CUl/taRQsiOZM
o/mgfK+d3MlBWa6Dew12/N0INJ4Rz7cGutqwkmnyR51nnnHzfuIsJLIPfb8xdaVK/MCeUqp6ryfE
8+fjG3TDBeOSnJyqfTokYklgx3LKebhYsw12yretTKMMg+yvMcMoWETDq/WzK/XvcT68cUmGc4V5
5pqg/m7GQRneNkSzpKpj/cnfquXbVbd6QEPgiK0+sPiYmjyrtE4S01ydUGERqumqWPMXOZ76Qx6y
7NTLCjjL4s1igSdyZzLuMux3S7WRI8o9Y+G0wn1CwXsuioDXB+x3WBhN8oko+rvzOURKOrhtUOke
j5Due3rw4meXfdyOamBJMOGDW1orWIRa52bREAxPpZZMD5k+Ozub8+bPHsQqWhNi/VZzt2BQRykI
gjY=
=k6do
-----END PGP SIGNATURE-----

--9UpJC8ZdoigN9CO2MkMVSol5rGhzyvYL4--

--===============3123721763127645862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3123721763127645862==--
