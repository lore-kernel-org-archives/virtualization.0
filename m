Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE52C9A
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381024; cv=none; b=MetmDNpi0jabRZsXvDB+Cr32TCwOoUfpqX6bBLEytZHmKI96sOLZFEnXhCZv9k7jYmOcMEh7ua1dLJN38LTtSGA3xeJGIlGRChORhZbHtH2Wb38TSxqpBz4OqT3AhIMCiocbEPn6AgGKCwIG+lXaa2mZNpvGXU4cVW1JZH9RsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381024; c=relaxed/simple;
	bh=V3dpcHs1LrGsJpWnrfG3Fs94hpUjMw/6oDnbxY7nuOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ms03GDq8s8C/yG+zvtkRZlz8LFfq0JWJXR/FSQK18nDOFY9FJhc9pPd7GAw8RuP9dwskAvLXTODQjT6fYq3LLGoNnOnFaqqd7sIHa6Jdq8DHFgrBCsiirESwybD2i70C7CV2S7ht0Y/+bBmRe5gDszEytLgnk3LJEA4B4Dl05oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=eKg5+FRq reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eKg5+FRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=x2BBtukZYvYARBXKGpzJXWGxpnAiVMOyWY2EnivpsjI=; b=e
	Kg5+FRqkSZrMnY9WMYXXwN5x5JLahtaHjU9am+mg4+7SPSdFAAY3nPa+aXvwIgel
	T6WWrMgSpo1R04Ygof5nCJgMDALglHzKYqH6iLPvFh6qqyfCZcTIKlbBoBYhgZ9i
	IdL1kNnKa8wwne0J9w3kq8kYstrKPMXbTC0bq8+DaE=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Fri, 16 May 2025 15:36:25 +0800
 (CST)
Date: Fri, 16 May 2025 15:36:25 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH] virtio_net: Fix duplicated return values in
 virtnet_get_hw_stats
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250515071042.5f668345@kernel.org>
References: <20250514054433.29709-1-lange_tang@163.com>
 <20250515071042.5f668345@kernel.org>
X-NTES-SC: AL_Qu2fBf+Tv0Ej4ySbYekfmUwag+07WcC2u/oh1YZXO5p6jC/r5wcvUXtMPkfm/d+ONRKykReYaSJi28dLcoZKc7AVba7Ab7Lfv7IBjFFquUSCkQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5e642aef.66ba.196d805de6a.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgAX9JX66iZo8CUGAA--.50563W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXQlPLmgmtXXhawAEs1
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA1LTE1IDIyOjEwOjQyLCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5lbC5v
cmc+IHdyb3RlOgo+T24gV2VkLCAxNCBNYXkgMjAyNSAxMzo0NDozMyArMDgwMCBUYW5nIExvbmdq
dW4gd3JvdGU6Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gaW5kZXggZTUzYmE2MDA2MDVhLi5jOWE4NmYzMjU2MTkg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPj4gQEAgLTQ4OTcsNyArNDg5Nyw3IEBAIHN0YXRpYyBpbnQgX192
aXJ0bmV0X2dldF9od19zdGF0cyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPj4gIAkJCQkJJnNn
c19vdXQsICZzZ3NfaW4pOwo+PiAgCj4+ICAJaWYgKCFvaykKPj4gLQkJcmV0dXJuIG9rOwo+PiAr
CQlyZXR1cm4gMTsKPgo+VGhpcyBtYWtlcyBzZW5zZSwgbG9va3MgbGlrZSBhIHR5cG8gaW4gdGhl
IG9yaWdpbmFsIGNvZGUuCj5CdXQgd2UgYXJlIG5vdyByZXR1cm5pbmcgdGhlIHJldmVyc2UgcG9s
YXJpdHkgb2YgIm9rIiwgc28gd2Ugc2hvdWxkCj5wcm9iYWJseSByZW5hbWUgdGhlIHZhcmlhYmxl
IGluIHZpcnRuZXRfZ2V0X2h3X3N0YXRzKCkgb2sgLT4gZmFpbGVkCj5PciBpbnZlcnQgdGhlIHBv
bGFyaXR5IGhlcmUgYW5kIGluIHZpcnRuZXRfZ2V0X2h3X3N0YXRzKCkKPgo+PiAgCWZvciAocCA9
IHJlcGx5OyBwIC0gcmVwbHkgPCByZXNfc2l6ZTsgcCArPSBsZTE2X3RvX2NwdShoZHItPnNpemUp
KSB7Cj4+ICAJCWhkciA9IHA7Cj4+IEBAIC00OTM3LDcgKzQ5MzcsNyBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfZ2V0X2h3X3N0YXRzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+PiAgCWludCBvazsK
Pj4gIAo+PiAgCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0Zf
REVWSUNFX1NUQVRTKSkKPj4gLQkJcmV0dXJuIDA7Cj4+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsK
Pgo+SURLIGFib3V0IHRoaXMgcGFydC4gV2Ugc2hvdWxkIG5vdCBzcGFtIHRoZSBsb2dzIGlmIHRo
ZSBkZXZpY2UgZG9lcyBub3QKPnN1cHBvcnQgYSBmZWF0dXJlLiBXZSBzaG91bGQgaW5zdGVhZCBz
a2lwIHJlcG9ydGluZyB0aGUgcmVsZXZhbnQgc3RhdHMuCj5Vc2VyIGNhbiB0ZWxsIHRoYXQgdGhv
c2Ugc3RhdHMgYXJlIG5vdCBzdXBwb3J0ZWQgZnJvbSB0aGUgZmFjdCB0aGV5IGFyZQo+bm90IHBy
ZXNlbnQuCj4tLSAKCj5wdy1ib3Q6IGNyCgoKSSBmb3VuZCB0aGF0IERhbiBDYXJwZW50ZXIgaGFk
IGRpc2NvdmVyZWQgdGhlIHNhbWUgaXNzdWUgYmVmb3JlLCBhbmQgaGUgaGFkIGFscmVhZHkgc3Vi
bWl0dGVkIGEgcGF0Y2gsIHNvIEknbSBiYWNraW5nIG91dC4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjQwNTE1MTEwNjI2LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy8g
CgoKCnJlZ2FyZHMsClRhbmcgTG9uZ2p1bg==
