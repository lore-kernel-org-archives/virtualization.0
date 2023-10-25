Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC35C25B48
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 02:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A7A884CDA;
	Wed, 25 Oct 2023 02:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A7A884CDA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aR3vGzaO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hGvC_PAWQOSE; Wed, 25 Oct 2023 02:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 11E4184CD6;
	Wed, 25 Oct 2023 02:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11E4184CD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C8AC0039;
	Wed, 25 Oct 2023 02:43:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D759C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 02:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0025370567
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 02:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0025370567
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aR3vGzaO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xn5vLHpJQ6-n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 02:43:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 307D3703C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 02:43:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 307D3703C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698201801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMy0WvwakBGIjMhprmavDWjMT3nj91uWvZ7aWtqt65s=;
 b=aR3vGzaOv6dylBEIlQZ0CkO0pozMjQ2pmrVv4W77OqHbohHI95qmpvFPG7MHtETLrf9bYB
 +NSgYitU5/9NbfFsOnWeifOsYdFl4HyFNhZNpHNN+HVdtqUi3Mmg6UXabLQn88qFmejk12
 gHnciKw2emfJo1zeodWekV5Aq1HOpxE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-bSqbZtDkM16q98piyY-5Lw-1; Tue, 24 Oct 2023 22:43:15 -0400
X-MC-Unique: bSqbZtDkM16q98piyY-5Lw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a00a2357so223656e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 19:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698201793; x=1698806593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMy0WvwakBGIjMhprmavDWjMT3nj91uWvZ7aWtqt65s=;
 b=VErVwVVyZOMxldsRq28ngGJiWLyl8fOlUrCd8JcRMignoOHM8rTUfphV8T08q3RYFo
 6TarbQx0Ved5lB3fVRCFUXPBNGlNlVXLeFSoS3L7xnBijW7V4cOH1q6rPPsJPicZk0ez
 +8adxs2+lfNPaGYSLZmqzDm4YXQvW0peVFlDV2wwyl56V1AhgSpvdPxxqU7N8h3mnHeq
 pkffvM6T6ngkgoMEaVwbSmitFLwbzPI0RGe+SLGpU7FidijZYSYKkKHCBEhBpqONyoU3
 8Zq1c9XOdhhcfbO1+DT24pjSyFxfEqDASZhAIkUSj5EBE3CCGhPcemQPwa9u1fBtrFgO
 18bA==
X-Gm-Message-State: AOJu0YyTaPlYmUMREfVSRrnrduBN0rNtyTr7tclfkX/LqiUZnfs82CjQ
 gQAR2LkIrGvnDKfy5oimuKG5Ts2pbWcKjlIZLCHsarHmpWlNlhsWbHprBNYrt6kxb1sL8OaDro3
 MZgmvxLS/W76UyR1QhnBk5+ToF6G7LfMOQh7ZUbNjfGHaghAUos1ziKixDg==
X-Received: by 2002:a05:6512:398a:b0:500:d96e:f6eb with SMTP id
 j10-20020a056512398a00b00500d96ef6ebmr6516404lfu.19.1698201793696; 
 Tue, 24 Oct 2023 19:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1Tj4bCK7ErZJcY6f0xD7qjhSzka+4hzM92V8cxi0KqWCOwX9cAmCnfZbOj55G5BLUs8xYtGJXPKaaSizYpc=
X-Received: by 2002:a05:6512:398a:b0:500:d96e:f6eb with SMTP id
 j10-20020a056512398a00b00500d96ef6ebmr6516389lfu.19.1698201793294; Tue, 24
 Oct 2023 19:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <ca2cef5c582bea958e300b39eb508d08675d1106.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <ca2cef5c582bea958e300b39eb508d08675d1106.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 10:43:01 +0800
Message-ID: <CACGkMEskTyU6i82ZzN8Rt_ROAXLzM-Wni0zA31ur2QZ6wht8PQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio-net: returns whether napi is complete
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMzo0NOKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiByeCBuZXRkaW0gbmVlZHMgdG8gY291bnQgdGhlIHRyYWZm
aWMgZHVyaW5nIGEgY29tcGxldGUgbmFwaSBwcm9jZXNzLAo+IGFuZCBzdGFydCB1cGRhdGluZyBh
bmQgY29tcGFyaW5nIHNhbXBsZXMgdG8gbWFrZSBkZWNpc2lvbnMgYWZ0ZXIKPiB0aGUgbmFwaSBl
bmRzLiBMZXQgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoKSByZXR1cm4gdHJ1ZSBpZiBuYXBpIGlz
IGRvbmUsCj4gb3RoZXJ3aXNlIHZpY2UgdmVyc2EuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIZW5nIFFp
IDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgNiArKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IGE1MmZkNzQzNTA0YS4uY2Y1ZDJlZjRiZDI0IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+IEBAIC00MzEsNyArNDMxLDcgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX25h
cGlfc2NoZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ICAgICAgICAgfQo+ICB9Cj4K
PiAtc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoc3RydWN0IG5hcGlfc3RydWN0
ICpuYXBpLAo+ICtzdGF0aWMgYm9vbCB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShzdHJ1Y3QgbmFw
aV9zdHJ1Y3QgKm5hcGksCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEsIGludCBwcm9jZXNzZWQpCj4gIHsKPiAgICAgICAgIGludCBvcGFx
dWU7Cj4gQEAgLTQ0MCw5ICs0NDAsMTMgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfY29t
cGxldGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ICAgICAgICAgaWYgKG5hcGlfY29tcGxl
dGVfZG9uZShuYXBpLCBwcm9jZXNzZWQpKSB7Cj4gICAgICAgICAgICAgICAgIGlmICh1bmxpa2Vs
eSh2aXJ0cXVldWVfcG9sbCh2cSwgb3BhcXVlKSkpCj4gICAgICAgICAgICAgICAgICAgICAgICAg
dmlydHF1ZXVlX25hcGlfc2NoZWR1bGUobmFwaSwgdnEpOwo+ICsgICAgICAgICAgICAgICBlbHNl
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4gICAgICAgICB9IGVsc2Ug
ewo+ICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYih2cSk7Cj4gICAgICAgICB9
Cj4gKwo+ICsgICAgICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgc2tiX3ht
aXRfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiAtLQo+IDIuMTkuMS42LmdiNDg1NzEwYgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
