Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA902E7D0C9
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 04:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0AAD400DF;
	Fri, 22 Sep 2023 04:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0AAD400DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O707aBYg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHlutytyE6j2; Fri, 22 Sep 2023 04:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98369421D4;
	Fri, 22 Sep 2023 04:28:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98369421D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3938FC0071;
	Fri, 22 Sep 2023 04:28:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4741C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8011561082
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:28:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8011561082
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O707aBYg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1Nxnk9BWwTI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:28:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1332B60BAD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1332B60BAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695356884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFy+oyazE1udWqOmaR5BG1aT8fM44g/nbkjOVlFoLS4=;
 b=O707aBYgynghNRXIROz5zLDL9YiOnW6gPbAP4pFxbyepX6SoL0P1cGZGPXuvuLqiUdDGTY
 aLGghjLzvY/+oPE+3MOh7ZUt7mHh6yESKv1COEXPv44OEqF6j5OYygAkyJzP1dOGSeTaoK
 GWlxJBr84c/Nzze8RAPUWJFB5mTgoqI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-mNz-3t-PPDOonk7p66yTdQ-1; Fri, 22 Sep 2023 00:28:01 -0400
X-MC-Unique: mNz-3t-PPDOonk7p66yTdQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-503343a850aso2086062e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695356880; x=1695961680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFy+oyazE1udWqOmaR5BG1aT8fM44g/nbkjOVlFoLS4=;
 b=GyZ1NMTGENxIxI2dx38209OEEq3qvXA9LvtAtf1r5kb93UUb2gWX3QaXV3yNu/C9RS
 mwh91EW9MXLzB1HECdHku0M6RI7Ui/vHjaz9HOL/PtkJc98zlJ167/wU+c6iK+2fJ0t+
 TzyRb3K6Z9nt86e6T0PDc5b+uCCNnbigph9aIv+Eqfz4lrfYox4Sxj22k0X3bnvJBlIg
 D9/nZyvrwmBfqNb3K9OMua8XyO8OYIFUbQDazZGjiGu22pKOzavzwkgqO+O/Z8B+wqQJ
 N6D86rdato13pKDVN6sHjodSiSM9erBh/GgZPkTRHFBZxMUFAUoyKjCczaihZ5tTyHJy
 yEQw==
X-Gm-Message-State: AOJu0YyqDKcXT5dr/48taWtxl1/3jtaPWMlWGj74ak0CvFaDgPLvvg5F
 JIkh+wo+rVlmSyqike+JKVtqv9f7BXVujQT2zQOHfs26EpudG2sjY8rW7l3VVGJBcufd2GxgNDN
 INdW8FIIvyynyaibKNIsI4EtVG+/Vrgv1V2uuusseNSoDDszj+z2//xtMWw==
X-Received: by 2002:ac2:4f07:0:b0:502:fdca:2eaa with SMTP id
 k7-20020ac24f07000000b00502fdca2eaamr6908589lfr.52.1695356880486; 
 Thu, 21 Sep 2023 21:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZGTc6Dhmz4NaaKOuv0D2j30mb1sTLpGN4K2T2Dk1R2+KZ4K0ldTQZ5KU/VIEQn+mBf/RojxjjD6q5WtGfZc=
X-Received: by 2002:ac2:4f07:0:b0:502:fdca:2eaa with SMTP id
 k7-20020ac24f07000000b00502fdca2eaamr6908579lfr.52.1695356880183; Thu, 21 Sep
 2023 21:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-5-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:27:49 +0800
Message-ID: <CACGkMEtKTpJ53-XExFa8YKRd0CT1JjVWP_7manyG2Z8WQodu6Q@mail.gmail.com>
Subject: Re: [PATCH net 4/6] virtio-net: fix per queue coalescing parameter
 setting
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
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBXaGVuIHRoZSB1c2VyIHNldHMgYSBub24temVybyBjb2Fs
ZXNjaW5nIHBhcmFtZXRlciB0byAwIGZvciBhIHNwZWNpZmljCj4gdmlydHF1ZXVlLCBpdCBkb2Vz
IG5vdCB3b3JrIGFzIGV4cGVjdGVkLCBzbyBsZXQncyBmaXggdGhpcy4KPgo+IEZpeGVzOiAzOTRi
ZDg3NzY0YjYgKCJ2aXJ0aW9fbmV0OiBzdXBwb3J0IHBlciBxdWV1ZSBpbnRlcnJ1cHQgY29hbGVz
Y2UgY29tbWFuZCIpCj4gUmVwb3J0ZWQtYnk6IFhpYW9taW5nIFpoYW8gPHp4bTM3NzkxN0BhbGli
YWJhLWluYy5jb20+Cj4gQ2M6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyB8IDM2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gaW5kZXggY2U2MDE2MmQzODBhLi5mOWE3ZjZhZmQwOTkgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gQEAgLTMyOTYsMjcgKzMyOTYsMjMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NlbmRf
bm90Zl9jb2FsX3ZxX2NtZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gIHsKPiAgICAgICAg
IGludCBlcnI7Cj4KPiAtICAgICAgIGlmIChlYy0+cnhfY29hbGVzY2VfdXNlY3MgfHwgZWMtPnJ4
X21heF9jb2FsZXNjZWRfZnJhbWVzKSB7Cj4gLSAgICAgICAgICAgICAgIGVyciA9IHZpcnRuZXRf
c2VuZF9jdHJsX2NvYWxfdnFfY21kKHZpLCByeHEydnEocXVldWUpLAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlYy0+cnhfY29hbGVzY2VfdXNl
Y3MsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVjLT5yeF9tYXhfY29hbGVzY2VkX2ZyYW1lcyk7Cj4gLSAgICAgICAgICAgICAgIGlmIChlcnIp
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiAtICAgICAgICAgICAgICAg
LyogU2F2ZSBwYXJhbWV0ZXJzICovCj4gLSAgICAgICAgICAgICAgIHZpLT5ycVtxdWV1ZV0uaW50
cl9jb2FsLm1heF91c2VjcyA9IGVjLT5yeF9jb2FsZXNjZV91c2VjczsKPiAtICAgICAgICAgICAg
ICAgdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tldHMgPSBlYy0+cnhfbWF4X2NvYWxl
c2NlZF9mcmFtZXM7Cj4gLSAgICAgICB9Cj4gKyAgICAgICBlcnIgPSB2aXJ0bmV0X3NlbmRfY3Ry
bF9jb2FsX3ZxX2NtZCh2aSwgcnhxMnZxKHF1ZXVlKSwKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVjLT5yeF9jb2FsZXNjZV91c2VjcywKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjLT5yeF9tYXhfY29hbGVzY2VkX2Zy
YW1lcyk7Cj4gKyAgICAgICBpZiAoZXJyKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+
ICsgICAgICAgLyogU2F2ZSBwYXJhbWV0ZXJzICovCgpJIHRoaW5rIGNvZGUgZXhwbGFpbnMgaXRz
ZWxmLCBzbyB3ZSBjYW4gcmVtb3ZlIHRoaXMuCgpPdGhlcnMgbG9vayBnb29kLgoKVGhhbmtzCgo+
ICsgICAgICAgdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3VzZWNzID0gZWMtPnJ4X2NvYWxl
c2NlX3VzZWNzOwo+ICsgICAgICAgdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tldHMg
PSBlYy0+cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4KPiAtICAgICAgIGlmIChlYy0+dHhfY29h
bGVzY2VfdXNlY3MgfHwgZWMtPnR4X21heF9jb2FsZXNjZWRfZnJhbWVzKSB7Cj4gLSAgICAgICAg
ICAgICAgIGVyciA9IHZpcnRuZXRfc2VuZF9jdHJsX2NvYWxfdnFfY21kKHZpLCB0eHEydnEocXVl
dWUpLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlYy0+dHhfY29hbGVzY2VfdXNlY3MsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lcyk7Cj4gLSAg
ICAgICAgICAgICAgIGlmIChlcnIpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVy
cjsKPiAtICAgICAgICAgICAgICAgLyogU2F2ZSBwYXJhbWV0ZXJzICovCj4gLSAgICAgICAgICAg
ICAgIHZpLT5zcVtxdWV1ZV0uaW50cl9jb2FsLm1heF91c2VjcyA9IGVjLT50eF9jb2FsZXNjZV91
c2VjczsKPiAtICAgICAgICAgICAgICAgdmktPnNxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tl
dHMgPSBlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4gLSAgICAgICB9Cj4gKyAgICAgICBl
cnIgPSB2aXJ0bmV0X3NlbmRfY3RybF9jb2FsX3ZxX2NtZCh2aSwgdHhxMnZxKHF1ZXVlKSwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjLT50eF9jb2FsZXNj
ZV91c2VjcywKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVj
LT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lcyk7Cj4gKyAgICAgICBpZiAoZXJyKQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gZXJyOwo+ICsgICAgICAgLyogU2F2ZSBwYXJhbWV0ZXJzICovCj4gKyAg
ICAgICB2aS0+c3FbcXVldWVdLmludHJfY29hbC5tYXhfdXNlY3MgPSBlYy0+dHhfY29hbGVzY2Vf
dXNlY3M7Cj4gKyAgICAgICB2aS0+c3FbcXVldWVdLmludHJfY29hbC5tYXhfcGFja2V0cyA9IGVj
LT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lczsKPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAt
LQo+IDIuMTkuMS42LmdiNDg1NzEwYgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
