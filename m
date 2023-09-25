Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18F1CE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 02:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D7A460F3D;
	Mon, 25 Sep 2023 02:30:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D7A460F3D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KNSfb7BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78vrVGauMnds; Mon, 25 Sep 2023 02:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFFF660F3F;
	Mon, 25 Sep 2023 02:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFFF660F3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D4D9C0039;
	Mon, 25 Sep 2023 02:30:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18B29C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E73AE814A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E73AE814A9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KNSfb7BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Y4jTh-8CL7Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFABC8149C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFABC8149C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695609012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPJxBbcUUYMfHcOUHqwNDKHgycKbeMx7KXqGoUlCq0E=;
 b=KNSfb7BCzCiVqF++yZt7EdQ/5SNG1laotrhgZZeprn6BWIFV1GBAn0Lzm5tgvGT0iAmEzo
 JxF5Mg/iaR2UuUr4JZWafCUz7oDw1a94noRZ9KFFEVxl8UD21q7bDpAMb0eFGF9pXPurW8
 moIUSHhmVjdgCVhPOAsfFCzp5g7RiYQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-HXlVWifbOvK6LlInWY3prw-1; Sun, 24 Sep 2023 22:30:10 -0400
X-MC-Unique: HXlVWifbOvK6LlInWY3prw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c0165b5c5cso69022951fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 19:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609009; x=1696213809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPJxBbcUUYMfHcOUHqwNDKHgycKbeMx7KXqGoUlCq0E=;
 b=a36f1oe1KiYD9xoKKn5xJIeibfrDKNdQwl9Tnu5XqCK9SiGn9bAtDlBvr5vdsCAAXW
 h77YzU9RfeNMvtJ69yRFbZvXwIwIWt76Lqgy3dJUOFjPeGXIDdr+EetgULclXsIRref+
 ntCKdvCTmjp9dGY7qXANu2uifRq88/AOLvKnqUEi9XK6OgLnJRXto9xDSYhcqIg6msqF
 0sO+ctrROatrjNcfaSxMUnqCReYeBymSm/JX+LXGsYzl3LY2rKtgIn9dDBQ8K+9HndaS
 PemSB+W2V0UqonEGfvXF+PaaqQZD4DLn9cSflkkJHjz0KqOTVafkMx2/YZlbU+iu/Zpe
 yzlg==
X-Gm-Message-State: AOJu0YzIkArDU0Z7g25JPJB1ATrjJCxDqwQkWPT7Xb3QTs/Elc8cu7vz
 XgwTBVwiSZXLNlc2DSCHMhXUFSPMHcXBrSgojGZfvkbVugTcmzBZE7hRqTuLF4TcripJVupmNJw
 kVayLyRRapwoxWeLu7Y9q/rExfCuwCvwr6KdGzQ1TlZHuBn69s5TZhHjBgQ==
X-Received: by 2002:a19:7009:0:b0:502:adbb:f9db with SMTP id
 h9-20020a197009000000b00502adbbf9dbmr4105252lfc.65.1695609009143; 
 Sun, 24 Sep 2023 19:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc/R9Qq6Bq0VtxQxiH5ufUuP57xjWU1IvwuFz8n5+CF1xdRlHYwTJnX7/Wqb0dT+dEORXfAW4JE2jOQfoIyVE=
X-Received: by 2002:a19:7009:0:b0:502:adbb:f9db with SMTP id
 h9-20020a197009000000b00502adbbf9dbmr4105238lfc.65.1695609008794; Sun, 24 Sep
 2023 19:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
 <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
 <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:29:57 +0800
Message-ID: <CACGkMEtU-F4PwfdkN0vrJ3hS-Wc3YsnTb2vY_bLUYXCSnnPb1g@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq
 resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Heng Qi <hengqi@linux.alibaba.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgNTo1NuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCAyMiBTZXAgMjAyMyAxNTozMjozOSAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBGcmks
IFNlcCAyMiwgMjAyMyBhdCAxOjAy4oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4g5ZyoIDIwMjMvOS8yMiDkuIvljYgx
MjoyOSwgSmFzb24gV2FuZyDlhpnpgZM6Cj4gPiA+ID4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQg
Mzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+
ID4+IEFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlvbiBvZiB2aXJ0cXVldWUgY29hbGVzY2luZyBz
cGVjWzFdOgo+ID4gPiA+Pgo+ID4gPiA+PiAgICBVcG9uIGRpc2FibGluZyBhbmQgcmUtZW5hYmxp
bmcgYSB0cmFuc21pdCB2aXJ0cXVldWUsIHRoZSBkZXZpY2UgTVVTVCBzZXQKPiA+ID4gPj4gICAg
dGhlIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBvZiB0aGUgdmlydHF1ZXVlIHRvIHRob3NlIGNvbmZp
Z3VyZWQgdGhyb3VnaCB0aGUKPiA+ID4gPj4gICAgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9U
WF9TRVQgY29tbWFuZCwgb3IsIGlmIHRoZSBkcml2ZXIgZGlkIG5vdCBzZXQKPiA+ID4gPj4gICAg
YW55IFRYIGNvYWxlc2NpbmcgcGFyYW1ldGVycywgdG8gMC4KPiA+ID4gPj4KPiA+ID4gPj4gICAg
VXBvbiBkaXNhYmxpbmcgYW5kIHJlLWVuYWJsaW5nIGEgcmVjZWl2ZSB2aXJ0cXVldWUsIHRoZSBk
ZXZpY2UgTVVTVCBzZXQKPiA+ID4gPj4gICAgdGhlIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBvZiB0
aGUgdmlydHF1ZXVlIHRvIHRob3NlIGNvbmZpZ3VyZWQgdGhyb3VnaCB0aGUKPiA+ID4gPj4gICAg
VklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9SWF9TRVQgY29tbWFuZCwgb3IsIGlmIHRoZSBkcml2
ZXIgZGlkIG5vdCBzZXQKPiA+ID4gPj4gICAgYW55IFJYIGNvYWxlc2NpbmcgcGFyYW1ldGVycywg
dG8gMC4KPiA+ID4gPj4KPiA+ID4gPj4gV2UgbmVlZCB0byBhZGQgdGhpcyBzZXR0aW5nIGZvciB2
cSByZXNpemUgKGV0aHRvb2wgLUcpIHdoZXJlIHZxX3Jlc2V0IGhhcHBlbnMuCj4gPiA+ID4+Cj4g
PiA+ID4+IFsxXSBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1k
ZXYvMjAyMzAzL21zZzAwNDE1Lmh0bWwKPiA+ID4gPj4KPiA+ID4gPj4gRml4ZXM6IDM5NGJkODc3
NjRiNiAoInZpcnRpb19uZXQ6IHN1cHBvcnQgcGVyIHF1ZXVlIGludGVycnVwdCBjb2FsZXNjZSBj
b21tYW5kIikKPiA+ID4gPiBJJ20gbm90IHN1cmUgdGhpcyBpcyBhIHJlYWwgZml4IGFzIHNwZWMg
YWxsb3dzIGl0IHRvIGdvIHplcm8/Cj4gPiA+Cj4gPiA+IFRoZSBzcGVjIHNheXMgdGhhdCBpZiB0
aGUgdXNlciBoYXMgY29uZmlndXJlZCBpbnRlcnJ1cHQgY29hbGVzY2luZwo+ID4gPiBwYXJhbWV0
ZXJzLAo+ID4gPiBwYXJhbWV0ZXJzIG5lZWQgdG8gYmUgcmVzdG9yZWQgYWZ0ZXIgdnFfcmVzZXQs
IG90aGVyd2lzZSBzZXQgdG8gMC4KPiA+ID4gdmktPmludHJfY29hbF90eCBhbmQgdmktPmludHJf
Y29hbF9yeCBhbHdheXMgc2F2ZSB0aGUgbmV3ZXN0IGdsb2JhbAo+ID4gPiBwYXJhbWV0ZXJzLAo+
ID4gPiByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIGNvbW1hbmQgaXMgc2VudCBvciBub3QuIFNv
IEkgdGhpbmsgd2UgbmVlZAo+ID4gPiB0aGlzIHBhdGNoCj4gPiA+IGl0IGNvbXBsaWVzIHdpdGgg
dGhlIHNwZWNpZmljYXRpb24gcmVxdWlyZW1lbnRzLgo+ID4KPiA+IEhvdyBjYW4gd2UgbWFrZSBz
dXJlIHRoZSBvbGQgY29hbGVzY2luZyBwYXJhbWV0ZXJzIHN0aWxsIG1ha2Ugc2Vuc2UKPiA+IGZv
ciB0aGUgbmV3IHJpbmcgc2l6ZT8KPgo+IEZvciB0aGUgdXNlciwgSSBkb24ndCB0aGluayB3ZSBz
aG91bGQgZHJvcCB0aGUgY29uZmlnIGZvciB0aGUgY29hbGVzY2luZy4KPiBNYXliZSB0aGUgY29u
ZmlnIGRvZXMgbm90IG1ha2Ugc2Vuc2UgZm9yIHRoZSBuZXcgcmluZyBzaXplLCBidXQgd2hlbiB0
aGUgdXNlcgo+IGp1c3QgY2hhbmdlIHRoZSByaW5nIHNpemUsIHRoZSBjb25maWcgZm9yIHRoZSBj
b2FsZXNpbmcgaXMgbWlzc2luZywgSSB0aGluawo+IHRoYXQgaXMgbm90IGdvb2QuCgpIb3cgZGlk
IG90aGVyIGRyaXZlcnMgZGVhbCB3aXRoIHRoaXM/CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPgo+
Cj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcyEKPiA+ID4KPiA+ID4gPgo+
ID4gPiA+IFRoYW5rcwo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
