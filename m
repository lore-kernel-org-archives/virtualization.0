Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EC7942D9EDB
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106745; cv=none; b=J+619C+Cq/lxohx7MAnB72nW8P7oJCaFG+U1kyJxXQ7WlalhLStAH20u4P7uKi1kR/elZEYZQp4qRsTzF06azxjMjss6L/lmZMbEgLfmlVKdGTjOjQBZ2+ZGXcE2keWRRjmMD2evTek0vZiJlY9kVKIc65fMmZhQm8y04nReJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106745; c=relaxed/simple;
	bh=j08jtL2NnAAtGlf0HPmiPrRSTh86i8kkz4d+9opoJUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ar5YA3HD3QbKRCLD2E9T5S5zQAcPxudctDirctkqwebpLq7sg7eyHSIWkVLFi3t8szdaoBAQrVgDp0r7WEsyXmyn+aToKDp0BrG0NxYZm2WJNQt6MHU4oTEuBvivyqIMWcc5d3YxxbCH/CR7ZJv+8n7OIka0gU3Dj9V/zltbl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=DgA3+5Pc; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="DgA3+5Pc"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jason Wang <jasowangio@gmail.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB2aXJ0aW9fcmlu?=
 =?utf-8?B?ZzogcmVzZXQgSU5fT1JERVIgc3RhdGUgaW4gdmlydHF1ZXVlX2luaXQoKQ==?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gdmlydGlvX3Jpbmc6IHJlc2V0?=
 =?utf-8?B?IElOX09SREVSIHN0YXRlIGluIHZpcnRxdWV1ZV9pbml0KCk=?=
Thread-Index: AQHdQSFpJC7F+DEBIESNJfSXG16LubbIHx8AgADFC+A=
Date: Fri, 11 Sep 2026 06:05:25 +0000
Message-ID: <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
References: <20260910123903.1717-1-lirongqing@baidu.com>
 <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
In-Reply-To: <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789106736;
	bh=j08jtL2NnAAtGlf0HPmiPrRSTh86i8kkz4d+9opoJUk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=DgA3+5Pce/kMuMVCDnOFQqGN7aC90hGteChLpN8pK6YSlmY8Oc/AhvpIPs79WwG0k
	 Tb/Qv62xN5Tdf2UIielqzWTk8UOJ62TrYf45qJtZaxF+Lv5q267E+pz8atm4gRiy9Z
	 AwQvRnj81uL5IM+b1B3iZfAHurSnqa8v20pXyZpNATa4334/ugbf1f/Yv7K2JwRokB
	 +CLda3W2cgPtdsnL7sQrDKb55w0SJvdWveAAhazLVGFrgMacd3etpfU6UBCouHLcKS
	 jFGoUIis67OjJXzOemIvPN/UFkw/BZNib6y93nYoNfXdZJZvVqAzgvjGa6vkUrEoN9
	 U1kaCp2rXI35w==

PiA+DQo+ID4gVGhlIElOX09SREVSIGZlYXR1cmUgdXNlcyBhZGRpdGlvbmFsIHNvZnR3YXJlIHN0
YXRlIHRvIHRyYWNrIHRoZSBuZXh0DQo+ID4gYXZhaWxhYmxlIGRlc2NyaXB0b3IgYW5kIGluLWZs
aWdodCBkZXNjcmlwdG9yIGJhdGNoZXMuDQo+ID4NCj4gPiB2aXJ0cXVldWVfaW5pdCgpIHJlc2V0
cyB0aGUgY29tbW9uIHZpcnRxdWV1ZSBzdGF0ZSwgYnV0IGZyZWVfaGVhZCBhbmQNCj4gPiBiYXRj
aF9sYXN0LmlkIGFyZSBpbml0aWFsaXplZCBvbmx5IHdoZW4gdGhlIHZpcnRxdWV1ZSBpcyBjcmVh
dGVkLiBXaGVuDQo+ID4gYW4gSU5fT1JERVIgdmlydHF1ZXVlIGlzIHJlc2V0LCB0aGVzZSBmaWVs
ZHMgY2FuIHJldGFpbiBzdGF0ZSBmcm9tIHRoZQ0KPiA+IHByZXZpb3VzIHF1ZXVlIGluc3RhbmNl
Lg0KPiA+DQo+ID4gUmVzZXQgZnJlZV9oZWFkIGFuZCBpbnZhbGlkYXRlIGJhdGNoX2xhc3Qgd2hl
biBpbml0aWFsaXppbmcgYW4NCj4gPiBJTl9PUkRFUiB2aXJ0cXVldWUuIEtlZXAgdGhpcyBpbiB2
aXJ0cXVldWVfaW5pdCgpIHNvIHRoZSBzdGF0ZSBpcw0KPiA+IGluaXRpYWxpemVkIGNvbnNpc3Rl
bnRseSBmb3IgYm90aCBuZXdseSBjcmVhdGVkIGFuZCByZXNldCB2aXJ0cXVldWVzLg0KPiA+DQo+
ID4gRml4ZXM6IGY2YTE1ZDg1NDk4NiAoInZpcnRpb19yaW5nOiBhZGQgaW4gb3JkZXIgc3VwcG9y
dCIpDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgbmVlZGVkIGZvciAtc3RhYmxlLg0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1ICsrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jDQo+ID4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGluZGV4IGRiNjc4ZjUuLmQwZGM0NjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMNCj4g
PiBAQCAtNTU5LDYgKzU1OSwxMSBAQCBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfaW5pdChzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSwNCj4gdTMyIG51bSkNCj4gPiAgICAgICAgIHZxLT5pbl91c2Ug
PSBmYWxzZTsNCj4gPiAgICAgICAgIHZxLT5sYXN0X2FkZF90aW1lX3ZhbGlkID0gZmFsc2U7ICAj
ZW5kaWYNCj4gPiArDQo+ID4gKyAgICAgICBpZiAodmlydHF1ZXVlX2lzX2luX29yZGVyKHZxKSkg
ew0KPiA+ICsgICAgICAgICAgICAgICB2cS0+ZnJlZV9oZWFkID0gMDsNCj4gPiArICAgICAgICAg
ICAgICAgdnEtPmJhdGNoX2xhc3QuaWQgPSBVSU5UX01BWDsNCj4gPiArICAgICAgIH0NCj4gDQo+
IEkgd291bGQgdHJ5IHRvIHJldXNlIG9yIHJlZmFjdG9yIHZpcnRxdWV1ZV92cmluZ19hdHRhY2hf
c3BsaXQoKSB0byByZWR1Y2UgY29kZQ0KPiBkdXBsaWNhdGlvbi4NCj4gDQo+IEJ0dyBoYXZlIHlv
dSBjaGVja2VkIFFlbXUgc2hhZG93IHZpcnRxdWV1ZSBhcyBpdCBtaWdodCBzdWZmZXIgZnJvbSB0
aGUgc2FtZQ0KPiBpc3N1ZS4NCj4gDQoNCkkgY2hlY2tlZCBRRU1VJ3Mgc2hhZG93IHZpcnRxdWV1
ZSBpbXBsZW1lbnRhdGlvbi4gYmF0Y2hfbGFzdCBpcyByZWluaXRpYWxpemVkIGluIHZob3N0X3N2
cV9zdGFydCgpLCANCmJ1dCBmcmVlX2hlYWQgaXMgbm90LiBTaW5jZSB0aGUgU1ZRIG9iamVjdCBj
YW4gYmUgcmV1c2VkIGFjcm9zcyBzdG9wL3N0YXJ0LCBmcmVlX2hlYWQgbWF5IHJldGFpbiBzdGFs
ZSANCnN0YXRlLiBTbyBhIGNvcnJlc3BvbmRpbmcgZml4IHNob3VsZCBiZSBuZWVkZWQNCg0Kdm9p
ZCB2aG9zdF9zdnFfc3RhcnQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgVmlydElPRGV2aWNl
ICp2ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgIFZpcnRRdWV1ZSAqdnEsIFZob3N0SU9WQVRy
ZWUgKmlvdmFfdHJlZSkNCiB7DQogICAgIC4uLg0KICAgICBzdnEtPnNoYWRvd19hdmFpbF9pZHgg
PSAwOw0KICAgICBzdnEtPnNoYWRvd191c2VkX2lkeCA9IDA7DQorICAgIHN2cS0+ZnJlZV9oZWFk
ID0gMDsNCiAgICAgbWVtc2V0KCZzdnEtPmJhdGNoX2xhc3QsIDAsIHNpemVvZihzdnEtPmJhdGNo
X2xhc3QpKTsNCiAgICAgc3ZxLT5sYXN0X3VzZWQgPSAwOw0KICAgICBzdnEtPmxhc3RfdXNlZF9p
ZHggPSAwOw0KDQp0aGFua3MNCiANCltMaSxSb25ncWluZ10gDQoNCg0KPiBUaGFua3MNCj4gDQo+
ID4gIH0NCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiAyLjkuNA0KPiA+DQo=
