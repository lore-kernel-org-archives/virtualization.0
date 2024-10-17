Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520E1DD875
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169904; cv=none; b=BJm2SLaxO/Mow7Nj0iawuKuhMXzDL2CUbqTOOyv4nSqpRIhdDv9xU3Xfto+CjoLrtT8FKLGnGiftdW1ftdS3ksD6PxgKJEOwpr3ZZwN2kKQWvI6A7WkJhhwOIF5Hz6CXgkavnWLj+sh6Rprs2ww6/4uBcQ3EzeOCIML3Xovo7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169904; c=relaxed/simple;
	bh=QTEIK+hjRYcsCWe0UVg7ofyNR9soooVcGWuUXTn5uls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mkQ48VZtXAGKG46NiR+bVeGvU0AipvM69r50uh5h34iKLmKvxBlgDMrFj+n+WFjGCl5PQpvPgqJhFj8hxBgejG7UfLa/y40RvIcf5vafxbz11eiXW/u5L+fKawE3XDZSOQHRYUQu0EuPQej6FPZsbciyV3b4ocjwpQnWEpn8JE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C02E8605FA
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.889
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8vUWpPIAvsN for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 12:58:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=shameerali.kolothum.thodi@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31D3F600BB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31D3F600BB
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31D3F600BB
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:58:18 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTns92yJQz6FGnM;
	Thu, 17 Oct 2024 20:56:29 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 818D01400F4;
	Thu, 17 Oct 2024 20:58:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 14:58:13 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 14:58:13 +0200
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Topic: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Index: AQHazEqXxVp4lf+dEUeIMwqdhDxFmrKHp/+AgACgmACAANsfAIAA4VKAgACtBACAAK2BAIAACGkAgAAneCA=
Date: Thu, 17 Oct 2024 12:58:13 +0000
Message-ID: <50ee0c0b052b40f6b67d1ad3b1b0eeb9@huawei.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
In-Reply-To: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTcsIDIw
MjQgMTozNSBQTQ0KPiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IENjOiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgS2V2aW4gVGlhbg0KPiA8a2V2aW4u
dGlhbkBpbnRlbC5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz47IFdpbGwgRGVh
Y29uDQo+IDx3aWxsQGtlcm5lbC5vcmc+OyBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPjsgSmVhbi0NCj4gUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3Jn
PjsgTmljb2xpbiBDaGVuDQo+IDxuaWNvbGluY0BudmlkaWEuY29tPjsgWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+OyBKYWNvYiBQYW4NCj4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29t
PjsgSm9lbCBHcmFuYWRvcw0KPiA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT47IGlvbW11QGxpc3Rz
LmxpbnV4LmRldjsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OCAwNy8xMF0gaW9tbXVmZDogRmF1bHQtY2FwYWJsZSBod3B0DQo+IGF0dGFjaC9k
ZXRhY2gvcmVwbGFjZQ0KPiANCj4gT24gVGh1LCAxNyBPY3QgMjAyNCBhdCAyMDowNSwgSmFzb24g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBPY3QgMTcs
IDIwMjQgYXQgMDk6NDQ6MThBTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOg0KPiA+ID4gT24g
V2VkLCAxNiBPY3QgMjAyNCBhdCAyMzoyNSwgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIE9jdCAxNiwgMjAyNCBhdCAwOTo1ODoz
NkFNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCAxNSBPY3Qg
MjAyNCBhdCAyMDo1NCwgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IHdyb3RlOg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDExOjE5OjMz
QU0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiArc3RhdGljIGlu
dCBpb21tdWZkX2ZhdWx0X2lvcGZfZW5hYmxlKHN0cnVjdA0KPiA+ID4gPiA+ID4gPiA+ICtpb21t
dWZkX2RldmljZSAqaWRldikgew0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gaWRldi0+ZGV2Ow0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgaW50IHJldDsNCj4g
PiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiA+ID4g
PiA+ICsgICAgICAgICogT25jZSB3ZSB0dXJuIG9uIFBDSS9QUkkgc3VwcG9ydCBmb3IgVkYsIHRo
ZSByZXNwb25zZQ0KPiBmYWlsdXJlIGNvZGUNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAqIHNo
b3VsZCBub3QgYmUgZm9yd2FyZGVkIHRvIHRoZSBoYXJkd2FyZSBkdWUgdG8gUFJJDQo+IGJlaW5n
IGEgc2hhcmVkDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgKiByZXNvdXJjZSBiZXR3ZWVuIFBG
IGFuZCBWRnMuIFRoZXJlIGlzIG5vIGNvb3JkaW5hdGlvbg0KPiBmb3IgdGhpcw0KPiA+ID4gPiA+
ID4gPiA+ICsgICAgICAgICogc2hhcmVkIGNhcGFiaWxpdHkuIFRoaXMgd2FpdHMgZm9yIGEgdlBS
SSByZXNldCB0byByZWNvdmVyLg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICovDQo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgICBpZiAoZGV2X2lzX3BjaShkZXYpICYmIHRvX3BjaV9kZXYoZGV2KS0+
aXNfdmlydGZuKQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSSBhbSB1c2luZyB0aGUgU01NVXYzIHN0
YWxsIGZlYXR1cmUsIGFuZCBuZWVkIHRvIGZvcndhcmQNCj4gPiA+ID4gPiA+ID4gdGhpcyB0byBo
YXJkd2FyZSwgQW5kIG5vdyBJIGFtIGhhY2tpbmcgdG8gY29tbWVudCB0aGlzIGNoZWNrLg0KPiA+
ID4gPiA+ID4gPiBBbnkgc3VnZ2VzdGlvbnM/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQXJl
IHlvdSB1c2luZyBQQ0kgU1JJT1YgYW5kIHN0YWxsIHRvZ2V0aGVyPw0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gT25seSB1c2Ugc21tdXYzIHN0YWxsIGZlYXR1cmUuDQo+IFNvcnJ5LCB0aGlzIGlzIG5v
dCBjb3JyZWN0DQo+IA0KPiA+ID4gPg0KPiA+ID4gPiBUaGVuIGlzbid0IHRvX3BjaV9kZXYoZGV2
KS0+aXNfdmlydGZuID09IGZhbHNlPw0KPiA+ID4gPg0KPiA+ID4gPiBUaGF0IHNob3VsZCBvbmx5
IGJlIHRydWUgd2l0aCBTUklPVg0KPiA+ID4NCj4gPiA+IERvIHlvdSBtZWFuDQo+ID4gPiBpZiAo
ZGV2X2lzX3BjaShkZXYpICYmIHRvX3BjaV9kZXYoZGV2KS0+aXNfdmlydGZuID09IGZhbHNlKQ0K
PiA+ID4gICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgZmluZQ0KPiA+
DQo+ID4gTm8sIEkgbWVhbiBvbiB5b3VyIHRlc3Qgc3lzdGVtIHlvdSBhcmUgbm90IHVzaW5nIFNS
SU9WIHNvIGFsbCB5b3VyIFBDSQ0KPiA+IGRldmljZXMgd2lsbCBoYXZlIGlzX3ZpcnRmbiA9PSBm
YWxzZSBhbmQgdGhlIGFib3ZlIGlmIHNob3VsZG4ndCBiZSBhDQo+ID4gcHJvYmxlbS4gaXNfdmly
dGZuIGluZGljYXRlcyB0aGUgUENJIGRldmljZSBpcyBhIFNSSU9WIFZGLg0KPiA+DQo+ID4gWW91
ciBleHBsYW5hdGlvbiBmb3IgeW91ciBwcm9ibGVtIGRvZXNuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2Us
IG9yIHRoZXJlDQo+ID4gaXMgc29tZXRoaW5nIHdyb25nIHNvbWVwbGFjZSBlbHNlIHRvIGdldCBh
IGJvZ3VzIGlzX3ZpcnRmbi4uDQo+ID4NCj4gPiBJZiB5b3UgYXJlIGRvaW5nIFNSSU9WIHdpdGgg
c3RhbGwsIHRoZW4gdGhhdCBpcyB1bmRlcnN0YW5kYWJsZS4NCj4gDQo+IFllcywgeW91IGFyZSBy
aWdodA0KPiAgSSBhbSB1c2luZyBTUklPViB2ZiBhbmQgc3RhbGwgZmVhdHVyZSwgc28gaXNfdmly
dGZuID09IHRydWUNCj4gDQo+IE91ciBBQ0MgZGV2aWNlcyBhcmUgZmFrZSBwY2kgZW5kcG9pbnQg
ZGV2aWNlcyB3aGljaCBzdXBwb3J0cyBzdGFsbCwgQW5kDQo+IHRoZXkgYWxzbyBzdXBwb3J0cyBz
cmlvdg0KDQpNYXkgYmUgdGhpcyB3aWxsIGhlbHAgdG8gZ2V0IHRoZSBiYWNrZ3JvdW5kOg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2MjYxNDQ4NzYtMTEzNTItMS1naXQtc2VuZC1lbWFp
bC16aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZy8NCg0KU2hhbWVlcg0KDQo=
