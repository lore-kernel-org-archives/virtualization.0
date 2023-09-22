Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C5E7D0C9
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 04:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DBCD41919;
	Fri, 22 Sep 2023 04:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DBCD41919
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c0AeUu9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1QluVJlQz1aW; Fri, 22 Sep 2023 04:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E55C740443;
	Fri, 22 Sep 2023 04:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E55C740443
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFBF5C0071;
	Fri, 22 Sep 2023 04:30:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC8CAC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C606A421CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C606A421CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c0AeUu9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VT8u03PLb0-5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7AAC4217A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7AAC4217A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695357026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUFaHgjxsCSWxW3Zs7AMTx7rbfdV9FlW7vh7gI4YaTs=;
 b=c0AeUu9C2uCJ92nOE12Wu3ECwiNw2+xH0XqLNUWAZ/FEt3fOcNwFUmxKWkOm9rmBKA/8xX
 ku/x6vrCPt7/JDbvqtKLAQxghpseI0ayccJ41uFh11gixq9yF8MH0uAhTvrX7CyHJiyZ6A
 /pfd1P2KZZ2AEgjifqzwvSbXjaL3T0Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-qJ7kkfPWPcebMx0G7xWxhA-1; Fri, 22 Sep 2023 00:30:25 -0400
X-MC-Unique: qJ7kkfPWPcebMx0G7xWxhA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bfe60dfbc3so21265151fa.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695357024; x=1695961824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUFaHgjxsCSWxW3Zs7AMTx7rbfdV9FlW7vh7gI4YaTs=;
 b=fpdAIoi2A1ZYNMFP/VsXm+rx3r1aVUqvw0j3d9AFMIYenDr6KxCrmNLQ3RP+1dam0l
 oKlijlYPTtmKIMDq9zpvsSNZS5T7332EGq6k4szsSfyXJo8/VwX5fdodQv8BcdAHZLy8
 0YaOVe1JijQeq2HauScBb6AlJ+/Z7steX6dLlmpaBY6T5Yu95KQjUHWwasO7NyPyh+an
 Ar/mOszowC2xRo04HlNo6SaXYDnR8j7GNlNHuAqlNgxS5YlHpycyux7MFogDrBUJe7Cc
 uJtxgFUmXxyReHiQDiCfpmYAY5QK1vS4Tr7LSFleNCKo7c/cNsbfcDW6MNJYm+nvTeHv
 6r7w==
X-Gm-Message-State: AOJu0YzHJ57D/Q8YPQA0o+WWB4CTNlOkmptMA64x3ZUpkcQaKzQT6K0y
 k+k5nO5Rf4cdMTRF2qWHPDujnuzIhd9oUrGZZ2BTJO1KyY5u+RtveorxQr1TU3Q0i+vxG27LmW8
 aPD0S7fmqXQ8/RakJDpt1lEhS4o+OlfxC2dPjJRVLdv0ZKhvtzElDFl7Hyw==
X-Received: by 2002:a2e:a0c5:0:b0:2b9:eb9d:cc51 with SMTP id
 f5-20020a2ea0c5000000b002b9eb9dcc51mr6047221ljm.49.1695357023946; 
 Thu, 21 Sep 2023 21:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbRHum9yQcEIpco8ikNB6ODIPRJCNuE5KXcZo0RlUVCtvIUuzVGjGqrtYZlIC3GLdJ125Hoj4Nnk9ZdNfQQ8=
X-Received: by 2002:a2e:a0c5:0:b0:2b9:eb9d:cc51 with SMTP id
 f5-20020a2ea0c5000000b002b9eb9dcc51mr6047215ljm.49.1695357023591; Thu, 21 Sep
 2023 21:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-7-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-7-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:30:12 +0800
Message-ID: <CACGkMEv1f3QQJ3HbAq=7Q7o9C1Mntcrmz+B+sbvD2dpe6ONq3Q@mail.gmail.com>
Subject: Re: [PATCH net 6/6] virtio-net: a tiny comment update
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBVcGRhdGUgYSBjb21tZW50IGJlY2F1c2UgdmlydGlvLW5l
dCBub3cgc3VwcG9ydHMgYm90aAo+IFZJUlRJT19ORVRfRl9OT1RGX0NPQUwgYW5kIFZJUlRJT19O
RVRfRl9WUV9OT1RGX0NPQUwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGlu
dXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiBpbmRleCA5ODg4MjE4YWJhYjQuLmRkNDk4ZmE0NjhjMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAt
MzM0Nyw3ICszMzQ3LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NlbmRfbm90Zl9jb2FsX3ZxX2Nt
ZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gIHN0YXRpYyBpbnQgdmlydG5ldF9jb2FsX3Bh
cmFtc19zdXBwb3J0ZWQoc3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVjKQo+ICB7Cj4gICAgICAg
ICAvKiB1c2VjcyBjb2FsZXNjaW5nIGlzIHN1cHBvcnRlZCBvbmx5IGlmIFZJUlRJT19ORVRfRl9O
T1RGX0NPQUwKPiAtICAgICAgICAqIGZlYXR1cmUgaXMgbmVnb3RpYXRlZC4KPiArICAgICAgICAq
IG9yIFZJUlRJT19ORVRfRl9WUV9OT1RGX0NPQUwgZmVhdHVyZSBpcyBuZWdvdGlhdGVkLgo+ICAg
ICAgICAgICovCj4gICAgICAgICBpZiAoZWMtPnJ4X2NvYWxlc2NlX3VzZWNzIHx8IGVjLT50eF9j
b2FsZXNjZV91c2VjcykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+IC0t
Cj4gMi4xOS4xLjYuZ2I0ODU3MTBiCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
