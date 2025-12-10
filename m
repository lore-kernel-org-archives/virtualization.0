Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A75242D6C
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381261; cv=none; b=uEr4sTVlOPP4UDpZJw2A6Rqo5OPo8FxboONqivASaR0YOGadbqm4/aT/+jeXgDZ3Q5xLKyzZEVGF5xyqNUc/Y53v7hYbJEN7Huh63g95NSbEQS5rOqd+WXrPw6Qyfn5ItLkTJFblP9FMWg+1CR+FCefVsOe+CL/pNMq1y0qTPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381261; c=relaxed/simple;
	bh=ZS5Vuu6O2eR/+hdrKDjFrlsK58ZpNOvlQzNK6UYNyDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TQ0qqy/Rt908UeVkNW3vbqlfCxXUXYcwaZpoRP7ifaizaO1JNMS7FdKOciJGyG8AVdDwgOf+EegaGiboqBLngxoubVXCMJN+7ms3j256vjEGh1h5v9pVST213LYNX88dXGe86BbpHr8hZKUGlE2lZa6SSLK9tN5HK9JBdfN2cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lp369/1h; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lp369/1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ZS5Vuu6O2eR/+hdrKDjFrlsK58ZpNOvlQzNK6UYNyDw=; b=l
	p369/1hhMjwjwINEpISHwru3wNpoGhIuvA1P0fr4lJjbrEN1VOi1++hEPxaWB+5W
	LGQ9f//YsdqclbEl4jvAYKLcbZ34xZRTXtv3hWwtCJfDFeFropvuFn00IrRWEyKf
	4f5epfTuh2BfPQzZNo4f2ONZBe4G9u6QLnn4Y/GNq0=
Received: from r4o5m6e8o$163.com ( [36.148.182.111] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Wed, 10 Dec 2025 23:40:52 +0800
 (CST)
Date: Wed, 10 Dec 2025 23:40:52 +0800 (CST)
From: r4o5m6e8o  <r4o5m6e8o@163.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Jason Wang" <jasowang@redhat.com>,
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Yuedong Wang" <wyd20130109@163.com>
Subject: Re:Re: [PATCH v2 2/2] tools: virtio: Fix no definition of
 dma_map_page_attrs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251210035947-mutt-send-email-mst@kernel.org>
References: <20251206032318.19084-1-r4o5m6e8o@163.com>
 <20251207142807.10808-1-r4o5m6e8o@163.com>
 <20251210035947-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2dB/+Tvkou5CKYbekfmk0Uh+g8UcG3v/4g3YBXc8wEowLA1w4ueE1TEEr9+sWQLTqHkh2dcB5p1cRWTYl533A/uKUvlsREAknSlrogIg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3a4a9443.b108.19b08ec247c.Coremail.r4o5m6e8o@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:figvCgC338mElDlpRl02AA--.436W
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbC7wTuZGk5lIS36wAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKClllcywgaXQncyBmaXggYWxsIGJ1aWxkIGVycm9ycyBmb3IgdG9vbHMvdmlydGlvLMKgClRo
YW5rcy4KCgoKCgoKCgoKCgpBdCAyMDI1LTEyLTEwIDE2OjAwOjQwLCAiTWljaGFlbCBTLiBUc2ly
a2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+T24gU3VuLCBEZWMgMDcsIDIwMjUgYXQgMTA6
Mjg6MDdQTSArMDgwMCwgWXVmZW5nIFdhbmcgd3JvdGU6Cj4+IEZpeCB0b29scy92aXJ0aW8gY29t
cGlsZXIgZXJyb3IsIHBvcnQgb3ZlciB0aGUgZGVmaW5pdGlvbgo+PiBvZiBkbWFfbWFwX3BhZ2Vf
YXR0cnMsIGRtYV91bm1hcF9wYWdlX2F0dHJzLCBkZXZfV0FSTl9PTkNFCj4+IAo+PiB2MjogcmVt
b3ZlIGRvIHt9IHdoaWxlICgwKS4KPj4gCj4+IEZpeGVzOiA0NDdiZWVjODA2NWIgKCJ2aXJ0aW9f
cmluZzogc3dpdGNoIHRvIHVzZSBkbWFfe21hcHx1bm1hcH1fcGFnZSgpIikKPj4gU2lnbmVkLW9m
Zi1ieTogWXVmZW5nIFdhbmcgPHI0bzVtNmU4b0AxNjMuY29tPgo+PiBUZXN0ZWQtYnk6IFl1ZWRv
bmcgV2FuZyA8d3lkMjAxMzAxMDlAMTYzLmNvbT4KPgo+Q2FuIHlvdSBwbHMgY2hlY2sgd2hldGhl
cgo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE3NjQ4NzM3OTkuZ2l0Lm1zdEBy
ZWRoYXQuY29tLwo+YWRkcmVzc2VzIHRoZSBpc3N1ZXMgZm9yIHlvdT8KPgo+VGhhbmtzIQo+Cj4K
Pj4gLS0tCj4+ICB0b29scy92aXJ0aW8vbGludXgvZG1hLW1hcHBpbmcuaCB8IDMgKysrCj4+ICB0
b29scy92aXJ0aW8vbGludXgva2VybmVsLmggICAgICB8IDEgKwo+PiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vbGludXgv
ZG1hLW1hcHBpbmcuaCBiL3Rvb2xzL3ZpcnRpby9saW51eC9kbWEtbWFwcGluZy5oCj4+IGluZGV4
IDA5NTk1ODQ2MTc4OC4uZGUyNTFhMWYwYzM3IDEwMDY0NAo+PiAtLS0gYS90b29scy92aXJ0aW8v
bGludXgvZG1hLW1hcHBpbmcuaAo+PiArKysgYi90b29scy92aXJ0aW8vbGludXgvZG1hLW1hcHBp
bmcuaAo+PiBAQCAtMjIsNiArMjIsNyBAQCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiB7Cj4+ICAj
ZGVmaW5lIGRtYV9mcmVlX2NvaGVyZW50KGQsIHMsIHAsIGgpIGtmcmVlKHApCj4+ICAKPj4gICNk
ZWZpbmUgZG1hX21hcF9wYWdlKGQsIHAsIG8sIHMsIGRpcikgKHBhZ2VfdG9fcGh5cyhwKSArIChv
KSkKPj4gKyNkZWZpbmUgZG1hX21hcF9wYWdlX2F0dHJzKGQsIHAsIG8sIHMsIGRpciwgYSkgKHBh
Z2VfdG9fcGh5cyhwKSArIChvKSkKPj4gIAo+PiAgI2RlZmluZSBkbWFfbWFwX3NpbmdsZShkLCBw
LCBzLCBkaXIpICh2aXJ0X3RvX3BoeXMocCkpCj4+ICAjZGVmaW5lIGRtYV9tYXBfc2luZ2xlX2F0
dHJzKGQsIHAsIHMsIGRpciwgYSkgKHZpcnRfdG9fcGh5cyhwKSkKPj4gQEAgLTI5LDYgKzMwLDgg
QEAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gewo+PiAgCj4+ICAjZGVmaW5lIGRtYV91bm1hcF9z
aW5nbGUoZCwgYSwgcywgcikgZG8geyAodm9pZCkoZCk7ICh2b2lkKShhKTsgKHZvaWQpKHMpOyAo
dm9pZCkocik7IH0gd2hpbGUgKDApCj4+ICAjZGVmaW5lIGRtYV91bm1hcF9wYWdlKGQsIGEsIHMs
IHIpIGRvIHsgKHZvaWQpKGQpOyAodm9pZCkoYSk7ICh2b2lkKShzKTsgKHZvaWQpKHIpOyB9IHdo
aWxlICgwKQo+PiArI2RlZmluZSBkbWFfdW5tYXBfcGFnZV9hdHRycyhkLCBhLCBzLCByLCB0KSBc
Cj4+ICsJZG8geyAodm9pZCkoZCk7ICh2b2lkKShhKTsgKHZvaWQpKHMpOyAodm9pZCkocik7ICh2
b2lkKSh0KTsgfSB3aGlsZSAoMCkKPj4gIAo+PiAgI2RlZmluZSBzZ19kbWFfYWRkcmVzcyhzZykg
KDApCj4+ICAjZGVmaW5lIHNnX2RtYV9sZW4oc2cpICgwKQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dmlydGlvL2xpbnV4L2tlcm5lbC5oIGIvdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oCj4+IGlu
ZGV4IDY3MDIwMDhmN2Y1Yy4uNDYwZGY5MzdiYTlkIDEwMDY0NAo+PiAtLS0gYS90b29scy92aXJ0
aW8vbGludXgva2VybmVsLmgKPj4gKysrIGIvdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oCj4+
IEBAIC0xMzQsNiArMTM0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICprcmVhbGxvY19hcnJheSh2
b2lkICpwLCBzaXplX3QgbmV3X24sIHNpemVfdCBuZXdfc2l6ZSwgZ2ZwX3QKPj4gICNkZWZpbmUg
ZGV2X2VycihkZXYsIGZvcm1hdCwgLi4uKSBmcHJpbnRmIChzdGRlcnIsIGZvcm1hdCwgIyMgX19W
QV9BUkdTX18pCj4+ICAjZGVmaW5lIGRldl93YXJuKGRldiwgZm9ybWF0LCAuLi4pIGZwcmludGYg
KHN0ZGVyciwgZm9ybWF0LCAjIyBfX1ZBX0FSR1NfXykKPj4gICNkZWZpbmUgZGV2X3dhcm5fb25j
ZShkZXYsIGZvcm1hdCwgLi4uKSBmcHJpbnRmIChzdGRlcnIsIGZvcm1hdCwgIyMgX19WQV9BUkdT
X18pCj4+ICsjZGVmaW5lIGRldl9XQVJOX09OQ0UoZGV2LCBjb25kaXRpb24sIGZvcm1hdCwgLi4u
KSBmcHJpbnRmKHN0ZGVyciwgZm9ybWF0LCAjIyBfX1ZBX0FSR1NfXykKPj4gIAo+PiAgI2RlZmlu
ZSBtaW4oeCwgeSkgKHsJCQkJXAo+PiAgCXR5cGVvZih4KSBfbWluMSA9ICh4KTsJCQlcCj4+IC0t
IAo+PiAyLjQzLjAK
