Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35298E7D0C2
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 04:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABDDF81E3D;
	Fri, 22 Sep 2023 04:27:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABDDF81E3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C/uVg1YN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wl-Zom1-W5RI; Fri, 22 Sep 2023 04:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B0F881E40;
	Fri, 22 Sep 2023 04:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B0F881E40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E49C6C0071;
	Fri, 22 Sep 2023 04:27:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73D7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44BB6421D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44BB6421D1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C/uVg1YN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIFYiANxmyL0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:27:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8D35421CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8D35421CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695356819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EaqgmQfjWf4RSP054NnjKIxOwf3P8mlQqF+5e289Wk=;
 b=C/uVg1YNlo8rYzyTvMQIfwNoUiiPVUWG10O3YN2is5QtCIOunFuYqswXkmi9HPaclg61YH
 8e5sGMXbq+YdDls1u/+uyNHiWX4FA0DzvFT9567MiKItYm2bV5+snOlnoePbIDimVj0005
 WmvLVsggzbq/AqKLFj00Sf526dhIGS0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-11yvoOulPXyi7_mgMV8h8g-1; Fri, 22 Sep 2023 00:26:57 -0400
X-MC-Unique: 11yvoOulPXyi7_mgMV8h8g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c0082e04eeso20976771fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695356816; x=1695961616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EaqgmQfjWf4RSP054NnjKIxOwf3P8mlQqF+5e289Wk=;
 b=B1GgAtaoGmQNvpVUmTOKG+cvMPZOo0bN3FQs+Lo+d8tkMjc6ynNYk063GzlZnl/HRx
 c4WZaKIqo+u88oMApCeMPnt/+ujG1DPyeNTZjgOut1Wr91yBZhsY0pNp2iB5PhHy28GM
 9luAjjZSRGDLVOkgBM4A9o218zN87EZxD6hexsDr9iYQv95YGunOGw5swRgpVu4G4Uwg
 /ZdLWJJUKiWz572OI8bYh1X6Z1utLEpc7bKA6YvLU/fnpS8U/Sipo5BrJMAT5wyxijqd
 BRZGWlSoEpJIjM4kghmIG9rocxGXOvt9s5DIlEdQFHvMaIYOVyQgO9eODEfKtX6zsnTO
 yFLQ==
X-Gm-Message-State: AOJu0Yzwn6A6wBN46iw4PoBPUCP1vqom9RMmzXcPfapiKTniHRdAlc96
 SG+PdE/jjCO6tbso/SpYy4PhPMuLyBA0ezq+yrRq3gYtX1OrTo0cSpD367HNavBUve4+QIOen05
 E0OSnknEBfDoAgHlpRaAynmDerU8DGpE7IMYWK0IMaTN8QLitUF1mGx9ccQ==
X-Received: by 2002:a2e:90d5:0:b0:2bf:ff17:811b with SMTP id
 o21-20020a2e90d5000000b002bfff17811bmr6233311ljg.3.1695356816409; 
 Thu, 21 Sep 2023 21:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kt7xDg+aB1I6QHkKIhyfLUbsI0g/0L7rhAHVvAsPsk/167eY/3mb1NulDto656tDuHLO1oTrs2ZNOV+f0Oc=
X-Received: by 2002:a2e:90d5:0:b0:2bf:ff17:811b with SMTP id
 o21-20020a2e90d5000000b002bfff17811bmr6233295ljg.3.1695356816098; Thu, 21 Sep
 2023 21:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-4-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-4-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:26:45 +0800
Message-ID: <CACGkMEumtfsqmB5F+c9t+6mSkEN_UB8iS9ztTg+NfYm56mQuvg@mail.gmail.com>
Subject: Re: [PATCH net 3/6] virtio-net: consistently save parameters for
 per-queue
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBXaGVuIHVzaW5nIC5zZXRfY29hbGVzY2UgaW50ZXJmYWNl
IHRvIHNldCBhbGwgcXVldWUgY29hbGVzY2luZwo+IHBhcmFtZXRlcnMsIHdlIG5lZWQgdG8gdXBk
YXRlIGJvdGggcGVyLXF1ZXVlIGFuZCBnbG9iYWwgc2F2ZSB2YWx1ZXMuCj4KPiBGaXhlczogMzk0
YmQ4Nzc2NGI2ICgidmlydGlvX25ldDogc3VwcG9ydCBwZXIgcXVldWUgaW50ZXJydXB0IGNvYWxl
c2NlIGNvbW1hbmQiKQo+IENjOiBHYXZpbiBMaSA8Z2F2aW5sQG52aWRpYS5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyB8IDkgKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA4MGQzNWE4NjQ3OTAuLmNlNjAxNjJkMzgwYSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiBAQCAtMzIzMyw2ICszMjMzLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3NlbmRfbm90Zl9jb2FsX2NtZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVj
KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3Qgc2dzX3R4LCBzZ3Nfcng7Cj4gKyAg
ICAgICBpbnQgaTsKPgo+ICAgICAgICAgdmktPmN0cmwtPmNvYWxfdHgudHhfdXNlY3MgPSBjcHVf
dG9fbGUzMihlYy0+dHhfY29hbGVzY2VfdXNlY3MpOwo+ICAgICAgICAgdmktPmN0cmwtPmNvYWxf
dHgudHhfbWF4X3BhY2tldHMgPSBjcHVfdG9fbGUzMihlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFt
ZXMpOwo+IEBAIC0zMjQ2LDYgKzMyNDcsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NlbmRfbm90
Zl9jb2FsX2NtZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAgICAgICAvKiBTYXZlIHBh
cmFtZXRlcnMgKi8KPiAgICAgICAgIHZpLT5pbnRyX2NvYWxfdHgubWF4X3VzZWNzID0gZWMtPnR4
X2NvYWxlc2NlX3VzZWNzOwo+ICAgICAgICAgdmktPmludHJfY29hbF90eC5tYXhfcGFja2V0cyA9
IGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lczsKPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCB2
aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiArICAgICAgICAgICAgICAgdmktPnNxW2ldLmlu
dHJfY29hbC5tYXhfdXNlY3MgPSBlYy0+dHhfY29hbGVzY2VfdXNlY3M7Cj4gKyAgICAgICAgICAg
ICAgIHZpLT5zcVtpXS5pbnRyX2NvYWwubWF4X3BhY2tldHMgPSBlYy0+dHhfbWF4X2NvYWxlc2Nl
ZF9mcmFtZXM7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgIHZpLT5jdHJsLT5jb2FsX3J4LnJ4X3Vz
ZWNzID0gY3B1X3RvX2xlMzIoZWMtPnJ4X2NvYWxlc2NlX3VzZWNzKTsKPiAgICAgICAgIHZpLT5j
dHJsLT5jb2FsX3J4LnJ4X21heF9wYWNrZXRzID0gY3B1X3RvX2xlMzIoZWMtPnJ4X21heF9jb2Fs
ZXNjZWRfZnJhbWVzKTsKPiBAQCAtMzI1OSw2ICszMjY0LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9zZW5kX25vdGZfY29hbF9jbWRzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAg
LyogU2F2ZSBwYXJhbWV0ZXJzICovCj4gICAgICAgICB2aS0+aW50cl9jb2FsX3J4Lm1heF91c2Vj
cyA9IGVjLT5yeF9jb2FsZXNjZV91c2VjczsKPiAgICAgICAgIHZpLT5pbnRyX2NvYWxfcngubWF4
X3BhY2tldHMgPSBlYy0+cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4gKyAgICAgICBmb3IgKGkg
PSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gKyAgICAgICAgICAgICAgIHZp
LT5ycVtpXS5pbnRyX2NvYWwubWF4X3VzZWNzID0gZWMtPnJ4X2NvYWxlc2NlX3VzZWNzOwo+ICsg
ICAgICAgICAgICAgICB2aS0+cnFbaV0uaW50cl9jb2FsLm1heF9wYWNrZXRzID0gZWMtPnJ4X21h
eF9jb2FsZXNjZWRfZnJhbWVzOwo+ICsgICAgICAgfQo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAg
fQo+IC0tCj4gMi4xOS4xLjYuZ2I0ODU3MTBiCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
