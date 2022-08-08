Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4DDC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 09:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6559982521;
	Mon,  8 Aug 2022 09:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6559982521
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nHT6gKCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcRq9hXGGeXx; Mon,  8 Aug 2022 09:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED1198246F;
	Mon,  8 Aug 2022 09:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED1198246F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8516C0032;
	Mon,  8 Aug 2022 09:07:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68B8AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 09:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 046DE82496
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 09:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 046DE82496
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hyCJzAJp-V-z
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 09:07:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B62AE8246F
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B62AE8246F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 09:07:05 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 33D276601C24;
 Mon,  8 Aug 2022 10:07:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659949623;
 bh=aT4Y4PRWFqoLXt9oUFCYxJFzPEP2F0zu3T57vKLD24o=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=nHT6gKCAsZ4JxG+TFwUKRhh/hjFC+mVec4ufjzbnSR1DnTAQLdf61/NP0tajrTQkE
 k3F7UI1dY3NJlENaiWDg03Dqb5PdJfnigKXFMAQQAImzfQTxvKNPLgB0q5pf6pO/QZ
 BC4HxJEFgc3H/80sjLeSVDkY2Fq62MQhYzIwxpJ1osunJyLAH0JIE6keSBFdfdRA6f
 rfw6pZy3rWtg9d1T325t+l5tgqZdWVPU64wPhI4gvaWaWh/2gisV0MrXuftdSL1m6P
 iIbN6GSQXZV0IMs66DGrBu2nHqFwv2nb5NERmFhKKUeqs6LXDoG2xflX/VZHE2nBwp
 A2cDpqYbdVngg==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 2/2] docs: driver-api: virtio: virtio on Linux
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-3-ricardo.canuelo@collabora.com>
 <Yu4fEEDMVrC7eNY1@debian.me>
In-reply-to: <Yu4fEEDMVrC7eNY1@debian.me>
Date: Mon, 08 Aug 2022 11:06:59 +0200
Message-ID: <87o7wvqf2k.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: mst@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgQmFnYXMsCgpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2gsIGNvbW1lbnRzIGJlbG93
OgoKT24gc8OhYiwgYWdvIDA2IDIwMjIgYXQgMTQ6NTg6MDgsIEJhZ2FzIFNhbmpheWEgPGJhZ2Fz
ZG90bWVAZ21haWwuY29tPiB3cm90ZToKPiBTcGhpbnggY2l0YXRpb24gc3ludGF4IGNhbiBiZSB1
c2VkIGZvciBleHRlcm5hbCByZWZlcmVuY2VzLCBsaWtlOgo+Cj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdCBiL0RvY3VtZW50YXRpb24vZHJp
dmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdAo+IGluZGV4IDRiNzNjNzA1Yzk0YzYxLi5hYmQ2ODJj
ZmQ0MWVkYSAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3Zp
cnRpby5yc3QKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5y
c3QKPiBAQCAtNTAsOCArNTAsOCBAQCBzaW1pbGFyIHRvIHRoZSBvbmVzIHVzZWQgaW4gYSBuZXR3
b3JrIGRldmljZToKPiAgQWxsIHRoZSBidWZmZXJzIHRoZSBkZXNjcmlwdG9ycyBwb2ludCB0byBh
cmUgYWxsb2NhdGVkIGJ5IHRoZSBndWVzdCBhbmQKPiAgdXNlZCBieSB0aGUgaG9zdCBlaXRoZXIg
Zm9yIHJlYWRpbmcgb3IgZm9yIHdyaXRpbmcgYnV0IG5vdCBmb3IgYm90aC4KPiAgCj4gLVJlZmVy
IHRvIENoYXB0ZXIgMi41ICgiVmlydHF1ZXVlcyIpIG9mIHRoZSB2aXJ0aW8gc3BlYyBbMV0gZm9y
IHRoZQo+IC1yZWZlcmVuY2UgZGVmaW5pdGlvbnMgb2YgdmlydHF1ZXVlcyBhbmQgdG8gWzJdIGZv
ciBhbiBpbGx1c3RyYXRlZAo+ICtSZWZlciB0byBDaGFwdGVyIDIuNSAoIlZpcnRxdWV1ZXMiKSBv
ZiB0aGUgdmlydGlvIHNwZWMgWzFdXyBmb3IgdGhlCj4gK3JlZmVyZW5jZSBkZWZpbml0aW9ucyBv
ZiB2aXJ0cXVldWVzIGFuZCB0byBbMl1fIGZvciBhbiBpbGx1c3RyYXRlZAo+ICBvdmVydmlldyBv
ZiBob3cgdGhlIGhvc3QgZGV2aWNlIGFuZCB0aGUgZ3Vlc3QgZHJpdmVyIGNvbW11bmljYXRlLgo+
ICAKPiAgVGhlIDpjOnR5cGU6YHZyaW5nX3ZpcnRxdWV1ZWAgc3RydWN0IG1vZGVscyBhIHZpcnRx
dWV1ZSwgaW5jbHVkaW5nIHRoZQo+IEBAIC0xMzgsMTMgKzEzOCwxMyBAQCBjYWxsaW5nIGEgdHJh
bnNwb3J0LXNwZWNpZmljIGBgZmluZF92cXNgYCBtZXRob2QuCj4gIFJlZmVyZW5jZXMKPiAgPT09
PT09PT09PQo+ICAKPiAtWzFdIFZpcnRpbyBTcGVjIHYxLjI6Cj4gLWh0dHBzOi8vZG9jcy5vYXNp
cy1vcGVuLm9yZy92aXJ0aW8vdmlydGlvL3YxLjIvdmlydGlvLXYxLjIuaHRtbAo+ICsuLiBbMV0g
VmlydGlvIFNwZWMgdjEuMjoKPiArICAgaHR0cHM6Ly9kb2NzLm9hc2lzLW9wZW4ub3JnL3ZpcnRp
by92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5odG1sCj4gIAo+IC1DaGVjayBmb3IgbGF0ZXIgdmVy
c2lvbnMgb2YgdGhlIHNwZWMgYXMgd2VsbC4KPiArICAgQ2hlY2sgZm9yIGxhdGVyIHZlcnNpb25z
IG9mIHRoZSBzcGVjIGFzIHdlbGwuCj4gIAo+IC1bMl0gVmlydHF1ZXVlcyBhbmQgdmlydGlvIHJp
bmc6IEhvdyB0aGUgZGF0YSB0cmF2ZWxzCj4gLWh0dHBzOi8vd3d3LnJlZGhhdC5jb20vZW4vYmxv
Zy92aXJ0cXVldWVzLWFuZC12aXJ0aW8tcmluZy1ob3ctZGF0YS10cmF2ZWxzCj4gKy4uIFsyXSBW
aXJ0cXVldWVzIGFuZCB2aXJ0aW8gcmluZzogSG93IHRoZSBkYXRhIHRyYXZlbHMKPiArICAgaHR0
cHM6Ly93d3cucmVkaGF0LmNvbS9lbi9ibG9nL3ZpcnRxdWV1ZXMtYW5kLXZpcnRpby1yaW5nLWhv
dy1kYXRhLXRyYXZlbHMKPiAgCj4gIC4uIHJ1YnJpYzo6IEZvb3Rub3RlcwoKSXMgdGhhdCB0aGUg
cHJlZmVycmVkIHdheSB0byBkbyBpdD8gSSBkaWRuJ3QgZmluZCBhbnkgZ3VpZGVsaW5lcyBhYm91
dAppdCBhbmQgdGhlIGV4aXN0aW5nIGRvY3MgZG9uJ3Qgc2VlbSB0byBzZXR0bGUgb24gYW55IHNw
ZWNpZmljCnN0eWxlLiBQZXJzb25hbGx5IEkgcHJlZmVyIHRvIGtlZXAgaXQgYXMgaXQgaXMgaW4g
dGhlIHBhdGNoIGJlY2F1c2UgSQpsaWtlIHRoZSBiaWJsaW9ncmFwaHkgcmVmZXJlbmNlcyB0byBs
b29rIGRpZmZlcmVudCB0aGFuIGZvb3Rub3RlIGxpbmtzCihbXSB2cyBzdXBlcnNjcmlwdCkuCgpD
aGVlcnMsClJpY2FyZG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
