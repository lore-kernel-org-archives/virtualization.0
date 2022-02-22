Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A115DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 13:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BF9560ECE;
	Tue, 22 Feb 2022 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlzL_SR3N9fN; Tue, 22 Feb 2022 13:05:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C005C60ECB;
	Tue, 22 Feb 2022 13:05:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CC8C001A;
	Tue, 22 Feb 2022 13:05:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0CBC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4598F40155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MzaPQ27h2OvN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:05:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FE3B401AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:05:31 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 g6-20020a9d6486000000b005acf9a0b644so9521593otl.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 05:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y01kJbrbcxAmMynqwHOhpegkdcYtXci9FUmRqGex7Vk=;
 b=MYLIC1UuwnuT1lAmTqdLKxfPFzcJiWQU2Dy7VgzbPDvSgwmStLXeAxRIh9n8JPMWV8
 XmMpMBQpxZwL4AT3xNJ6LR71Nu9IKuOGIo0O23r/qewTwRuOyI6ujQnPFpa2ZacYa7Xx
 l1hfO4vid7eVt7ws4qJKTkGffb+K2MZduPRxRpis4x0Qh7otWBQ0o7HjkVcZgR+AmjoO
 8K04zn0WmTi2HQAjEw+Qt3JmZEvqe3jYqWfdx31qMenF6Dqz8+Ce/mpgH8cBHXIV8wLA
 emRghWmB0+UAYctbX9DT0on05ydMXNw8IfNpcTJ5T32GSKLpYFxhJUf+8bG6v4SDOneV
 B/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y01kJbrbcxAmMynqwHOhpegkdcYtXci9FUmRqGex7Vk=;
 b=MkgpikRuV1cI7KiMh+ftBaHDijwxevcbBDiTdesnmtXJyUF5XObExFqt1Skc76duly
 jszzfm/9+UQdsu6pJPOtZIMgSMok9kY90ODpBnL3GSXf1fZJOI7WY6z0af9NVzbucHeT
 ZZOxNrwG7adXYOp99OuvQWJB6Vett9Yb6GYcAthAPwQS6GD8yztgPtUI8B3zyS/GaobX
 pP4qMbrPSX0VRK4dz1V/n4h1XY/IrqtbSoyhYu7ffm2QExbH5E4QPPYiO76IQK07ZMxm
 ZIYlT9JDvdxeS5v+oIFYbi5xSYIzTNblnrrn5n9Zujjxz6/whoSqibeeAQ7ooy/ODJ4y
 ROrw==
X-Gm-Message-State: AOAM532ULS5iir2eBhADkx1zK6FFbIRZYd4/0dtGu0OzoeZQMO3zgald
 +vqdmu7utrJo54QJcNW1mXVj+Awh7QG0kK83voTfeA==
X-Google-Smtp-Source: ABdhPJz4oJQbfPa+jyB8PwWlxFFv+uK2vA7h3V8F0P2qHSPcHtxfpVfHkTBak96qlDXOkT/dhxGoWYCfAiK/NnGx1HQ=
X-Received: by 2002:a05:6830:1dd2:b0:5a2:2d10:c3ba with SMTP id
 a18-20020a0568301dd200b005a22d10c3bamr8282177otj.41.1645535130874; Tue, 22
 Feb 2022 05:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
 <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
 <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
 <3ab523ac-0ab5-5011-5328-e119840e1c07@redhat.com>
In-Reply-To: <3ab523ac-0ab5-5011-5328-e119840e1c07@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 22 Feb 2022 15:05:19 +0200
Message-ID: <CABcq3pG3c32b8uHdfNq2LkgCAo8hnOQcY-wQXEG58vPe4FBmUg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

SGkgYWxsLAoKT24gV2VkLCBGZWIgOSwgMjAyMiBhdCA3OjQxIEFNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMi8yLzgg5LiL5Y2IOTowOSwgQW5k
cmV3IE1lbG5pY2hlbmtvIOWGmemBkzoKPiA+IEhpIHBlb3BsZSwKPiA+IENhbiB5b3UgcGxlYXNl
IHJldmlldyB0aGlzIHNlcmllcz8KPgo+Cj4gQXJlIHRoZXJlIGFueSBwZXJmb3JtYW5jZSBudW1i
ZXIgdG8gZGVtb25zdHJhdGUgdGhlIGRpZmZlcmVuY2U/Cj4KPiBUaGFua3MKPgoKWWVhaCwgSSd2
ZSB1c2VkIHVkcGdzb19iZW5jaCBmcm9tIExpbnV4IHRvIHRlc3QuCkhlcmUgYXJlIHNvbWUgbnVt
YmVyczoKClNlbmRpbmcgcGFja2V0cyB3aXRoIHNpemUgMTAwMDAKCldpdGhvdXQgVVNPOgpgYGAK
JCAuL3VkcGdzb19iZW5jaF90eCAtNCAtRCAxOTIuMTY4LjE1LjEgLXMgMTAwMDAgLVMgMTAwMApy
YW5kb206IGNybmcgaW5pdCBkb25lCnJhbmRvbTogNyB1cmFuZG9tIHdhcm5pbmcocykgbWlzc2Vk
IGR1ZSB0byByYXRlbGltaXRpbmcKdWRwIHR4OiAgICAgMzYgTUIvcyAgICAgMzg2MyBjYWxscy9z
ICAgMzg2MyBtc2cvcwp1ZHAgdHg6ICAgICAzMiBNQi9zICAgICAzMzYwIGNhbGxzL3MgICAzMzYw
IG1zZy9zCnVkcCB0eDogICAgIDMxIE1CL3MgICAgIDMzNDAgY2FsbHMvcyAgIDMzNDAgbXNnL3MK
dWRwIHR4OiAgICAgMzEgTUIvcyAgICAgMzM1MyBjYWxscy9zICAgMzM1MyBtc2cvcwp1ZHAgdHg6
ICAgICAzMiBNQi9zICAgICAzMzU5IGNhbGxzL3MgICAzMzU5IG1zZy9zCnVkcCB0eDogICAgIDMy
IE1CL3MgICAgIDMzNzAgY2FsbHMvcyAgIDMzNzAgbXNnL3MKYGBgCgpXaXRoIFVTTzoKYGBgCiQg
Li91ZHBnc29fYmVuY2hfdHggLTQgLUQgMTkyLjE2OC4xNS4xIC1zIDEwMDAwIC1TIDEwMDAKcmFu
ZG9tOiBjcm5nIGluaXQgZG9uZQpyYW5kb206IDcgdXJhbmRvbSB3YXJuaW5nKHMpIG1pc3NlZCBk
dWUgdG8gcmF0ZWxpbWl0aW5nCnVkcCB0eDogICAgMTIwIE1CL3MgICAgMTI1OTYgY2FsbHMvcyAg
MTI1OTYgbXNnL3MKdWRwIHR4OiAgICAxMjIgTUIvcyAgICAxMjg4NSBjYWxscy9zICAxMjg4NSBt
c2cvcwp1ZHAgdHg6ICAgIDEyMCBNQi9zICAgIDEyNjY3IGNhbGxzL3MgIDEyNjY3IG1zZy9zCnVk
cCB0eDogICAgMTIzIE1CL3MgICAgMTI5NjkgY2FsbHMvcyAgMTI5NjkgbXNnL3MKdWRwIHR4OiAg
ICAxMTYgTUIvcyAgICAxMjIzMiBjYWxscy9zICAxMjIzMiBtc2cvcwp1ZHAgdHg6ICAgIDEwOCBN
Qi9zICAgIDExMzg5IGNhbGxzL3MgIDExMzg5IG1zZy9zCmBgYAoKCj4KPiA+Cj4gPiBPbiBXZWQs
IEphbiAyNiwgMjAyMiBhdCAxMDozMiBBTSBZdXJpIEJlbmRpdG92aWNoCj4gPiA8eXVyaS5iZW5k
aXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPiA+PiBPbiBXZWQsIEphbiAyNiwgMjAyMiBhdCA5
OjU0IEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4+
PiBPbiBUdWUsIDI1IEphbiAyMDIyIDEwOjQ2OjU3ICswMjAwLCBBbmRyZXcgTWVsbnljaGVua28g
PGFuZHJld0BkYXluaXguY29tPiB3cm90ZToKPiA+Pj4+IEFkZGVkIG5ldyBvZmZsb2FkcyBmb3Ig
VFVOIGRldmljZXMgVFVOX0ZfVVNPNCBhbmQgVFVOX0ZfVVNPNi4KPiA+Pj4+IFRlY2huaWNhbGx5
IHRoZXkgZW5hYmxlIE5FVElGX0ZfR1NPX1VEUF9MNAo+ID4+Pj4gKGFuZCBvbmx5IGlmIFVTTzQg
JiBVU082IGFyZSBzZXQgc2ltdWx0YW5lb3VzbHkpLgo+ID4+Pj4gSXQgYWxsb3dzIHRvIHRyYW5z
bWlzc2lvbiBvZiBsYXJnZSBVRFAgcGFja2V0cy4KPiA+Pj4+Cj4gPj4+PiBEaWZmZXJlbnQgZmVh
dHVyZXMgVVNPNCBhbmQgVVNPNiBhcmUgcmVxdWlyZWQgZm9yIHFlbXUgd2hlcmUgV2luZG93cyBn
dWVzdHMgY2FuCj4gPj4+PiBlbmFibGUgZGlzYWJsZSBVU08gcmVjZWl2ZXMgZm9yIElQdjQgYW5k
IElQdjYgc2VwYXJhdGVseS4KPiA+Pj4+IE9uIHRoZSBvdGhlciBzaWRlLCBMaW51eCBjYW4ndCBy
ZWFsbHkgZGlmZmVyZW50aWF0ZSBVU080IGFuZCBVU082LCBmb3Igbm93Lgo+ID4+Pj4gRm9yIG5v
dywgdG8gZW5hYmxlIFVTTyBmb3IgVFVOIGl0IHJlcXVpcmVzIGVuYWJsaW5nIFVTTzQgYW5kIFVT
TzYgdG9nZXRoZXIuCj4gPj4+PiBJbiB0aGUgZnV0dXJlLCB0aGVyZSB3b3VsZCBiZSBhIG1lY2hh
bmlzbSB0byBjb250cm9sIFVEUF9MNCBHU08gc2VwYXJhdGVseS4KPiA+Pj4+Cj4gPj4+PiBUZXN0
IGl0IFdJUCBRZW11IGh0dHBzOi8vZ2l0aHViLmNvbS9kYXluaXgvcWVtdS90cmVlL0Rldl9VU092
Mgo+ID4+Pj4KPiA+Pj4+IE5ldyB0eXBlcyBmb3IgVmlydGlvTmV0IGFscmVhZHkgb24gbWFpbGlu
ZzoKPiA+Pj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNv
bW1lbnQvMjAyMTEwL21zZzAwMDEwLmh0bWwKPiA+Pj4gU2VlbXMgbGlrZSB0aGlzIGhhc24ndCBi
ZWVuIHVwdm90ZWQgeWV0Lgo+ID4+Pgo+ID4+PiAgICAgICAgICBodHRwczovL2dpdGh1Yi5jb20v
b2FzaXMtdGNzL3ZpcnRpby1zcGVjI3VzZS1vZi1naXRodWItaXNzdWVzCj4gPj4gWWVzLCBjb3Jy
ZWN0LiBUaGlzIGlzIGEgcmVhc29uIHdoeSB0aGlzIHNlcmllcyBvZiBwYXRjaGVzIGlzIFJGQy4K
PiA+Pgo+ID4+PiBUaGFua3MuCj4gPj4+Cj4gPj4+PiBBbHNvLCB0aGVyZSBpcyBhIGtub3duIGlz
c3VlIHdpdGggdHJhbnNtaXR0aW5nIHBhY2thZ2VzIGJldHdlZW4gdHdvIGd1ZXN0cy4KPiA+Pj4+
IFdpdGhvdXQgaGFja3Mgd2l0aCBza2IncyBHU08gLSBwYWNrYWdlcyBhcmUgc3RpbGwgc2VnbWVu
dGVkIG9uIHRoZSBob3N0J3MgcG9zdHJvdXRpbmcuCj4gPj4+Pgo+ID4+Pj4gQW5kcmV3IE1lbG55
Y2hlbmtvICg1KToKPiA+Pj4+ICAgIHVhcGkvbGludXgvaWZfdHVuLmg6IEFkZGVkIG5ldyBpb2N0
bCBmb3IgdHVuL3RhcC4KPiA+Pj4+ICAgIGRyaXZlci9uZXQvdHVuOiBBZGRlZCBmZWF0dXJlcyBm
b3IgVVNPLgo+ID4+Pj4gICAgdWFwaS9saW51eC92aXJ0aW9fbmV0Lmg6IEFkZGVkIFVTTyB0eXBl
cy4KPiA+Pj4+ICAgIGxpbnV4L3ZpcnRpb19uZXQuaDogQWRkZWQgU3VwcG9ydCBmb3IgR1NPX1VE
UF9MNCBvZmZsb2FkLgo+ID4+Pj4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOiBBZGRlZCBV
U08gc3VwcG9ydC4KPiA+Pj4+Cj4gPj4+PiAgIGRyaXZlcnMvbmV0L3RhcC5jICAgICAgICAgICAg
ICAgfCAxOCArKysrKysrKysrKysrKysrLS0KPiA+Pj4+ICAgZHJpdmVycy9uZXQvdHVuLmMgICAg
ICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysrLQo+ID4+Pj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQo+ID4+Pj4gICBpbmNs
dWRlL2xpbnV4L3ZpcnRpb19uZXQuaCAgICAgIHwgMTEgKysrKysrKysrKysKPiA+Pj4+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oICAgICB8ICAzICsrKwo+ID4+Pj4gICBpbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX25ldC5oIHwgIDQgKysrKwo+ID4+Pj4gICA2IGZpbGVzIGNoYW5nZWQs
IDY2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gPj4+Pgo+ID4+Pj4gLS0KPiA+Pj4+
IDIuMzQuMQo+ID4+Pj4KPiA+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gPj4+PiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiA+Pj4+IFZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPj4+PiBodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
