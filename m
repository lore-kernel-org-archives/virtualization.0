Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845133;
	b=OHtSWY0oibnggYuhStt6SruoBzmT2RFpmsoWdPPT1c2lCrJvm+4BX43VuAxSq5QAqcL7
	 avAJ6jirq8U2gKyQhezG8g0GusyfobCL6tUQFSqI6Ts736y1Fya/DX+Dv8pTFD5OInf0K
	 oemaMW61a5lTM6BoF1kjjsHnEo+DSOrxn2HPto+DACxK7kcIgCI9IfdnHdPl5I9+y/Ww3
	 RyZFvR22VocFz1VwaB87NTlrfOnEMm5wSbUrSdzcgeazkrtlFyT/7uWINFWBqU9NFOC+0
	 KoS7saZJtmrhUCCGhyd66CLGFCcIsCczWLACP45vgE4RjEShiZhiFIj6v2mKrVd2y9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845133;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=xBu8GzeDrk7xvt8Bx0CRjK8uvrfVOw0/hRdHRPrcQig=;
	b=rBjUuZoWHxB7iwKBHM82aUqSiUw0KRYJ4LXkDq6lmGsaV4sBc1qbFoijaFeEu7k3z3ul
	 z3JBXDMNnAmEbVKqyk/AiTiIMm9kvOmcOBQGb9NIGnl1gUvMpcHt5B8f3XS0zVOJdym46
	 pxKa48eep1qwM4UjnieLB30qcI+YG9lvfK0xc1fcNa/j0ytw4ieIttyHHXT7CnhiF/jTs
	 f8vtEw+YsdE1rbXgvlJsixGp6kcK6qpChDaq0VaBomU/zDhuX+Ow0SMSkwHolx4bv9RJq
	 g3jkqB3tYSlCJXPTAXm5jTwP1zpJV6Laim8zNXj1perK7opGl16ls1gAdas/8zLkwbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iM++q2JP;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84E606A32F
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 16:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E84E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iM++q2JP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794845126; bh=xBu8GzeDrk7xvt8Bx0CRjK8uvrfVOw0/hRdHRPrcQig=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=iM++q2JPHV9nYNTsHPvMfOPZaNaQnxA+K7vcHVN9KBpSdtBSq2bcxMiUYXMScaBn2
	 XUWR9F2Lfmq8YI8oZ7lbYwlznLDMLvQGh5E5ABMs5rU/NxUqIB/Bq1DGO6WnjcOOoO
	 GCo73jetIdWRY9iOSi8x5peT6GKJdv7EOSgmShuY=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: MMvVzQSdFuTp9sTjQOGIRK8xE+zYC9uRyfQxc8yQGv9al2Q86T3U8Tzb/wwbfi
	 aEYwdjK9wwqzxGmtd/dRL/uYlGaaJrEvZLD68OamQgJpzd1jysozGF3l0R2K49mU1Wh32y6QHN1OK
	 CP+q5v5O3WNbfZcQ0D1oVVVpOOx9qBYBemSJQtIQDCAOmIS0by1p75q0wquKAyKkizoivj+bjZoXu
	 Nx5xA4W/hf6md+c2QeI20aw3nROdPRtL21B/26o6ql+gdyu9mIPRrcJ0daKcUBMsxxLjlyoS0ps7E
	 mqWVPewoJoRy35xa4zicXEhYTBsqdGv0IVP0ufEJ8a8SFj7X9JK+5gaVOUcMoSWd+54X6lAruy8HR
	 mbWVWrBCmNBz2gi7N+Ne7E4RAVg1xwdU+R8/QzreX0m+YGTbP9Up/ai4xzH82JvrqyAcNGF/YwM9A
	 WjvZtCROQjQB2fNhhHPD+++tsLmf7a+s6ox2rK3l29J4ecXjEcmUPWchXFJYYOKW40XCJDcx6DKCU
	 8TNuPzp2y65pGQhAMpwxDyibahFSLAMFaY371/pTejPwUwqu3RfulRRtZwAJRxZwlJe794V815O18
	 UtxDooDoDRoyd7tyaUkt+zioxTmVTgjYZScNBIVDY1fsOtl/hopv3U6yvhXfGFK5WEeoBoy/vkZet
	 tcl0OjlPgMQgNZqszcW8Pi1d3up5tdpZKot9D6KOarOJUJhC63ygNplMYdLMQrVzyCw30tvzaGA2s
	 IE+RZWRjTuG9MdBlaHr9tqUwhbiSiAsefsz96aXmWo5gQ40flFNZOh7nmGyjLfoWVOmQAeUet9Aas
	 lC7UJU+RiURBJMuEMDpMLm27z3RCXvXjRaLNDXDrpTz0StR50aRIiNAa/LTw8c3czPjE4sEyAqFGm
	 BXmmF9eILYukDytP4YLrkkr75SiU8xLnLmXCWZJUbYeoNZEYl4Q+Y2/ioYiQp2Mi9qaQrbRK7ynUr
	 6EjwQY7QN9KyXbb9QQ59puWj4sAWsjx9zMrVhT3Tmj2y0hZI8s36amx5OuhTU/rnCWzaS5JAdP327
	 t4icK/h/GDz3kybqmAobWzolPd4IRsXD4q6r6emLF7fvNrYJaloeRdP5BfV3xdczXjxq9y256arXU
	 JzkM7LPPIk8H81YKvQ1oH79T
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
Date: Tue, 17 Nov 2026 00:05:24 +0800
X-Priority: 3
Message-ID: <tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <20261115175445-mutt-send-email-mst@kernel.org>
 <tencent_94953697D2BA27275BEF7A26404E69800605@qq.com>
	<20261116044750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261116044750-mutt-send-email-mst@kernel.org>
X-QQ-mid: xmsezc52-0t1794845124tuizgangp

PiBNYXliZSBsZXQncyBqdXN0IGNoZWNrIHRoZSBwb2xsIGxpc3QuCgpDaGVja2luZyB0aGUg
cG9sbCBsaXN0IGZpeGVzIHRoZSBlYXJsaWVyIHJhY2Ugd2hlcmUgdGhlIHdhdGNoZG9nIGhh
cwphbHJlYWR5IGZpbmlzaGVkLiBIb3dldmVyLCB0aGUgdGltZXIgY2FuIHN0aWxsIGJlIGNv
bnN1bWVkIHdpdGhvdXQKdHJpZ2dlcmluZyBhbm90aGVyIHBvbGwgaWYgaXQgZmlyZXMgYWZ0
ZXIgdGhlIG9sZCBjYWxsZXIncyBjaGVjazoKCiAgb2xkIHBvbGwgLyB3YXRjaGRvZyAgICAg
ICAgICAgICAgICBzdWNjZXNzb3IgYnVzeS1wb2xsCiAgLS0tLS0tLS0tLS0tLS0tLS0tLSAg
ICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tCiAgbmFwaV9jb21wbGV0ZV9kb25l
KCk6CiAgICBjbGVhciBTQ0hFRCwgYXJtIHRpbWVyLAogICAgcmV0dXJuIGZhbHNlCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY3F1aXJlIE5BUEkKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZSBjYWxsYmFja3MsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGVuIHBhdXNlIGJlZm9yZSBjb21wbGV0
aW9uCiAgZGlzYWJsZSBjYWxsYmFja3MKICBuYXBpX2hhc19wZW5kaW5nX3BvbGwoKToKICAg
IHRpbWVyIGlzIHN0aWxsIHF1ZXVlZCwKICAgIHNvIHNraXAgbmFwaV9zY2hlZHVsZSgpCiAg
b2xkIHBvbGwgZXhpdHMKICB3YXRjaGRvZyBleHBpcmVzLCBzZWVzIFNDSEVEPTE6CiAgICBu
byBzY2hlZHVsaW5nLCBubyBNSVNTRUQKICB3YXRjaGRvZyByZXR1cm5zCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBuYXBpX2NvbXBsZXRlX2RvbmUoLi4uLCAwKToK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYXIgU0NIRUQsIHJl
dHVybiB0cnVlCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZSBp
cyBlbXB0eSwgZXhpdAoKQXQgdGhhdCBwb2ludCwgdGhlIG5leHQgdXNlZCBlbnRyeSBlbmRz
IHVwIHdpdGggbmVpdGhlciBub3RpZmljYXRpb25zCmVuYWJsZWQgbm9yIGEgcGVuZGluZyB0
aW1lciBvciBzY2hlZHVsZWQgcG9sbCB0byBwcm9jZXNzIGl0LgoKU3RlcHBpbmcgYmFjaywg
dGhlIGZ1bmRhbWVudGFsIG9yZGVyaW5nIGlzc3VlIGhlcmUgaXM6CgogIG9sZCByZWxlYXNl
cyBTQ0hFRAogICAgLT4gc3VjY2Vzc29yIHJlYXJtcyBjYWxsYmFja3MKICAgIC0+IG9sZCBt
YXNrcyBjYWxsYmFja3MKClJpZ2h0IG5vdywgbm90aGluZyBndWFyYW50ZWVzIHRoYXQgdGhl
IG9sZCBtYXNrIGhhcHBlbnMgYmVmb3JlIHRoZQpzdWNjZXNzb3IncyByZWFybS4gRXZlbiBp
ZiB0aGUgc3VjY2Vzc29yIHN0aWxsIGhvbGRzIFNDSEVELCBpdCBtaWdodApoYXZlIGFscmVh
ZHkgZG9uZSBpdHMgZmluYWwgcmVhcm0uIFNpbWlsYXJseSwgaGF2aW5nIGEgcXVldWVkIHRp
bWVyCmRvZXNuJ3QgZ3VhcmFudGVlIGFub3RoZXIgcG9sbOKAlHRoZSB3YXRjaGRvZyB3aWxs
IHNpbXBseSBiYWlsIG91dCB3aXRob3V0CnNjaGVkdWxpbmcgYmVjYXVzZSBTQ0hFRCBpcyBh
bHJlYWR5IHNldC4gU28gYWxsIHRoZXNlIHN0YXRlIGNoZWNrcyBjYW4KbG9vayBjb21wbGV0
ZWx5IHZhbGlkIGF0IHRoZSB0aW1lLCB5ZXQgc3RpbGwgZmFpbCB0byBndWFyYW50ZWUgcmVj
b3ZlcnkuCgpUaGUgcm9vdCBjYXVzZSBpcyB0aGF0IHdpdGggdGhlIHRpbWVyIGludHJvZHVj
ZWQgYnkgTkFQSSBkZWZlciwKbmFwaV9jb21wbGV0ZV9kb25lKCkgY2FuIHJldHVybiBmYWxz
ZSB3aGlsZSBzdGlsbCBnaXZpbmcgdXAgU0NIRUQKb3duZXJzaGlwLCBsZWF2aW5nIHVzIHdp
dGggbm90aGluZyBlbHNlIHRvIHN5bmNocm9uaXplIHRoZSBjYWxsYmFjawpzdGF0ZS4gQmVm
b3JlIE5BUEkgZGVmZXIsIHJldHVybmluZyBmYWxzZSBtZWFudCB3ZSBzdGlsbCBoZWxkIG9u
dG8KU0NIRUQsIHNvIGV2ZXJ5dGhpbmcgd29ya2VkIGFzIGV4cGVjdGVkLgoKVG8gZml4IHRo
aXMgcHJvcGVybHksIEkgdGhpbmsgd2UgZWl0aGVyIG5lZWQgdG8gY2FsbAp2aXJ0cXVldWVf
ZGlzYWJsZV9jYigpIGJlZm9yZSBnaXZpbmcgdXAgU0NIRUQgb3duZXJzaGlwLCBvciBpbnRy
b2R1Y2UgYQpzZXBhcmF0ZSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtIChsaWtlIGEgbG9j
aykgdG8gZW5zdXJlIHdlIGNhbiBhbHdheXMKcmVjb3ZlciBOQVBJIGV4ZWN1dGlvbi4gU2lt
cGxlIGZsYWcgY2hlY2tzIGFsb25lIGRvbid0IHNlZW0gZW5vdWdoIHRvCmNsb3NlIHRoaXMg
cmFjZSBjb21wbGV0ZWx5Lg==

