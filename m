Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700B2CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EADA242495;
	Thu, 19 Oct 2023 06:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EADA242495
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bzd+cAGF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnsS5LT4-EuE; Thu, 19 Oct 2023 06:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1803E400AF;
	Thu, 19 Oct 2023 06:18:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1803E400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5474C0071;
	Thu, 19 Oct 2023 06:18:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60C30C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CA596FAD1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:18:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CA596FAD1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bzd+cAGF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8o7kRg-U_ARc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:18:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A33760BA6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:18:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A33760BA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697696331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5lP2IEwe8+p9/Axdm9QTLhS4D+SLbQCbPDvFOSM2PI=;
 b=Bzd+cAGFZ9rE4jRwSZvQyqFl4RY3qQcQo/DpVt4fQsIcdS14cWvx2arV52u0YQz1+t/rmv
 4tUOOepEN2KWYxDD5M7hiBkOD1/fm+rhK+41OBKBCsSckqE5o+ucMe6x8loG00rVmGeO2D
 KpwSYK+9n37jJ56hAY9n8y3+0w4EcZ0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-NJwqimABMh6f4DsbAgyHwg-1; Thu, 19 Oct 2023 02:18:50 -0400
X-MC-Unique: NJwqimABMh6f4DsbAgyHwg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507cafb69e8so1283012e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697696328; x=1698301128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5lP2IEwe8+p9/Axdm9QTLhS4D+SLbQCbPDvFOSM2PI=;
 b=sOhj5Q1xx3fHwgA02AmqlWm1se9/AMjRytXcR6hZAwJ9i7YmZjGqdkS9vYHUZxO2d8
 E4C8BOSeXG0irrWxu9uRwEgPxXxM+CR7DNx0fTCOb9Rk13QZtwZxNJ0XvdIEJ37u+nRa
 ttNtZs+dq3Cgd5ng7L3EcJzLKyQqJD38RLp3AJ/t2l6/uRPDxHCrGxSjGbCcUn4cL3Ae
 pRoc6w3Cz9GL8F9YtxEu2p5Nyp+1T8MoOPJ/vy0lFwCPlEXZBZM5pDs5/+RQIlhzTFoK
 22r6lLqGv2tHcyyei/uCbAlFObS1XrUiglYA3rJu1ox6VFZNWSN7ye/2gmK3LAuu8eyf
 fqqw==
X-Gm-Message-State: AOJu0Yz3nWEZWuET272VoCarLmOXIbQ6cH4FkyUojTILNHUtKy0zSAFj
 ikuzlxGl9IAXKrdyjwSq5fb47mwoASvcCEUs9nHPPR/wGPPanuiVDVjaAXS692OGbFDM8jMvCQp
 RvdohH3Pc6wjvWM8ZWXyowFYgNwsYxZAPl0bugW/ed0AxARRvMVUvv8qocQ==
X-Received: by 2002:a05:6512:3e06:b0:507:9d71:2a77 with SMTP id
 i6-20020a0565123e0600b005079d712a77mr873088lfv.17.1697696328563; 
 Wed, 18 Oct 2023 23:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKm6rGJgW6Z7BA1cTpUTUR/6KwfiGtTMHbrw0rOATMiEWNT9mWMqGW2Jy0QbHUI+LlwOQs/pr5t1Vl/fEWNyY=
X-Received: by 2002:a05:6512:3e06:b0:507:9d71:2a77 with SMTP id
 i6-20020a0565123e0600b005079d712a77mr873065lfv.17.1697696328225; Wed, 18 Oct
 2023 23:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:18:37 +0800
Message-ID: <CACGkMEvMzp3zW5OXicemuC-GetrfMdGdscY_ZY5xY_pO8eYZvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 07/19] virtio_net: separate virtnet_tx_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBzZXBhcmF0ZXMgdHdvIHN1Yi1m
dW5jdGlvbnMgZnJvbSB2aXJ0bmV0X3R4X3Jlc2l6ZSgpOgo+Cj4gKiB2aXJ0bmV0X3R4X3BhdXNl
Cj4gKiB2aXJ0bmV0X3R4X3Jlc3VtZQo+Cj4gVGhlbiB0aGUgc3Vic2VxdWVudCB2aXJ0bmV0X3R4
X3Jlc2V0KCkgY2FuIHNoYXJlIHRoZXNlIHR3byBmdW5jdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvbmV0
L3ZpcnRpby9tYWluLmMgICAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0KPiAgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaCB8ICAyICsrCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jIGIvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+
IGluZGV4IGU2YjI2MjM0MTYxOS4uOGRhODRlYTliY2JlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpby9tYWluLmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jCj4gQEAg
LTIxNTYsMTIgKzIxNTYsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwKPiAgICAgICAgIHJldHVybiBlcnI7Cj4gIH0KPgo+IC1zdGF0aWMg
aW50IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRuZXRfc3EgKnNxLCB1MzIgcmluZ19udW0p
Cj4gK3ZvaWQgdmlydG5ldF90eF9wYXVzZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0
IHZpcnRuZXRfc3EgKnNxKQo+ICB7Cj4gICAgICAgICBib29sIHJ1bm5pbmcgPSBuZXRpZl9ydW5u
aW5nKHZpLT5kZXYpOwo+ICAgICAgICAgc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+IC0gICAg
ICAgaW50IGVyciwgcWluZGV4Owo+ICsgICAgICAgaW50IHFpbmRleDsKPgo+ICAgICAgICAgcWlu
ZGV4ID0gc3EgLSB2aS0+c3E7Cj4KPiBAQCAtMjE4MiwxMCArMjE4MSwxNyBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAgbmV0
aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+Cj4gICAgICAgICBfX25ldGlmX3R4
X3VubG9ja19iaCh0eHEpOwo+ICt9Cj4KPiAtICAgICAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUo
c3EtPnZxLCByaW5nX251bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+IC0gICAgICAg
aWYgKGVycikKPiAtICAgICAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHR4
IGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gK3Zv
aWQgdmlydG5ldF90eF9yZXN1bWUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCB2aXJ0
bmV0X3NxICpzcSkKPiArewo+ICsgICAgICAgYm9vbCBydW5uaW5nID0gbmV0aWZfcnVubmluZyh2
aS0+ZGV2KTsKPiArICAgICAgIHN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiArICAgICAgIGlu
dCBxaW5kZXg7Cj4gKwo+ICsgICAgICAgcWluZGV4ID0gc3EgLSB2aS0+c3E7Cj4gKwo+ICsgICAg
ICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+Cj4gICAgICAg
ICBfX25ldGlmX3R4X2xvY2tfYmgodHhxKTsKPiAgICAgICAgIHNxLT5yZXNldCA9IGZhbHNlOwo+
IEBAIC0yMTk0LDYgKzIyMDAsMjMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6ZShzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSwKPgo+ICAgICAgICAgaWYgKHJ1bm5pbmcpCj4gICAgICAgICAg
ICAgICAgIHZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiAr
fQo+ICsKPiArc3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSwgc3RydWN0IHZpcnRuZXRfc3EgKnNxLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTMyIHJpbmdfbnVtKQo+ICt7Cj4gKyAgICAgICBpbnQgcWluZGV4LCBlcnI7Cj4gKwo+ICsg
ICAgICAgcWluZGV4ID0gc3EgLSB2aS0+c3E7Cj4gKwo+ICsgICAgICAgdmlydG5ldF90eF9wYXVz
ZSh2aSwgc3EpOwo+ICsKPiArICAgICAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUoc3EtPnZxLCBy
aW5nX251bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ICsgICAgICAgaWYgKGVycikK
PiArICAgICAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHR4IGZhaWw6IHR4
IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gKwo+ICsgICAgICAg
dmlydG5ldF90eF9yZXN1bWUodmksIHNxKTsKPiArCj4gICAgICAgICByZXR1cm4gZXJyOwo+ICB9
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaCBiL2RyaXZl
cnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmgKPiBpbmRleCA3MGVlYTIzYWRiYTYuLjJmOTMwYWYz
NTM2NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oCj4gKysr
IGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+IEBAIC0yNTYsNCArMjU2LDYgQEAg
c3RhdGljIGlubGluZSBib29sIHZpcnRuZXRfaXNfeGRwX3Jhd19idWZmZXJfcXVldWUoc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksIGludAo+Cj4gIHZvaWQgdmlydG5ldF9yeF9wYXVzZShzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJxKTsKPiAgdm9pZCB2aXJ0bmV0
X3J4X3Jlc3VtZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJx
KTsKPiArdm9pZCB2aXJ0bmV0X3R4X3BhdXNlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1
Y3QgdmlydG5ldF9zcSAqc3EpOwo+ICt2b2lkIHZpcnRuZXRfdHhfcmVzdW1lKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9zcSAqc3EpOwo+ICAjZW5kaWYKPiAtLQo+IDIu
MzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
