Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DC6CDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9883A4EB94;
	Fri, 20 Oct 2023 06:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9883A4EB94
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eDT+MNOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IuatC2U8HYBR; Fri, 20 Oct 2023 06:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 119314BE77;
	Fri, 20 Oct 2023 06:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 119314BE77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED703C0071;
	Fri, 20 Oct 2023 06:54:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91C95C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79A7B610EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79A7B610EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eDT+MNOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AoZZDyVqml_n
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:54:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C279A60ED7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C279A60ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697784852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
 b=eDT+MNObxNsY+KxwuI1rAxALs7IT23vxsa6+Qk+4+znD8oEVKjSHkbVujMenLgfypgyAKE
 oGHHTAhjVX3eZ8ZjcrNAHPkkN6/iKH1cgS/H0vbpieNtO81XApFwHn1CbW1rJ2pqAFI3FA
 ZDEygjDXIlM+R3DNSdpWB/IHeMMUGis=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-I2LWkbkHMVGORHE1hmp2Hg-1; Fri, 20 Oct 2023 02:54:11 -0400
X-MC-Unique: I2LWkbkHMVGORHE1hmp2Hg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079630993dso438305e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697784850; x=1698389650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
 b=B+u56zpDpoT/uBdGhGduWOme1/a16YAJCyKU7vZ9jJ/PLqmz5/Fs56pWB79LZfTBzr
 ohtO5I3tXkgXY5FaIpeXiWXR/fWT6PyA0raOAk6nNYJHxyN9jTaCv/EcxWggWKuH2jRp
 L/D3uzjmuX2FTmH6M826Pr6JyaZuylC4XZ9+4JaJlMtsOCQqOct5mYzUILyKIMdSxviA
 Gs0r/EZxiwx+s2/+QY8nViDvF5Sw/ulO5FboTWPMNs8D7koPhHHAKgWT4C0uqT0gpgWm
 k8kZarT3AeQ/6XDMfci64WtrmGXPrV4Irqs0/FtqY9g+wZPKbaZY2fpZ9r6vv25/AeT1
 B4VA==
X-Gm-Message-State: AOJu0YzWOA8mDTbhbvs77TmSHpL292t30o1WUD5YdbTsoIlIG3bybk9h
 gUFG4+rK+Ht4DMyMr77ARgjOeNtLwfibkcLeQIgQVXMm/EZAiKPh0u32QCE9t7grBaEZWv14hNd
 Kj9qIYLVdIMj//UKYmfpufXznPluBEFGKNUxtWeMgQS6JvrvNx0pJ2DcjnQ==
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id
 i19-20020ac25233000000b00506899d1994mr568147lfl.52.1697784849615; 
 Thu, 19 Oct 2023 23:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOn/oJyJJPOYLBOv/fMkCipSGgZNHIW13oOFcOt53IHv46J5tRmnf3LsN5yPokvReRkUsdi5w2tb1PpviVoOo=
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id
 i19-20020ac25233000000b00506899d1994mr568135lfl.52.1697784849320; Thu, 19 Oct
 2023 23:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:53:58 +0800
Message-ID: <CACGkMEvHRcjeomqqxpPQc1wjw64qcthNT=AbDoUJUkMWwgyDag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 14/19] virtio_net: xsk: tx:
 virtnet_sq_free_unused_buf() check xsk buffer
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYoKSBj
aGVjayB4c2sgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKVGhhbmtzCgoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvL21haW4uYyB8IDYgKysr
Ky0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpby9tYWluLmMKPiBpbmRleCAxYTIyMjIyMTM1MmUuLjU4YmIzOGY5YjQ1MyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
L21haW4uYwo+IEBAIC0zODc2LDEwICszODc2LDEyIEBAIHN0YXRpYyB2b2lkIGZyZWVfcmVjZWl2
ZV9wYWdlX2ZyYWdzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+Cj4gIHZvaWQgdmlydG5ldF9z
cV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikKPiAgewo+
IC0gICAgICAgaWYgKCF2aXJ0bmV0X2lzX3hkcF9mcmFtZShidWYpKQo+ICsgICAgICAgaWYgKHZp
cnRuZXRfaXNfc2tiX3B0cihidWYpKQo+ICAgICAgICAgICAgICAgICBkZXZfa2ZyZWVfc2tiKGJ1
Zik7Cj4gLSAgICAgICBlbHNlCj4gKyAgICAgICBlbHNlIGlmICh2aXJ0bmV0X2lzX3hkcF9mcmFt
ZShidWYpKQo+ICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lKHZpcnRuZXRfcHRyX3Rv
X3hkcChidWYpKTsKPiArCj4gKyAgICAgICAvKiB4c2sgYnVmZmVyIGRvIG5vdCBuZWVkIGhhbmRs
ZS4gKi8KPiAgfQo+Cj4gIHZvaWQgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZp
cnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
