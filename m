Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53ECC001B0
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 04:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15ABA60F51;
	Mon, 14 Aug 2023 04:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15ABA60F51
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F3h7bkrc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLCpfQbB-oyz; Mon, 14 Aug 2023 04:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE6F2600B9;
	Mon, 14 Aug 2023 04:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE6F2600B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71DA7C0072;
	Mon, 14 Aug 2023 04:38:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC6FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 04:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 180D860B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 04:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 180D860B9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3N5HaBUKB9v
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 04:38:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F4ED600B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 04:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F4ED600B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691987922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aK0SJ5Ys3aL4eIY1ULDHKa+YKSKcNhoW58WmpbgTceE=;
 b=F3h7bkrc4mBHV0cI9+e8cCLkRwoxPtAQFMdpfna3i/FmQTibPNNTsZqqhhUshqtanoYwNM
 rqRl5wZPkzCxgjEmAaAozCc3PtkUiWYOkVWbQa8T8jjacIxZIgXUHGWFb5PlKOPcuVb+pv
 FsoLRGJ1zDTTLEyxZi83pghRfXv/S/0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-WEJzJjJSMnC_rdVhQVy2MA-1; Mon, 14 Aug 2023 00:38:41 -0400
X-MC-Unique: WEJzJjJSMnC_rdVhQVy2MA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9dc1bfdd2so38105271fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 21:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691987919; x=1692592719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aK0SJ5Ys3aL4eIY1ULDHKa+YKSKcNhoW58WmpbgTceE=;
 b=XJdFbXr7d0ZfNuvu1P3HpAILfkHMh1NrbFhhS4o9mRg+gwiVg8L7oJ4tDOgEHZcJSc
 vPRYgseMdlGu3xVoLuy/sUR3EKU3Ty7XZZzZFDincttAaky/EVskhFcxf2L+j/aERw78
 VsAo09+s97Gy7PJQgMQC79gD2vHXqBV3KXz2ZGC0IK/ndW4y3/HS/hRZUnnwlpYLQibV
 W4BO8koY0S1vk2NUVVlBhfryYkVFGli/c90rkTy0Gz8zSmvauzbHGQndnQePmWhs5dWA
 cBfAMIrt/jYAbHnFTJJuJhmlQynb/c59GYSby4kYGJYec92n9a9ZACJn2nt8QGPpGpQC
 pQFw==
X-Gm-Message-State: AOJu0Yyc/Y5TXGOgqkDO+q9RcF1i/AS+IeadgIacpIbDUvHVMFg0/frS
 hDCPScnrfZJ60kLGw01563KQQrAY2UnPM+1BhKr8++h+q4hjmmsVHkgNX4r98BatEi+1DNOXg87
 cQWuC1H1VMoyplUzmRauOZKjJwybu936l28G9v4DBxOPCnUQ9LHYPPLH3UA==
X-Received: by 2002:a2e:b712:0:b0:2b4:6eb0:2a27 with SMTP id
 j18-20020a2eb712000000b002b46eb02a27mr5968656ljo.17.1691987919725; 
 Sun, 13 Aug 2023 21:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPgsJX7lmRRXk9QZtHBISV4+zSZ0QOhF0u67nsy81U9FUxM1FnoRDpxfZLXAQcZCxRxHts49gu6GBBBeW2d/I=
X-Received: by 2002:a2e:b712:0:b0:2b4:6eb0:2a27 with SMTP id
 j18-20020a2eb712000000b002b46eb02a27mr5968639ljo.17.1691987919420; Sun, 13
 Aug 2023 21:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230811065512.22190-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 12:38:28 +0800
Message-ID: <CACGkMEugNDGufpcK0apumz6+MdptoshMPuVWB4Czo1Z5jw1UyA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] virtio-net: support dynamic notification
 coalescing moderation
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMjo1NeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBOb3csIHZpcnRpby1uZXQgYWxyZWFkeSBzdXBwb3J0cyBw
ZXItcXVldWUgbm90aWZpY2F0aW9uIGNvYWxlc2NpbmcgcGFyYW1ldGVyCj4gc2V0dGluZy4gQmFz
ZWQgb24gdGhpcywgd2UgdXNlIHRoZSBuZXRkaW0gbGlicmFyeVsxXSBvZiBsaW51eCB0byBzdXBw
b3J0Cj4gZHluYW1pYyBub3RpZmljYXRpb24gY29hbGVzY2luZyBtb2RlcmF0aW9uIGZvciB2aXJ0
aW8tbmV0Lgo+Cj4gWzFdIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL25ldHdvcmtpbmcvbmV0X2Rp
bS5odG1sCgpEbyB5b3UgaGF2ZSBwZXJmIG51bWJlcnM/CgpUaGFua3MKCj4KPiBUaGlzIHNlcmll
cyBhbHNvIGludHJvZHVjZXMgc29tZSBleHRyYWN0aW9ucyBhbmQgZml4ZXMuIFBsZWFzZSByZXZp
ZXcuCj4KPiBIZW5nIFFpICg4KToKPiAgIHZpcnRpby1uZXQ6IGluaXRpYWxseSBjaGFuZ2UgdGhl
IHZhbHVlIG9mIHR4LWZyYW1lcwo+ICAgdmlydGlvLW5ldDogZml4IG1pc21hdGNoIG9mIGdldHRp
bmcgdHhxIHR4LWZyYW1lcyBwYXJhbQo+ICAgdmlydGlvLW5ldDogcmV0dXJucyB3aGV0aGVyIG5h
cGkgaXMgY29tcGxldGUKPiAgIHZpcnRpby1uZXQ6IHNlcGFyYXRlIHJ4L3R4IGNvYWxlc2Npbmcg
bW9kZXJhdGlvbiBjbWRzCj4gICB2aXJ0aW8tbmV0OiBleHRyYWN0IHZpcnRxdWV1ZSBjb2FsZXNj
aWcgY21kIGZvciByZXVzZQo+ICAgdmlydGlvLW5ldDogc3VwcG9ydCByeCBuZXRkaW0KPiAgIHZp
cnRpby1uZXQ6IHN1cHBvcnQgdHggbmV0ZGltCj4gICB2aXJ0aW8tbmV0OiBhIHRpbnkgY29tbWVu
dCB1cGRhdGUKPgo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAzNzAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMTYgaW5zZXJ0
aW9ucygrKSwgNTQgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuMTkuMS42LmdiNDg1NzEwYgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
