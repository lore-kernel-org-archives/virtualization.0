Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F6FE95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2F9561068;
	Sun,  8 Oct 2023 04:35:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2F9561068
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q20FFEfM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvGiPoM3R3FA; Sun,  8 Oct 2023 04:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C42D6103A;
	Sun,  8 Oct 2023 04:35:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C42D6103A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06D16C0071;
	Sun,  8 Oct 2023 04:35:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96E41C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71F936104B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:35:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71F936104B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ws7SsVj1xTPY
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:35:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 587BD6103A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 587BD6103A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
 b=Q20FFEfMkn/Us1BE9FLji2G30Ze9zjDsCM+FMhPa2Ch1EZ43Gpk80sf71BWNoPX1lxet5+
 2uc/Bnmo4EAGkjEakGg2G82ZHz5JUP1k0UIeThtCj3GecreXpoAfpfq5Q8F6Ejc8ZJwBhg
 ZcEBHRwqIqpq2uQPgYP2ftbuTHWrdss=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-K2zo822ENr2SgVi4W7yT6w-1; Sun, 08 Oct 2023 00:35:43 -0400
X-MC-Unique: K2zo822ENr2SgVi4W7yT6w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043353efbdso3036084e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739742; x=1697344542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
 b=YeLb7Tb2/6NX+ijGjV/9uhDnUovLUG6NKfGrRiQQKTfbSRcmHBfuNksqfy/UCCLdmx
 DDRqh7zaER/cFxYVH3lxvCrctPEw3X8tJcwKvduEqy8D9wVBsaSCa9haG+inQ6YP81mP
 0RHaNOftDzS2VOf5pKnztjb0bO4jqeDf4Q2PW2X64lorcaXk3OI2xUQSPl7fqKRy7Bnp
 9VZT18vj9d2Zp+qkagzP8RhQxJgjEjDF/au1XmOSwCfoFtlE57iTQ6AiLbA8AIhvKKsw
 zQnUW+Z7wWMxET0/GKqHAoAzx6I+bwBorK8fYPp4meUnyW64sQWtDMUDsVAfYxHv2VFY
 7jhA==
X-Gm-Message-State: AOJu0Yyr+MI4EEj3JPj4eQ9DzRNHUIAMFQ75YgVdo1sy7psJJUsLHOHi
 DHUOmdSpxCh+DWWBKkwIxB7nvmZUO4XOOAA9BkS9e2rmsWH6tXHwHs6E6LDD9ITg+mPNgBFkEI9
 nnT60Gguq6HrfY2t0LaJfb9t/kekaRJOdE8ujfLvor3YtgYFzDY6arQGcIQ==
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id
 m28-20020a19435c000000b0050091c19642mr10346146lfj.21.1696739741947; 
 Sat, 07 Oct 2023 21:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEesW3+LqZnNyyPWhlp2aUtbUAkF/QV4pVuw/g7/p5xHxM6btq/MV1uwbCGf05M1pAxvqEdVbSQyK8H6pYHRZo=
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id
 m28-20020a19435c000000b0050091c19642mr10346138lfj.21.1696739741529; Sat, 07
 Oct 2023 21:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:35:30 +0800
Message-ID: <CACGkMEujvBtAx=1eTqSrzyjBde=0xpC9D0sRVC7wHHf_aqfqwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
To: liming.wu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: 398776277@qq.com, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTowMOKAr1BNIDxsaW1pbmcud3VAamFndWFybWljcm8u
Y29tPiB3cm90ZToKPgo+IEZyb206IExpbWluZyBXdSA8bGltaW5nLnd1QGphZ3Vhcm1pY3JvLmNv
bT4KPgo+IE5lZWQgdG8gaW5zbW9kIHZob3N0X3Rlc3Qua28gYmVmb3JlIHJ1biB2aXJ0aW9fdGVz
dC4KPiBHaXZlIHNvbWUgaGludHMgdG8gdXNlcnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcg
V3UgPGxpbWluZy53dUBqYWd1YXJtaWNyby5jb20+Cj4gLS0tCj4gIHRvb2xzL3ZpcnRpby92aXJ0
aW9fdGVzdC5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vdmlydGlvX3Rlc3QuYyBiL3Rvb2xzL3ZpcnRpby92
aXJ0aW9fdGVzdC5jCj4gaW5kZXggMDI4ZjU0ZTY4NTRhLi5jZTJjNGQ5M2Q3MzUgMTAwNjQ0Cj4g
LS0tIGEvdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMKPiArKysgYi90b29scy92aXJ0aW8vdmly
dGlvX3Rlc3QuYwo+IEBAIC0xMzUsNiArMTM1LDEwIEBAIHN0YXRpYyB2b2lkIHZkZXZfaW5mb19p
bml0KHN0cnVjdCB2ZGV2X2luZm8qIGRldiwgdW5zaWduZWQgbG9uZyBsb25nIGZlYXR1cmVzKQo+
ICAgICAgICAgZGV2LT5idWYgPSBtYWxsb2MoZGV2LT5idWZfc2l6ZSk7Cj4gICAgICAgICBhc3Nl
cnQoZGV2LT5idWYpOwo+ICAgICAgICAgZGV2LT5jb250cm9sID0gb3BlbigiL2Rldi92aG9zdC10
ZXN0IiwgT19SRFdSKTsKPiArCj4gKyAgICAgICBpZiAoZGV2LT5jb250cm9sIDwgMCkKPiArICAg
ICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJJbnN0YWxsIHZob3N0X3Rlc3QgbW9kdWxlIiBc
Cj4gKyAgICAgICAgICAgICAgICIoLi92aG9zdF90ZXN0L3Zob3N0X3Rlc3Qua28pIGZpcnN0bHlc
biIpOwoKVGhlcmUgc2hvdWxkIGJlIG1hbnkgb3RoZXIgcmVhc29ucyB0byBmYWlsIGZvciBvcGVu
KCkuCgpMZXQncyB1c2Ugc3RyZXJyb3IoKT8KClRoYW5rcwoKCj4gICAgICAgICBhc3NlcnQoZGV2
LT5jb250cm9sID49IDApOwo+ICAgICAgICAgciA9IGlvY3RsKGRldi0+Y29udHJvbCwgVkhPU1Rf
U0VUX09XTkVSLCBOVUxMKTsKPiAgICAgICAgIGFzc2VydChyID49IDApOwo+IC0tCj4gMi4zNC4x
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
