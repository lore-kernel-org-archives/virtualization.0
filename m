Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F3C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 14:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0AAF81D88;
	Wed, 27 Apr 2022 14:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id To4UjUd1VwbU; Wed, 27 Apr 2022 14:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 368DE80AF6;
	Wed, 27 Apr 2022 14:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03B99C0039;
	Wed, 27 Apr 2022 14:14:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C542C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 593BF60EF8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0IOSOa0H35_z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:14:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2085A60DFC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:14:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 371D521122;
 Wed, 27 Apr 2022 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1651068856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYg8gr5wdcRyNG4AdxCsOdtftu2BHg4O2FTCP/bxq/Q=;
 b=UXIU7N2CQQ5qRMc2FRXJprmzFwf/qo7e51hP46lpgE4FMqJqhD5OooyjrY2AWeEi1koB1Z
 ZGTys0DsW9TZY9F/6dFpFtEikB69Bp29GagoYcXl8I+NHhNJUW00ppcEnrtiNzjJU/KeGe
 in+uFjE4wRsHo3IbUhWG+MNPEONi5eQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60A9213A39;
 Wed, 27 Apr 2022 14:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +JM4FrdPaWLnbwAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 14:14:15 +0000
Message-ID: <f1fa517f-a59d-df48-b5c5-f38ce210d999@suse.com>
Date: Wed, 27 Apr 2022 16:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
 <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
In-Reply-To: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
Cc: linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Dexuan Cui <decui@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: multipart/mixed; boundary="===============0069986008248470642=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0069986008248470642==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qrX1Zw0otlm9chkAauIvtpiu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qrX1Zw0otlm9chkAauIvtpiu
Content-Type: multipart/mixed; boundary="------------SjQ8Clt6NV07sBwPPOSV6wCG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <f1fa517f-a59d-df48-b5c5-f38ce210d999@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
 <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
In-Reply-To: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>

--------------SjQ8Clt6NV07sBwPPOSV6wCG
Content-Type: multipart/mixed; boundary="------------cGEVlD8i867vhmcCg7GQujS6"

--------------cGEVlD8i867vhmcCg7GQujS6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDQuMjIgMTY6MDksIFRvbSBMZW5kYWNreSB3cm90ZToNCj4gT24gNC8yNy8yMiAw
NzozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDI3LjA0LjIyIDE0OjI4LCBCb3Jp
c2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMDg6Mzc6
MzFBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pj4gT24gMjYuMDQuMjIgMTk6
MzUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgQXByIDI2LCAyMDIy
IGF0IDAzOjQwOjIxUE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gwqDC
oCAvKiBwcm90ZWN0ZWQgdmlydHVhbGl6YXRpb24gKi8NCj4+Pj4+PiDCoMKgIHN0YXRpYyB2
b2lkIHB2X2luaXQodm9pZCkNCj4+Pj4+PiDCoMKgIHsNCj4+Pj4+PiDCoMKgwqDCoMKgwqAg
aWYgKCFpc19wcm90X3ZpcnRfZ3Vlc3QoKSkNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm47DQo+Pj4+Pj4gK8KgwqDCoCBwbGF0Zm9ybV9zZXRfZmVhdHVyZShQTEFURk9S
TV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4+Pj4+DQo+Pj4+PiBLaW5kYSBs
b25nLWlzaCBmb3IgbXkgdGFzdGUuIEknbGwgcHJvYmFibHkgY2FsbCBpdDoNCj4+Pj4+DQo+
Pj4+PiDCoMKgwqDCoHBsYXRmb3JtX3NldCgpDQo+Pj4+Pg0KPj4+Pj4gYXMgaXQgaXMgaW1w
bGljaXQgdGhhdCBpdCBzZXRzIGEgZmVhdHVyZSBiaXQuDQo+Pj4+DQo+Pj4+IE9rYXksIGZp
bmUgd2l0aCBtZS4NCj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMgDQo+Pj4+Pj4gYi9hcmNoL3g4Ni9tbS9tZW1f
ZW5jcnlwdF9pZGVudGl0eS5jDQo+Pj4+Pj4gaW5kZXggYjQzYmMyNGQyYmI2Li42MDQzYmE2
Y2QxN2QgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRl
bnRpdHkuYw0KPj4+Pj4+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5
LmMNCj4+Pj4+PiBAQCAtNDAsNiArNDAsNyBAQA0KPj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGxp
bnV4L21tLmg+DQo+Pj4+Pj4gwqDCoCAjaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4N
Cj4+Pj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9jY19wbGF0Zm9ybS5oPg0KPj4+Pj4+ICsj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm0tZmVhdHVyZS5oPg0KPj4+Pj4+IMKgwqAgI2luY2x1
ZGUgPGFzbS9zZXR1cC5oPg0KPj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5o
Pg0KPj4+Pj4+IEBAIC01NjYsNiArNTY3LDEwIEBAIHZvaWQgX19pbml0IHNtZV9lbmFibGUo
c3RydWN0IGJvb3RfcGFyYW1zICpicCkNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgfSBlbHNlIHsN
Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBTRVYgc3RhdGUgY2Fubm90IGJlIGNv
bnRyb2xsZWQgYnkgYSBjb21tYW5kIGxpbmUgb3B0aW9uICovDQo+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc21lX21lX21hc2sgPSBtZV9tYXNrOw0KPj4+Pj4+ICsNCj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLyogU2V0IHJlc3RyaWN0ZWQgbWVtb3J5IGFjY2VzcyBmb3Igdmly
dGlvLiAqLw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwbGF0Zm9ybV9zZXRfZmVhdHVyZShQ
TEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4gDQo+IFRoaXMgaXMg
d2F5IGVhcmx5IGluIHRoZSBib290LCBidXQgaXQgYXBwZWFycyB0aGF0IG1hcmtpbmcgdGhl
IHBsYXRmb3JtIGZlYXR1cmUgDQo+IGJpdG1hcCBhcyBfX3JlYWRfbW9zdGx5IHB1dHMgdGhp
cyBpbiB0aGUgLmRhdGEgc2VjdGlvbiwgc28gYXZvaWRzIHRoZSBpc3N1ZSBvZiANCj4gYnNz
IGJlaW5nIGNsZWFyZWQuDQoNCkluIFYyIChub3QgeWV0IHBvc3RlZCkgSSBoYXZlIG1vdmVk
IHRoZSBjYWxsIHRvIHNldl9zZXR1cF9hcmNoKCkuDQoNCj4gDQo+IFREWCBzdXBwb3J0IGFs
c28gdXNlcyB0aGUgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcygp
IGZ1bmN0aW9uIA0KPiBhbmQgd2lsbCBuZWVkIHRvIGJlIHVwZGF0ZWQuDQoNClllcy4NCg0K
PiBTZWVtcyBsaWtlIGEgbG90IG9mIGNoYW5nZXMsIEkganVzdCB3b25kZXIgaWYgdGhlIHRo
ZSBhcmNoX2hhcy4uLigpIGZ1bmN0aW9uIA0KPiBjb3VsZG4ndCBiZSB1cGRhdGVkIHRvIGFs
c28gaW5jbHVkZSBhIFhlbiBjaGVjaz8NCg0KVGhpcyB3YXMgbm90IHNlZW4gdG8gYmUgYSBu
aWNlIHNvbHV0aW9uLg0KDQpBbmQgVEJILCBJIHRoaW5rIHRoaXMgc2VyaWVzIGlzIG1ha2lu
ZyB0aGUgY29kZSBtdWNoIGNsZWFuZXIuIExvb2sgYXQgdGhlDQpkaWZmc3RhdCBvZiB0aGlz
IHBhdGNoLg0KDQoNCkp1ZXJnZW4NCg==
--------------cGEVlD8i867vhmcCg7GQujS6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------cGEVlD8i867vhmcCg7GQujS6--

--------------SjQ8Clt6NV07sBwPPOSV6wCG--

--------------qrX1Zw0otlm9chkAauIvtpiu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJpT7YFAwAAAAAACgkQsN6d1ii/Ey8N
uAf+Jas60ulcqZxW/5BLONH0Ysyzp+8tr8yRp44PyWuOsMeWy7WfcogAZD+WsimNGhr6i1KqA/F6
NWAfvn7HEAGBS99DMJgHBJzWUv7yzfo6t6PQBu41g2XGyDuJabILztdVj171jyyquK5CPvJDmRfb
yKIptT2SfLxnK03HwLES7EbIVCvnTCMVznBy5PaTfxx8PBjgK8Y4EWP0R/QQPCeokBVT5pQXPMuX
pt/33FiukREX57d4h6GSBxLimFu3IuHbyL6VefObUbd9H3Oiy1I6L334KqGkDf4LQ2uUVn4xVP71
LlF0czzuLhUn3IUqgUqUO9axHSU0UoWEPCbcofbJqA==
=K2x+
-----END PGP SIGNATURE-----

--------------qrX1Zw0otlm9chkAauIvtpiu--

--===============0069986008248470642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0069986008248470642==--
