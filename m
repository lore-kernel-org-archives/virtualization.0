Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA675C32771
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 01:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30509830C5;
	Thu, 22 Sep 2022 01:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30509830C5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZ/8yJTM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogUAtmccBhE1; Thu, 22 Sep 2022 01:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BF628308B;
	Thu, 22 Sep 2022 01:41:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BF628308B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7093BC0033;
	Thu, 22 Sep 2022 01:41:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A30CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8691830AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:41:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8691830AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsn0Y9ahPm0n
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:41:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDD4A8308B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDD4A8308B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663810887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIfhKq61xO6QH7rgAjTE4pO7Kfb94I1KOlakBeMYdtw=;
 b=AZ/8yJTM+8ZFpMoK6800/XI43yuxbAQqygna9YTo18o3kx2qQRoKRiOD6t1M4VmlLWmbOG
 Wtag1g2tw4gZgoMKsFUuUamjF57oWY5z3C98KTfCwYiMQEKeEOILUmMkDI8GxbLeGAwPhB
 /PGRIHKgh+1pqwu1XCkYQogTl7r3jaw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-0WfBEzDUPP-viP4cVncDqQ-1; Wed, 21 Sep 2022 21:41:26 -0400
X-MC-Unique: 0WfBEzDUPP-viP4cVncDqQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 b9-20020a17090a6e0900b00203a8013b45so4123466pjk.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 18:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=TIfhKq61xO6QH7rgAjTE4pO7Kfb94I1KOlakBeMYdtw=;
 b=sGa9pi9e8Qr9bo9NDUhSubST64cUE0k2A6UaDheRlUdLpryyWl1wb9uf4yqOyzTlr6
 /n5q1+aeZnYktMwFom7oWv7uTMv2ol6oJ5xofiIU+ayjXZ2cJDhewWzlIBrrHIegUk7h
 I9tqBrksre/AyybwVi0xAqCO4JxDLOhL2gL52OeurOppHvkiasKUPQXir6hkkB3IHc9r
 UtY6ApP2SprUpKZsyNnBNnF6u99xgKOhrlc9g1hsKos1KSDOkQhsMXJbecC3wl05Y7T9
 qaZNFtFht6bywQHms3cT9Keiik1EaWCLHx6LdurU59u4UhED2MVx2D4pw0zY3s0FIAt2
 DQTA==
X-Gm-Message-State: ACrzQf2IpOzyvlJvmhBmb6oDbXrMboUhIZTKYHUBbwdkJj7kVeT2P7H7
 zgkeI/33zqGhrWndAhPpgLU3p4lrwW/fXc2Kj8Q4nLyffnKgn3KTlsUU3R1l489x852omFv1B23
 c9skApMk/k3GuoPGZ5aoU4gE8s8A+BegpL3umMZDgjA==
X-Received: by 2002:a17:902:7795:b0:178:897e:16b2 with SMTP id
 o21-20020a170902779500b00178897e16b2mr842608pll.153.1663810885431; 
 Wed, 21 Sep 2022 18:41:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6luUiD0QV+HVUNnyL3QlSYTq4CR8EaVAumYf+PyZ5yhvh93CSjjUjNOKMM3EKCV04QYUVZ0w==
X-Received: by 2002:a17:902:7795:b0:178:897e:16b2 with SMTP id
 o21-20020a170902779500b00178897e16b2mr842582pll.153.1663810885151; 
 Wed, 21 Sep 2022 18:41:25 -0700 (PDT)
Received: from [10.72.13.82] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 r26-20020a63441a000000b0042b5095b7b4sm2638151pga.5.2022.09.21.18.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Sep 2022 18:41:24 -0700 (PDT)
Message-ID: <b271dd91-49d5-fac4-bb3d-8405099c2710@redhat.com>
Date: Thu, 22 Sep 2022 09:41:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/2] virtio-net: use mtu size as buffer length for big
 packets
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, jesse.brandeburg@intel.com, kuba@kernel.org,
 sridhar.samudrala@intel.com, loseweigh@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
References: <20220914144911.56422-1-gavinl@nvidia.com>
 <20220914144911.56422-3-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220914144911.56422-3-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Gavi Teitz <gavi@nvidia.com>
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

CuWcqCAyMDIyLzkvMTQgMjI6NDksIEdhdmluIExpIOWGmemBkzoKPiBDdXJyZW50bHkgYWRkX3Jl
Y3ZidWZfYmlnKCkgYWxsb2NhdGVzIE1BWF9TS0JfRlJBR1Mgc2VnbWVudHMgZm9yIGJpZwo+IHBh
Y2tldHMgZXZlbiB3aGVuIEdVRVNUXyogb2ZmbG9hZHMgYXJlIG5vdCBwcmVzZW50IG9uIHRoZSBk
ZXZpY2UuCj4gSG93ZXZlciwgaWYgZ3Vlc3QgR1NPIGlzIG5vdCBzdXBwb3J0ZWQsIGl0IHdvdWxk
IGJlIHN1ZmZpY2llbnQgdG8KPiBhbGxvY2F0ZSBzZWdtZW50cyB0byBjb3ZlciBqdXN0IHVwIHRo
ZSBNVFUgc2l6ZSBhbmQgbm8gZnVydGhlci4KPiBBbGxvY2F0aW5nIHRoZSBtYXhpbXVtIGFtb3Vu
dCBvZiBzZWdtZW50cyByZXN1bHRzIGluIGEgbGFyZ2Ugd2FzdGUgb2YKPiBidWZmZXIgc3BhY2Ug
aW4gdGhlIHF1ZXVlLCB3aGljaCBsaW1pdHMgdGhlIG51bWJlciBvZiBwYWNrZXRzIHRoYXQgY2Fu
Cj4gYmUgYnVmZmVyZWQgYW5kIGNhbiByZXN1bHQgaW4gcmVkdWNlZCBwZXJmb3JtYW5jZS4KPgo+
IFRoZXJlZm9yZSwgaWYgZ3Vlc3QgR1NPIGlzIG5vdCBzdXBwb3J0ZWQsIHVzZSB0aGUgTVRVIHRv
IGNhbGN1bGF0ZSB0aGUKPiBvcHRpbWFsIGFtb3VudCBvZiBzZWdtZW50cyByZXF1aXJlZC4KPgo+
IEJlbG93IGlzIHRoZSBpcGVyZiBUQ1AgdGVzdCByZXN1bHRzIG92ZXIgYSBNZWxsYW5veCBOSUMs
IHVzaW5nIHZEUEEgZm9yCj4gMSBWUSwgcXVldWUgc2l6ZSAxMDI0LCBiZWZvcmUgYW5kIGFmdGVy
IHRoZSBjaGFuZ2UsIHdpdGggdGhlIGlwZXJmCj4gc2VydmVyIHJ1bm5pbmcgb3ZlciB0aGUgdmly
dGlvLW5ldCBpbnRlcmZhY2UuCj4KPiBNVFUoQnl0ZXMpL0JhbmR3aWR0aCAoR2JpdC9zKQo+ICAg
ICAgICAgICAgICAgQmVmb3JlICAgQWZ0ZXIKPiAgICAxNTAwICAgICAgICAyMi41ICAgICAyMi40
Cj4gICAgOTAwMCAgICAgICAgMTIuOCAgICAgMjUuOQo+Cj4gQW5kIHJlc3VsdCBvZiBxdWV1ZSBz
aXplIDI1Ni4KPiBNVFUoQnl0ZXMpL0JhbmR3aWR0aCAoR2JpdC9zKQo+ICAgICAgICAgICAgICAg
QmVmb3JlICAgQWZ0ZXIKPiAgICA5MDAwICAgICAgICAyLjE1ICAgICAxMS45Cj4KPiBXaXRoIHRo
aXMgcGF0Y2ggbm8gZGVncmFkYXRpb24gaXMgb2JzZXJ2ZWQgd2l0aCBtdWx0aXBsZSBiZWxvdyB0
ZXN0cyBhbmQKPiBmZWF0dXJlIGJpdCBjb21iaW5hdGlvbnMuIFJlc3VsdHMgYXJlIHN1bW1hcml6
ZWQgYmVsb3cgZm9yIHEgZGVwdGggb2YKPiAxMDI0LiBJbnRlcmZhY2UgTVRVIGlzIDE1MDAgaWYg
TVRVIGZlYXR1cmUgaXMgZGlzYWJsZWQuIE1UVSBpcyBzZXQgdG8gOTAwMAo+IGluIG90aGVyIHRl
c3RzLgo+Cj4gRmVhdHVyZXMvICAgICAgICAgICAgICBCYW5kd2lkdGggKEdiaXQvcykKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEJlZm9yZSAgIEFmdGVyCj4gbXR1IG9mZiAgICAgICAgICAg
ICAgICAgICAyMC4xICAgICAyMC4yCj4gbXR1L2luZGlyZWN0IG9uICAgICAgICAgICAxNy40ICAg
ICAxNy4zCj4gbXR1L2luZGlyZWN0L3BhY2tlZCBvbiAgICAxNy4yICAgICAxNy4yCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBHYXZpbiBMaSA8Z2F2aW5sQG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEdh
dmkgVGVpdHogPGdhdmlAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxw
YXJhdkBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+IFJldmlld2VkLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNs
ZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAt
LS0KPiBjaGFuZ2Vsb2c6Cj4gdjUtPnY2Cj4gLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBKYXNv
biBhbmQgTWljaGFlbCBTLiBUc2lya2luCj4gLSBSZW1vdmUgd3JvbmcgY29tbWl0IGxvZyBkZXNj
cmlwdGlvbgo+IC0gUmVuYW1lIHZpcnRuZXRfc2V0X2JpZ19wYWNrZXRzX2ZpZWxkcyB3aXRoIHZp
cnRuZXRfc2V0X2JpZ19wYWNrZXRzCj4gLSBBZGQgbW9yZSB0ZXN0IHJlc3VsdHMgZm9yIGRpZmZl
cmVudCBmZWF0dXJlIGNvbWJpbmF0aW9ucwo+IHY0LT52NQo+IC0gQWRkcmVzc2VkIGNvbW1lbnRz
IGZyb20gTWljaGFlbCBTLiBUc2lya2luCj4gLSBJbXByb3ZlIGNvbW1pdCBtZXNzYWdlCj4gdjMt
PnY0Cj4gLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBTaS1XZWkKPiAtIFJlbmFtZSBiaWdfcGFj
a2V0c19zZ19udW0gd2l0aCBiaWdfcGFja2V0c19udW1fc2tiZnJhZ3MKPiB2Mi0+djMKPiAtIEFk
ZHJlc3NlZCBjb21tZW50cyBmcm9tIFNpLVdlaQo+IC0gU2ltcGxpZnkgdGhlIGNvbmRpdGlvbiBj
aGVjayB0byBlbmFibGUgdGhlIG9wdGltaXphdGlvbgo+IHYxLT52Mgo+IC0gQWRkcmVzc2VkIGNv
bW1lbnRzIGZyb20gSmFzb24sIE1pY2hhZWwsIFNpLVdlaS4KPiAtIFJlbW92ZSB0aGUgZmxhZyBv
ZiBndWVzdCBHU08gc3VwcG9ydCwgc2V0IHNnX251bSBmb3IgYmlnIHBhY2tldHMgYW5kCj4gICAg
dXNlIGl0IGRpcmVjdGx5Cj4gLSBSZWNhbGN1bGF0ZSBzZ19udW0gZm9yIGJpZyBwYWNrZXRzIGlu
IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzCj4gLSBSZXBsYWNlIHRoZSByb3VuZCB1cCBhbGdv
cml0aG0gd2l0aCBESVZfUk9VTkRfVVAKPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBp
bmRleCBmNTRjNzE4Mjc1OGYuLjcxMDY5MzJjNmY4OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjI1
LDYgKzIyNSw5IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ICAgCS8qIEkgbGlrZS4uLiBiaWcg
cGFja2V0cyBhbmQgSSBjYW5ub3QgbGllISAqLwo+ICAgCWJvb2wgYmlnX3BhY2tldHM7Cj4gICAK
PiArCS8qIG51bWJlciBvZiBzZyBlbnRyaWVzIGFsbG9jYXRlZCBmb3IgYmlnIHBhY2tldHMgKi8K
PiArCXVuc2lnbmVkIGludCBiaWdfcGFja2V0c19udW1fc2tiZnJhZ3M7Cj4gKwo+ICAgCS8qIEhv
c3Qgd2lsbCBtZXJnZSByeCBidWZmZXJzIGZvciBiaWcgcGFja2V0cyAoc2hha2UgaXQhIHNoYWtl
IGl0ISkgKi8KPiAgIAlib29sIG1lcmdlYWJsZV9yeF9idWZzOwo+ICAgCj4gQEAgLTEzMzEsMTAg
KzEzMzQsMTAgQEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9iaWcoc3RydWN0IHZpcnRuZXRfaW5m
byAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiAgIAljaGFyICpwOwo+ICAgCWludCBp
LCBlcnIsIG9mZnNldDsKPiAgIAo+IC0Jc2dfaW5pdF90YWJsZShycS0+c2csIE1BWF9TS0JfRlJB
R1MgKyAyKTsKPiArCXNnX2luaXRfdGFibGUocnEtPnNnLCB2aS0+YmlnX3BhY2tldHNfbnVtX3Nr
YmZyYWdzICsgMik7Cj4gICAKPiAtCS8qIHBhZ2UgaW4gcnEtPnNnW01BWF9TS0JfRlJBR1MgKyAx
XSBpcyBsaXN0IHRhaWwgKi8KPiAtCWZvciAoaSA9IE1BWF9TS0JfRlJBR1MgKyAxOyBpID4gMTsg
LS1pKSB7Cj4gKwkvKiBwYWdlIGluIHJxLT5zZ1t2aS0+YmlnX3BhY2tldHNfbnVtX3NrYmZyYWdz
ICsgMV0gaXMgbGlzdCB0YWlsICovCj4gKwlmb3IgKGkgPSB2aS0+YmlnX3BhY2tldHNfbnVtX3Nr
YmZyYWdzICsgMTsgaSA+IDE7IC0taSkgewo+ICAgCQlmaXJzdCA9IGdldF9hX3BhZ2UocnEsIGdm
cCk7Cj4gICAJCWlmICghZmlyc3QpIHsKPiAgIAkJCWlmIChsaXN0KQo+IEBAIC0xMzY1LDcgKzEz
NjgsNyBAQCBzdGF0aWMgaW50IGFkZF9yZWN2YnVmX2JpZyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSwgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+ICAgCj4gICAJLyogY2hhaW4gZmlyc3QgaW4g
bGlzdCBoZWFkICovCj4gICAJZmlyc3QtPnByaXZhdGUgPSAodW5zaWduZWQgbG9uZylsaXN0Owo+
IC0JZXJyID0gdmlydHF1ZXVlX2FkZF9pbmJ1ZihycS0+dnEsIHJxLT5zZywgTUFYX1NLQl9GUkFH
UyArIDIsCj4gKwllcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVmKHJxLT52cSwgcnEtPnNnLCB2aS0+
YmlnX3BhY2tldHNfbnVtX3NrYmZyYWdzICsgMiwKPiAgIAkJCQkgIGZpcnN0LCBnZnApOwo+ICAg
CWlmIChlcnIgPCAwKQo+ICAgCQlnaXZlX3BhZ2VzKHJxLCBmaXJzdCk7Cj4gQEAgLTM2OTAsMTMg
KzM2OTMsMjcgQEAgc3RhdGljIGJvb2wgdmlydG5ldF9jaGVja19ndWVzdF9nc28oY29uc3Qgc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICAJCXZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwg
VklSVElPX05FVF9GX0dVRVNUX1VGTyk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydG5l
dF9zZXRfYmlnX3BhY2tldHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIGNvbnN0IGludCBtdHUp
Cj4gK3sKPiArCWJvb2wgZ3Vlc3RfZ3NvID0gdmlydG5ldF9jaGVja19ndWVzdF9nc28odmkpOwo+
ICsKPiArCS8qIElmIGRldmljZSBjYW4gcmVjZWl2ZSBBTlkgZ3Vlc3QgR1NPIHBhY2tldHMsIHJl
Z2FyZGxlc3Mgb2YgbXR1LAo+ICsJICogYWxsb2NhdGUgcGFja2V0cyBvZiBtYXhpbXVtIHNpemUs
IG90aGVyd2lzZSBsaW1pdCBpdCB0byBvbmx5Cj4gKwkgKiBtdHUgc2l6ZSB3b3J0aCBvbmx5Lgo+
ICsJICovCj4gKwlpZiAobXR1ID4gRVRIX0RBVEFfTEVOIHx8IGd1ZXN0X2dzbykgewo+ICsJCXZp
LT5iaWdfcGFja2V0cyA9IHRydWU7Cj4gKwkJdmktPmJpZ19wYWNrZXRzX251bV9za2JmcmFncyA9
IGd1ZXN0X2dzbyA/IE1BWF9TS0JfRlJBR1MgOiBESVZfUk9VTkRfVVAobXR1LCBQQUdFX1NJWkUp
Owo+ICsJfQo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+ICAgewo+ICAgCWludCBpLCBlcnIgPSAtRU5PTUVNOwo+ICAgCXN0
cnVjdCBuZXRfZGV2aWNlICpkZXY7Cj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmk7Cj4gICAJ
dTE2IG1heF9xdWV1ZV9wYWlyczsKPiAtCWludCBtdHU7Cj4gKwlpbnQgbXR1ID0gMDsKPiAgIAo+
ICAgCS8qIEZpbmQgaWYgaG9zdCBzdXBwb3J0cyBtdWx0aXF1ZXVlL3JzcyB2aXJ0aW9fbmV0IGRl
dmljZSAqLwo+ICAgCW1heF9xdWV1ZV9wYWlycyA9IDE7Cj4gQEAgLTM3ODQsMTAgKzM4MDEsNiBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4g
ICAJSU5JVF9XT1JLKCZ2aS0+Y29uZmlnX3dvcmssIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29y
ayk7Cj4gICAJc3Bpbl9sb2NrX2luaXQoJnZpLT5yZWZpbGxfbG9jayk7Cj4gICAKPiAtCS8qIElm
IHdlIGNhbiByZWNlaXZlIEFOWSBHU08gcGFja2V0cywgd2UgbXVzdCBhbGxvY2F0ZSBsYXJnZSBv
bmVzLiAqLwo+IC0JaWYgKHZpcnRuZXRfY2hlY2tfZ3Vlc3RfZ3NvKHZpKSkKPiAtCQl2aS0+Ymln
X3BhY2tldHMgPSB0cnVlOwo+IC0KPiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19ORVRfRl9NUkdfUlhCVUYpKQo+ICAgCQl2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgPSB0cnVl
Owo+ICAgCj4gQEAgLTM4NTMsMTIgKzM4NjYsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2Jl
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCj4gICAJCWRldi0+bXR1ID0gbXR1Owo+
ICAgCQlkZXYtPm1heF9tdHUgPSBtdHU7Cj4gLQo+IC0JCS8qIFRPRE86IHNpemUgYnVmZmVycyBj
b3JyZWN0bHkgaW4gdGhpcyBjYXNlLiAqLwo+IC0JCWlmIChkZXYtPm10dSA+IEVUSF9EQVRBX0xF
TikKPiAtCQkJdmktPmJpZ19wYWNrZXRzID0gdHJ1ZTsKPiAgIAl9Cj4gICAKPiArCXZpcnRuZXRf
c2V0X2JpZ19wYWNrZXRzKHZpLCBtdHUpOwo+ICsKPiAgIAlpZiAodmktPmFueV9oZWFkZXJfc2cp
Cj4gICAJCWRldi0+bmVlZGVkX2hlYWRyb29tID0gdmktPmhkcl9sZW47Cj4gICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
