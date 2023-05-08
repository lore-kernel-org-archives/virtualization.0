Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE453C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D3682213;
	Mon,  8 May 2023 06:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36D3682213
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BUT9VW23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2pGMVp_01px; Mon,  8 May 2023 06:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7CD3821F6;
	Mon,  8 May 2023 06:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7CD3821F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0C2C0037;
	Mon,  8 May 2023 06:14:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E54CC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 556FF60F32
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 556FF60F32
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BUT9VW23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDljx74AbxwW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4417605A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4417605A2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683526436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnGoERqYvEOx4rgm1MihSTLdb9c387eTW69LQCmBdTs=;
 b=BUT9VW23z+v/dC6oxCWBFYgsfVdRBkA/efFw6opNGiEkOHB8D6+HM7wvGdF3hwiBbTfywz
 CJ5eYvo3FSCw2mJpV+Jo3meuVXb2OnQ/NH4nIZPvzArxgahjVuseMcKJS36KV2btsEa+ya
 ItCPGFbUViIfYq1zmFXT1fLqxZO4Qsk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-BWXG3cZ4MmiBG7kbqXlliw-1; Mon, 08 May 2023 02:13:55 -0400
X-MC-Unique: BWXG3cZ4MmiBG7kbqXlliw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edc7406cb5so2394285e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683526434; x=1686118434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnGoERqYvEOx4rgm1MihSTLdb9c387eTW69LQCmBdTs=;
 b=XwZ4/re29rPPtsuPy63Rar+SwhbNBiROzhS1vVngQCCGuidzK9nEyek7jA7hFWiOG6
 3zBUQbu9622ZB0oS1EZkIzxfrO6jsOqo8Y1zZdONangr7PnmjmeklV0bjz3gFJyGojiZ
 MJFuLvjMYWPavJbl1SSzkgjtCYWcptenpQMJYPycl33BOprib2mnZDDP813fn8lUv5FM
 76AFwEXSrzaQwxnZF+MR4ciQ+Kad4l6BWs8Oe4LlWJ977NUvvXTDbWb5UE1cHSfkiX0k
 mha5pi5sunmZqiR+EtUBGCcbmeoO23A5/p0uVnQBAJc1gS1JIY/Nq97zqj4uhDBWvaJY
 r7BQ==
X-Gm-Message-State: AC+VfDx5jfHcYy/62772AM/QYYfcWmK/Jbqwhs6Po4ZNivtPV0r4sVFL
 to79Cnln8vyrcFmtCL11qlgaH5hbxVYRQ41moRIjnfKA/n3e+d31NtW1F41GaKRz4znPjwm2RyN
 ImTU6nJXS8o5h+7lHrw4/HHLGUPPaDC6IolirxjCCXxRx6fajB3Tzp2vb9w==
X-Received: by 2002:ac2:593b:0:b0:4ef:ef67:65c9 with SMTP id
 v27-20020ac2593b000000b004efef6765c9mr2058505lfi.23.1683526434064; 
 Sun, 07 May 2023 23:13:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xe3F00uxjHFgO1bBN466ruxcj/9ORWBBNpVG7tQRZFYEKmzPnbfmii1vtrAf20GtOe/ACrR9OgSj4WDi/k7E=
X-Received: by 2002:ac2:593b:0:b0:4ef:ef67:65c9 with SMTP id
 v27-20020ac2593b000000b004efef6765c9mr2058496lfi.23.1683526433776; Sun, 07
 May 2023 23:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
 <20230508020717-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508020717-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 14:13:42 +0800
Message-ID: <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBNYXkgOCwgMjAyMyBhdCAyOjA44oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIE1heSAwOCwgMjAyMyBhdCAxMToxMjowM0FN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIzLzUvNyAyMTozNCwgTWlj
aGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gT24gRnJpLCBNYXkgMDUsIDIwMjMgYXQgMTE6
Mjg6MjVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIE1heSA0LCAy
MDIzIGF0IDEwOjI34oCvQU0gV2VubGlhbmcgV2FuZwo+ID4gPiA+IDx3YW5nd2VubGlhbmcuMTk5
NUBieXRlZGFuY2UuY29tPiB3cm90ZToKPiA+ID4gPiA+IEZvciBtdWx0aS1xdWV1ZSBhbmQgbGFy
Z2UgcmluZy1zaXplIHVzZSBjYXNlLCB0aGUgZm9sbG93aW5nIGVycm9yCj4gPiA+ID4gPiBvY2N1
cnJlZCB3aGVuIGZyZWVfdW51c2VkX2J1ZnM6Cj4gPiA+ID4gPiByY3U6IElORk86IHJjdV9zY2hl
ZCBzZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBGaXhlczog
OTg2YTRmNGQ0NTJkICgidmlydGlvX25ldDogbXVsdGlxdWV1ZSBzdXBwb3J0IikKPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFdlbmxpYW5nIFdhbmcgPHdhbmd3ZW5saWFuZy4xOTk1QGJ5dGVkYW5j
ZS5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+IHYyOgo+ID4gPiA+ID4gLWFkZCBuZWVkX3Jl
c2NoZWQgY2hlY2suCj4gPiA+ID4gPiAtYXBwbHkgc2FtZSBsb2dpYyB0byBzcS4KPiA+ID4gPiA+
IHYzOgo+ID4gPiA+ID4gLXVzZSBjb25kX3Jlc2NoZWQgaW5zdGVhZC4KPiA+ID4gPiA+IHY0Ogo+
ID4gPiA+ID4gLWFkZCBmaXhlcyB0YWcKPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgfCAyICsrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiBpbmRleCA4
ZDgwMzg1MzhmYzQuLmExMmFlMjZkYjBlMiAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gPiA+ID4gPiBAQCAtMzU2MCwxMiArMzU2MCwxNCBAQCBzdGF0aWMgdm9pZCBmcmVlX3VudXNl
ZF9idWZzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5zcVtpXS52cTsKPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAh
PSBOVUxMKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRuZXRfc3FfZnJl
ZV91bnVzZWRfYnVmKHZxLCBidWYpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGNvbmRfcmVz
Y2hlZCgpOwo+ID4gPiA+IERvZXMgdGhpcyByZWFsbHkgYWRkcmVzcyB0aGUgY2FzZSB3aGVuIHRo
ZSB2aXJ0cXVldWUgaXMgdmVyeSBsYXJnZT8KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPgo+
ID4gPiBpdCBkb2VzIGluIHRoYXQgYSB2ZXJ5IGxhcmdlIHF1ZXVlIGlzIHN0aWxsIGp1c3QgNjRr
IGluIHNpemUuCj4gPiA+IHdlIG1pZ2h0IGhvd2V2ZXIgaGF2ZSA2NGsgb2YgdGhlc2UgcXVldWVz
Lgo+ID4KPiA+Cj4gPiBPaywgYnV0IHdlIGhhdmUgb3RoZXIgc2ltaWxhciBsb29wcyBlc3BlY2lh
bGx5IHRoZSByZWZpbGwsIEkgdGhpbmsgd2UgbWF5Cj4gPiBuZWVkIGNvbmRfcmVzY2hlZCgpIHRo
ZXJlIGFzIHdlbGwuCj4gPgo+ID4gVGhhbmtzCj4gPgo+Cj4gUmVmaWxsIGlzIGFscmVhZHkgcGVy
IHZxIGlzbid0IGl0PwoKTm90IGZvciB0aGUgcmVmaWxsX3dvcmsoKS4KClRoYW5rcwoKPgo+Cj4g
PiA+Cj4gPiA+ID4gPiAgICAgICAgICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgZm9y
IChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5ycVtpXS52cTsKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9i
dWYodnEpKSAhPSBOVUxMKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRu
ZXRfcnFfZnJlZV91bnVzZWRfYnVmKHZxLCBidWYpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
IGNvbmRfcmVzY2hlZCgpOwo+ID4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+ID4gICB9Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMjAuMQo+ID4gPiA+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
