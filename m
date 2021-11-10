Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52EFC433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF3861152
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AF3861152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36C2260AC9;
	Wed, 10 Nov 2021 12:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c46-PQI4FS6k; Wed, 10 Nov 2021 12:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C04C96071F;
	Wed, 10 Nov 2021 12:48:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94876C0019;
	Wed, 10 Nov 2021 12:48:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4059FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20D87400C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="Wpvs3Q/f";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="F/YEYbGh"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDurVK4awh1Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:48:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D0F0400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:48:04 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75AE81FD6F;
 Wed, 10 Nov 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636548481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2WufwUXuacQxACp4CzCzI/JF4gBFBKhG2MtaMFrxrqc=;
 b=Wpvs3Q/faap2TFU60d4JGwunm4RbJmhZxwW7BrGmHxCTliCC8W3K4sfUYSFcXp7MAf3kDC
 w2y9eXrig7ckruMCbQe2sTlfUMVmMSb5XdpcJ3a0IusDlXRsg0ry1qJ7cK8Ebg6PY1uPUJ
 pTjMuF4q9a5UY6mAqafV64TxMeU0H+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636548481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2WufwUXuacQxACp4CzCzI/JF4gBFBKhG2MtaMFrxrqc=;
 b=F/YEYbGhJyKv9S6W8fsVnPFCia/YkbHO01hLtXjkN5Qejo0KHOrE5R905xQdvZlPUwv0QJ
 c5wyWfvXsRu6M6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1393413C13;
 Wed, 10 Nov 2021 12:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4QzJA4G/i2G+BwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 12:48:01 +0000
Message-ID: <19ba897d-9007-a103-581e-060c5ce1c9ed@suse.de>
Date: Wed, 10 Nov 2021 13:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
Content-Language: en-US
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211110103702.374-1-tzimmermann@suse.de>
 <20211110103702.374-8-tzimmermann@suse.de>
 <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============6403260401410681754=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6403260401410681754==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0cX1qCaT9R59oyZmyRmlISAI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0cX1qCaT9R59oyZmyRmlISAI
Content-Type: multipart/mixed; boundary="------------KIACkatNRafAgCIAHPTqpNXC";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Message-ID: <19ba897d-9007-a103-581e-060c5ce1c9ed@suse.de>
Subject: Re: [PATCH v3 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
References: <20211110103702.374-1-tzimmermann@suse.de>
 <20211110103702.374-8-tzimmermann@suse.de>
 <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>
In-Reply-To: <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>

--------------KIACkatNRafAgCIAHPTqpNXC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTAuMTEuMjEgdW0gMTM6MzQgc2NocmllYiBOb3JhbGYgVHLDuG5uZXM6DQo+
IA0KPiANCj4gRGVuIDEwLjExLjIwMjEgMTEuMzcsIHNrcmV2IFRob21hcyBaaW1tZXJtYW5u
Og0KPj4gRW5hYmxlIHRoZSBGQl9EQU1BR0VfQ0xJUFMgcHJvcGVydHkgdG8gcmVkdWNlIGRp
c3BsYXktdXBkYXRlDQo+PiBvdmVyaGVhZC4gQWxzbyBmaXhlcyBhIHdhcm5pbmcgaW4gdGhl
IGtlcm5lbCBsb2cuDQo+Pg0KPj4gICAgc2ltcGxlLWZyYW1lYnVmZmVyIHNpbXBsZS1mcmFt
ZWJ1ZmZlci4wOiBbZHJtXSBkcm1fcGxhbmVfZW5hYmxlX2ZiX2RhbWFnZV9jbGlwcygpIG5v
dCBjYWxsZWQNCj4+DQo+PiBGaXggdGhlIGNvbXB1dGF0aW9uIG9mIHRoZSBibGl0IHJlY3Rh
bmdsZS4gVGhpcyB3YXNuJ3QgYW4gaXNzdWUgc28NCj4+IGZhciwgYXMgc2ltcGxlZHJtIGFs
d2F5cyBibGl0dGVkIHRoZSBmdWxsIGZyYW1lYnVmZmVyLiBUaGUgY29kZSBub3cNCj4+IHN1
cHBvcnRzIGRhbWFnZSBjbGlwcGluZyBhbmQgdmlydHVhbCBzY3JlZW4gc2l6ZXMuDQo+Pg0K
Pj4gdjM6DQo+PiAJKiBmaXggZHJtX2Rldl9lbnRlcigpIGVycm9yIHBhdGggKE5vcmFsZikN
Cj4+IAkqIHJlbW92ZSB1bm5lY2Vzc2FyeSBjbGlwcGluZyBmcm9tIHVwZGF0ZSBmdW5jdGlv
biAoTm9yYWxmKQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0
emltbWVybWFubkBzdXNlLmRlPg0KPj4gLS0tDQo+IA0KPiBSZXZpZXdlZC1ieTogTm9yYWxm
IFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+DQo+IA0KDQpUaGFuayB5b3Ugc28gbXVj
aCBmb3IgcmV2aWV3aW5nLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQotLSANClRob21h
cyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhy
ZXI6IEl2byBUb3Rldg0K

--------------KIACkatNRafAgCIAHPTqpNXC--

--------------0cX1qCaT9R59oyZmyRmlISAI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGLv4AFAwAAAAAACgkQlh/E3EQov+B9
Mw/+NWgWEaue6XDuMNmcZfWO78HWOL7wEbr4gmBorYMXdBBwSo1NM9xr3lPs2+HHUVfeg2p6MG40
G/q760Z700QqAAsptSspUs+8dCQkz7dp+Mi6qBDIXgXFWCdz3K/pXrsqdTu1X1j7rbbzhFlC2eDY
pIuusZn9WMppPOGUpWrh1oLeCP/z3aq6gefhIauMpJkZjm1LXHr2wmtczdt8xEN0TO7HiXzb0R0S
9ZbjBPJ6CxLESd74BIxBx1KSeCV7kOYZGznA+EtI0hzH7FkLUNxfOp3vt/mUJTfVwr7jVwbubYsF
7vpKselbtekKzE8ERE2KVYQTVrTcFoAioxIvdoeox3FWJ0g7fe/3//I3aNf0RGrEASKlhNacKvT4
+4aF04FBJ2e7wb87Bb2KklcDN5btNzo0Lo+d8CZ2PabtjSlb1w2w7M+/+0IBBZsQZbV5IV8Bz5Ib
Gjh3UzpkjG1AGfJ69++Q8ARVX6rNi02g5MmJobiGtJS2gGsy3k1Vj8gI83qbgiZX1GaJLHqt/6Fj
OVRGN6xUk2LE2KKKkErAdLB+Aq022MWUbiFaNNiJB7MJv1dmT1PrYG5XuBn+sJaQ26TFte9RPGN0
CBL9fzKF6el+G3Th+6vhlr0F2L2GAW6yxK2SBLi4663QkY0Yh+53ro2yJz/b4iiDLOxHil24B+Jd
lhU=
=/pjM
-----END PGP SIGNATURE-----

--------------0cX1qCaT9R59oyZmyRmlISAI--

--===============6403260401410681754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6403260401410681754==--
