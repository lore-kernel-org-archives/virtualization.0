Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016CDC433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 19:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96D5A4018E;
	Thu, 10 Mar 2022 19:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jad5sTihpARG; Thu, 10 Mar 2022 19:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA3D84053E;
	Thu, 10 Mar 2022 19:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6D0FC0012;
	Thu, 10 Mar 2022 19:02:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56A7DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 19:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45B908477F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 19:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="h7pIh4eL";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="iuJ2YCVb"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-SmkELy5g2r
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 19:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A87D84741
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 19:02:31 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF1AF1F381;
 Thu, 10 Mar 2022 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646938943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvuxtOkRTYe6y27Po/1nErjm/dM9kXlHT4HNL9PVo00=;
 b=h7pIh4eLaWzgkaI2p833yncJUhkX9aylvhTUlrji0Wa6KUgmBcDx5GsBivnV4CHgXyZJAJ
 nN0QeKx4SW3t/3hxvKNXt2SEISGHrT58J29q3Glpc1uUwnduBhNW5T5JXXpocvg5bAvh1D
 z2zfTxerc+h1Nmx+WDTF69G2lZGAebA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646938943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvuxtOkRTYe6y27Po/1nErjm/dM9kXlHT4HNL9PVo00=;
 b=iuJ2YCVbYLpYcDF0VrQP3c/Ot3qB8OqqkPdpQBhTK8m1aknrovDZBmbMYf3tDQ5JbxC6QG
 Uy+hW3T9oCDjloBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6086F13FA3;
 Thu, 10 Mar 2022 19:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PbzeFT9LKmIXVAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Mar 2022 19:02:23 +0000
Message-ID: <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
Date: Thu, 10 Mar 2022 20:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
 <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Dmitry Osipenko <digetx@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4482644520215469806=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4482644520215469806==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NNe0wuk0PVOqaesrUKI5pL6A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NNe0wuk0PVOqaesrUKI5pL6A
Content-Type: multipart/mixed; boundary="------------jixjnh6q6q1yWxdpMDOQzT0K";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
 <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
In-Reply-To: <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>

--------------jixjnh6q6q1yWxdpMDOQzT0K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDkuMDMuMjIgdW0gMjM6MjUgc2NocmllYiBEbWl0cnkgT3NpcGVua286DQo+
Pg0KPj4gVGhlIHJlYXNvbiBmb3IgdGhpcyB3b3JrIGlzIHRvIGtlZXAgR0VNIHNobWVtIHBh
Z2VzIG1hcHBlZCBhbmQgYWxsb2NhdGVkDQo+PiBldmVuIHdoaWxlIHRoZSBCTyBpcyBuZWl0
aGVyIG1hcHBlZCBub3IgcGlubmVkLsKgIEFzIGl0IGlzIG5vdywgR0VNIFNITUVNDQo+PiBj
cmVhdGVzIGFuZCByZWxlYXNlcyBwYWdlcyBvbiBlYWNoIHBpbiBhbmQgdW5waW4sIGFuZCBt
YXBzIGFuZCB1bm1hcHMNCj4+IG1lbW9yeSByYW5nZXMgb24gZWFjaCB2bWFwIGFuZCB2dW5t
YXAuwqAgSXQncyBhbGwgd2FzdGVmdWwuIE9ubHkgdGhlDQo+PiBmaXJzdCBwaW4gYW5kIHZt
YXAgY2FsbHMgc2hvdWxkIGVzdGFibGlzaCBwYWdlcyBhbmQgbWFwcGluZ3MgYW5kIG9ubHkN
Cj4+IHRoZSBwdXJnZSBhbmQgZnJlZSBmdW5jdGlvbnMgc2hvdWxkIHJlbGVhc2UgdGhlbS4N
Cj4gDQo+IEhtLCBhcmVuJ3QgbWFwcyBhbmQgcGlucyBhbHJlYWR5IHJlZmNvdW50ZWQ/DQoN
ClRoZXkgYXJlLiBCdXQgZXZlbiB3aGVuIHRoZSByZWZjb3VudGVyIHJlYWNoZXMgMCBvbiBk
ZXJlZiwgdGhlcmUncyBubyANCm5lZWQgdG8gcmVtb3ZlIHRoZSBtYXBwaW5nIG9yIGZyZWUg
dGhlIG1lbW9yeSBwYWdlcy4gV2UgY2FuIGtlZXAgdGhlbSANCmFyb3VuZCBmb3IgdGhlIG5l
eHQgcmVmIG9wZXJhdGlvbi4gIE9ubHkgdGhlIHNocmlua2VyJ3MgcHVyZ2Ugb3IgZnJlZWlu
ZyANCnRoZSBvYmplY3QgaGFzIHRvIGRvIHN1Y2ggY2xlYW4tdXAgb3BlcmF0aW9ucy4gIFN1
Y2ggYmVoYXZpb3IgaXMgDQpzdXBwb3J0ZWQgYnkgVFRNIGFuZCB3ZSBhbHJlYWR5IHVzZSBp
dCBpbiBWUkFNIGhlbHBlcnMgYXMgd2VsbC4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0K
PiANCj4+IFRoZSBwYXRjaHNldCBhZGRzIG5ldyBoZWxwZXJzIGZvciBCTyBwdXJnaW5nIHRv
IHN0cnVjdA0KPj4gZHJtX2dlbV9vYmplY3RfZnVuY3MuIFdpdGggdGhpcywgSSB0aGluayBp
dCBtaWdodCBiZSBwb3NzaWJsZSB0byBoYXZlDQo+PiBvbmUgZ2xvYmFsIERSTSBzaHJpbmtl
ciBhbmQgbGV0IGl0IGhhbmRsZSBhbGwgQk9zOyBpbmRlcGVuZGVudCBvZiBlYWNoDQo+PiBC
TydzIG1lbW9yeSBtYW5hZ2VyLg0KPiANCj4gVGhhbmsgeW91LCBJJ2xsIGdpdmUgaXQgYSB0
cnkuDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9w
ZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcp
DQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------jixjnh6q6q1yWxdpMDOQzT0K--

--------------NNe0wuk0PVOqaesrUKI5pL6A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIqSz4FAwAAAAAACgkQlh/E3EQov+At
9g//Z9letBO6G3sE8aowjvZbpoZsrIyVdjoy+W6UDaqOrF3j938fYly4mcECyifSvmPTkt4gqyOf
EBtirJ+muEGKtJhVGI384pw0yT86VYb0Avhv9y0Ev+zzoXbd+QSL4i7M12ne6P7/gbIpb/qMEtfV
IRInAJ3VOKcYDAc/nveXusnJHRvghCqiyc6seLqWaZhtvSirTIrW4uihFd9N0Ol0Ix/WrT/EH2VO
CP9AHptSWTGikCb/7lN9SvbeAZAbOKwLiYkldCuGzpydabmIXEE8R7dFSJPcrjZ9+bSftMZYWErs
VYaXUZ3OcRRIAE4Y1GsvCBFyzfVtBCJH4QsajTa4Pu/U2Aa0obmKhtHlkNPIhMUAM60Uo50JtRut
PhohOZXqLEE3Z4glpCzEgEarAY/nMm19cMU3TPyBt1PdjMWhpzn/gIwHz7JwlY4ki1QHn5WaY1Nx
5//5GPSZtSSkSgPqKJOjTCv5gGyLOcvy+0DAGlH4AWncdhS79pjDtA+X5WEafy0YgB3aCApp+qnX
HA4Rby5o7fOm+RdcLPvDWfwHLUHWPABbRrK+EyD0sTi0DIo/XCz2HMHeK1nJuSbbaDu0XshvM9CZ
VcrCiaQDH8GTMhAvN0ZEiPIKBp1yRtOhVBXDwbkrHerz6KIjGLGicRn9O/APnd4K2yw8VhjH8+7b
v7c=
=7O5g
-----END PGP SIGNATURE-----

--------------NNe0wuk0PVOqaesrUKI5pL6A--

--===============4482644520215469806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4482644520215469806==--
