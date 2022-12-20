Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211BCC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 09:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7B4B41570;
	Tue, 20 Dec 2022 09:54:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7B4B41570
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hi3q6NMe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovVr8KUOCZVO; Tue, 20 Dec 2022 09:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1B6041553;
	Tue, 20 Dec 2022 09:54:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1B6041553
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0070C0032;
	Tue, 20 Dec 2022 09:54:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86BA9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D866D80BEB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D866D80BEB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=hi3q6NMe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7xhsogcJ6ad
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:54:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3F6A80BB1
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3F6A80BB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:54:21 +0000 (UTC)
Received: from [192.168.231.135] (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id B7D326602CAF;
 Tue, 20 Dec 2022 09:54:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671530060;
 bh=hGDOLF1RyGRcC3iX5uCk+dEsXvStRSEoO8MB9kbk4uc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hi3q6NMex3dFB8xrlrmd0eXb5H8vjTGkxGdBjOK5iW78R5BRQf1eDsSzSrPFziNYP
 zN/WIRc1nzGGpIPKPHbEzyD1wtSH6k7Hw7x7S8ObdFquKhxIqHiwvgUFwO0z82YtEf
 r1TsNNITanfsXFxb9UgTzOSbd13U5zZILfjGhgrgkNlxO84zAg7vmJrwUyNGaAXn27
 OUVuFbClmt5vp2U0DqqIG7Bb3m0oWD3Jj9O5za3BZpZzRrtU/ae1mXUA3WBTQz907v
 ZvZX+tQHCz4Le4dpXOmpT3FKAle72pHGYHVQUDJhoaWYD2MRnMrqObo2ZkuXqw/bDC
 7M7yjiAusFI7Q==
Message-ID: <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
Date: Tue, 20 Dec 2022 10:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>, mst@redhat.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <Y6F8dlRQbOzIvJff@debian.me>
From: =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <Y6F8dlRQbOzIvJff@debian.me>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgQmFnYXMsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcsIHNvbWUgY29tbWVudHMgYmVsb3c6CgpP
biAyMC8xMi8yMiAxMDoxMiwgQmFnYXMgU2FuamF5YSB3cm90ZTo+IE9uIFR1ZSwgRGVjIDIwLCAy
MDIyIGF0IDA4OjM3OjA5QU0gKzAxMDAsIFJpY2FyZG8gQ2HDsXVlbG8gd3JvdGU6Cj4gRGVzY3Jp
YmUgdGhlIHN0ZXBzIG5lZWRlZCB0byBmaXggYm90aCB3YXJuaW5ncyBhYm92ZS4gSSBzZWUgaW4g
dGhlIGRpZmYgdGhhdDoKPiAKPiAgICAqIG1vdmUgdnFfY2FsbGJhY2tfdCgpIGRlY2xhcmF0aW9u
IGFib3ZlOwo+ICAgICogbWF0Y2ggZW50aXR5IHR5cGUgb2YgdmlydGlvX2NvbmZpZ19vcHM7IGFu
ZAo+ICAgICogcmVmb3JtYXQgQGZpbmFsaXplX2ZlYXR1cmVzIGRlc2NyaXB0aW9uLgoKSSB3b3Vs
ZG4ndCBsaWtlIHRvIGFkZCByZWR1bmRhbnQgaW5mbyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgZm9y
CnN1Y2ggYSB0cml2aWFsIHBhdGNoLiBUaGUgY29tbWl0IG1lc3NhZ2UgZGVzY3JpYmVzIF93aGF0
XyB0aGUKcGF0Y2ggZG9lcy4gVGhlIF9ob3dfIGlzIGp1c3QgYXMgY2xlYXIgaW4gdGhlIHBhdGNo
IGl0c2VsZiBhcyBpbgp0aGlzIGRlc2NyaXB0aW9uLCBJTU8uCgo+IAo+PiBTaWduZWQtb2ZmLWJ5
OiBSaWNhcmRvIENhw7F1ZWxvIDxyaWNhcmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4KPiAKPiBZ
b3UgbmVlZCB0byBhZGQgYXBwcm9wcmlhdGUgdGFnczoKPiAKPiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1uZXh0LzIwMjIxMjIwMTA1OTU2LjQ3ODY4NTJkQGNhbmIuYXV1Zy5v
cmcuYXUvCj4gRml4ZXM6IDMzMzcyM2U4YmMzOTNkICgiZG9jczogZHJpdmVyLWFwaTogdmlydGlv
OiB2aXJ0aW8gb24gTGludXgiKQo+IFJlcG9ydGVkLWJ5OiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJA
Y2FuYi5hdXVnLm9yZy5hdT4KClRoYW5rcyBmb3IgdGhlIHRpcCBhbHRob3VnaCwgYWN0dWFsbHks
IGl0J3Mgbm90IHRoYXQgY29tbWl0IHRoYXQKbmVlZHMgdG8gYmUgZml4ZWQgYnV0IHRoZSBrZXJu
ZWxkb2MgaXRzZWxmLiBUaGUgd2FybmluZ3Mgd2VyZQptYWRlIHZpc2libGUgYWZ0ZXIgdGhhdCBj
b21taXQgYnV0IG5vdCBpbnRyb2R1Y2VkIGJ5IGl0LiBJJ2xsIGFkZAp0aGUgUmVwb3J0ZWQtYnkg
dGFnIGluIHYyLgoKQ2hlZXJzLApSaWNhcmRvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
