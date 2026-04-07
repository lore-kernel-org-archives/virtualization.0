Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286752701BB
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545344; cv=none; b=cpJTQQvJW2uRZV8gE0sRxUZ5lKs7n6A33Vik6RY9Irxz3gSVTIxIQJlvjxgWp9EuH7nVroDXGT5IG/8XTkmilSuZDxURVDRNU3pSAbN6gFXDxOAIZYSTVh7unE4yz5zCZmhPa4cmQh1reitRJpPdyA1T+r21JknaDCVeosAyPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545344; c=relaxed/simple;
	bh=CZSuwVT3quAegd0Fzr/nxFubgptyko3vaKpnuLeW/5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=b8qoo3NXbYu8cgFuIHmfUPJyhRNvsss5m2uLljnayWSzwRDAZaUSJHzTz0dULhd4zdzwo0r6c9f0HdFzf8KPw4/VeJGhm/lZKH1K8wZZkKrl056CzTTCsvfzjRlsvVbHGRbKDJ6HXaJcqtf9mhj7/LDEtSrzTyFmKYXzCdBGgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dEDnv/ic; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dEDnv/ic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CZSuwVT3quAegd0Fzr/nxFubgptyko3vaKpnuLeW/5U=; b=d
	EDnv/icqgLjbz/KRq63CCaZXvjVqywJXRpH9MUmoHnifBSyob7x/4VuA5QjrmXNM
	3tbARMYMNr8GPKN0zqu5Pxg05/xVrQf6j3U2sLpK3jPomxd0GvePLVV95CCyQsXg
	cpyvz6dDdoT1G+h1JTcAAOQ3lg1q9vOZy+e6N0DUKw=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Tue, 7 Apr 2026 15:02:02 +0800 (CST)
Date: Tue, 7 Apr 2026 15:02:02 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"Tang Longjun" <tanglongjun@kylinos.cn>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re:Re: [PATCH 1/2] virtio_net: disable cb when in busy-polling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CACGkMEtakF0EUYT11N=aNjphY_Ra4YsRaJZmJ4UD0VL5aPxX9g@mail.gmail.com>
References: <20260331102626.108962-1-lange_tang@163.com>
 <20260331102626.108962-2-lange_tang@163.com>
 <CACGkMEtakF0EUYT11N=aNjphY_Ra4YsRaJZmJ4UD0VL5aPxX9g@mail.gmail.com>
X-NTES-SC: AL_Qu2cB/mfuksp5CWfY+kfmUgRg+c/XsK4svUj24VVOJF8jCnr3DI5bV1hEV753sKeJSShrT21WzlsxvtUX6dJbbw3vYoLjZww9fYDQ9EaLQv6+g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <18d16bfe.6bd3.19d66bf8c59.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgD33_Lrq9RpH7uJAA--.3898W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gu04mnUq+tsLQAA3D
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNC0wMyAxMDo1Nzo1OCwgIkphc29uIFdhbmciIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPk9uIFR1ZSwgTWFyIDMxLCAyMDI2IGF0IDY6MjfigK9QTSBMb25nanVuIFRhbmcg
PGxhbmdlX3RhbmdAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEZyb206IExvbmdqdW4gVGFuZyA8dGFu
Z2xvbmdqdW5Aa3lsaW5vcy5jbj4KPj4KPj4gdmlydG5ldF9wb2xsKCkgaXMgc2hhcmVkIGJldHdl
ZW4gTkFQSSBzb2Z0aXJxIGNvbnRleHQgYW5kIHRoZSBidXN5LXBvbGwKPj4gcGF0aCAoc2tfYnVz
eV9sb29wKS4gIEluIHRoZSBidXN5LXBvbGwgcGF0aCB0aGUgY2FsbGVyIGRyaXZlcyB0aGUgbG9v
cAo+PiBkaXJlY3RseSBhbmQgZG9lcyBub3QgcmVseSBvbiBpbnRlcnJ1cHRzIHRvIHNjaGVkdWxl
IE5BUEk7IGtlZXBpbmcKPj4gY2FsbGJhY2tzIGVuYWJsZWQgaXMgd2FzdGVmdWwgYW5kIHJpc2tz
IGEgZmxvb2Qgb2YgSVJRX05PTkUgcmV0dXJucyB0aGF0Cj4+IGNhbiB0cmlnZ2VyIHRoZSBrZXJu
ZWwncyBzcHVyaW91cy1JUlEgZGV0ZWN0b3IuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExvbmdqdW4g
VGFuZyA8dGFuZ2xvbmdqdW5Aa3lsaW5vcy5jbj4KPj4gLS0tCj4+ICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4+IGluZGV4IDcyZDZhOWM2YTVhMi4uZGYzNjVmYmEyYzQwIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+IEBAIC0zMDc4LDYgKzMwNzgsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbChz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4+ICAgICAgICAgdW5zaWduZWQg
aW50IHhkcF94bWl0ID0gMDsKPj4gICAgICAgICBib29sIG5hcGlfY29tcGxldGU7Cj4+Cj4+ICsg
ICAgICAgaWYgKFJFQURfT05DRShuYXBpLT5zdGF0ZSkgJiBOQVBJRl9TVEFURV9JTl9CVVNZX1BP
TEwpCj4+ICsgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihycS0+dnEpOwo+PiAr
Cj4KPkkgZ3Vlc3MgdGhlIHJvb3QgY2F1c2UgaXMgdmlydHVxZXVlX2Rpc2FibGVfY2IoKSBkb2Vz
bid0IGRpc2FibGUgY2IgaW4KPnRoaXMgY2FzZT8KPgo+c3RhdGljIHZvaWQgdmlydHF1ZXVlX25h
cGlfc2NoZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj57Cj4gICAgICAgIGlmIChu
YXBpX3NjaGVkdWxlX3ByZXAobmFwaSkpIHsKPnZpcnRxdWV1ZV9kaXNhYmxlX2NiKHZxKTsKPiAg
ICAgICAgICAgICAgICBfX25hcGlfc2NoZWR1bGUobmFwaSk7Cj4gICAgICAgIH0KPn0KPgo+SWYg
dGhlcmUncyBhbiBpbnRlcnJ1cHQgaW4gdGhlIG1pZGRsZSBvZiBOQVBJRl9TVEFURV9JTl9CVVNZ
X1BPTEwsCj5uYXBpX3NjaGVkdWxlX3ByZXAoKSB3aWxsIHJldHVybiBmYWxzZSwgc28gd2UgbG9z
ZSB0aGUgY2hhbmNlIHRvCj5kaXNhYmxlIGNiLgo+CgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkh
CgpSZWdhcmRpbmcgdGhlIHJvb3QgY2F1c2UgeW91IG1lbnRpb25lZCwgdGhlIGNoYW5jZSB0byBk
aXNhYmxlIGNiIGlzIGluZGVlZCBsb3N0IAp3aGVuIHRoZSBmb2xsb3dpbmcgdGhyZWUgY29uZGl0
aW9ucyBhcmUgbWV0OgoxLiBJbiBOQVBJRl9TVEFURV9JTl9CVVNZX1BPTEwKMi4gSW50ZXJydXB0
IG9jY3VycwozLiBtb3JlX3VzZWQgcmV0dXJucyB0cnVlCgpIb3dldmVyLCBpbiBhbm90aGVyIHNj
ZW5hcmlvOgoxLiBJbiBOQVBJRl9TVEFURV9JTl9CVVNZX1BPTEwKMi4gSW50ZXJydXB0IG9jY3Vy
cwozLiBtb3JlX3VzZWQgcmV0dXJucyBmYWxzZQpJbiB0aGlzIHNlY29uZCBzY2VuYXJpbywgdGhl
cmUgaXMgbm8gY2hhbmNlIHRvIGRpc2FibGUgY2IgZHVyaW5nIHRoZSBleGVjdXRpb24gCm9mIHRo
ZSB2aXJ0bmV0X3BvbGwgdW50aWwgdmlydHF1ZXVlX25hcGlfY29tcGxldGUuCgo+VGhhbmtzCj4K
Pj4gICAgICAgICB2aXJ0bmV0X3BvbGxfY2xlYW50eChycSwgYnVkZ2V0KTsKPj4KPj4gICAgICAg
ICByZWNlaXZlZCA9IHZpcnRuZXRfcmVjZWl2ZShycSwgYnVkZ2V0LCAmeGRwX3htaXQpOwo+PiAt
LQo+PiAyLjQzLjAKPj4K
