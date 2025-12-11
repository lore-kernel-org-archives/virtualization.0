Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B97260F
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765421525; cv=none; b=toO7g7qQHI0fLg489VLenLlQ6odle5dJlkZTYrJqKsbiCvFQv28fNEnmBvGPriZB/c2VF6aaCBCJfX1/sI2Z7vhxxPpuMMXLDYwIxtZin49Mdn0R5c+LUnv2FwXE6EmWXllvJAf0E6yyWuwtiVTvELp8FlgPSX1nLbI/U+MmzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765421525; c=relaxed/simple;
	bh=hnWOGNTKB7vJUjTdz5FKWuEA7PL7GnHWO1BOwxI2y4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=X2jAaqL5P56VRt6R2zJPQChy+UO5fJ/P1t7CSn8HYaWSDrnyv3UHB4gC5GEHxXC4Fon8nD2vUdq/XeTcgNTtZ/u61taZ+eG7GZMXDtMDNNs4O/SZMHJi5RdIMrEy/r3mV5Au7zDL6/kfdAuv94nLdGsYyV1dZbIAn/5kedngyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a+o7w9Dy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a+o7w9Dy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hnWOGNTKB7vJUjTdz5FKWuEA7PL7GnHWO1BOwxI2y4Q=; b=a
	+o7w9DyoxJTU7mz9GcU1YwkhK1N0un8+6ZY6KlOos0SdHMxpSTYsF8wMHEn+DdYu
	fdl+TpKdVIN6PsHayKc5lzdOsDdrQ+Av1FAn3UdKmr7/mbyfLjJOopacmfFy7ffm
	tkBBcyjJcCaQnvbPzaV4LFcpvaKRAX10Ao4mhat2Ys=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Thu, 11 Dec 2025 10:51:37 +0800
 (CST)
Date: Thu, 11 Dec 2025 10:51:37 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"Tang Longjun" <tanglongjun@kylinos.cn>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re:Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251210040328-mutt-send-email-mst@kernel.org>
References: <20251127032407.33475-1-lange_tang@163.com>
 <20251210040328-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2dB/iZvkwi4SeRZ+kfmUgRg+c/XsK4svUj24VVOJF8jCzp8SogZ39yMHHQ08i/OyyMsSa4VxVX89xUWaNxWp45KmllYI98dfC8FD0H1FwDKQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3X4+6MTpp3FE2AA--.814W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hpjkWk6MboIIwAA3l
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0xMi0xMCAxNzowNDowNCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPk9uIFRodSwgTm92IDI3LCAyMDI1IGF0IDExOjI0OjAwQU0gKzA4MDAsIExv
bmdqdW4gVGFuZyB3cm90ZToKPj4gRnJvbTogVGFuZyBMb25nanVuIDx0YW5nbG9uZ2p1bkBreWxp
bm9zLmNuPgo+PiAKPj4gaGksCj4+IHZpcnRuZXRfbW9uIGlzIHVzZWQgdG8gbW9uaXRvciB0aGUg
ZGF0YSBwYWNrZXRzIG9mIHRoZSB2aXJ0aW9fbmV0IGRyaXZlciAKPj4gYW5kIHRoZSByZWxhdGVk
IHBhcmFtZXRlcnMgb2YgdmlydHF1ZXVlLCB1c2VmdWwgZm9yIHRyYWNraW5nIGl0cyBzdGF0dXMg
Cj4+IGFuZCB0cm91Ymxlc2hvb3RpbmcgZmF1bHRzLgo+PiAKPj4gcGxzIHJldmlldy4gdGtzCj4+
IAo+PiBCZXN0IHJlZ2FyZC4KPgo+d2hhdCBkb2VzIHRoaXMgYWNoaWV2ZSB0aGF0IGRpcmVjdCB1
c2Ugb2YgdHJhY2luZyB3b3VsZCBub3Q/CgpJIGFwb2xvZ2l6ZSB0aGF0IG15IGV4cGxhbmF0aW9u
IG9mIHZpcnRuZXRfbW9uIHdhcyBub3QgZGV0YWlsZWQgZW5vdWdoLiAKdmlydG5ldF9tb24gdXNl
cyBrcHJvYmUgYW5kIGJ1ZmZlcnMgdG8gbW9uaXRvciB2aXJ0aW9fbmV0LiAKVG8gbW9uaXRvciB2
aXJ0aW9fbmV0LCBpdCBpcyBuZWNlc3NhcnkgdG8gdHJhY2sgdGhlIG1lbWJlciBwYXJhbWV0ZXJz
IG9mIHRoZSB2aXJ0cXVldWUgY29ycmVzcG9uZGluZyB0byBlYWNoIGRhdGEgcGFja2V0IGFuZCBv
dXRwdXQgdGhlbS4gCldoZW4gUFBTIHZlcnkgaGlnaCwgb3RoZXIgdHJhY2luZyB0ZWNobmlxdWVz
LCBzdWNoIGFzIGVicGYsIG1heSBub3QgYmUgYWJsZSB0byBoYW5kbGUgaXQsIHJlc3VsdGluZyBp
biBkYXRhIGxvc3MgYmVjYXVzZSB0aGV5IGRvIG5vdCBoYXZlIHN1ZmZpY2llbnRseSBsYXJnZSBi
dWZmZXJzIHRvIGJhdGNoIGV4cG9ydCBsb2cgZGF0YS4KCkFzIGZvciB0aGUgZHVwbGljYXRlIGNv
ZGUsIGl0IGlzIG9ubHkgdG8gb2J0YWluIHRoZSBsYXlvdXQgb2YgdGhlIHJlbGV2YW50IHN0cnVj
dHVyZSwgYW5kIEkgaGF2ZSBub3QgeWV0IHRob3VnaHQgb2YgYSB3YXkgdG8gYXZvaWQgZHVwbGlj
YXRpb24uIEkgd291bGQgbG92ZSB0byBoZWFyIHlvdXIgc3VnZ2VzdGlvbnMuCgo+Cj4+IFRhbmcg
TG9uZ2p1biAoNyk6Cj4+ICAgdG9vbHMvdmlydGlvL3ZpcnRuZXRfbW9uOiBjcmVhdGUgbWlzYyBk
cml2ZXIgZm9yIHZpcnRuZXRfbW9uCj4+ICAgdG9vbHMvdmlydGlvL3ZpcnRuZXRfbW9uOiBhZGQg
a2ZpZm8gdG8gdmlydG5ldF9tb24KPj4gICB0b29scy92aXJ0aW8vdmlydG5ldF9tb246IGFkZCBr
cHJvYmUgc3RhcnRfeG1pdAo+PiAgIHRvb2xzL3ZpcnRpby92aXJ0bmV0X21vbjogYWRkIGtwcm9i
ZSBncm9fcmVjZWl2ZV9za2IKPj4gICB0b29scy92aXJ0aW8vdmlydG5ldF9tb246IGFkZCBrcHJv
YmUgaXBfbG9jYWxfZGVsaXZlcgo+PiAgIHRvb2xzL3ZpcnRpby92aXJ0bmV0X21vbjogYWRkIGtw
cm9iZSBza2JfeG1pdF9kb25lIGFuZCBza2JfcmVjdl9kb25lCj4+ICAgdG9vbHMvdmlydGlvL3Zp
cnRuZXRfbW9uOiBhZGQgUkVBRE1FIGZpbGUgZm9yIHZpcnRuZXRfbW9pbgo+PiAKPj4gIHRvb2xz
L3ZpcnRpby92aXJ0bmV0X21vbi9NYWtlZmlsZSAgICAgIHwgICAxMCArCj4+ICB0b29scy92aXJ0
aW8vdmlydG5ldF9tb24vUkVBRE1FICAgICAgICB8ICAgMzUgKwo+PiAgdG9vbHMvdmlydGlvL3Zp
cnRuZXRfbW9uL3ZpcnRuZXRfbW9uLmMgfCAxMDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKwo+
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMDkzIGluc2VydGlvbnMoKykKPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy92aXJ0aW8vdmlydG5ldF9tb24vTWFrZWZpbGUKPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy92aXJ0aW8vdmlydG5ldF9tb24vUkVBRE1FCj4+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgdG9vbHMvdmlydGlvL3ZpcnRuZXRfbW9uL3ZpcnRuZXRfbW9uLmMKPj4gCj4+IC0tIAo+PiAy
LjQzLjAK
