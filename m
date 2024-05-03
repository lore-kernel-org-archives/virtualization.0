Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD3155343
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753403; cv=none; b=raooBaHVzcRp2BvvS3NVG/VbUBI2OiABl59+Ii8hmn1ylpO2823d0jtN3aHgtL/2QLfx1f7tScgUEYSgtchg1VUmScEtiDpExLfnRSjHDdY/YOFfQgJ4FY2JQQOg1XJZPTewINc9oeP0u+PGpE94I3Ma0GVj7L8BzpLYYJpGNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753403; c=relaxed/simple;
	bh=uRsf89PYPNNB+MDH2jhxz1s0c6RGa/OSvDNRlwMEnsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=H3M5a8G/7qC3Ae3Qbt13/35OI5Nl0VNOzF/BagHNa+xciq4rETnKo81ZWthH1ljQljKoSJYK2M2kAhBOcTO0jONbYmeA5nK2dXPd7jKRlZEJKXMl19RliU5kv8GZIFyU6WaDcmQtXJSgWpIdOL+3nCQwavF/FOu1h/4a47Lsw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5B6C83BE3
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 16:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tx9IuEKrCIEK for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 16:23:20 +0000 (UTC)
X-Greylist: delayed 311 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 03 May 2024 16:23:19 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1240683ACF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1240683ACF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.86.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1240683ACF
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 16:23:19 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-6zAZYStTPmWnjs5bkxLi4w-1; Fri, 03 May 2024 17:16:52 +0100
X-MC-Unique: 6zAZYStTPmWnjs5bkxLi4w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 3 May
 2024 17:16:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 3 May 2024 17:16:22 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHexhPrXlAAACWziA=
Date: Fri, 3 May 2024 16:16:21 +0000
Message-ID: <a4b3b3a260b94bfdb46a4b5d57b36f01@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
In-Reply-To: <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDMgTWF5IDIwMjQgMTc6MDANCj4gVG86IERhdmlk
IExhaWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+OyAnbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZycgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgJ3BldGVyekBpbmZy
YWRlYWQub3JnJyA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IENjOiAnbWluZ29AcmVkaGF0LmNv
bScgPG1pbmdvQHJlZGhhdC5jb20+OyAnd2lsbEBrZXJuZWwub3JnJyA8d2lsbEBrZXJuZWwub3Jn
PjsgJ2JvcXVuLmZlbmdAZ21haWwuY29tJw0KPiA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+OyAnTGlu
dXMgVG9ydmFsZHMnIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz47ICd2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC0NCj4gZm91bmRhdGlvbi5vcmcnIDx2aXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZz47ICdaZW5nIEhlbmcnIDx6ZW5naGVuZzRAaHVhd2VpLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXh0IHYyIDUvNV0gbG9ja2luZy9vc3FfbG9jazog
T3B0aW1pc2UgZGVjb2RlX2NwdSgpIGFuZCBwZXJfY3B1X3B0cigpLg0KPiANCj4gDQo+IE9uIDEy
LzMxLzIzIDIzOjE0LCBXYWltYW4gTG9uZyB3cm90ZToNCj4gPg0KPiA+IE9uIDEyLzMxLzIzIDE2
OjU1LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+IHBlcl9jcHVfcHRyKCkgaW5kZXhlcyBfX3Bl
cl9jcHVfb2Zmc2V0W10gd2l0aCB0aGUgY3B1IG51bWJlci4NCj4gPj4gVGhpcyByZXF1aXJlcyB0
aGUgY3B1IG51bWJlciBiZSA2NGJpdC4NCj4gPj4gSG93ZXZlciB0aGUgdmFsdWUgaXMgb3NxX2xv
Y2soKSBjb21lcyBmcm9tIGEgMzJiaXQgeGNoZygpIGFuZCB0aGVyZQ0KPiA+PiBpc24ndCBhIHdh
eSBvZiB0ZWxsaW5nIGdjYyB0aGUgaGlnaCBiaXRzIGFyZSB6ZXJvICh0aGV5IGFyZSkgc28NCj4g
Pj4gdGhlcmUgd2lsbCBhbHdheXMgYmUgYW4gaW5zdHJ1Y3Rpb24gdG8gY2xlYXIgdGhlIGhpZ2gg
Yml0cy4NCj4gPj4NCj4gPj4gVGhlIGNwdSBudW1iZXIgaXMgYWxzbyBvZmZzZXQgYnkgb25lICh0
byBtYWtlIHRoZSBpbml0aWFsaXNlciAwKQ0KPiA+PiBJdCBzZWVtcyB0byBiZSBpbXBvc3NpYmxl
IHRvIGdldCBnY2MgdG8gY29udmVydA0KPiA+PiBfX3Blcl9jcHVfb2Zmc2V0W2NwdV9wMSAtIDFd
DQo+ID4+IGludG8gKF9fcGVyX2NwdV9vZmZzZXQgLSAxKVtjcHVfcDFdICh0cmFuc2ZlcnJpbmcg
dGhlIG9mZnNldCB0byB0aGUNCj4gPj4gYWRkcmVzcykuDQo+ID4+DQo+ID4+IENvbnZlcnRpbmcg
dGhlIGNwdSBudW1iZXIgdG8gMzJiaXQgdW5zaWduZWQgcHJpb3IgdG8gdGhlIGRlY3JlbWVudCBt
ZWFucw0KPiA+PiB0aGF0IGdjYyBrbm93cyB0aGUgZGVjcmVtZW50IGhhcyBzZXQgdGhlIGhpZ2gg
Yml0cyB0byB6ZXJvIGFuZCBkb2Vzbid0DQo+ID4+IGFkZCBhIHJlZ2lzdGVyLXJlZ2lzdGVyIG1v
dmUgKG9yIGNsdHEpIHRvIHplcm8vc2lnbiBleHRlbmQgdGhlIHZhbHVlLg0KPiA+Pg0KPiA+PiBO
b3QgbWFzc2l2ZSBidXQgc2F2ZXMgdHdvIGluc3RydWN0aW9ucy4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogRGF2aWQgTGFpZ2h0IDxkYXZpZC5sYWlnaHRAYWN1bGFiLmNvbT4NCj4gPj4gLS0t
DQo+ID4+IMKgIGtlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMgfCA2ICsrLS0tLQ0KPiA+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYyBiL2tlcm5lbC9sb2NraW5n
L29zcV9sb2NrLmMNCj4gPj4gaW5kZXggMzViYjk5ZTk2Njk3Li4zN2E0ZmE4NzI5ODkgMTAwNjQ0
DQo+ID4+IC0tLSBhL2tlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMNCj4gPj4gKysrIGIva2VybmVs
L2xvY2tpbmcvb3NxX2xvY2suYw0KPiA+PiBAQCAtMjksMTEgKzI5LDkgQEAgc3RhdGljIGlubGlu
ZSBpbnQgZW5jb2RlX2NwdShpbnQgY3B1X25yKQ0KPiA+PiDCoMKgwqDCoMKgIHJldHVybiBjcHVf
bnIgKyAxOw0KPiA+PiDCoCB9DQo+ID4+IMKgIC1zdGF0aWMgaW5saW5lIHN0cnVjdCBvcHRpbWlz
dGljX3NwaW5fbm9kZSAqZGVjb2RlX2NwdShpbnQNCj4gPj4gZW5jb2RlZF9jcHVfdmFsKQ0KPiA+
PiArc3RhdGljIGlubGluZSBzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX25vZGUgKmRlY29kZV9jcHUo
dW5zaWduZWQgaW50DQo+ID4+IGVuY29kZWRfY3B1X3ZhbCkNCj4gPj4gwqAgew0KPiA+PiAtwqDC
oMKgIGludCBjcHVfbnIgPSBlbmNvZGVkX2NwdV92YWwgLSAxOw0KPiA+PiAtDQo+ID4+IC3CoMKg
wqAgcmV0dXJuIHBlcl9jcHVfcHRyKCZvc3Ffbm9kZSwgY3B1X25yKTsNCj4gPj4gK8KgwqDCoCBy
ZXR1cm4gcGVyX2NwdV9wdHIoJm9zcV9ub2RlLCBlbmNvZGVkX2NwdV92YWwgLSAxKTsNCj4gPj4g
wqAgfQ0KPiA+PiDCoCDCoCAvKg0KPiA+DQo+ID4gWW91IHJlYWxseSBsaWtlIG1pY3JvLW9wdGlt
aXphdGlvbi4NCj4gPg0KPiA+IEFueXdheSwNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBXYWltYW4g
TG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiA+DQo+IERhdmlkLA0KPiANCj4gQ291bGQgeW91
IHJlc3BpbiB0aGUgc2VyaWVzIGJhc2VkIG9uIHRoZSBsYXRlc3QgdXBzdHJlYW0gY29kZT8NCg0K
TG9va3MgbGlrZSBhIHdldCBiYW5rIGhvbGlkYXkgd2Vla2VuZC4uLi4uDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

