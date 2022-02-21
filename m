Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F32C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 03:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5A1C813BB;
	Mon, 21 Feb 2022 03:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVKnWzTJtB1B; Mon, 21 Feb 2022 03:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51E71813B7;
	Mon, 21 Feb 2022 03:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29F2FC0033;
	Mon, 21 Feb 2022 03:40:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDDEC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3947C4088C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOa_jnpNTTfi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7442640629
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645414822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ypSbCPo0Gk9NMaMcen+IxNOtD8mEJFJ/jbVr1mxKkM=;
 b=DZLKs7Rsn+9FlVhNlSHo2+e/ezI1xd7j9eIMCnpuLaBWUXFLg48B+v53boZKF4BkIgRaLP
 ZbycDd6ADspf1p+Ni20wTmZUw/OGYw65fO8t+OqqMAXiINJIVaCiqicxZDIijuc56c94DJ
 9vIrDi8HvFtfn1UCr/YA7gU0qbE6EBY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-44H8P0DQOnCFL8VEewXbzg-1; Sun, 20 Feb 2022 22:40:21 -0500
X-MC-Unique: 44H8P0DQOnCFL8VEewXbzg-1
Received: by mail-pf1-f199.google.com with SMTP id
 y127-20020a626485000000b004f1027d72a7so2149508pfb.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 19:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8ypSbCPo0Gk9NMaMcen+IxNOtD8mEJFJ/jbVr1mxKkM=;
 b=t0qZxUk7zkudWCOsmtJBe4n0dl8Y3/139nHS9H/uDa39W17J/iPwkm6LQj7vwrpJhu
 MLRNAXNiJA+lXMNbi5/xpmMDFQJ2PQUaJ82Q7JTEC/Pqa6OlPIz1cI9URlu6RF1HBYam
 BYBqbmTe3/O/jbNxrcdbkyDmmJJqdU9/HYbZceIzbULKxHWmIEkozjib1PwD2ZCYT9J7
 r46NvEwHKfI3VzuINTCkLts0sOc8Us/fRvFrezTULAbikoFv9jImSIEMHV/C+ZtdDIOS
 xOyPAJLNKm6vknVJ23Bsql7kRaPnPk1YEgznZc58BNzkxTDoAC/vzj77Hjr7+0DcHM4E
 mmlw==
X-Gm-Message-State: AOAM5329dwsAV8OtrU4gunjfPNK+DDokUQ9DmtTBBRFGd/xWEAyKrsbC
 g1dBN64cVZ8Drf9GqtBussiWZ+/NtFyCS03wd4rrSvcq7s1s9LIwzv3fPpxmrClCwIsa7HpV6Hb
 /lFh/nLYZ0kYAgTvRYk3ufKsHUW/tuyJndW1ToxN2fQ==
X-Received: by 2002:a17:902:e34b:b0:14f:af20:4b3c with SMTP id
 p11-20020a170902e34b00b0014faf204b3cmr4544198plc.56.1645414819994; 
 Sun, 20 Feb 2022 19:40:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzcIuqLJzByhSvItSubyW/3yRd7BPYRbICv/iy2A+xDF+LqUyhbDkizahPkdOQEPRwWAdvZA==
X-Received: by 2002:a17:902:e34b:b0:14f:af20:4b3c with SMTP id
 p11-20020a170902e34b00b0014faf204b3cmr4544182plc.56.1645414819532; 
 Sun, 20 Feb 2022 19:40:19 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e3sm13908239pga.74.2022.02.20.19.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 19:40:19 -0800 (PST)
Message-ID: <2a7acc5a-2c4d-2176-efd6-2aa828833587@redhat.com>
Date: Mon, 21 Feb 2022 11:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
 <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
 <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
 <1645090228.2917905-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1645090228.2917905-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzIvMTcg5LiL5Y2INTozMCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUaHUsIDE3
IEZlYiAyMDIyIDE1OjIxOjI2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4gT24gV2VkLCBGZWIgMTYsIDIwMjIgYXQgMzo1MiBQTSBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPj4+IE9uIFdlZCwgMTYgRmViIDIwMjIg
MTI6MTQ6MzEgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pj4+IE9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDQ6MTQgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4+Pj4+IFNldHMgdGhlIGRlZmF1bHQgbWF4aW11bSBy
aW5nIG51bSBiYXNlZCBvbiB2aXJ0aW9fc2V0X21heF9yaW5nX251bSgpLgo+Pj4+Pgo+Pj4+PiBU
aGUgZGVmYXVsdCBtYXhpbXVtIHJpbmcgbnVtIGlzIDEwMjQuCj4+Pj4gSGF2aW5nIGEgZGVmYXVs
dCB2YWx1ZSBpcyBwcmV0dHkgdXNlZnVsLCBJIHNlZSAzMksgaXMgdXNlZCBieSBkZWZhdWx0IGZv
ciBJRkNWRi4KPj4+Pgo+Pj4+IFJldGhpbmsgdGhpcywgaG93IGFib3V0IGhhdmluZyBhIGRpZmZl
cmVudCBkZWZhdWx0IHZhbHVlIGJhc2VkIG9uIHRoZSBzcGVlZD8KPj4+Pgo+Pj4+IFdpdGhvdXQg
U1BFRURfRFVQTEVYLCB3ZSB1c2UgMTAyNC4gT3RoZXJ3aXNlCj4+Pj4KPj4+PiAxMGcgNDA5Ngo+
Pj4+IDQwZyA4MTkyCj4+PiBXZSBjYW4gZGVmaW5lIGRpZmZlcmVudCBkZWZhdWx0IHZhbHVlcyBv
ZiB0eCBhbmQgcnggYnkgdGhlIHdheS4gVGhpcyB3YXkgSSBjYW4KPj4+IGp1c3QgdXNlIGl0IGlu
IHRoZSBuZXcgaW50ZXJmYWNlIG9mIGZpbmRfdnFzKCkuCj4+Pgo+Pj4gd2l0aG91dCBTUEVFRF9E
VVBMRVg6ICB0eCA1MTIgcnggMTAyNAo+Pj4KPj4gQW55IHJlYXNvbiB0aGF0IFRYIGlzIHNtYWxs
ZXIgdGhhbiBSWD8KPj4KPiBJJ3ZlIHNlZW4gc29tZSBOSUMgZHJpdmVycyB3aXRoIGRlZmF1bHQg
dHggc21hbGxlciB0aGFuIHJ4LgoKCkludGVyZXN0aW5nLCBkbyB0aGV5IHVzZSBjb21iaW5lZCBj
aGFubmVscz8KCgo+Cj4gT25lIHByb2JsZW0gSSBoYXZlIG5vdyBpcyB0aGF0IGluc2lkZSB2aXJ0
bmV0X3Byb2JlLCBpbml0X3ZxcyBpcyBiZWZvcmUgZ2V0dGluZwo+IHNwZWVkL2R1cGxleC4gSSdt
IG5vdCBzdXJlLCBjYW4gdGhlIGxvZ2ljIHRvIGdldCBzcGVlZC9kdXBsZXggYmUgcHV0IGJlZm9y
ZQo+IGluaXRfdnFzPyBJcyB0aGVyZSBhbnkgcmlzaz8KPgo+IENhbiB5b3UgaGVscCBtZT8KCgpU
aGUgZmVhdHVyZSBoYXMgYmVlbiBuZWdvdGlhdGVkIGR1cmluZyBwcm9iZSgpLCBzbyBJIGRvbid0
IHNlZSBhbnkgcmlzay4KClRoYW5rcwoKCj4KPiBUaGFua3MuCj4KPj4gVGhhbmtzCj4+Cj4+PiBU
aGFua3MuCj4+Pgo+Pj4KPj4+PiBldGMuCj4+Pj4KPj4+PiAoVGhlIG51bWJlciBhcmUganVzdCBj
b3BpZWQgZnJvbSB0aGUgMTBnLzQwZyBkZWZhdWx0IHBhcmFtZXRlciBmcm9tCj4+Pj4gb3RoZXIg
dmVuZG9ycykKPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgIGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQgKysrKwo+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+PiBpbmRleCBhNGZmZDdjZGY2MjMu
Ljc3ZTYxZmUwYjJjZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+PiBAQCAtMzUsNiArMzUs
OCBAQCBtb2R1bGVfcGFyYW0obmFwaV90eCwgYm9vbCwgMDY0NCk7Cj4+Pj4+ICAgI2RlZmluZSBH
T09EX1BBQ0tFVF9MRU4gKEVUSF9ITEVOICsgVkxBTl9ITEVOICsgRVRIX0RBVEFfTEVOKQo+Pj4+
PiAgICNkZWZpbmUgR09PRF9DT1BZX0xFTiAgMTI4Cj4+Pj4+Cj4+Pj4+ICsjZGVmaW5lIFZJUlRO
RVRfREVGQVVMVF9NQVhfUklOR19OVU0gMTAyNAo+Pj4+PiArCj4+Pj4+ICAgI2RlZmluZSBWSVJU
TkVUX1JYX1BBRCAoTkVUX0lQX0FMSUdOICsgTkVUX1NLQl9QQUQpCj4+Pj4+Cj4+Pj4+ICAgLyog
QW1vdW50IG9mIFhEUCBoZWFkcm9vbSB0byBwcmVwZW5kIHRvIHBhY2tldHMgZm9yIHVzZSBieSB4
ZHBfYWRqdXN0X2hlYWQgKi8KPj4+Pj4gQEAgLTMwNDUsNiArMzA0Nyw4IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIGN0eFtyeHEydnEoaSldID0gdHJ1ZTsKPj4+Pj4gICAgICAgICAgfQo+
Pj4+Pgo+Pj4+PiArICAgICAgIHZpcnRpb19zZXRfbWF4X3JpbmdfbnVtKHZpLT52ZGV2LCBWSVJU
TkVUX0RFRkFVTFRfTUFYX1JJTkdfTlVNKTsKPj4+Pj4gKwo+Pj4+PiAgICAgICAgICByZXQgPSB2
aXJ0aW9fZmluZF92cXNfY3R4KHZpLT52ZGV2LCB0b3RhbF92cXMsIHZxcywgY2FsbGJhY2tzLAo+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5hbWVzLCBjdHgsIE5VTEwp
Owo+Pj4+PiAgICAgICAgICBpZiAocmV0KQo+Pj4+PiAtLQo+Pj4+PiAyLjMxLjAKPj4+Pj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
