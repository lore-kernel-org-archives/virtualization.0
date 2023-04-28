Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC04BC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 02:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 754E241DC9;
	Fri, 28 Apr 2023 02:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 754E241DC9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=h6oFHljr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cbpF7qitQ_oU; Fri, 28 Apr 2023 02:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C39641DB5;
	Fri, 28 Apr 2023 02:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C39641DB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45437C0036;
	Fri, 28 Apr 2023 02:00:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95F5BC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 695C360E5B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 695C360E5B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=h6oFHljr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZbVE6imPNcN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 214A360BFB
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 214A360BFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:17 +0000 (UTC)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-440403d3517so3636934e0c.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682647216; x=1685239216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Bu06xaZjqwdhavFM+nCEMDPQNzUKIISgFnYAUBIAag=;
 b=h6oFHljrG+HXxPmuqq2stsVnzZgqSPxUe26OkBrjJGIzolHbcrwCzznfpD8JNP0X1V
 spbVfzVFjDvR7S9HlGCRX4GesPpcLHrdYOmTgRlF2ryVQPVwrLqn/JAqpH6dwKw4DMTZ
 Mrtm/GkHlmjehI9V6YrBDNVzc5cjBIYZ+Ibg/6Hx8r/352f4zzDozQMbzbyW/BV+zdAX
 pdoVs6EOkNJgxjUb7Lr78elGeTxCa4s68Hp657YqlLLfpKJHypL4r20qUS2qh3nwEF38
 w20T2pkVHcO0r9TnEbTECCHvra6OxPelXVr2YQkIt4IGdKzR/3Bct6PRFHAO/yUpghYl
 yIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682647216; x=1685239216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Bu06xaZjqwdhavFM+nCEMDPQNzUKIISgFnYAUBIAag=;
 b=gtiB45ReXqROz1lqGveknJQwbOPCwNQViOF3DSyn3hAaH+oNkNdG6QAGebCnP3l/Xo
 vHSkcZqiHBGtUsHjesYf7IVNIdjL4p8MGbkpHA9I+aPZA86fAuvj2y7DmPBkOIfHBMrX
 67BRssE3SduyVZN2uJ0NCpM2hsQWZaUM/aWCiJX6UtL6zLVIg77p2j2B0hf+OEnHK9SL
 yEZ//PhG3ue0sS3oH/xLyX4wBEJ+2caRpa/UL07X6j3UJ7LSgf32NYSrcNwLB/nfET/Y
 xQwgjGtAdYj9jicHNbrz69Y8wWW978U0p4BeUOguEVfiydL0paMzcC6lzX13ulwA8qyL
 uz+A==
X-Gm-Message-State: AC+VfDyRN4UpokMCxK8gP8j+B8+Uh7GUEGvlPqbEt25NbQ7HJJZAZ3oM
 Wjws42emlVCLryXI9ILdcqgUIDsQQnwjzusKQQ0/cA==
X-Google-Smtp-Source: ACHHUZ5q50UOPeI0svu3+cdmdaaSAo9Ud0iFTTHsDeVc7WvvOu/Nn3vVEHATa5X99m1ESmYr6ewdb1QJqxLTp/rywBE=
X-Received: by 2002:a1f:bfd4:0:b0:440:8a24:e716 with SMTP id
 p203-20020a1fbfd4000000b004408a24e716mr1726465vkf.6.1682647215811; Thu, 27
 Apr 2023 19:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230425102250.3847395-1-mie@igel.co.jp>
 <CACGkMEumt4p7jU+H+T-b9My0buhdS8a-1GCSnWjnCwMAM=wo1Q@mail.gmail.com>
In-Reply-To: <CACGkMEumt4p7jU+H+T-b9My0buhdS8a-1GCSnWjnCwMAM=wo1Q@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Fri, 28 Apr 2023 11:00:04 +0900
Message-ID: <CANXvt5pn5uFxp1RYX+UQuVq=RyTjVZHBb-LgipFDN4L-0Z6ekg@mail.gmail.com>
Subject: Re: [PATCH v3] vringh: IOMEM support
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

MjAyM+W5tDTmnIgyNuaXpSjmsLQpIDE1OjEwIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Ogo+Cj4gT24gVHVlLCBBcHIgMjUsIDIwMjMgYXQgNjoyM+KAr1BNIFNodW5zdWtlIE1pZSA8
bWllQGlnZWwuY28uanA+IHdyb3RlOgo+ID4KPiA+IEludHJvZHVjZSBhIG5ldyBtZW1vcnkgYWNj
ZXNzb3IgZm9yIHZyaW5naC4gSXQgaXMgYWJsZSB0byB1c2UgdnJpbmdoIHRvCj4gPiB2aXJ0aW8g
cmluZ3MgbG9jYXRlZCBvbiBpby1tZW1vcnkgcmVnaW9uLgo+Cj4gSXMgdGhlcmUgYSB1c2VyIGZv
ciB0aGlzPyBJdCB3b3VsZCBiZSBiZXR0ZXIgaWYgeW91IGNhbiBkZXNjcmliZSB0aGUKPiB1c2Ug
Y2FzZXMgZm9yIHRoaXMuIE1heWJlIHlvdSBjYW4gcG9zdCB0aGUgdXNlciBvciBhdCBsZWFzdCBh
IGxpbmsgdG8KPiB0aGUgZ2l0IGFzIGEgcmVmZXJlbmNlLgpUaGlzIGlzIGZvciB0aGUgZm9sbG93
aW5nIHBhdGNoLgpodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIzMDQy
NzE3NTI0NC5HQTI2MTE5N0BiaGVsZ2Fhcy9ULyNtMzBhMjU4NTA5Y2FjYTI0MTNhMjFmOWE5Y2Uw
ZjVmZDMxZDNiZDAwNgpJJ2QgbGlrZSB0byBhZGQgYSBkZXNjcmlwdGlvbiBvZiBob3cgdGhpcyBm
ZWF0dXJlIHdpbGwgYmUgdXNlZCBpbiB0aGUKbmV4dCB2ZXJzaW9uLgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4gPiAtLS0KPiA+Cj4gPiBDaGFu
Z2VzIGZyb20gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjMw
MjAyMDkwOTM0LjU0OTU1Ni0xLW1pZUBpZ2VsLmNvLmpwLwo+ID4gLSBGb2N1cyBvbiBhbiBhZGRp
bmcgaW8gbWVtb3J5IEFQSXMKPiA+IFJlbW92ZSB2cmluZ2ggQVBJIHVuaWZpY2F0aW9uIGFuZCBz
b21lIGZpeGVzLgo+ID4gLSBSZWJhc2Ugb24gbmV4dC0yMDIzMDQxNAo+ID4KPiA+ICBkcml2ZXJz
L3Zob3N0L0tjb25maWcgIHwgICA2ICsrCj4gPiAgZHJpdmVycy92aG9zdC92cmluZ2guYyB8IDEy
OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIGluY2x1ZGUv
bGludXgvdnJpbmdoLmggfCAgMzMgKysrKysrKysrKysKPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE2
OCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvS2NvbmZp
ZyBiL2RyaXZlcnMvdmhvc3QvS2NvbmZpZwo+ID4gaW5kZXggYjQ1NWQ5YWI2ZjNkLi40YjBkYmI0
YThhYjMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L0tjb25maWcKPiA+ICsrKyBiL2Ry
aXZlcnMvdmhvc3QvS2NvbmZpZwo+ID4gQEAgLTYsNiArNiwxMiBAQCBjb25maWcgVkhPU1RfSU9U
TEIKPiA+ICAgICAgICAgICBUaGlzIG9wdGlvbiBpcyBzZWxlY3RlZCBieSBhbnkgZHJpdmVyIHdo
aWNoIG5lZWRzIHRvIHN1cHBvcnQKPiA+ICAgICAgICAgICBhbiBJT01NVSBpbiBzb2Z0d2FyZS4K
PiA+Cj4gPiArY29uZmlnIFZIT1NUX1JJTkdfSU9NRU0KPiA+ICsgICAgICAgdHJpc3RhdGUKPiA+
ICsgICAgICAgc2VsZWN0IFZIT1NUX0lPTUVNCj4gPiArICAgICAgIGhlbHAKPiA+ICsgICAgICAg
ICBUaGlzIG9wdGlvbiBlbmFibGVzIHZyaW5naCBBUElzIHRvIHN1cHBvcnRzIGlvIG1lbW9yeSBz
cGFjZS4KPgo+IFRoZXJlJ3Mgbm8gc3BlY2lmaWMgS2NvbmZpZyBmb3IgYWxsIHRoZSBleGlzdGlu
ZyBhY2Nlc3NvcnMuIEFueSByZWFzb24KPiBJL08gbWVtb3J5IGlzIHNwZWNpYWwgb3IgZG8geW91
IGNhcmUgYWJvdXQgdGhlIHNpemUgb2YgdGhlIG1vZHVsZT8KSSBmb2xsb3dlZCB0aGUgSU9UTEIg
dGhhdCBpcyB1c2VkIGZvciB2aG9zdCBhbmQgdnJpbmdoLiBIb3dldmVyLCB0aGlzIGNvZGUgaGFz
CmxpdHRsZSBlZmZlY3Qgb24gdGhlIGNvZGUgc2l6ZSBhbmQgZGVwZW5kZW5jaWVzIGlmIGluY2x1
ZGVkLCBzbyBJCndvdWxkIGxpa2UgdG8gcmVtb3ZlCnRoZSBLY29uZmlnLgo+ID4gKwo+ID4gIGNv
bmZpZyBWSE9TVF9SSU5HCj4gPiAgICAgICAgIHRyaXN0YXRlCj4gPiAgICAgICAgIHNlbGVjdCBW
SE9TVF9JT1RMQgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2
ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiBpbmRleCA5NTVkOTM4ZWI2NjMuLmNlNWE4OGVlY2MwNSAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+ICsrKyBiL2RyaXZlcnMv
dmhvc3QvdnJpbmdoLmMKPiA+IEBAIC0xNjA0LDQgKzE2MDQsMTMzIEBAIEVYUE9SVF9TWU1CT0wo
dnJpbmdoX25lZWRfbm90aWZ5X2lvdGxiKTsKPiA+Cj4gPiAgI2VuZGlmCj4gPgo+Cj4gWy4uLl0K
Pgo+ID4KPiA+IGJhc2UtY29tbWl0OiBkM2YyY2QyNDgxOTE1OGJiNzA3MDFjMzU0OWU1ODZmOWRm
OWNlZTY3Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDc2MGFiYmU4Yzk4MWM1MmNjYzQyMWI4
MTM5ZTg5OTlhYjcxNjE5YWEKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogOTlkODY3OWFiNDU2
OTU0NWM4YWY0MDFlODQxNDJjNjYzMTJlOTUzZQo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBh
Y2E4MTUxNmFiYTc1YjU4Yzg0MjJkMzdjMmRjN2RiMmY2MWZmZTkyCj4gPiBwcmVyZXF1aXNpdGUt
cGF0Y2gtaWQ6IDNkNzYxMzYyMDBjNGU1NWJhMmM0MTY4MTMyNWYyNDI4NTlkZDZkYmQKPiA+IHBy
ZXJlcXVpc2l0ZS1wYXRjaC1pZDogNDdhOTk0ZmViNjhkOTU0MTJkODFiMGZkMWZhMjdiYzdiYTA1
YWUxOAo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBhMmY3ZmMzZjM1MzU4ZjcwYjZkYWQ0Yzkx
OWNlMjkzYjEwMjk1YzRmCj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDcwZTJlZTMyYjk0NWJl
OTZhMDM4OGYwZmY1NjQ2NTFhYzkzMzUyMjAKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMjAy
MzY5MGY5YzQ3MDE3YjU2ZDdmMDM2MzMyYTVjYTNlY2U2YmRlOAo+ID4gcHJlcmVxdWlzaXRlLXBh
dGNoLWlkOiAyMTFlMTEzZmVjNmM0NTBkMTNmYmRiNDM3ZWNmYWQ2N2RlYzBhMTU3Cj4gPiBwcmVy
ZXF1aXNpdGUtcGF0Y2gtaWQ6IGYyYmNkMzE2ODkzMzg4NmU0Y2Q0YzM5ZTQ3NDQ2ZDFiZDdjYjI2
OTEKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMzdiMTMxNTYwODA4NzMzYTBiODg3OGU4NWEz
ZDJhNDZkNmFiMDJjYQo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA3OWIwMjE5YTcxNWNiNWFj
ZTIyN2Q1NTY2NmQ2MmZkYjJkY2M2ZmZlCj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDMwZjE3
NDBjZDQ4YTE5YWExYzNjOTNlNjI1Yzc0MGNhZTI4NDU0NzgKPiA+IHByZXJlcXVpc2l0ZS1wYXRj
aC1pZDogMzE5ODllNGE1MjFmMmZjNmY2OGM0Y2NkYjY5NjAwMzVlODc2NjZhNwo+ID4gcHJlcmVx
dWlzaXRlLXBhdGNoLWlkOiAzOTQ4YmIzZTBjMDQ1ZTJmZmZmMDZhNzE0ZDE3YmFiMTZjOTQ3NzVk
Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGNmMjhlMDExNWI5MTExYmNiNzdhYTljNzEwZDk4
YjJiZTkzYzdlODkKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogZWJmMjM0OWMwYWUxMjk2NjYz
ODU0ZWVlMmRhMGI0M2ZlODk3MmY5Ygo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBmYzU3MDky
MWQ4ODVhMmE2MDAwODAwYjQwMjIzMjFlNjNmMTY1MGE1Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gt
aWQ6IDFmZDUyMTlmZWYxN2MyYmYyZDc2MDAwMjA3YjI1YWFlNThjMzY4ZjMKPiA+IHByZXJlcXVp
c2l0ZS1wYXRjaC1pZDogMzRlNWYwNzgyMDI3NjJmZTY5ZGY0NzFlOTdiNTFiMTM0MWNiZGZhOQo+
ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA3ZmE1MTUxYjllMDQ4OGI0OGMyYjlkMTIxOTE1MmNm
YjA0N2Q2NTg2Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDMzY2NhMjcyNzY3YWYwNGFlOWFi
ZTdhZjJmNmNiYjk5NzJjYzBiNzcKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogYmIxYTZiZWZj
ODk5ZGQ5N2JjZDk0NmMyZDc2Y2U3MzY3NWExZmE0NQo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlk
OiAxMGJlMDRkZDkyZmE0NTFkMTM2NzZlOTFkOTA5NGI2M2NkN2ZiY2Y4Cj4gPiBwcmVyZXF1aXNp
dGUtcGF0Y2gtaWQ6IDg3Yjg2ZWI0Y2U5NTAxYmJhOWMwNGVjODEwOTRhYzkyMDIzOTI0MzEKPiA+
IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogYTVjZWQyODc2MmJmNmJkNjQxOWRhZTBlNDQxM2QwMmNj
YWZkNzJjMgo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiAyZGI0Yzk2MDNlMDBkNjliYjAxODRk
YWJjYzMxOWU3Zjc0ZjMwMzA1Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDQxOTMzZjlkNTNl
NWU5ZTAyZWZkNjE1N2I2OGVlN2Q5MmIxMGNmYTIKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDog
ZGYzMjk1YjRjZGRlM2E0NWVhZjRjNDAwNDcxNzk2OThhNDIyNGQwNQo+ID4gcHJlcmVxdWlzaXRl
LXBhdGNoLWlkOiA5ZTJmY2E5YWIwYmEyYjkzNWRhYTk2ZjE3NDVmZjRjOTA5NzkyMjMxCj4gPiBw
cmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDg5NDgzNzgwOTliYTRkNjFlMTBhODdlNjE3ZDY5ZWQyZmM0
MTA0YWUKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogNWU3NDY2ZjNmMGQ3NDg4MGQxYTU3NGEx
YmQ5MWIxMjA5MWRjZjNmNQo+ID4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA5MDI4OTllMWNkNTNi
N2ZjYzc5NzFmNjMwYWVkMTAzODMwZmMzZTNkCj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDQy
MTI2YjE4MDUwMGY5ZmYxMjNkYjc4NzQ4OTcyYzZlY2UxOGFjNTcKPiA+IHByZXJlcXVpc2l0ZS1w
YXRjaC1pZDogNTIzNmEwM2VmNTc0MDc0ZjNjMTAwOWE1MjYxMjA1MTg2MmIzMWVmZgo+ID4gcHJl
cmVxdWlzaXRlLXBhdGNoLWlkOiBhZGFlMWFhODBkZjY1YmQwMmE5ZTNmNGRiNDkwY2Y4MDFjMWM2
MTE5Cj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDIyODA2ZmNhYmI5NzNlZTVmMDRlZTYyMTJk
YjYxNjFhYWI1YmNiZmMKPiA+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogNmViMTRjZmRjMmNmMzFl
OTA1NTZmNmFmZTczNjE0MjdhMzMyZThkYwo+Cj4gVGhlc2Ugc2VlbSBtZWFuaW5nbGVzcz8KSSdt
IHNvcnJ5LCB0aGF0IGRpZG4ndCBtYWtlIHNlbnNlLiBJJ2xsIHJlbW92ZSBpdC4KPiBUaGFua3MK
Pgo+ID4gLS0KPiA+IDIuMjUuMQo+ID4KPgpCZXN0IHJlZ2FyZHMsClNodW5zdWtlCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
