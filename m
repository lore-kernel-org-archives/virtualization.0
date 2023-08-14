Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07F2C001DB
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 03:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 685A18175B;
	Mon, 14 Aug 2023 03:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 685A18175B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bB72YiIu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-UWmfSj3duM; Mon, 14 Aug 2023 03:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9690A81756;
	Mon, 14 Aug 2023 03:06:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9690A81756
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42D92C0072;
	Mon, 14 Aug 2023 03:06:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F518C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 03:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14E8A415A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 03:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14E8A415A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bB72YiIu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ktrbHgn4LxDA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 03:06:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C6F1415A7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 03:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C6F1415A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691982366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEQvLnZpHKMxmINXxgY8yNlnhaoRKs5JAeT4GwTAej0=;
 b=bB72YiIuAcijfYcLoAd+D9Z9KhbBxnOOG7ASLfq/W0BArT6apLcECG75sFnCM7cG8a3oLJ
 CHI3tU9qhwmkvmcmOPvnGuJ7FDec7i1S1cU5q3SuPo9gSkt+smPUx4IN8vCSjaaNvZS9HL
 In+dWuJApk6vKJedq7EfqbNqi+23IBM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ICCc9I7sNfeKwaDpV1T2LA-1; Sun, 13 Aug 2023 23:06:03 -0400
X-MC-Unique: ICCc9I7sNfeKwaDpV1T2LA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9dc1bfdd2so37599931fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 20:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691982361; x=1692587161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEQvLnZpHKMxmINXxgY8yNlnhaoRKs5JAeT4GwTAej0=;
 b=lSC1uoAK21k49lTV2VpeU8veeQCUkJl6u2kMKHXqRZ79758wdoCAlHgjp6339rPHGz
 cjn2Fne7f4Q3csPVA3A9E4RQ1KRqLq3Aem573zlcY3x8kws7yv6NEuu0LeXNxTZAU50l
 6GF262J/vwXBfQgxT9GKSU5qGv1MumkWEgU2EEZbttgW2x9PkOW4t7Frj5d565ZUZxAP
 rOvyG5ivSdv3pZZGRPamKpPVei/xc2F0Ovv8wMZyLq2uAROy/zw3UkBGE8P9KzdeJnw3
 +p6HUEsXq8oHZNsMc7U1dsGbiTshWFJEZpe1JpNkNfOvaxJZ1+hOqMkioZ6hZyLhsHaG
 JJEg==
X-Gm-Message-State: AOJu0YzuH9V4C1u2bCyuM0cmvbwj3DeNbNYWuXDcSHBt056FB7hCq+eW
 l52vnhCXFW6Z8ZQciNm4BFuz5Ea22DN74uFI/aUHjD18MtJKOPx/OFVOvIy2MMh1ECG0txGxKGG
 Fsk7vjKiDD25NtApPBDhzYhqDvQcvwHiNPkosPzyia4GBwcUf45E8wI0xlQ==
X-Received: by 2002:a05:651c:201:b0:2b6:c8e8:915f with SMTP id
 y1-20020a05651c020100b002b6c8e8915fmr6561105ljn.22.1691982361708; 
 Sun, 13 Aug 2023 20:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAPWsS2u1WCGu6IhHV+mL911csJPkxR6lX4zb+l6NtWUsStkFmd5o09OQZkwH4y+pfluKc9s8tjYAVczcb04=
X-Received: by 2002:a05:651c:201:b0:2b6:c8e8:915f with SMTP id
 y1-20020a05651c020100b002b6c8e8915fmr6561095ljn.22.1691982361435; Sun, 13 Aug
 2023 20:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 11:05:49 +0800
Message-ID: <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODozMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gQWRkZWQgdmlydHF1ZXVlX2RtYV9kZXYoKSB0byBn
ZXQgRE1BIGRldmljZSBmb3IgdmlydGlvLiBUaGVuIHRoZQo+IGNhbGxlciBjYW4gZG8gZG1hIG9w
ZXJhdGlvbiBpbiBhZHZhbmNlLiBUaGUgcHVycG9zZSBpcyB0byBrZWVwIG1lbW9yeQo+IG1hcHBl
ZCBhY3Jvc3MgbXVsdGlwbGUgYWRkL2dldCBidWYgb3BlcmF0aW9ucy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpTbyBJIHRoaW5rIHdlIGRvbid0IGhhdmUg
YWN0dWFsIHVzZXJzIGZvciB0aGlzIGluIHRoaXMgc2VyaWVzPyBDYW4gd2UKc2ltcGx5IGhhdmUg
YW5vdGhlciBpbmRlcGVuZGVudCBwYXRjaCBmb3IgdGhpcz8KCj4gLS0tCj4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCAxNyArKysrKysrKysrKysrKysrKwo+ICBpbmNsdWRlL2xpbnV4
L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBmOWY3NzJlODVhMzguLmJiM2Q3M2QyMjFj
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMjY1LDYgKzIyNjUsMjMgQEAgaW50IHZp
cnRxdWV1ZV9hZGRfaW5idWZfY3R4KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ICB9Cj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KTsKPgo+ICsvKioKPiArICogdmly
dHF1ZXVlX2RtYV9kZXYgLSBnZXQgdGhlIGRtYSBkZXYKPiArICogQF92cTogdGhlIHN0cnVjdCB2
aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiArICoKPiArICogUmV0dXJucyB0aGUgZG1h
IGRldi4gVGhhdCBjYW4gYmVlbiB1c2VkIGZvciBkbWEgYXBpLgo+ICsgKi8KPiArc3RydWN0IGRl
dmljZSAqdmlydHF1ZXVlX2RtYV9kZXYoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7Cj4gKyAg
ICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsKPiArICAg
ICAgIGlmICh2cS0+dXNlX2RtYV9hcGkpCj4gKyAgICAgICAgICAgICAgIHJldHVybiB2cmluZ19k
bWFfZGV2KHZxKTsKPiArICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2RtYV9kZXYpOwoKT25lIHBvc3Np
YmxlIGNvbmNlcm4gaXMgdGhhdCBleHBvcnRpbmcgdGhpbmdzIGxpa2UgTlVMTCBtYXkgcmVzdWx0
IGluCnRoZSBzd2l0Y2ggaW4gdGhlIGNhbGxlciAoZHJpdmVyKS4gSSB3b25kZXIgaWYgaXQncyBi
ZXR0ZXIgdG8gZG8KQlVHX09OKCkgaW4gdGhlIHBhdGggb2YgTlVMTD8KClRoYW5rcwoKPiArCj4g
IC8qKgo+ICAgKiB2aXJ0cXVldWVfa2lja19wcmVwYXJlIC0gZmlyc3QgaGFsZiBvZiBzcGxpdCB2
aXJ0cXVldWVfa2ljayBjYWxsLgo+ICAgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+IGluZGV4IDhhZGQzODAzODg3Ny4uYmQ1NWEwNWVlYzA0IDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTYx
LDYgKzYxLDggQEAgaW50IHZpcnRxdWV1ZV9hZGRfc2dzKHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+
ICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLAo+ICAgICAgICAgICAgICAgICAgICAg
ICBnZnBfdCBnZnApOwo+Cj4gK3N0cnVjdCBkZXZpY2UgKnZpcnRxdWV1ZV9kbWFfZGV2KHN0cnVj
dCB2aXJ0cXVldWUgKnZxKTsKPiArCj4gIGJvb2wgdmlydHF1ZXVlX2tpY2soc3RydWN0IHZpcnRx
dWV1ZSAqdnEpOwo+Cj4gIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZShzdHJ1Y3QgdmlydHF1
ZXVlICp2cSk7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
