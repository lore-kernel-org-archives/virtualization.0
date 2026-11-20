Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158818;
	b=ml4ejawxIJ2AraCWEU9oB9jdVnkeeMpZy+8fR9eUVzLjGss2A8lhrCqn3MttGR3w3unH
	 x9uO44MnchTkhWEwv05PlP7Ny86GPXNRJP4F+T2J4V1wCM5HG9FhjDv7M8T3Ivl77/nkD
	 FvHtRy9hG67rTlN8DnDVQU2oOkAhe92EhuM5aZRD3tBbh8g1+eJj/wD2PDOKF4k+8C8vD
	 gqB313kdwc9Fqp89499Yzc8W/dTmMBTeTCdyMtWtP1d7SZwVKyRNKQSnFJFtS86Ralfs8
	 o+Tn++MOitq1kc5LjIl6b9yNwmJdFbaKJJBuWW0l7+UnngopJ5AYaTYwL/NsJRiQxQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158818;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=bEA86BmeuaVIl/WuC196ZahnWqjhESSU5lFaK7N0pcY=;
	b=NDwcAn/NTC89+5TFFlRpjZifPgY9YBcokwpdAVlXB81rvr9iALYxc9M2gvhWM4I5sDnJ
	 zjEnd5Uv9z7v83Zzx7kafarEPTmpaTmIBFOwPOqVhryczlAsj2QbxsT8mzpF1qBl45IlR
	 fr9gqm/b748a8Szz/zprf5gxzhiU/qoWEQhGE1C9OH4Ih1eDQR3J4XOxnv4RviBRF0vtd
	 qg9vMTQ2GUohdyKWwTTeJlhyDZvwgRkhOWwafQcJRqGhZpwdpYsG9Uj0mtjCjGAB6QGNA
	 kTI3/M5T1XVK5xobBONHHRnvnB2eccHOVuIDoeH/uIJysGfhCuqb5unS3LUBcAt2SZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UNblf+6w;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93D606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A93D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UNblf+6w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bEA86BmeuaVIl/WuC196ZahnWqjhESSU5lFaK7N0pcY=; b=U
	Nblf+6w0WzYFxY6o8Npm4UFIFHiBs8WZgaRhoefW3ilZu/HM8cBRdnMPBWTLggkz
	TlPAr+21AFkabbHjuOWFDzNox/EXcjBfWIUCEuUmnkWGRAzL490GzeQ1nm6h+Ic3
	3rHOiVDjoKZoLjQMxdakYfUBrNxRUxMsEHqmNG9eIM=
Date: Fri, 20 Nov 2026 15:13:23 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
	"Eugenio Perez" <eperezma@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261112174936-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-2-lange_tang@163.com>
 <20261112174936-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2SB/2et0Ar5SGfZukfmUgRg+c/XsK4svUj24VVOJF8jCDp+SEJYHZTFGvuwfi3ASqsmSO8ahFRxdZ2WohybrgljfmB9rd7tqyaLw/zu0Gkkg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <62c513b2.5a25.1a1f7cd82ec.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3_8gT8_9qo31yAA--.319W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-RObyWr-8xNxiwAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMS0xMyAwNjo1MDozMywgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPk9uIE1vbiwgTm92IDA5LCAyMDI2IGF0IDA1OjQzOjA4UE0gKzA4MDAsIExv
bmdqdW4gVGFuZyB3cm90ZToKPj4gRnJvbTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBreWxp
bm9zLmNuPgo+PiAKPj4gRXhwb3J0IGEgcmVhZC1vbmx5IGFjY2Vzc29yIGZvciB0aGUgbGFzdCBj
b25zdW1lZCB1c2VkIHJpbmcgaW5kZXguCj4+IEl0J3MgdXNlZnVsIGZvciBkcml2ZXJzIHRoYXQg
bmVlZCB0byBkZXRlY3Qgd2hldGhlciB0aGUgZGV2aWNlIGhhcwo+PiBwcm9kdWNlZCBidWZmZXJz
IHRoYXQgaGF2ZSBub3QgYmVlbiBjb25zdW1lZCB5ZXQsIGJ5IHBhc3NpbmcgdGhlCj4+IHJldHVy
bmVkIHZhbHVlIHRvIHZpcnRxdWV1ZV9wb2xsKCkuCj4+IAo+PiBUaGUgc3BsaXQgcmluZyBub3cg
d3JpdGVzIHRoZSBmaWVsZCB3aXRoIFdSSVRFX09OQ0UoKSAodGhlIHBhY2tlZAo+PiByaW5nIGFs
cmVhZHkgZGlkKSB0byBkb2N1bWVudCB0aGF0IHRoZSBuZXcgcmVhZGVyIGNhbiBydW4gY29uY3Vy
cmVudGx5Cj4+IHdpdGggdGhlIHBvbGwgcGF0aC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExvbmdq
dW4gVGFuZyA8dGFuZ2xvbmdqdW5Aa3lsaW5vcy5jbj4KPgo+VGhpcyBpcyBub3QgYSBnb29kIEFQ
SSwgcGFja2VkIHJpbmcgZG9lcyBub3QgaGF2ZSBhIHVzZWQgcmluZyBhdCBhbGwuCgpSaWdodCwg
cGFja2VkIGhhcyBubyB1c2VkIHJpbmcuIEJ1dCBsYXN0X3VzZWRfaWR4IGlzIG1haW50YWluZWQg
Zm9yIGJvdGggc3BsaXQgYW5kIHBhY2tlZApyaW5ncyBhbmQgY2FuIGJlIHVzZWQgdG8gZ2V0IHRo
ZSBwb3NpdGlvbiB0aGUgZHJpdmVyIGxhc3QgY29uc3VtZWQuCj4KPj4gLS0tCj4+ICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTggKysrKysrKysrKysrKysrKy0tCj4+ICBpbmNsdWRl
L2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBpbmRl
eCBkYjY3OGY1YTgwZTAuLjZkODQ4NWM3Mzg4MSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+
IEBAIC0xMDAxLDcgKzEwMDEsNyBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4
X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+PiAgCS8qIGRldGFjaF9idWZfc3Bs
aXQgY2xlYXJzIGRhdGEsIHNvIGdyYWIgaXQgbm93LiAqLwo+PiAgCXJldCA9IHZxLT5zcGxpdC5k
ZXNjX3N0YXRlW2ldLmRhdGE7Cj4+ICAJZGV0YWNoX2J1Zl9zcGxpdCh2cSwgaSwgY3R4KTsKPj4g
LQl2cS0+bGFzdF91c2VkX2lkeCsrOwo+PiArCVdSSVRFX09OQ0UodnEtPmxhc3RfdXNlZF9pZHgs
IHZxLT5sYXN0X3VzZWRfaWR4ICsgMSk7Cj4+ICAJLyogSWYgd2UgZXhwZWN0IGFuIGludGVycnVw
dCBmb3IgdGhlIG5leHQgZW50cnksIHRlbGwgaG9zdAo+PiAgCSAqIGJ5IHdyaXRpbmcgZXZlbnQg
aW5kZXggYW5kIGZsdXNoIG91dCB0aGUgd3JpdGUgYmVmb3JlCj4+ICAJICogdGhlIHJlYWQgaW4g
dGhlIG5leHQgZ2V0X2J1ZiBjYWxsLiAqLwo+PiBAQCAtMTA2OCw3ICsxMDY4LDcgQEAgc3RhdGlj
IHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdF9pbl9vcmRlcihzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlICp2cSwKPj4gIAlyZXQgPSB2cS0+c3BsaXQuZGVzY19zdGF0ZVtsYXN0X3VzZWRd
LmRhdGE7Cj4+ICAJZGV0YWNoX2J1Zl9zcGxpdF9pbl9vcmRlcih2cSwgbGFzdF91c2VkLCBjdHgp
Owo+PiAgCj4+IC0JdnEtPmxhc3RfdXNlZF9pZHgrKzsKPj4gKwlXUklURV9PTkNFKHZxLT5sYXN0
X3VzZWRfaWR4LCB2cS0+bGFzdF91c2VkX2lkeCArIDEpOwo+PiAgCXZxLT5sYXN0X3VzZWQgKz0g
KHZxLT52cS5udW1fZnJlZSAtIG51bV9mcmVlKTsKPj4gIAkvKiBJZiB3ZSBleHBlY3QgYW4gaW50
ZXJydXB0IGZvciB0aGUgbmV4dCBlbnRyeSwgdGVsbCBob3N0Cj4+ICAJICogYnkgd3JpdGluZyBl
dmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUKPj4gQEAgLTMyMjcsNiAr
MzIyNywyMCBAQCBib29sIHZpcnRxdWV1ZV9wb2xsKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdW5z
aWduZWQgaW50IGxhc3RfdXNlZF9pZHgpCj4+ICB9Cj4+ICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0
cXVldWVfcG9sbCk7Cj4+ICAKPj4gKy8qKgo+PiArICogdmlydHF1ZXVlX2dldF9sYXN0X3VzZWRf
aWR4IC0gZ2V0IHRoZSBsYXN0IGNvbnN1bWVkIHVzZWQgcmluZyBpbmRleAo+PiArICogQF92cTog
dGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPj4gKyAqCj4+ICsgKiBS
ZXR1cm5zIHRoZSBpbmRleCBvZiB0aGUgbW9zdCByZWNlbnRseSBjb25zdW1lZCB1c2VkIGJ1ZmZl
ci4KPj4gKyAqLwo+PiArdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfbGFzdF91c2VkX2lkeChj
b25zdCBzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICt7Cj4+ICsJY29uc3Qgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4gKwo+PiArCXJldHVybiBSRUFEX09OQ0Uo
dnEtPmxhc3RfdXNlZF9pZHgpOwo+PiArfQo+PiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVl
X2dldF9sYXN0X3VzZWRfaWR4KTsKPj4gKwo+PiAgLyoqCj4+ICAgKiB2aXJ0cXVldWVfZW5hYmxl
X2NiIC0gcmVzdGFydCBjYWxsYmFja3MgYWZ0ZXIgZGlzYWJsZV9jYi4KPj4gICAqIEBfdnE6IHRo
ZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3JlIHRhbGtpbmcgYWJvdXQuCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+PiBpbmRleCBm
OTIzZTQyY2ZkMDEuLjFhZWQ0ZDkyMzVjOCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92
aXJ0aW8uaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4+IEBAIC0xMTIsNiArMTEy
LDggQEAgdW5zaWduZWQgdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxKTsKPj4gIAo+PiAgYm9vbCB2aXJ0cXVldWVfcG9sbChzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwgdW5zaWduZWQpOwo+PiAgCj4+ICt1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF9sYXN0X3Vz
ZWRfaWR4KGNvbnN0IHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4gKwo+PiAgYm9vbCB2aXJ0cXVl
dWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+PiAgCj4+ICB2b2lk
ICp2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+PiAt
LSAKPj4gMi41MS4wCg==
