Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC8FCDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3DF81431F0;
	Fri, 20 Oct 2023 06:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DF81431F0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BP2lxZ7T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3PEi_TV1Jfy; Fri, 20 Oct 2023 06:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8DCBD402F6;
	Fri, 20 Oct 2023 06:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DCBD402F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 669F9C0071;
	Fri, 20 Oct 2023 06:52:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38B06C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06CF94BE7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06CF94BE7B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BP2lxZ7T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsq2XmoDmeoS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C0544BE77
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C0544BE77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697784729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
 b=BP2lxZ7TiykJYmaQPBqpDwLtzoz3M4H6M95tk8jHIa97+JgP+c3+ZH40Q0EzTLeV5sVbmo
 IepaYygZIcZTY+pjh5QBY+HWJNvea4GhyigMoe5f3Zy7E/axrTzJCnBlF5WrmNmpVDlDYe
 7TnTEl9AU/4EkWkFnHgX9PGKNADqpBc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-gZjrPErhOtyf-Yms4h3lHQ-1; Fri, 20 Oct 2023 02:52:07 -0400
X-MC-Unique: gZjrPErhOtyf-Yms4h3lHQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507d2e150c2so446056e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697784726; x=1698389526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
 b=k9B67n0cDUxryENJ5g8jELmZBo/E7/PKSyZ13ZxV2CDPKo0a8XkaGX66G8m0AdhUJ1
 zGkCWhRa5UCEVTcwewBEQEKBGZ8FhgNPLreBf89F2j0nglMO3TcCwiXSJpObLdvaT8kO
 7nF/vmx9KPmfCIVvrD6bVb9wHwlIaVhy9v6caa9TxKEgrjvBpQdPHI47iSOCKj5MsGH0
 OZDUq12TsMl0mhy9KDjOoSltvuXFB5Ta87m9oXJnvfwiTfl9+ejGrpoSVy3VOM/szxhH
 nKEL6KXiqkmP/9RTAd5CVyAhEkD7b+j616cQXdY98JFeMH02sQdI1NoPbbI3ywgQijUd
 CN5w==
X-Gm-Message-State: AOJu0Yzz0va2DXNc13eIPBJz/lWf9sy97930d2eXTOWsONlmqmXvYJiX
 NDSzdWAC7FbBZzgtkRJyXR7rHB3U4LAgbELf9bHQJnbyqp2luAJ2UschSaMsmn/bg9kHiBVAJ1h
 jEyeoqU8n18DXdmKUCe0oXAbeSAOGdnAUyM7aGOg2XpkiC+gryb8bTO9J7g==
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id
 s13-20020a056512214d00b0050799fe3237mr541285lfr.41.1697784725941; 
 Thu, 19 Oct 2023 23:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzELhpEx22FYwYPhyfWTswvFv2Oj8GyZnrYRmy1SO1OL2VvOAVbm8+PFPWb4VQn5j6eQ7znrwUmrAEcGMPA8=
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id
 s13-20020a056512214d00b0050799fe3237mr541278lfr.41.1697784725636; Thu, 19 Oct
 2023 23:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:51:54 +0800
Message-ID: <CACGkMEv7pCQ9mnqBwbGWaoFHJZO06Q=SCPvihDbSb+7cEfD0ag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 10/19] virtio_net: xsk: prevent disable tx napi
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
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gU2luY2UgeHNrJ3MgVFggcXVldWUgaXMgY29uc3Vt
ZWQgYnkgVFggTkFQSSwgaWYgc3EgaXMgYm91bmQgdG8geHNrLCB0aGVuCj4gd2UgbXVzdCBzdG9w
IHR4IG5hcGkgZnJvbSBiZWluZyBkaXNhYmxlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpby9t
YWluLmMgfCAxMCArKysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5j
IGIvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+IGluZGV4IDM4NzMzYTc4MmYxMi4uYjMyMDc3
MGU1ZjRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiArKysgYi9k
cml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jCj4gQEAgLTMyMDMsNyArMzIwMyw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9zZXRfY29hbGVzY2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykK
PiAgewo+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYp
Owo+IC0gICAgICAgaW50IHJldCwgcXVldWVfbnVtYmVyLCBuYXBpX3dlaWdodDsKPiArICAgICAg
IGludCByZXQsIHF1ZXVlX251bWJlciwgbmFwaV93ZWlnaHQsIGk7Cj4gICAgICAgICBib29sIHVw
ZGF0ZV9uYXBpID0gZmFsc2U7Cj4KPiAgICAgICAgIC8qIENhbid0IGNoYW5nZSBOQVBJIHdlaWdo
dCBpZiB0aGUgbGluayBpcyB1cCAqLwo+IEBAIC0zMjMyLDYgKzMyMzIsMTQgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Owo+Cj4gICAgICAgICBpZiAodXBkYXRlX25hcGkpIHsKPiArICAg
ICAgICAgICAgICAgLyogeHNrIHhtaXQgZGVwZW5kcyBvbiB0aGUgdHggbmFwaS4gU28gaWYgeHNr
IGlzIGFjdGl2ZSwKPiArICAgICAgICAgICAgICAgICogcHJldmVudCBtb2RpZmljYXRpb25zIHRv
IHR4IG5hcGkuCj4gKyAgICAgICAgICAgICAgICAqLwo+ICsgICAgICAgICAgICAgICBmb3IgKGkg
PSBxdWV1ZV9udW1iZXI7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAocnRubF9kZXJlZmVyZW5jZSh2aS0+c3FbaV0ueHNrLnBvb2wp
KQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiArICAg
ICAgICAgICAgICAgfQo+ICsKPiAgICAgICAgICAgICAgICAgZm9yICg7IHF1ZXVlX251bWJlciA8
IHZpLT5tYXhfcXVldWVfcGFpcnM7IHF1ZXVlX251bWJlcisrKQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHZpLT5zcVtxdWV1ZV9udW1iZXJdLm5hcGkud2VpZ2h0ID0gbmFwaV93ZWlnaHQ7Cj4g
ICAgICAgICB9Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
