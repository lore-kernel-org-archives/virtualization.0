Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BC35B654
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578856; cv=none; b=Db87SE/EALe2aSTkts7C8PJR1PTdik8m28A42hxGLapRjc0Th6UL/jpYZxVx41U1SlEmm+Fci2W+2Rxp7CMsC1ICjVjoSwhicAsfd/NGOtuYkTjNyeGvis69J4NnOKnYMnEK/Z5R455eFh6HtvhcLOSGnc9akkr/5Lv2c184w5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578856; c=relaxed/simple;
	bh=fnjNjJ9yuh7ByzQ95azL2OCDKyizvMOVYSsudqusVTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=i6czjFtooWKaiK2Ilp2DUS3tokANZfYL6OlzDH+QHQbP2XGZHE9H8yelQd+6kErLMOz089vt2T1IVkT07iii4jwHRvia58lzDNWr59lbH0GATw/CvuMd0zDIFs6h67oNoBXmM+5i+KLPODHUjy43uYZLmgKVkRJrAuHOtCNuQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DFC1KIve; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DFC1KIve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fnjNjJ9yuh7ByzQ95azL2OCDKyizvMOVYSsudqusVTo=; b=D
	FC1KIveHH3bTeZJptnicyl8oNk7P7weuM/frXa3KXMA4RuawD9pHP7IvqQcVzgMS
	8wPClxVt7R1W+bsrKl1ywL05JWTtqyT4Bo49UTbV9GD5gOsANyoenEhRvi0TBjQg
	YsO4TXcXdmeKC/UwSrO/B0ZEobXAbnXUAui+00/V0g=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Tue, 16 Jun 2026 11:00:29 +0800
 (CST)
Date: Tue, 16 Jun 2026 11:00:29 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"mst@redhat.com" <mst@redhat.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Tang Longjun" <tanglongjun@kylinos.cn>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep fails
 during busy-poll
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
References: <20260615094550.106391-1-lange_tang@163.com>
 <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
X-NTES-SC: AL_Qu2TA/mct0Ap7yKeYukfmUgRg+c/XsK4svUj24VVOJF8jADp8zofem1pAWnJ7cygKSmInCW7exN/4M1eY7dVcKsyKiriw0J73myiQx3jhAhcfA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gSgvCgDnTz1OvDBqDiIKAA--.16830W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-Q7oF2owvE62AQAA3T
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNi0xNSAxODowMTo0MCwgIlh1YW4gWmh1byIgPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPk9uIE1vbiwgMTUgSnVuIDIwMjYgMTc6NDU6NTAgKzA4MDAsIExvbmdq
dW4gVGFuZyA8bGFuZ2VfdGFuZ0AxNjMuY29tPiB3cm90ZToKPj4gRnJvbTogTG9uZ2p1biBUYW5n
IDx0YW5nbG9uZ2p1bkBreWxpbm9zLmNuPgo+Pgo+PiBXaGVuIGJ1c3ktcG9sbCBpcyBhY3RpdmUs
IG5hcGlfc2NoZWR1bGVfcHJlcCgpIHJldHVybnMgZmFsc2UgaW4KPj4gc2tiX3JlY3ZfZG9uZSgp
LCBzbyB2aXJ0cXVldWVfZGlzYWJsZV9jYigpIGlzIHNraXBwZWQuIFRoZSBkZXZpY2UKPj4gbWF5
IGtlZXAgZmlyaW5nIGlycXMgdW50aWwgdGhlIG5leHQgcG9sbCByb3VuZCByZWFjaGVzCj4+IHZp
cnRxdWV1ZV9uYXBpX2NvbXBsZXRlKCkuIElmIGNiIGlzIGVuYWJsZWQgdW5kZXIgYnVzeS1wb2xs
IGNhc2UsCj4+IGl0IHdpbGwgbGVhZCB0byBhIGxhcmdlIG51bWJlciBvZiBzcHVyaW91cyBpbnRl
cnJ1cHRzLiBFeHBsaWNpdGx5Cj4+IGRpc2FibGUgY2FsbGJhY2tzIGluIHRoaXMgY2FzZSB0byBw
cmV2ZW50IHNwdXJpb3VzIGludGVycnVwdHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExvbmdqdW4g
VGFuZyA8dGFuZ2xvbmdqdW5Aa3lsaW5vcy5jbj4KPj4gLS0tCj4+ICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAyICsrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPj4gaW5kZXggZjRhZGNmZWU3YTgwLi42ZDY3NWZkZGM1OWIgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPj4gQEAgLTcyOCw2ICs3MjgsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfbmFwaV9z
Y2hlZHVsZShzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksCj4+ICAJaWYgKG5hcGlfc2NoZWR1bGVf
cHJlcChuYXBpKSkgewo+PiAgCQl2aXJ0cXVldWVfZGlzYWJsZV9jYih2cSk7Cj4+ICAJCV9fbmFw
aV9zY2hlZHVsZShuYXBpKTsKPj4gKwl9IGVsc2UgaWYgKHRlc3RfYml0KE5BUElfU1RBVEVfSU5f
QlVTWV9QT0xMLCAmbmFwaS0+c3RhdGUpKSB7Cj4+ICsJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHZx
KTsKPgo+SSBzZWUsIGJ1dCB3ZSBzaG91bGQgYXZvaWQgY2hlY2tpbmcgTkFQSV9TVEFURV9JTl9C
VVNZX1BPTEwgZGlyZWN0bHkgaW4gdGhlCj5kcml2ZXJzLiBUaGUgTklDIGRyaXZlciBzaG91bGQg
cmVtYWluIGFnbm9zdGljIHRvIGJ1c3kgcG9sbGluZy4gSSB0aGluayB3ZSBuZWVkCj5hIGJldHRl
ciB3YXksIG1heWJlIHdlIHNob3VsZCByZXdyaXRlIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlIGlu
c3RlYWQuCgpIb3cgYWJvdXQgcmV3cml0ZSBpdCBsaWtlIHRoaXM/CnN0YXRpYyB2b2lkIHZpcnRx
dWV1ZV9uYXBpX3NjaGVkdWxlKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEpCnsgICAgICAgCiAg
ICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2IodnEpOwogICAgICAgIGlmIChuYXBpX3NjaGVkdWxl
X3ByZXAobmFwaSkpCiAgICAgICAgICAgICAgICBfX25hcGlfc2NoZWR1bGUobmFwaSk7Cn0KQW55
IGNvbW1lbnRzIGFyZSB3ZWxjb21lLgo+Cj5UaGFua3MuCj4KPj4gIAl9Cj4+ICB9Cj4+Cj4+IC0t
Cj4+IDIuMjUuMQo+Pgo=
