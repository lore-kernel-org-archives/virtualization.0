Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8395CC433FE
	for <virtualization@archiver.kernel.org>; Fri, 18 Nov 2022 13:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A97B40CE8;
	Fri, 18 Nov 2022 13:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A97B40CE8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cfkfoW+B;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vIj2QM6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzwpAALEfHhK; Fri, 18 Nov 2022 13:18:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48CD240CDD;
	Fri, 18 Nov 2022 13:18:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48CD240CDD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E1BEC0032;
	Fri, 18 Nov 2022 13:18:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D45C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E91F821C7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:18:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E91F821C7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=cfkfoW+B; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vIj2QM6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwvDlmGGBLtw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A3F2821C6
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A3F2821C6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:18:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8E761FA33;
 Fri, 18 Nov 2022 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668777480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BAVNBVFVfVtxZxe7QhigYHqSU4574s0B0gEoRhso11Q=;
 b=cfkfoW+BeC9feabSwwJizGG6Ebx2Odt1S2IawYflmXCTWRTRUR8MoRGUaeOgsk0FOZMGc+
 LvrujlSnpes+SmeUcBk903GyYgfuKN/mD8zn2Ri9UnRNVp72umohlDBz2Ym21SZ56w6Drx
 79MCl4aTs87fEiUhNqbmb+XJJJUtCGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668777480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BAVNBVFVfVtxZxe7QhigYHqSU4574s0B0gEoRhso11Q=;
 b=vIj2QM6apt18XyN3MNsT9TbLzCc31yxhqT+riMbVqJp/2aGRZQexKlG6DSJG696MqgiFoG
 nDYOmSTq9AvoxcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8112A13A66;
 Fri, 18 Nov 2022 13:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q26JHgiGd2M3IwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 18 Nov 2022 13:18:00 +0000
Message-ID: <a62babce-5deb-43ba-1a96-8f31c603b3a2@suse.de>
Date: Fri, 18 Nov 2022 14:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] drm/hisilicon/hibmc: Fix preferred depth and bpp
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 xinliang.liu@linaro.org, tiantao6@hisilicon.com, jstultz@google.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 paul.kocialkowski@bootlin.com, airlied@redhat.com, kraxel@redhat.com
References: <20221116160917.26342-1-tzimmermann@suse.de>
 <20221116160917.26342-2-tzimmermann@suse.de>
 <b0421c22-2893-d76a-4cd8-07f5fdb9add1@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <b0421c22-2893-d76a-4cd8-07f5fdb9add1@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6701230017064043340=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6701230017064043340==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6j2tlNrNxOTqjNGhaSaDReGo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6j2tlNrNxOTqjNGhaSaDReGo
Content-Type: multipart/mixed; boundary="------------wWaNKLvt6iCaAUrJbtT314re";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 xinliang.liu@linaro.org, tiantao6@hisilicon.com, jstultz@google.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 paul.kocialkowski@bootlin.com, airlied@redhat.com, kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <a62babce-5deb-43ba-1a96-8f31c603b3a2@suse.de>
Subject: Re: [PATCH 1/7] drm/hisilicon/hibmc: Fix preferred depth and bpp
References: <20221116160917.26342-1-tzimmermann@suse.de>
 <20221116160917.26342-2-tzimmermann@suse.de>
 <b0421c22-2893-d76a-4cd8-07f5fdb9add1@redhat.com>
In-Reply-To: <b0421c22-2893-d76a-4cd8-07f5fdb9add1@redhat.com>

--------------wWaNKLvt6iCaAUrJbtT314re
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmF2aWVyDQoNCkFtIDE4LjExLjIyIHVtIDEzOjUyIHNjaHJpZWIgSmF2aWVyIE1hcnRp
bmV6IENhbmlsbGFzOg0KPiBIZWxsbyBUaG9tYXMsDQo+IA0KPiBPbiAxMS8xNi8yMiAxNzow
OSwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6DQo+PiBTZXQgdGhlIHByZWZlcnJlZCBjb2xv
ciBkZXB0aCB0byAyNCBiaXRzIGFuZCB0aGUgZmJkZXYgYnBwIHRvIDMyDQo+PiBiaXRzLiBU
aGlzIHdpbGwgc2lnbmFsIFhSR0I4ODg4IGFzIGRlZmF1bHQgZm9ybWF0IHRvIGNsaWVudHMu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5u
QHN1c2UuZGU+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2hpc2lsaWNvbi9oaWJt
Yy9oaWJtY19kcm1fZHJ2LmMgfCA0ICsrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJtY19kcm1fZHJ2LmMgYi9kcml2ZXJzL2dw
dS9kcm0vaGlzaWxpY29uL2hpYm1jL2hpYm1jX2RybV9kcnYuYw0KPj4gaW5kZXggMjIwNTNj
NjEzNjQ0YS4uMGM0YWE0ZDliMGE3NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9oaXNpbGljb24vaGlibWMvaGlibWNfZHJtX2Rydi5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaGlzaWxpY29uL2hpYm1jL2hpYm1jX2RybV9kcnYuYw0KPj4gQEAgLTEwNiw3ICsx
MDYsNyBAQCBzdGF0aWMgaW50IGhpYm1jX2ttc19pbml0KHN0cnVjdCBoaWJtY19kcm1fcHJp
dmF0ZSAqcHJpdikNCj4+ICAgCWRldi0+bW9kZV9jb25maWcubWF4X3dpZHRoID0gMTkyMDsN
Cj4+ICAgCWRldi0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IDEyMDA7DQo+PiAgIA0KPj4g
LQlkZXYtPm1vZGVfY29uZmlnLnByZWZlcnJlZF9kZXB0aCA9IDMyOw0KPj4gKwlkZXYtPm1v
ZGVfY29uZmlnLnByZWZlcnJlZF9kZXB0aCA9IDI0Ow0KPiANCj4gSW4gdGhlIGNvdmVyIGxl
dHRlciB5b3Ugc2FpZCAiY29sb3IgZGVwdGggaXMgdGhlIG51bWJlciBvZiBjb2xvciBhbmQg
YWxwaGEgYml0cw0KPiB0aGF0IGFmZmVjdCBpbWFnZSBjb21wb3NpdGlvbiIgYnV0IGl0IHNo
b3VsZCBiZSAib25seSB0aGUgbnVtYmVyIG9mIGNvbG9yIGJpdHMNCj4gZXhjbHVkaW5nIHRo
ZSBhbHBoYSBiaXRzIiBhIGJldHRlciBkZXNjcmlwdGlvbiByaWdodD8NCg0KSSB3YXMgbG9v
a2luZyBhdCBkcm1fZm91cmNjLmMsIHdoZXJlIGFscGhhIGZvcm1hdHMsIHN1Y2ggYXMgQVJH
Qjg4OCwgDQpoYXZlIGFscGhhIGluY2x1ZGVkIGluIHRoZWlyIGRlcHRoIHZhbHVlLiBbMV0g
QWxwaGEgb2J2aW91c2x5IGVmZmVjdHMgDQppbWFnZSBjb21wb3NpdGlvbi4NCg0KQnV0IG1l
YW5pbmcgb2YgdGhlc2UgdGVybXMgaXMgc29tZXdoYXQgZnV6enksIGFzIHRoZSBjb21tYW5k
LWxpbmUgDQphcmd1bWVudHMgb2YgdmlkZW89IGluY2x1ZGUgYSBCUFAgdmFsdWUgdGhhdCBp
cyBtb3JlIHNpbWlsYXIgdG8gRFJNJ3MgDQpkZXB0aCB2YWx1ZS4NCg0KWzFdIA0KaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2ZvdXJjYy5jI0wxNzUNCg0KPiANCj4gSSBhbHNvIHdvbmRlciBpZiBpbnN0ZWFk
IG9mIHVzaW5nIGEgMjQgbWFnaWMgbnVtYmVyLCBUUlVFX0NPTE9SX0RFUFRIIGNvbnN0YW50
DQo+IG1hY3JvIG9yIFhSR0I4ODg4X0NPTE9SX0RFUFRIIGNvdWxkIGJlIGRlZmluZWQ/DQoN
ClBsZWFzZSBub3QuIFdoYXQgd2Ugc2hvdWxkIGRvIGlzIHRvIHJlcGxhY2UgdGhlIHByZWZl
cnJlZCBkZXB0aCBhbmQgYnBwIA0Kd2l0aCBhIHNpbmdsZSBmb3JtYXQgY29uc3RhbnQgKGFz
IDRjYyBvciBkcm1fZm9ybWF0X2luZm8pIHRoYXQgDQpkZXNpZ25hdGVzIGEgcHJlZmVycmVk
IGRlZmF1bHQuIEZyb20gdGhhdCBmb3JtYXQgY29uc3RhbnQsIHRoZSB2YWx1ZXMgDQpleHBv
cnRlZCB0byB1c2Vyc3BhY2UgYW5kIGZiZGV2IGVtdWxhdGlvbiBzaG91bGQgYmUgcmV0cmll
dmVkIGF1dG9tYXRpY2FsbHkuDQoNCklmIGFueXRoaW5nLCBJJ2QgYWRkIGEgVE9ETyBpdGVt
IHRvIGNvbnZlcnQgdGhlIERSTSBjb2RlYmFzZS4NCg0KPiANCj4+ICAgCWRldi0+bW9kZV9j
b25maWcucHJlZmVyX3NoYWRvdyA9IDE7DQo+PiAgIA0KPj4gICAJZGV2LT5tb2RlX2NvbmZp
Zy5mdW5jcyA9ICh2b2lkICopJmhpYm1jX21vZGVfZnVuY3M7DQo+PiBAQCAtMzQwLDcgKzM0
MCw3IEBAIHN0YXRpYyBpbnQgaGlibWNfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LA0KPj4gICAJCWdvdG8gZXJyX3VubG9hZDsNCj4+ICAgCX0NCj4+ICAgDQo+PiAtCWRybV9m
YmRldl9nZW5lcmljX3NldHVwKGRldiwgZGV2LT5tb2RlX2NvbmZpZy5wcmVmZXJyZWRfZGVw
dGgpOw0KPj4gKwlkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cChkZXYsIDMyKTsNCj4+DQo+IA0K
PiBBbmQgc2FtZSBoZXJlPyBNYXliZSBUUlVFX0NPTE9SX0FMUEhBX0JQUCBvciBYUkdCODg4
OF9CUFA/IENhbid0IHRoaW5rIG9mIGENCj4gZ29vZCBuYW1lIHJlYWxseSBmb3IgdGhpcywg
YnV0IGp1c3QgdG8gYXZvaWQgdXNpbmcgYSBjb25zdGFudCBudW1iZXIgaGVyZS4NCj4gICAN
Cj4gSW4gYW55IGNhc2UgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWU6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIDxqYXZpZXJtQHJlZGhhdC5jb20+
DQoNClRoYW5rcyBhIGxvdC4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCg0KLS0g
DQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6Rm
dHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------wWaNKLvt6iCaAUrJbtT314re--

--------------6j2tlNrNxOTqjNGhaSaDReGo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmN3hggFAwAAAAAACgkQlh/E3EQov+BK
Mg//Sn3bYzkBdYSx44bEOfHYre8Sb0NMw+xX4PhS9O7YxLYkmkCb8cG/wThuoGljN0KyF0x7oWoe
FjGJGNKLXX1YYJ2soL5le/XtrkwHFawENG9rRw7iowu/BV1po80zEbBsHUXElJD1RYvb1mXAHX8D
aheq4NbVBsjwlTzU4hdH7R8xjdpXd+fo80c6GgN1ou7Ev1wT7honUjyWA2wOk144/jMcnptgPFke
6doMV4BgbKcYgpH1aiJ8re9amyaU9l1BXlWXKgSN4ijEBZzxLRweEQEiI2jV9rC9QV61qSOTDzzR
546RwZ3WEpYR6ekrKOzNzXW9UzBBz90XMTfhKdxl4NnSCLm9zujcM5Oh/iAEfaSOv/KQ7F9q7K8K
vB097uuKf9BVqrP9mPAQbFcpl5gHprQUcWMRxqOVDerR4CKkMl0iB7pI8LqkuuClBRrN5JG1CHRd
F8xGzrvN8UKZnuLSvr0KpH3Uy/x7/jwe2yyR3YTqUOt5aanHUYiyY+U6/0nMEGckDjtI8zhEyyNP
aa3/SBQ8PTM2S9fflA9zk8m5P0RDGMbp16J0RLI9/ZPXl5CkdHLIEfwq6eYHUOvfzLKmVj5yj49D
MSblyMBprduGoQkkfumkHIeMi0n9Vasv8Y9aq9GxflrsjtJ7uJY2lX5COFpyJn7mlh2Lev/lXYDo
N78=
=5dGj
-----END PGP SIGNATURE-----

--------------6j2tlNrNxOTqjNGhaSaDReGo--

--===============6701230017064043340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6701230017064043340==--
