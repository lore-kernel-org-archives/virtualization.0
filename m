Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839672622
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350957; cv=none; b=a/2nvd4U5Kp1CBkHSpzKktKyVuCKTaG7WtVDtTPgRzIvLiKmsDYPEPuVQwiQkznHRC67WRD9eyUYvPqExFnAGC3zvMjuw7kvQQwUxfJz++Os5DiEnGg/d+tUbon59kBejxqBHE5osiwGKsM8qmBATcKNJexxU4/HHZrdyuwhAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350957; c=relaxed/simple;
	bh=UqZwpZ26Eb5HYrrXHU4/HDB7pkosw+GCzJ4X6GzSJCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VZdr7tQjkIIhW2SlMxVo+MzawlO1UNRTtmnlB5BQ8cY+EZvHAjWDzmJzm9CludzsNSPIUJhe44NgU9/o6zgnFqcK+3ZKVODejFTS9VAm58qEuElp4aRKNp40eXywJG3UQIB6su4gLlIDbakQVzZ0r5D869eStPB0aGyXpCy2pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U+6Z1LOK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U+6Z1LOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=UqZwpZ26Eb5HYrrXHU4/HDB7pkosw+GCzJ4X6GzSJCM=; b=U
	+6Z1LOK/Hhhfgmia72QA9dGhFX+9r62oZxMhOgBzq5x3B+1PPwtH97cD1tt0mOhd
	WXaYu40bLc339QScpqOKlH2Ybm//sf4MX7qhWP1NnbiTqGdexHW9t3pdiwgJFG9n
	mEMhM+lItoOMPLYdZGHAPCzltCB9frsMuKWzQawICQ=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Thu, 25 Jun 2026 09:28:59 +0800
 (CST)
Date: Thu, 25 Jun 2026 09:28:59 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH v3] virtio_net: disable cb when NAPI is busy-polled
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260624030656-mutt-send-email-mst@kernel.org>
References: <20260624070206.85467-1-lange_tang@163.com>
 <20260624030656-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2TAP+ev0Eo7yifYukcn08QhOo9Wsu0v/0u1YRQc80EszHAxCE5YXhfA3Tk0s+tCT2UrRepTj1XzMZ2WapSzWbwq86oiN1BRV8zbLbn3w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <60045f90.11cf.19efc6506ed.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fSgvCgDnBz1chDxqLR8QAA--.344W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RzhEGo8hFwQlwAA3F
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNi0yNCAxNTowODoyNCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPk9uIFdlZCwgSnVuIDI0LCAyMDI2IGF0IDAzOjAyOjA2UE0gKzA4MDAsIExv
bmdqdW4gVGFuZyB3cm90ZToKPj4gRnJvbTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBreWxp
bm9zLmNuPgo+PiAKPj4gV2hlbiBidXN5LXBvbGwgaXMgYWN0aXZlLCBuYXBpX3NjaGVkdWxlX3By
ZXAoKSByZXR1cm5zIGZhbHNlIGluCj4+IHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKCksIHNvIHZp
cnRxdWV1ZV9kaXNhYmxlX2NiKCkgaXMgc2tpcHBlZC4KPj4gVGhlIGRldmljZSBtYXkga2VlcCBm
aXJpbmcgaXJxcyB1bnRpbCByZWFjaGVzIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKCkuCj4+IFVu
ZGVyIGxvYWQgKHJlY2VpdmVkID09IGJ1ZGdldCksIGl0IHdpbGwgbGVhZCB0byBhIGxhcmdlIG51
bWJlcgo+PiBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+PiAKPj4gRml4IGl0IGJ5IGRpc2FibGlu
ZyB0aGUgY2FsbGJhY2sgYXQgdGhlIHZpcnRuZXRfcG9sbCgpIGVudHJ5LiBUaGlzIGtlZXBzCj4+
IHRoZSBjYWxsYmFjayBvZmYgd2hpbGUgd2UgcG9sbCBhbmQgcmUtZW5hYmxlCj4KPmFuZCBpdCBp
cyByZS1lbmFibGVkCj4KPj4gYnkgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoKQo+PiB3aGVuIGdv
aW5nIGlkbGUuCj4+IAo+PiBGaXhlczogY2VlZjQzOGQ2MTNmICgidmlydGlvX25ldDogcmVtb3Zl
IGN1c3RvbSBidXN5X3BvbGwiKQo+PiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBr
eWxpbm9zLmNuPgo+PiAKPj4gLS0tCj4+IFYxIC0+IFYyOiBSZW1haW4gYWdub3N0aWMgdG8gYnVz
eSBwb2xsaW5nCj4+IFYyIC0+IFYzOiBBZGQgZml4ZXMgdGFnCj4+IC0tLQo+PiAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgNSArKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+PiBpbmRleCBmNGFkY2ZlZTdhODAuLjBhMTFmMmIzMjUwMCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+PiBAQCAtMzAwOCw2ICszMDA4LDExIEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPj4gIAl1bnNp
Z25lZCBpbnQgeGRwX3htaXQgPSAwOwo+PiAgCWJvb2wgbmFwaV9jb21wbGV0ZTsKPj4gIAo+PiAr
CS8qIEtlZXAgY2FsbGJhY2tzIHN1cHByZXNzZWQgZm9yIHRoZSBkdXJhdGlvbiBvZiB0aGlzIHBv
bGwsCj4+ICsJICogYnVzeS1wb2xsIG5lZWQuCj4KPkkgZG9uJ3Qga25vdyB3aGF0ICJidXN5LXBv
bGwgbmVlZCIgbWVhbnMuIEp1c3QgZHJvcCB0aGlzIHBhcnQ/Cj5JbiBmYWN0LCB0aGUgd2hvbGUg
Y29tbWVudCBjYW4gZ28sIHdlIGtub3cgdmlydHF1ZXVlX2Rpc2FibGVfY2IKPmRpc2FibGVzIGNh
bGxiYWNrcy4KClRoYW5rcyBmb3IgeW91ciByZXBseS4gIEkgZ290IGl0LCBzZWUgeW91IG5leHQg
dmVyc2lvbi4KPgo+PiArCSAqLwo+PiArCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHJxLT52cSk7Cj4+
ICsKPj4gIAl2aXJ0bmV0X3BvbGxfY2xlYW50eChycSwgYnVkZ2V0KTsKPj4gIAo+PiAgCXJlY2Vp
dmVkID0gdmlydG5ldF9yZWNlaXZlKHJxLCBidWRnZXQsICZ4ZHBfeG1pdCk7Cj4+IC0tIAo+PiAy
LjQzLjAK
