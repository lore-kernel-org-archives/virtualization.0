Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105976;
	b=0eLn69xDqJa+Z5kWpIhwzD8bQWEwrihQEmRbD10UyUmrHuf3YbakM2RiTIvkn0d3CEN5
	 eX+H7rf67GPmNroTzSI777XGNiSUOnkEbxbDtEFvqrTTEmmqbISbWkOj8QC2XeQuQ+2S8
	 8GWFaIuaRAHnDJhayMZBrLcguFWfAy9Pxo3lJ+IKPY+rjW+YXg0Tu2cShqxuwr4oUUCTf
	 CMnYy4yzaQatJN083dyrnOF9ep6mKmso9m1Td9AWsxRNhTScBlWUR/UMAFlndfi3QfxhR
	 V7IgLfyb1Hyf1ej/mvg9ewQR8ZFGnRtB9Gl/Jd8zP7r9WwuzX2rB3PwM3C6OwF/cOAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105976;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=hmvVD4jshjGTJPKVKH0iUEryYLKyYDibytdthlFHw3A=;
	b=siUICsFGeXwMKs2lWLBHRFyg1c969itfMVQl0sPwPlrsTTEnJHwURGDZZpokk30PMdQR
	 hIqGpZCbFNMPcrHAXJZEni7c/s7+fJMXXC/lmh9+YbUAtY1RDLyG5V+sAP15lQaclFe2B
	 N7ACeryWjwGAAjF6aGqkOrFSjLyaUilf3z3olkywO+qyqjDpQGq1JWUwgbemlxiuqRDG3
	 wUWYMXiYc2JsZteXTxNlSg6QFC9ArQNOUJ/6zGnxjMYuIWIS/OLbaPbYa5fJNZIHJ6PEj
	 XUkiBlw4hzxuusRZ7UqH0zYy3lSDMLdCl3vZARc7868+AEptiKcsdqK+d+5NzYRLOwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="ydNW5j/o";
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EE60A2602
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 16:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D86EE60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ydNW5j/o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795105966; bh=hmvVD4jshjGTJPKVKH0iUEryYLKyYDibytdthlFHw3A=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=ydNW5j/oJaVyJyCJNBsr04hhxUrWBZlgBEKN0kUs16FtF9Ej6hQayEJKdUeein9Mg
	 wQbjScaHeJUhayHNcDXXFs+4sCKI9Ms8M21pmqAaSuUyYkaX99z/Jtc4sC9LC9gYGm
	 xIbQzvUurFdinaZmUP9oZ+RWEp8BnNTw+V95NF+U=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: McF9JvsryK5JISAGsN0AA0TDtB0RYm29ij4SbvfKO878us4ycgKj+fWwpsOvaB
	 ok7gmYQPlUi0/0V9zKwEgZeAYUF2aFw7Eg1SRCxPmH5LnNH6QrcISQ/FYhSWPWY7vJXarjmMyzWl5
	 SphIIB+2kNlbqWXT6rQ8SeBZe4JkuJ2unpFgMls6fJ92QMh5e+2DzvuBqXC6TL3qTFEgRLKXZCGo8
	 dvhuL7bXQ351YtU9n3bP4dsc9EVg1R6xK51/xhxJ0XaVJnL17oGZ4QoGPykjGvyEMUrx9OJsLLHRW
	 e36kVLOaDVJYRszWlq6eXlFKc2zASmlKQYUGZEKf7o+FeQGtIA0a4m0kAdT4g8+40CMaFavHE9WIC
	 ShGvEVDM2QvQOFPfogalHWsGBFifYMp6ZbTj/ee9YlRhB6UPg07dHZcSaEf8Qiw17w8xtq85Z99zo
	 95NUMFFGBP1lQ1BKe9WBvQcnKuVod5IAjbd6VvUBhanyoonG6HxPwIZpelErOwkUs8YB+xD+C+FFy
	 ivrnpf5TLBhPPaU16MZOkzC6lAgAZ47ShJ/wkNfzSys2uUUdUsHAfP7PAPptKeflISENMrREJnsrz
	 ZdmGY2Ul9Xp0OqMhywEBbwNWc2+TfpMQOHreKAFkq+sj7bnF6kh6zqQK7sWkDH9qUxb/V4BRbQ6w3
	 cXTXbdT8qxElezLBLZ4ftOEKaU8SVrumuwNrtRTKPM2jfDnrZUEzVHcqwIcsCrjFGCvvw4hix9xkt
	 /KtTp1i4kz7EFAZVhipTdrHBGtJbyTlIzK9QffzNGC24SJSCisxkSkmUZVK9etKtG6CK5pOv0T//y
	 TQaVdnhRKrtpdidoLo76rSA6XV51cJCLo/6Gr9zfptBTsfzC8z5gohyE3JnNpYZRBZNT9DT+nDWHL
	 yk4rPEDFUryH7VDdq2POSnYcve0pxOTBQW5kLuodsqqoTUT3j4/tpzARhrZRZK54NTMhQzpXXTEMa
	 ZVdUlwwX5Ecsb6fVMoQvCzxgWiyZnj0LLWQtyNzKSwyzk+bksEusO30WddveOlcz3s307XF7GAEUH
	 3QeQ/sZ6O6yo43MdcQ8dw+SFTUgzYInXFpOAqOQAxPeOOjtNHDsKFAmNWveP7DRu1ltjDl9Y/NaWp
	 SPmbPyVBwR1ucEW710u2nYjI
From: "=?utf-8?B?Q29uZ2ppZSBaaG91?=" <zcjie0802@qq.com>
To: "=?utf-8?B?TWljaGFlbCBTLiBUc2lya2lu?=" <mst@redhat.com>
Cc: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?amFzb3dhbmdpbw==?=" <jasowangio@gmail.com>, "=?utf-8?B?ZXBlcmV6bWE=?=" <eperezma@redhat.com>, "=?utf-8?B?eHVhbnpodW8=?=" <xuanzhuo@linux.alibaba.com>, "=?utf-8?B?YW5kcmV3K25ldGRldg==?=" <andrew+netdev@lunn.ch>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?dmlydHVhbGl6YXRpb24=?=" <virtualization@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] virtio_net: RX stall caused by masking callbacks after NAPI ownership release
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 20 Nov 2026 00:32:44 +0800
X-Priority: 3
Message-ID: <tencent_3F7F39BC8117D4E15C286B951C22BDF71907@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <20261115175445-mutt-send-email-mst@kernel.org>
 <tencent_94953697D2BA27275BEF7A26404E69800605@qq.com>
 <20261116044750-mutt-send-email-mst@kernel.org>
 <tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com>
	<20261119064843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261119064843-mutt-send-email-mst@kernel.org>
X-QQ-mid: xmsezc52-0t1795105964tq0ulqo3y

PiBSaWdodC4gU28gSSBjYW1lIHVwIHdpdGggdGhpcyB0aGVuLiBQbHMgbm90ZSBpIGNvdWxk
IG5vdCByZXBybyB0aGUKPiBwcm9ibGVtIHNvIEkgYW0gbWVyZWx5IHJlYXNvbmluZyBiYXNl
ZCBvbiB0aGVvcmV0aWNhbCB1bmRlcnN0YW5kaW5nCj4gb2YgaXQuCj4gCj4gLS0tPgo+IAo+
IHZpcnRpb19uZXQ6IG1hc2sgY2FsbGJhY2tzIGJlZm9yZSBoYW5kaW5nIG9mZiBOQVBJIG93
bmVyc2hpcAo+IAo+IFZpcnRpbyBpcyBzcGVjaWFsIGluIHRoYXQgZW5hYmxpbmcgb3IgZGlz
YWJsaW5nIGNhbGxiYWNrcyAoaW50ZXJydXB0cykKPiBhY2Nlc3NlcyBzaGFyZWQgdmlydHF1
ZXVlIHN0YXRlIGFuZCBtdXN0IGJlIHNlcmlhbGl6ZWQgd2l0aCBwb2xsaW5nLiBJdAo+IHRo
ZXJlZm9yZSBlbmFibGVzIGNhbGxiYWNrcyBiZWZvcmUgY29tcGxldGluZyBOQVBJLCBhbmQg
ZGlzYWJsZXMgdGhlbQo+IGFnYWluIGlmIGNvbXBsZXRpb24gcmV0dXJucyBmYWxzZS4KPiAK
PiBXaXRoIG5hcGlfY29tcGxldGVfZG9uZSgpLCB0aGF0IGZhbHNlIHJldHVybiBjYW4gY29t
ZSBhZnRlciBvd25lcnNoaXAgaGFzCj4gcGFzc2VkIHRvIGFub3RoZXIgcG9sbC4gVGhlIGZp
cnN0IHBvbGwgY2FuIHRoZW4gZGlzYWJsZSBjYWxsYmFja3MgYWZ0ZXIKPiBpdHMgc3VjY2Vz
c29yIGhhcyBlbmFibGVkIHRoZW0sIGxlYXZpbmcgUlggc3RhbGxlZC4gVmlydGlvIHRoZXJl
Zm9yZQo+IG5lZWRzIHRvIGRpc2FibGUgY2FsbGJhY2tzIGJlZm9yZSBoYW5kaW5nIG9mZiBO
QVBJIG93bmVyc2hpcC4KPiAKPiBBZGQgYSBwcmVwYXJlL2ZpbmlzaCBOQVBJIGNvbXBsZXRp
b24gQVBJIHNvIHZpcnRpby1uZXQgY2FuIG1hc2sgaW50ZXJydXB0cwo+IGJlZm9yZSBoYW5k
aW5nIG93bmVyc2hpcCBvZmYuCj4gCj4gVGhpcyBwcmVzZXJ2ZXMgaW50ZXJydXB0IHN1cHBy
ZXNzaW9uIHdpdGhvdXQgYSBjYWxsYmFjayBvciBhbiBhZGRpdGlvbmFsCj4gZGF0YS1wYXRo
IGJhcnJpZXIuIE9yZGluYXJ5IG5hcGlfY29tcGxldGVfZG9uZSgpIGNvbXBpbGVzIGlkZW50
aWNhbGx5IGluCj4gdGhlIHRlc3RlZCBjb25maWd1cmF0aW9uLgo+IAo+IFRlc3RlZCBvbiB4
ODYtNjQgS1ZNIHdpdGggbG9jayBkZWJ1Z2dpbmcsIGluY2x1ZGluZyBJUlEgZGVmZXJyYWws
IGNvbmN1cnJlbnQKPiBzY2hlZHVsaW5nLCBidXN5IHBvbGxpbmcsIG5ldHBvbGwsIGFuZCB0
aHJlYWRlZCBOQVBJLiBTcGxpdCBhbmQgcGFja2VkCj4gdmlydHF1ZXVlIFRDUCBSWCB0ZXN0
cyB3aXRoIElSUSBkZWZlcnJhbCBhbmQgYnVzeSBwb2xsaW5nIGFsc28gcGFzc2VkLgo+IAo+
IFJlcG9ydGVkLWJ5OiBDb25namllIFpob3UgPHpjamllMDgwMkBxcS5jb20+Cj4gQ2xvc2Vz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvdGVuY2VudF9EMDY1MEY4Q0EyQUFF
NEMyNThCRkU1QkNFODA1Q0RCNENBMEFAcXEuY29tLwo+IEZpeGVzOiA2ZjhiMTJkNjYxZDAg
KCJuZXQ6IG5hcGk6IGFkZCBoYXJkIGlycXMgZGVmZXJyYWwgZmVhdHVyZSIpCj4gQXNzaXN0
ZWQtYnk6IExMTQoKSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBsb2NhbGx5ICwgYW5kIGV2ZXJ5
dGhpbmcgbG9va3MgZ29vZCBub3csIHRoZSBpc3N1ZSBpcyBnb25lLgo=

