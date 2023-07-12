Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33478EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3C3340604;
	Wed, 12 Jul 2023 08:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3C3340604
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2azKyay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bbL4x3W1KfBs; Wed, 12 Jul 2023 08:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E61F40142;
	Wed, 12 Jul 2023 08:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E61F40142
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF404C0072;
	Wed, 12 Jul 2023 08:33:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1137C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D48BE813FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D48BE813FD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2azKyay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRF7kmwL2I5T
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19BF9813F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19BF9813F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvdacFEp0fHJZBwcSBoPdNOwi8cM02LSwjABkIHIvP4=;
 b=I2azKyayccD/v5U3vKNBPKrg2Z9H1/kFiATuWDObTEBnF9CMxCZlDVTkau6gwPpvDHfPig
 2skc8e3KjislrDbHehcz0L1af2pSYMMCtQ6jcRr/lTyrNLZqdD9tVb1uffCkfPByLboTlI
 nFmiLIOsS2NvBaOgVI7rXcx4tSMt960=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-n9l8SAWWPM67dq9vE89pbw-1; Wed, 12 Jul 2023 04:33:30 -0400
X-MC-Unique: n9l8SAWWPM67dq9vE89pbw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b701c82e83so62779471fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150809; x=1691742809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvdacFEp0fHJZBwcSBoPdNOwi8cM02LSwjABkIHIvP4=;
 b=NLXYFiRHWPrltA1yqVKMbK8IzB+Hyajzy1BR37Jt+SphO4LG2nWJxgFNdbjB77OHls
 tPP6qyKWss0ATbfusZBwf9NyrWKhhH+99gIutHhSDBL6CeWQzjZeU/RUBulqh5GfPv5z
 z8MTlSod7+O8mEuJti7eAJXbgIpJ3O9Q8jCkwVajyCQ/paTPhZqxmQ2a7rxw2IurQlID
 yxIluPh2rD3WHo7itBeAMWJLGlLbxdKaF5EcufoDTohCzOPyX4V8bHgszoJz5qD4e1y0
 XOiSaBUloHm+Nkz0LvCSduGo9pPOioAfJQYeFxxp9mnFcKPUyGrdb260to1XaU6fVPL8
 o2VA==
X-Gm-Message-State: ABy/qLYMumclU/TDG9iFEAbQZgQ+7OKveDr/R5wU49EsV5Gs8m39A0p9
 LeqDXDG/AJMkrg6lHpPAJORr79ZUmBIPIlJmV95J+oOpy01DnqaZQtMxxyeYjqvJqtMP1hrG3UM
 h2IBkljNImCJ8bUqHkP+2pygHZfAGKcZu3mT5vcehiB9CnnfJFmXaMdsE9g==
X-Received: by 2002:a2e:b603:0:b0:2b4:737c:e316 with SMTP id
 r3-20020a2eb603000000b002b4737ce316mr16712868ljn.14.1689150809142; 
 Wed, 12 Jul 2023 01:33:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmgozVOI0gKaZQ3hOgaTYXTianq80QHVDrFU4Y4jEsQxG9CbS08CkZMlDFE28l0iJfKv8GKqIhGpj8BU76nDU=
X-Received: by 2002:a2e:b603:0:b0:2b4:737c:e316 with SMTP id
 r3-20020a2eb603000000b002b4737ce316mr16712841ljn.14.1689150808782; Wed, 12
 Jul 2023 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:33:17 +0800
Message-ID: <CACGkMEseicSpsCZEunV_GoPR2qYfnB-kp_DvJQUg1pyED9XBkA@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6NDLigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IEFkZGVkIHZpcnRxdWV1ZV9kbWFfZGV2KCkgdG8g
Z2V0IERNQSBkZXZpY2UgZm9yIHZpcnRpby4gVGhlbiB0aGUKPiBjYWxsZXIgY2FuIGRvIGRtYSBv
cGVyYXRpb24gaW4gYWR2YW5jZS4gVGhlIHB1cnBvc2UgaXMgdG8ga2VlcCBtZW1vcnkKPiBtYXBw
ZWQgYWNyb3NzIG11bHRpcGxlIGFkZC9nZXQgYnVmIG9wZXJhdGlvbnMuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNyArKysrKysrKysrKysrKysrKwo+ICBpbmNsdWRlL2xp
bnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBkNDcxZGVlM2Y0ZjcuLjFmYjJjNmRj
YTllYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMjY1LDYgKzIyNjUsMjMgQEAgaW50
IHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ICB9Cj4gIEVY
UE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KTsKPgo+ICsvKioKPiArICog
dmlydHF1ZXVlX2RtYV9kZXYgLSBnZXQgdGhlIGRtYSBkZXYKPiArICogQF92cTogdGhlIHN0cnVj
dCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiArICoKPiArICogUmV0dXJucyB0aGUg
ZG1hIGRldi4gVGhhdCBjYW4gYmVlbiB1c2VkIGZvciBkbWEgYXBpLgo+ICsgKi8KPiArc3RydWN0
IGRldmljZSAqdmlydHF1ZXVlX2RtYV9kZXYoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7Cj4g
KyAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsKPiAr
ICAgICAgIGlmICh2cS0+dXNlX2RtYV9hcGkpCj4gKyAgICAgICAgICAgICAgIHJldHVybiB2cmlu
Z19kbWFfZGV2KHZxKTsKPiArICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2RtYV9kZXYpOwo+ICsKPiAg
LyoqCj4gICAqIHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUgLSBmaXJzdCBoYWxmIG9mIHNwbGl0IHZp
cnRxdWV1ZV9raWNrIGNhbGwuCj4gICAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5o
Cj4gaW5kZXggMmVmZDA3Yjc5ZWNmLi4zNWQxNzUxMjFjYzYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBAQCAtNjEs
NiArNjEsOCBAQCBpbnQgdmlydHF1ZXVlX2FkZF9zZ3Moc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4g
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEsCj4gICAgICAgICAgICAgICAgICAgICAg
IGdmcF90IGdmcCk7Cj4KPiArc3RydWN0IGRldmljZSAqdmlydHF1ZXVlX2RtYV9kZXYoc3RydWN0
IHZpcnRxdWV1ZSAqdnEpOwo+ICsKPiAgYm9vbCB2aXJ0cXVldWVfa2ljayhzdHJ1Y3QgdmlydHF1
ZXVlICp2cSk7Cj4KPiAgYm9vbCB2aXJ0cXVldWVfa2lja19wcmVwYXJlKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxKTsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
