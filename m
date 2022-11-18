Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEE2C433FE
	for <virtualization@archiver.kernel.org>; Fri, 18 Nov 2022 13:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF694821C7;
	Fri, 18 Nov 2022 13:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF694821C7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=W9igDoPo;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TbL3mM/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6Km5DBD6r67; Fri, 18 Nov 2022 13:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 115398219E;
	Fri, 18 Nov 2022 13:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 115398219E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E26BFC0032;
	Fri, 18 Nov 2022 13:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D48644194E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D48644194E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=W9igDoPo; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TbL3mM/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPL2QAALOtWp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8DB841996
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8DB841996
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 13:22:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17D6C1FA4A;
 Fri, 18 Nov 2022 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668777742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KSFeZZcQcmOphqHP4wAHfaw5Qgs+WGe8vO8FoC897Q=;
 b=W9igDoPojmJMnHeEcFHVuJyFpEXL9nn+6yPXKk/IgQQBwlvRBqBOPe2KmhTa6Hz3LD2ynq
 fuCng2+Or5hnd5BimnXn7rPN8vAWI3omPmz3Df+oA6l6VQtNGdf87cYS7uQvXAp9eS+0g4
 MzUzGmoJFOUTyw6y+O3b69EiHZejB5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668777742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KSFeZZcQcmOphqHP4wAHfaw5Qgs+WGe8vO8FoC897Q=;
 b=TbL3mM/OR3uzZJnetBuemXorykqfNODCyWS4crjA7H9LcSpTUcfyhhnDCYr+BNovWcmX0B
 Zy3omPfov2NLToCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C94FB13A66;
 Fri, 18 Nov 2022 13:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f1BMMA2Hd2OnJQAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 18 Nov 2022 13:22:21 +0000
Message-ID: <10c809cb-2ea9-273c-bfd2-a267e6219f22@suse.de>
Date: Fri, 18 Nov 2022 14:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/7] drm/logicvc: Fix preferred fbdev cpp
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 xinliang.liu@linaro.org, tiantao6@hisilicon.com, jstultz@google.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 paul.kocialkowski@bootlin.com, airlied@redhat.com, kraxel@redhat.com
References: <20221116160917.26342-1-tzimmermann@suse.de>
 <20221116160917.26342-3-tzimmermann@suse.de>
 <521e43bb-0c76-f3b7-aa78-8ed97edce613@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <521e43bb-0c76-f3b7-aa78-8ed97edce613@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1413574696348041365=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1413574696348041365==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pC07C59nTw9ATfbYYbKgTzXm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pC07C59nTw9ATfbYYbKgTzXm
Content-Type: multipart/mixed; boundary="------------wgxeQ0Y9p012UoklBJ4bWcxk";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 xinliang.liu@linaro.org, tiantao6@hisilicon.com, jstultz@google.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 paul.kocialkowski@bootlin.com, airlied@redhat.com, kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <10c809cb-2ea9-273c-bfd2-a267e6219f22@suse.de>
Subject: Re: [PATCH 2/7] drm/logicvc: Fix preferred fbdev cpp
References: <20221116160917.26342-1-tzimmermann@suse.de>
 <20221116160917.26342-3-tzimmermann@suse.de>
 <521e43bb-0c76-f3b7-aa78-8ed97edce613@redhat.com>
In-Reply-To: <521e43bb-0c76-f3b7-aa78-8ed97edce613@redhat.com>

--------------wgxeQ0Y9p012UoklBJ4bWcxk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTguMTEuMjIgdW0gMTQ6MDggc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2Fu
aWxsYXM6DQo+IE9uIDExLzE2LzIyIDE3OjA5LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToN
Cj4+IExvZ2ljdmMgY2FuIGhhdmUgZGlmZmVyZW50IHZhbHVlcyBmb3IgdGhlIHByZWZlcnJl
ZCBjb2xvciBkZXB0aC4gU2V0DQo+PiB0aGUgZmJkZXYgYnBwIHZhbHVlIGRlcGVuZGluZyBv
biB0aGUgcnVudGltZSB2YWx1ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmlt
bWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dw
dS9kcm0vbG9naWN2Yy9sb2dpY3ZjX2RybS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2xvZ2ljdmMvbG9naWN2Y19kcm0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9sb2dpY3ZjL2xvZ2ljdmNfZHJtLmMNCj4+IGluZGV4IDlkZTI0
ZDlmMGM5NjMuLmQ5Y2Q1ZDk2N2UzMWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbG9naWN2Yy9sb2dpY3ZjX2RybS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbG9n
aWN2Yy9sb2dpY3ZjX2RybS5jDQo+PiBAQCAtMzAxLDYgKzMwMSw3IEBAIHN0YXRpYyBpbnQg
bG9naWN2Y19kcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAg
CXN0cnVjdCByZWdtYXAgKnJlZ21hcCA9IE5VTEw7DQo+PiAgIAlzdHJ1Y3QgcmVzb3VyY2Ug
cmVzOw0KPj4gICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPj4gKwl1bnNpZ25lZCBpbnQgcHJl
ZmVycmVkX2JwcDsNCj4+ICAgCWludCBpcnE7DQo+PiAgIAlpbnQgcmV0Ow0KPj4gICANCj4+
IEBAIC00MzgsNyArNDM5LDE4IEBAIHN0YXRpYyBpbnQgbG9naWN2Y19kcm1fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgCQlnb3RvIGVycm9yX21vZGU7DQo+
PiAgIAl9DQo+PiAgIA0KPj4gLQlkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cChkcm1fZGV2LCBk
cm1fZGV2LT5tb2RlX2NvbmZpZy5wcmVmZXJyZWRfZGVwdGgpOw0KPj4gKwlzd2l0Y2ggKGRy
bV9kZXYtPm1vZGVfY29uZmlnLnByZWZlcnJlZF9kZXB0aCkgew0KPj4gKwljYXNlIDE1Og0K
PiANCj4gV2h5IGNvdWxkIGhhdmUgMTU/IElJVUMgdGhlIGZvcm1hdHMgc3VwcG9ydGVkIGJ5
IHRoaXMgZHJpdmVyIGFyZToNCj4gDQo+IHN0YXRpYyB1aW50MzJfdCBsb2dpY3ZjX2xheWVy
X2Zvcm1hdHNfcmdiMTZbXSA9IHsNCj4gCURSTV9GT1JNQVRfUkdCNTY1LA0KPiAJRFJNX0ZP
Uk1BVF9CR1I1NjUsDQo+IAlEUk1fRk9STUFUX0lOVkFMSUQsDQo+IH07DQo+IA0KPiBzdGF0
aWMgdWludDMyX3QgbG9naWN2Y19sYXllcl9mb3JtYXRzX3JnYjI0W10gPSB7DQo+IAlEUk1f
Rk9STUFUX1hSR0I4ODg4LA0KPiAJRFJNX0ZPUk1BVF9YQkdSODg4OCwNCj4gCURSTV9GT1JN
QVRfSU5WQUxJRCwNCj4gfTsNCj4gDQo+IC8qDQo+ICAgKiBXaGF0IHdlIGNhbGwgZGVwdGgg
aW4gdGhpcyBkcml2ZXIgb25seSBjb3VudHMgY29sb3IgY29tcG9uZW50cywgbm90IGFscGhh
Lg0KPiAgICogVGhpcyBhbGxvd3MgdXMgdG8gc3RheSBjb21wYXRpYmxlIHdpdGggdGhlIExv
Z2lDVkMgYmlzdHJlYW0gZGVmaW5pdGlvbnMuDQo+ICAgKi8NCj4gc3RhdGljIHVpbnQzMl90
IGxvZ2ljdmNfbGF5ZXJfZm9ybWF0c19yZ2IyNF9hbHBoYVtdID0gew0KPiAJRFJNX0ZPUk1B
VF9BUkdCODg4OCwNCj4gCURSTV9GT1JNQVRfQUJHUjg4ODgsDQo+IAlEUk1fRk9STUFUX0lO
VkFMSUQsDQo+IH07DQo+IA0KPiBTbyBzaG91bGRuJ3QgYmUganVzdCAxNiwgMjQgYW5kIDMy
ID8NCg0KVGhhdCBtYWtlcyBzZW5zZS4NCg0KPiANCj4+ICsJY2FzZSAxNjoNCj4+ICsJCXBy
ZWZlcnJlZF9icHAgPSAxNjsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIDI0Og0KPj4gKwlj
YXNlIDMyOg0KPj4gKwlkZWZhdWx0Og0KPj4gKwkJcHJlZmVycmVkX2JwcCA9IDMyOw0KPj4g
KwkJYnJlYWs7DQo+IA0KPiBJJ20gYWxzbyBub3Qgc3VyZSBpZiB0aGlzIGlzIG5lZWRlZC4g
U2luY2UgSUlVQyBpbiBsb2dpY3ZjX21vZGVfaW5pdCgpIHRoZQ0KPiBkcml2ZXIgZG9lczoN
Cj4gDQo+IAlwcmVmZXJyZWRfZGVwdGggPSBsYXllcl9wcmltYXJ5LT5mb3JtYXRzLT5kZXB0
aDsNCj4gDQo+IAkvKiBEUk0gY291bnRzIGFscGhhIGluIGRlcHRoLCBvdXIgZHJpdmVyIGRv
ZXNuJ3QuICovDQo+IAlpZiAobGF5ZXJfcHJpbWFyeS0+Zm9ybWF0cy0+YWxwaGEpDQo+IAkJ
cHJlZmVycmVkX2RlcHRoICs9IDg7DQo+IA0KPiAJLi4uDQo+IAltb2RlX2NvbmZpZy0+cHJl
ZmVycmVkX2RlcHRoID0gcHJlZmVycmVkX2RlcHRoOw0KPiANCj4gU28gaXQgc2VlbXMgdGhp
cyBwYXRjaCBpcyBub3QgbmVlZGVkPyBVbmxlc3MgSSdtIG1pc3VuZGVyc3RhbmRpbmcgdGhl
IGNvZGUuDQoNClRoZSBkcml2ZXIgdXNlcyBYUkdCODg4OCwgc28gdGhlIDI0LWJpdCBjb2xv
ciBkZXB0aCBoYXMgYSAzMi1iaXQgYnBwIA0KdmFsdWUuIEhlbmNlIHRoZSBzd2l0Y2guDQoN
CkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4N
CkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQoo
SFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2
DQo=

--------------wgxeQ0Y9p012UoklBJ4bWcxk--

--------------pC07C59nTw9ATfbYYbKgTzXm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmN3hw0FAwAAAAAACgkQlh/E3EQov+CJ
SA//c2J0S0au0WQJ+0NrtSwe0Ro6Rrgxegju5qqvLVlzXMZ3lbHq5KlQDBn3ObHrEyu7IDcxZFpj
WfSayjS/Uso8HXQKmrz+QDe+qhk3SyeiG8WAOK50T8xh93a7QeiXaWM0XYkXtGRLJkI+AJh8pMFJ
fZnsLG104pW7s5adaEnimmu6pvYs2BhUQFsazTN4d/dISSWyNEl+BkFdbEiotB+YYMAMocI5Zkdy
j207IVGEDX/GFO2HYOmHmZ3qB0hX6c3Rr3eXot9fdmah5JO9Dv+L9tPCZKsH/IVDAquGETWGDFa7
VI+B1i8L7F7ZqtYKGK8upmUsxZ+vsmIsMJxnmXoBYECp/hSXzmPYRMSh01+3e6JgfXrE4F/OMpAE
BYMt4ZTzmTEy2ua0d5jbXFuw0hPQeAmCK4Z4ZVYM+FI58dC0fwDKO0CqgwCKCbjgQMwnmRrOO4H+
hj0z7jFa+TqupUvW85Hl8EBSj3AupjZBsH9EULUn0/A2A/Eo9pvFeAHTq7JzaRTgcKaIwwhteFWv
JxtoZeMIZZRJxXtC2YzeXrOjzhEml1TnU8p5kvhGJtlLj3Pq1h03kLwfm4h2bpczHj+uNkwJtEEE
fV54dcMV7KsgkC1vnmcsY5rWbKfVrNDTQuBx+KkAxyAa4n96TNnUxRiis/3uXF9+CA5Orjgas5Pa
HXI=
=I4A7
-----END PGP SIGNATURE-----

--------------pC07C59nTw9ATfbYYbKgTzXm--

--===============1413574696348041365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1413574696348041365==--
