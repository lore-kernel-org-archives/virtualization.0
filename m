Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45343CF1E5
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590092; cv=none; b=lYPmUN/nV7ahXnX82gKeV3mQGv5fvPx6Ql/KQPID8A5lVBNGpohDpEOaETrrkOfuY1VTVFJ5nlUrzYaUznsCv0Mwhum/cswqCzRDilPHOWqRYAXEfua34D0QDkXKVpFsV108faUYZ6zXYQ9gH2Q5FkK26fjVTZh/lnOyK7DJTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590092; c=relaxed/simple;
	bh=pV69cg4BHqxVB8u0ijNx6jOoumjLp4cdYzLrvtNeBjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Lhe1gkxdiQe/fpjeYlVI6omL5gC7r3xpM+FQwy7SRuQgObD+DxRokt/5w0QHgEj5LM+ZwKF8q8QCq7CKCRCreWQF2N4Xt2nKALIGYVnDqYoQD8sqsxFCmff3JXALH+44rjm/g7l9LZr+wXZBFWhq6eEdWlWmGck94LGVgF+tVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JEgw87DZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JEgw87DZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=pV69cg4BHqxVB8u0ijNx6jOoumjLp4cdYzLrvtNeBjc=; b=J
	Egw87DZg1mruyt9qA+IRkvgoRJcNZpTIWfYwgltu8+v3OXCislw5k231HeEKoEWb
	3BWz6UcpdQwRw9X4DKkxbFiHegWKC3A7mn4EOTPlp58GgJoxim1oCNsZui4hDPBI
	hKmL7KWHy512hrCu9Lwiya+7anOjTNuoXu2pQNqFtE=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Tue, 16 Jun 2026 14:07:34 +0800
 (CST)
Date: Tue, 16 Jun 2026 14:07:34 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"mst@redhat.com" <mst@redhat.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Tang Longjun" <tanglongjun@kylinos.cn>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re:Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep
 fails during busy-poll
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
References: <20260615094550.106391-1-lange_tang@163.com>
 <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
 <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
 <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
X-NTES-SC: AL_Qu2TA/mSv0gu4ieRZOkfmUgRg+c/XsK4svUj24VVOJF8jCDp0wsEbXJTDFzy2dyQNzGnlgGUUD1Ww+5AQYpdR7Ms2N3InYDtMYw4PXCano7eOA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <4118686.4d22.19ecf0ad78e.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgDXH8cn6DBqk6MKAA--.17809W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gfpGGow6Cdk6gAA3P
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNi0xNiAxMToyNzoxMiwgIlh1YW4gWmh1byIgPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPk9uIFR1ZSwgMTYgSnVuIDIwMjYgMTE6MDA6MjkgKzA4MDAgKENTVCks
IExhbmdlIFRhbmcgPGxhbmdlX3RhbmdAMTYzLmNvbT4gd3JvdGU6Cj4+IEF0IDIwMjYtMDYtMTUg
MTg6MDE6NDAsICJYdWFuIFpodW8iIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6
Cj4+ID5PbiBNb24sIDE1IEp1biAyMDI2IDE3OjQ1OjUwICswODAwLCBMb25nanVuIFRhbmcgPGxh
bmdlX3RhbmdAMTYzLmNvbT4gd3JvdGU6Cj4+ID4+IEZyb206IExvbmdqdW4gVGFuZyA8dGFuZ2xv
bmdqdW5Aa3lsaW5vcy5jbj4KPj4gPj4KPj4gPj4gV2hlbiBidXN5LXBvbGwgaXMgYWN0aXZlLCBu
YXBpX3NjaGVkdWxlX3ByZXAoKSByZXR1cm5zIGZhbHNlIGluCj4+ID4+IHNrYl9yZWN2X2RvbmUo
KSwgc28gdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBpcyBza2lwcGVkLiBUaGUgZGV2aWNlCj4+ID4+
IG1heSBrZWVwIGZpcmluZyBpcnFzIHVudGlsIHRoZSBuZXh0IHBvbGwgcm91bmQgcmVhY2hlcwo+
PiA+PiB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpLiBJZiBjYiBpcyBlbmFibGVkIHVuZGVyIGJ1
c3ktcG9sbCBjYXNlLAo+PiA+PiBpdCB3aWxsIGxlYWQgdG8gYSBsYXJnZSBudW1iZXIgb2Ygc3B1
cmlvdXMgaW50ZXJydXB0cy4gRXhwbGljaXRseQo+PiA+PiBkaXNhYmxlIGNhbGxiYWNrcyBpbiB0
aGlzIGNhc2UgdG8gcHJldmVudCBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+PiA+Pgo+PiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBMb25nanVuIFRhbmcgPHRhbmdsb25nanVuQGt5bGlub3MuY24+Cj4+ID4+IC0t
LQo+PiA+PiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArKwo+PiA+PiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+PiA+Pgo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ID4+IGluZGV4IGY0
YWRjZmVlN2E4MC4uNmQ2NzVmZGRjNTliIDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPj4gPj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ID4+IEBA
IC03MjgsNiArNzI4LDggQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfc2NoZWR1bGUoc3Ry
dWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+PiA+PiAgCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAobmFw
aSkpIHsKPj4gPj4gIAkJdmlydHF1ZXVlX2Rpc2FibGVfY2IodnEpOwo+PiA+PiAgCQlfX25hcGlf
c2NoZWR1bGUobmFwaSk7Cj4+ID4+ICsJfSBlbHNlIGlmICh0ZXN0X2JpdChOQVBJX1NUQVRFX0lO
X0JVU1lfUE9MTCwgJm5hcGktPnN0YXRlKSkgewo+PiA+PiArCQl2aXJ0cXVldWVfZGlzYWJsZV9j
Yih2cSk7Cj4+ID4KPj4gPkkgc2VlLCBidXQgd2Ugc2hvdWxkIGF2b2lkIGNoZWNraW5nIE5BUElf
U1RBVEVfSU5fQlVTWV9QT0xMIGRpcmVjdGx5IGluIHRoZQo+PiA+ZHJpdmVycy4gVGhlIE5JQyBk
cml2ZXIgc2hvdWxkIHJlbWFpbiBhZ25vc3RpYyB0byBidXN5IHBvbGxpbmcuIEkgdGhpbmsgd2Ug
bmVlZAo+PiA+YSBiZXR0ZXIgd2F5LCBtYXliZSB3ZSBzaG91bGQgcmV3cml0ZSB2aXJ0cXVldWVf
bmFwaV9zY2hlZHVsZSBpbnN0ZWFkLgo+Pgo+PiBIb3cgYWJvdXQgcmV3cml0ZSBpdCBsaWtlIHRo
aXM/Cj4+IHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKHN0cnVjdCBuYXBpX3N0
cnVjdCAqbmFwaSwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZpcnRxdWV1ZSAqdnEpCj4+IHsKPj4gICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYih2cSk7
Cj4+ICAgICAgICAgaWYgKG5hcGlfc2NoZWR1bGVfcHJlcChuYXBpKSkKPj4gICAgICAgICAgICAg
ICAgIF9fbmFwaV9zY2hlZHVsZShuYXBpKTsKPj4gfQo+PiBBbnkgY29tbWVudHMgYXJlIHdlbGNv
bWUuCj4KPgo+QW5vdGhlciBDUFUgY291bGQgYmUgcnVubmluZyBOQVBJIGFuZCBoYXMganVzdCBl
bmFibGVkIHRoZSBjYWxsYmFja3MgKGNiKS4KPk1lYW53aGlsZSwgdGhpcyBzaWRlIHVuY29uZGl0
aW9uYWxseSBkaXNhYmxlcyB0aGUgY2IuIFNpbmNlIE5BUEkgb24gdGhlIG90aGVyCj5DUFUgaGFz
bid0IGV4aXRlZCB5ZXQsIHRoZSBzdWJzZXF1ZW50IHByZXAgb24gdGhpcyBzaWRlIGZhaWxzLCBs
ZWF2aW5nIG5vIG9uZSB0bwo+cmUtZW5hYmxlIHRoZSBjYi4KPgo+VGhhbmtzLgoKUmVnYXJkaW5n
IHRoZSBjYXNlIHlvdSBkZXNjcmliZWQsIHdoZW4gTkFQSSBvbiBhbm90aGVyIENQVSBleGl0cywg
dGhlIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlIGZ1bmMKd2lsbCBiZSBleGVjdXRlZCB0byByZS1l
bmFibGUgY2IuICBhbmQgaWYgdGhlcmUgaXMgc3RpbGwgdW5jb25zdW1lZCBkYXRhIGluIHRoZSB2
aXJ0cXVldWUsIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlCndpbGwgYmUgY2FsbGVkIGFnYWluIHRv
IHNjaGVkdWxlIE5BUEkuCgpJbiBzdW1tYXJ5LCBJIHRoaW5rIHRoYXQgdGhlIGRpc2FibGVfY2Ig
YW5kIF9fbmFwaV9zY2hlZHVsZSB3aXRoaW4gdGhlIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlIGZ1
bmMgZG8gbm90IG5lZWQgdG8gYmUgYm91bmQgdG9nZXRoZXIuCgpBbnkgY29tbWVudHMgYXJlIHdl
bGNvbWUuIFRoaW5rcy4KCj4KPgo+PiA+Cj4+ID4KPj4gPj4gIAl9Cj4+ID4+ICB9Cj4+ID4+Cj4+
ID4+IC0tCj4+ID4+IDIuMjUuMQo+PiA+Pgo+Pgo=
