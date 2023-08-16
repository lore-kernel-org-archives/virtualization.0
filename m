Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5701EC001B0
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 02:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DED248138F;
	Wed, 16 Aug 2023 02:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DED248138F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivfv7coN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxFfCuKzbJof; Wed, 16 Aug 2023 02:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E1A981384;
	Wed, 16 Aug 2023 02:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E1A981384
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04BCFC0072;
	Wed, 16 Aug 2023 02:33:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5032E418EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5032E418EF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivfv7coN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6U4O-JmxI5N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:33:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2686041816
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2686041816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692153228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNW1zQdlSA+EBMwsqEGzK2TiH2hiDgSEYVGqzy81FKw=;
 b=ivfv7coNyr6G+K3BeKepxNRJ84eDyBcx4Vcwp8fvdAPFGUcQfluj/pnOVX80BilVvAn3lQ
 16jeI9TZUF6hpWv5/5tL/i8HawOKrWFcS0Qv/Oo/3nnv4AiZEUntgi0jQCx2SQza/aHJwJ
 SqMVHQdS/khQ9Vd5RFF4fhpWrPphWYU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-PTH2BTbTOGqXAub_gilmAA-1; Tue, 15 Aug 2023 22:33:47 -0400
X-MC-Unique: PTH2BTbTOGqXAub_gilmAA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba0f144938so63921841fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 19:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692153226; x=1692758026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNW1zQdlSA+EBMwsqEGzK2TiH2hiDgSEYVGqzy81FKw=;
 b=WVN6sFEnmFGZrf1eJSrl7NhGfkpGOzlm0fTA9pCC7H3keVT46TGCWunxUDbqkdpT3I
 iQbJ5FXKvNYuqVLRamUZKBowrObrb9f5gHhs/c7Fp4lmjislrkxmiHOKIBJswYrroRcP
 1QjMglV50CfQo9uUQw/HCBT0bHdI7hTufNBxLv3Ajj/o3LhyzCmcZQNEmyk92ECmEn1x
 imYdgrMlgNv9i0ruApnt3G7yHT2grLtyQxToOSMLIixAKnynIuze6mVBuqYK5eaEYUXO
 Dgy0EYPQGpvCAyzL4jySp/QLeGFQrBjRuvYFdl2Dzk2vkCow3JPcgCB0wY0oWX8280mq
 EzQQ==
X-Gm-Message-State: AOJu0YwSRO+ODLefDwTNdDfuwBehMXTnW2bCEA3qGCDb5rs2l7dkhIGF
 nFFfYQerUjLGSD6X8KaLsT7vGFAkcVXL1WFIgiCuwoOg9fggrWkv/zG3PkxmP7X35ZXJ/aOy7AF
 szg9b8JD0vbfFdGsjweYjUdI7/t4nhJQe9i+h7KmhxrjNbBoVeAzb1Ta6tg==
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id
 v20-20020a2e87d4000000b002b9cd3d4136mr426229ljj.2.1692153225915; 
 Tue, 15 Aug 2023 19:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuqvZAnE6ML8oI2NAwZU1V3nFQiHWJ1QHjUqgo9pCf+uRWTz3qikCM4YBJ7Mh6JT7RKQu36d2mSMT50bmGwcU=
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id
 v20-20020a2e87d4000000b002b9cd3d4136mr426215ljj.2.1692153225633; Tue, 15 Aug
 2023 19:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
 <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:33:34 +0800
Message-ID: <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMTA6MjTigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMTYgQXVnIDIwMjMgMTA6MTk6MzQg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gV2Vk
LCBBdWcgMTYsIDIwMjMgYXQgMTA6MTbigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gV2VkLCAxNiBBdWcgMjAyMyAwOToxMzo0
OCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4g
T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNTo0MOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFR1ZSwgMTUgQXVn
IDIwMjMgMTU6NTA6MjMgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEhpLCBKYXNvbgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gQ291bGQgeW91IHNraXAgdGhpcyBwYXRjaD8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
SSdtIGZpbmUgd2l0aCBlaXRoZXIgbWVyZ2luZyBvciBkcm9wcGluZyB0aGlzLgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTGV0IHdlIHJldmlldyBvdGhlciBwYXRjaGVz
IGZpcnN0bHk/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBz
b29uLCBhbmQgd29uJ3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+ID4g
PiA+ID4KPiA+ID4gPiA+IEhhdmUgYSBoYXBwbHkgdmFjYXRpb24uCj4gPiA+ID4gPgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBCdXQgSSBzcG90IHR3byBwb3NzaWJsZSAiaXNzdWVzIjoKPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gMSkgdGhlIERNQSBtZXRhZGF0YSB3ZXJlIHN0b3JlZCBpbiB0aGUg
aGVhZHJvb20gb2YgdGhlIHBhZ2UsIHRoaXMKPiA+ID4gPiA+ID4gYnJlYWtzIGZyYWdzIGNvYWxl
c2NpbmcsIHdlIG5lZWQgdG8gYmVuY2htYXJrIGl0J3MgaW1wYWN0Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gTm90IGV2ZXJ5IHBhZ2UsIGp1c3QgdGhlIGZpcnN0IHBhZ2Ugb2YgdGhlIENPTVAgcGFnZXMu
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gU28gSSB0aGluayB0aGVyZSBpcyBubyBpbXBhY3QuCj4gPiA+
ID4KPiA+ID4gPiBOb3BlLCBzZWUgdGhpczoKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgaWYgKFNL
Ql9GUkFHX1BBR0VfT1JERVIgJiYKPiA+ID4gPiAgICAgICAgICAgICAhc3RhdGljX2JyYW5jaF91
bmxpa2VseSgmbmV0X2hpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZV9rZXkpKSB7Cj4gPiA+ID4gICAg
ICAgICAgICAgICAgIC8qIEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8g
d2FrZSAqLwo+ID4gPiA+ICAgICAgICAgICAgICAgICBwZnJhZy0+cGFnZSA9IGFsbG9jX3BhZ2Vz
KChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0pIHwKPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX0dGUF9DT01QIHwgX19HRlBfTk9XQVJOIHwKPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX0dGUF9OT1JF
VFJZLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNL
Ql9GUkFHX1BBR0VfT1JERVIpOwo+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAobGlrZWx5KHBm
cmFnLT5wYWdlKSkgewo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBmcmFnLT5zaXpl
ID0gUEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JERVI7Cj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4gPiA+ID4gICAgICAgICAgICAgICAgIH0KPiA+ID4g
PiAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+IFRoZSBjb21wIHBhZ2UgbWlnaHQgYmUgZGlzYWJs
ZWQgZHVlIHRvIHRoZSBTS0JfRlJBR19QQUdFX09SREVSIGFuZAo+ID4gPiA+IG5ldF9oaWdoX29y
ZGVyX2FsbG9jX2Rpc2FibGVfa2V5Lgo+ID4gPgo+ID4gPgo+ID4gPiBZRVMuCj4gPiA+Cj4gPiA+
IEJ1dCBpZiBjb21wIHBhZ2UgaXMgZGlzYWJsZWQuIFRoZW4gd2Ugb25seSBnZXQgb25lIHBhZ2Ug
ZWFjaCB0aW1lLiBUaGUgcGFnZXMgYXJlCj4gPiA+IG5vdCBjb250aWd1b3VzLCBzbyB3ZSBkb24n
dCBoYXZlIGZyYWdzIGNvYWxlc2NpbmcuCj4gPiA+Cj4gPiA+IElmIHlvdSBtZWFuIHRoZSB0d28g
cGFnZXMgZ290IGZyb20gYWxsb2NfcGFnZSBtYXkgYmUgY29udGlndW91cy4gVGhlIGNvYWxlc2Np
bmcKPiA+ID4gbWF5IHRoZW4gYmUgYnJva2VuLiBJdCdzIGEgcG9zc2liaWxpdHksIGJ1dCBJIHRo
aW5rIHRoZSBpbXBhY3Qgd2lsbCBiZSBzbWFsbC4KPiA+Cj4gPiBMZXQncyBoYXZlIGEgc2ltcGxl
IGJlbmNobWFyayBhbmQgc2VlPwo+Cj4KPiBUaGF0IGlzIG9rLgo+Cj4gSSB0aGluayB5b3Ugd2Fu
dCB0byBrbm93IHRoZSBwZXJmIG51bSB3aXRoIGJpZyB0cmFmZmljIGFuZCB0aGUgY29tcCBwYWdl
Cj4gZGlzYWJsZWQuCgpZZXMuCgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPgo+ID4KPiA+IFRoYW5r
cwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gMikgcHJlIG1hcHBlZCBETUEgYWRkcmVzc2VzIHdlcmUgbm90
IHJldXNlZCBpbiB0aGUgY2FzZSBvZiBYRFBfVFgvWERQX1JFRElSRUNUCj4gPiA+ID4gPgo+ID4g
PiA+ID4gQmVjYXVzZSB0aGF0IHRoZSB0eCBpcyBub3QgdGhlIHByZW1hcHBlZCBtb2RlLgo+ID4g
PiA+Cj4gPiA+ID4gWWVzLCB3ZSBjYW4gb3B0aW1pemUgdGhpcyBvbiB0b3AuCj4gPiA+ID4KPiA+
ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgc2VlIE1pY2hhZWwgaGFzIG1lcmdlIHRoaXMgc2Vy
aWVzIHNvIEknbSBmaW5lIHRvIGxldCBpdCBnbyBmaXJzdC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3Mu
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
