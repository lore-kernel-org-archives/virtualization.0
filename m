Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C5EE95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 05:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93898400CF;
	Sun,  8 Oct 2023 05:21:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93898400CF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPftFsnC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VW7NDl2CrdKi; Sun,  8 Oct 2023 05:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 249344033A;
	Sun,  8 Oct 2023 05:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 249344033A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0036EC0039;
	Sun,  8 Oct 2023 05:21:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09AA7C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB4C6821D4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB4C6821D4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPftFsnC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEEne9SdbQ59
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:20:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E930821D0
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E930821D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ltwr1aarUCyx8j6R/ivfe090hDGl0OfKeeWRWPXUe+0=;
 b=RPftFsnC13elnzAP2gRDgaiLkoKkaMLl6Hfa7KbTuYTJAxDzgbCgsSJIif6peak3rTm4DD
 aWfBX69uSBptRoonCIFHjzskIwe8WvjqFEMR0h1yG9eXU3bMweiL4/iQs5Knr7HIe4NAl2
 KtNbruau/RDQ3ApmQfInBGHfJGD1WVQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-DNVU44zoPC-F2dsZPByw_Q-1; Sun, 08 Oct 2023 01:20:55 -0400
X-MC-Unique: DNVU44zoPC-F2dsZPByw_Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50318e9067eso2995362e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 22:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742453; x=1697347253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ltwr1aarUCyx8j6R/ivfe090hDGl0OfKeeWRWPXUe+0=;
 b=EGh+PAxIB/PPQXOh7BQHsGBJTMViJ450VOs2bM8moz6xrToj8+tQ40UBXLgCRQts/a
 R34gf4rvcxCSh49d74HB3/KpCygC9Doxb9pcsRJvH4/dpWINU3zFuJQjz3f5cYwPuQiK
 E4eJImYdnOun+gs5UHB2Y/oF9nuG1yyU8+zldCKdzK0pPXVi5DHYsYAbrp3EdlqMWzd5
 O6loo8e+mvNsd3WMcGogk8g3setbqd4CpFxtzSgP3orjeV0XyuseE2ue4dpQ3/983nxU
 JqPn2BYzNCeuRlles0pe9BHIi9APwEsraf4stwtvQMP2CRlgjyTb40Tevb5mKsOVrhB9
 1khQ==
X-Gm-Message-State: AOJu0YxGFo9BRiP7bctvo0J5+NZkixFMAu6XPqkMX9gAzfvMci8XKAmP
 8yl2J9MO4Vp2Cp0+e6Q/UGxr6mVptcNt46uAR+ee+vV3QM9ub089VmOssgfoZMCl6eDN7Ux1nEp
 6zs/adsxpsX/NZmpgsqNSYBTHUyZIj9rLijlw8QEKaYzKz0bUZryih3hJHQ==
X-Received: by 2002:a05:6512:239d:b0:503:364d:b93b with SMTP id
 c29-20020a056512239d00b00503364db93bmr13408059lfv.33.1696742453548; 
 Sat, 07 Oct 2023 22:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEMBXwSWw9CEVnvt3LAifJ/rGQZAyBpRAM5inTwKLDJaU/7h+HDVhb2P54DBbnfHclbOyr7dbMfbHGvssK/6I=
X-Received: by 2002:a05:6512:239d:b0:503:364d:b93b with SMTP id
 c29-20020a056512239d00b00503364db93bmr13408051lfv.33.1696742453162; Sat, 07
 Oct 2023 22:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
 <967eec7b4eaad940222448043c1098559bc484da.1695627660.git.hengqi@linux.alibaba.com>
In-Reply-To: <967eec7b4eaad940222448043c1098559bc484da.1695627660.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:20:41 +0800
Message-ID: <CACGkMEt3JOXpH5Mvqw6Xy6L1HfO2MdOKmOTH8AeoH=UV1xhmHA@mail.gmail.com>
Subject: Re: [PATCH net v2 4/6] virtio-net: fix per queue coalescing parameter
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMzo1M+KAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBXaGVuIHRoZSB1c2VyIHNldHMgYSBub24temVybyBjb2Fs
ZXNjaW5nIHBhcmFtZXRlciB0byAwIGZvciBhIHNwZWNpZmljCj4gdmlydHF1ZXVlLCBpdCBkb2Vz
IG5vdCB3b3JrIGFzIGV4cGVjdGVkLCBzbyBsZXQncyBmaXggdGhpcy4KPgo+IEZpeGVzOiAzOTRi
ZDg3NzY0YjYgKCJ2aXJ0aW9fbmV0OiBzdXBwb3J0IHBlciBxdWV1ZSBpbnRlcnJ1cHQgY29hbGVz
Y2UgY29tbWFuZCIpCj4gUmVwb3J0ZWQtYnk6IFhpYW9taW5nIFpoYW8gPHp4bTM3NzkxN0BhbGli
YWJhLWluYy5jb20+Cj4gQ2M6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiB2MS0+djI6Cj4g
ICAgIDEuIFJlbW92ZSB1c2VsZXNzIGNvbW1lbnRzLgo+Cj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDM2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
aW5kZXggNjEyMGRkNTM0M2RkLi4xMmVjM2FlMTliNjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTMy
OTYsMjcgKzMyOTYsMjMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NlbmRfbm90Zl9jb2FsX3ZxX2Nt
ZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gIHsKPiAgICAgICAgIGludCBlcnI7Cj4KPiAt
ICAgICAgIGlmIChlYy0+cnhfY29hbGVzY2VfdXNlY3MgfHwgZWMtPnJ4X21heF9jb2FsZXNjZWRf
ZnJhbWVzKSB7Cj4gLSAgICAgICAgICAgICAgIGVyciA9IHZpcnRuZXRfc2VuZF9jdHJsX2NvYWxf
dnFfY21kKHZpLCByeHEydnEocXVldWUpLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlYy0+cnhfY29hbGVzY2VfdXNlY3MsCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjLT5yeF9tYXhfY29h
bGVzY2VkX2ZyYW1lcyk7Cj4gLSAgICAgICAgICAgICAgIGlmIChlcnIpCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsKPiAtICAgICAgICAgICAgICAgLyogU2F2ZSBwYXJhbWV0
ZXJzICovCj4gLSAgICAgICAgICAgICAgIHZpLT5ycVtxdWV1ZV0uaW50cl9jb2FsLm1heF91c2Vj
cyA9IGVjLT5yeF9jb2FsZXNjZV91c2VjczsKPiAtICAgICAgICAgICAgICAgdmktPnJxW3F1ZXVl
XS5pbnRyX2NvYWwubWF4X3BhY2tldHMgPSBlYy0+cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4g
LSAgICAgICB9Cj4gKyAgICAgICBlcnIgPSB2aXJ0bmV0X3NlbmRfY3RybF9jb2FsX3ZxX2NtZCh2
aSwgcnhxMnZxKHF1ZXVlKSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVjLT5yeF9jb2FsZXNjZV91c2VjcywKPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVjLT5yeF9tYXhfY29hbGVzY2VkX2ZyYW1lcyk7Cj4gKyAgICAg
ICBpZiAoZXJyKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Cj4gLSAgICAgICBpZiAo
ZWMtPnR4X2NvYWxlc2NlX3VzZWNzIHx8IGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lcykgewo+
IC0gICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3NlbmRfY3RybF9jb2FsX3ZxX2NtZCh2aSwg
dHhxMnZxKHF1ZXVlKSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZWMtPnR4X2NvYWxlc2NlX3VzZWNzLAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFt
ZXMpOwo+IC0gICAgICAgICAgICAgICBpZiAoZXJyKQo+IC0gICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBlcnI7Cj4gLSAgICAgICAgICAgICAgIC8qIFNhdmUgcGFyYW1ldGVycyAqLwo+IC0g
ICAgICAgICAgICAgICB2aS0+c3FbcXVldWVdLmludHJfY29hbC5tYXhfdXNlY3MgPSBlYy0+dHhf
Y29hbGVzY2VfdXNlY3M7Cj4gLSAgICAgICAgICAgICAgIHZpLT5zcVtxdWV1ZV0uaW50cl9jb2Fs
Lm1heF9wYWNrZXRzID0gZWMtPnR4X21heF9jb2FsZXNjZWRfZnJhbWVzOwo+IC0gICAgICAgfQo+
ICsgICAgICAgdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3VzZWNzID0gZWMtPnJ4X2NvYWxl
c2NlX3VzZWNzOwo+ICsgICAgICAgdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tldHMg
PSBlYy0+cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4gKwo+ICsgICAgICAgZXJyID0gdmlydG5l
dF9zZW5kX2N0cmxfY29hbF92cV9jbWQodmksIHR4cTJ2cShxdWV1ZSksCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlYy0+dHhfY29hbGVzY2VfdXNlY3MsCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlYy0+dHhfbWF4X2Nv
YWxlc2NlZF9mcmFtZXMpOwo+ICsgICAgICAgaWYgKGVycikKPiArICAgICAgICAgICAgICAgcmV0
dXJuIGVycjsKPiArCj4gKyAgICAgICB2aS0+c3FbcXVldWVdLmludHJfY29hbC5tYXhfdXNlY3Mg
PSBlYy0+dHhfY29hbGVzY2VfdXNlY3M7Cj4gKyAgICAgICB2aS0+c3FbcXVldWVdLmludHJfY29h
bC5tYXhfcGFja2V0cyA9IGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lczsKPgo+ICAgICAgICAg
cmV0dXJuIDA7Cj4gIH0KPiAtLQo+IDIuMTkuMS42LmdiNDg1NzEwYgo+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
