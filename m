Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4DBE95A80
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 05:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CE1C41B08;
	Sun,  8 Oct 2023 05:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CE1C41B08
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHzfXNpK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-uq8P5Pzzr0; Sun,  8 Oct 2023 05:28:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9ED86416B9;
	Sun,  8 Oct 2023 05:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9ED86416B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80B16C0039;
	Sun,  8 Oct 2023 05:28:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14C29C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE09982321
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE09982321
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHzfXNpK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4dK0tcSk8Klv
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:28:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D68818230A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D68818230A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpwgwXaEWYaaFsSNTMyBQD+39EpH2AOMJtj5zGk8lYE=;
 b=CHzfXNpKIFlCjaK9udPoX1sQeiSLl9NbIsryIfhDcKPLGbuUZr1ObQXGas4NrCmj65lcwr
 30H6OybdKN9ft9BPlBQ1xkSHE+lMhiWAgzXDj8EIBALxFmlLkOkObZVC8HDocPbUlMwX35
 nFSoCAsbD+/U4MsxunlnTVCWVsHJ224=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-ye5erJJPOSeq-CDIFdHUfg-1; Sun, 08 Oct 2023 01:28:25 -0400
X-MC-Unique: ye5erJJPOSeq-CDIFdHUfg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5039413f4f9so286657e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 22:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742904; x=1697347704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpwgwXaEWYaaFsSNTMyBQD+39EpH2AOMJtj5zGk8lYE=;
 b=oWEXY6gAL0a04tozC99nlRxNwF8mII5P12DPFlqKm4WVapNUSn0kdadDumpZ2t0o0n
 kI5T3Kn9CQdvSC8qxuNry96tl7k9kJj0mzex72w3oVK413/vFLkNE6HgIkYHEp7fRkgF
 cwVS7rta8H5T5NRUcsxfyADw8guPxkLBhVa+Zl6EAtLzdUDGes6cQEQb5uh5HSur7tTC
 e2lJa5Bfy4o560zL1PgFyZZspZA6sQiwQHhrHwWU2jR90G29XxZhHabe4vs5SRFLvh7s
 ho5D+Z9YJAdEjqHbGCofn37Ds4Qzo6F4IN22EWZyejXGG0nmGChvuO/qoXsgXoeU61Br
 QjzA==
X-Gm-Message-State: AOJu0YzK1hTLDnUsYUksZS+yRJBSJbI2zUAd5kBDCB8Xq8tXipIpxTb3
 iPnHI8ULFw/FN3LbB/JD5t++VJE1KXv9jwoFg29HzAYaim0uE5i7nlfkNHouiGEWsIN0HXrlHxx
 HbV2zBVBjLCBIxS0SQXbxqf5fnDv7pxCbX15y8JzYlOOLiGvZsODRVfbB9w==
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id
 n8-20020a0565120ac800b005031aaeeca0mr13205997lfu.44.1696742904222; 
 Sat, 07 Oct 2023 22:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkfgKx+SsS4nJgqunmdWhqRU27F8n/DJo7Eoi3C9DaLJia2YytDK0igSUNaJhTR/6Bwkn5zUkOK1fexckvwI=
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id
 n8-20020a0565120ac800b005031aaeeca0mr13205990lfu.44.1696742904022; Sat, 07
 Oct 2023 22:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <2023100643-tricolor-citizen-6c2d@gregkh>
In-Reply-To: <2023100643-tricolor-citizen-6c2d@gregkh>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:28:13 +0800
Message-ID: <CACGkMEt3Tneppu3qbKXCDLS-1Hw5bmspOdE29dPijwwkW5iKJw@mail.gmail.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Xie Yongji <xieyongji@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gRnJpLCBPY3QgNiwgMjAyMyBhdCAxMDozMeKAr1BNIEdyZWcgS3JvYWgtSGFydG1hbgo8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+Cj4gTm93IHRoYXQgdGhlIGRyaXZlciBj
b3JlIGFsbG93cyBmb3Igc3RydWN0IGNsYXNzIHRvIGJlIGluIHJlYWQtb25seQo+IG1lbW9yeSwg
d2Ugc2hvdWxkIG1ha2UgYWxsICdjbGFzcycgc3RydWN0dXJlcyBkZWNsYXJlZCBhdCBidWlsZCB0
aW1lCj4gcGxhY2luZyB0aGVtIGludG8gcmVhZC1vbmx5IG1lbW9yeSwgaW5zdGVhZCBvZiBoYXZp
bmcgdG8gYmUgZHluYW1pY2FsbHkKPiBhbGxvY2F0ZWQgYXQgcnVudGltZS4KPgo+IENjOiAiTWlj
aGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+Cj4gQ2M6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gQ2M6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4gQ2M6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+CgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0K
PiAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDQwICsrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCBkZjc4
Njk1MzdlZjEuLjBkZGQ0YjhhYmVjYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYu
Ywo+IEBAIC0xMzQsNyArMTM0LDYgQEAgc3RhdGljIERFRklORV9NVVRFWCh2ZHVzZV9sb2NrKTsK
PiAgc3RhdGljIERFRklORV9JRFIodmR1c2VfaWRyKTsKPgo+ICBzdGF0aWMgZGV2X3QgdmR1c2Vf
bWFqb3I7Cj4gLXN0YXRpYyBzdHJ1Y3QgY2xhc3MgKnZkdXNlX2NsYXNzOwo+ICBzdGF0aWMgc3Ry
dWN0IGNkZXYgdmR1c2VfY3RybF9jZGV2Owo+ICBzdGF0aWMgc3RydWN0IGNkZXYgdmR1c2VfY2Rl
djsKPiAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp2ZHVzZV9pcnFfd3E7Cj4gQEAg
LTE1MjgsNiArMTUyNywxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtvYmpfdHlwZSB2cV90eXBl
ID0gewo+ICAgICAgICAgLmRlZmF1bHRfZ3JvdXBzID0gdnFfZ3JvdXBzLAo+ICB9Owo+Cj4gK3N0
YXRpYyBjaGFyICp2ZHVzZV9kZXZub2RlKGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldiwgdW1vZGVf
dCAqbW9kZSkKPiArewo+ICsgICAgICAgcmV0dXJuIGthc3ByaW50ZihHRlBfS0VSTkVMLCAidmR1
c2UvJXMiLCBkZXZfbmFtZShkZXYpKTsKPiArfQo+ICsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBj
bGFzcyB2ZHVzZV9jbGFzcyA9IHsKPiArICAgICAgIC5uYW1lID0gInZkdXNlIiwKPiArICAgICAg
IC5kZXZub2RlID0gdmR1c2VfZGV2bm9kZSwKPiArfTsKPiArCj4gIHN0YXRpYyB2b2lkIHZkdXNl
X2Rldl9kZWluaXRfdnFzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldikKPiAgewo+ICAgICAgICAgaW50
IGk7Cj4gQEAgLTE2MzgsNyArMTY0Nyw3IEBAIHN0YXRpYyBpbnQgdmR1c2VfZGVzdHJveV9kZXYo
Y2hhciAqbmFtZSkKPiAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5sb2NrKTsKPgo+ICAgICAg
ICAgdmR1c2VfZGV2X3Jlc2V0KGRldik7Cj4gLSAgICAgICBkZXZpY2VfZGVzdHJveSh2ZHVzZV9j
bGFzcywgTUtERVYoTUFKT1IodmR1c2VfbWFqb3IpLCBkZXYtPm1pbm9yKSk7Cj4gKyAgICAgICBk
ZXZpY2VfZGVzdHJveSgmdmR1c2VfY2xhc3MsIE1LREVWKE1BSk9SKHZkdXNlX21ham9yKSwgZGV2
LT5taW5vcikpOwo+ICAgICAgICAgaWRyX3JlbW92ZSgmdmR1c2VfaWRyLCBkZXYtPm1pbm9yKTsK
PiAgICAgICAgIGt2ZnJlZShkZXYtPmNvbmZpZyk7Cj4gICAgICAgICB2ZHVzZV9kZXZfZGVpbml0
X3ZxcyhkZXYpOwo+IEBAIC0xODA1LDcgKzE4MTQsNyBAQCBzdGF0aWMgaW50IHZkdXNlX2NyZWF0
ZV9kZXYoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZywKPgo+ICAgICAgICAgZGV2LT5t
aW5vciA9IHJldDsKPiAgICAgICAgIGRldi0+bXNnX3RpbWVvdXQgPSBWRFVTRV9NU0dfREVGQVVM
VF9USU1FT1VUOwo+IC0gICAgICAgZGV2LT5kZXYgPSBkZXZpY2VfY3JlYXRlX3dpdGhfZ3JvdXBz
KHZkdXNlX2NsYXNzLCBOVUxMLAo+ICsgICAgICAgZGV2LT5kZXYgPSBkZXZpY2VfY3JlYXRlX3dp
dGhfZ3JvdXBzKCZ2ZHVzZV9jbGFzcywgTlVMTCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1LREVWKE1BSk9SKHZkdXNlX21ham9yKSwgZGV2LT5taW5vciksCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXYsIHZkdXNlX2Rldl9ncm91cHMsICIlcyIsIGNvbmZp
Zy0+bmFtZSk7Cj4gICAgICAgICBpZiAoSVNfRVJSKGRldi0+ZGV2KSkgewo+IEBAIC0xODIxLDcg
KzE4MzAsNyBAQCBzdGF0aWMgaW50IHZkdXNlX2NyZWF0ZV9kZXYoc3RydWN0IHZkdXNlX2Rldl9j
b25maWcgKmNvbmZpZywKPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIGVycl92cXM6Cj4gLSAgICAg
ICBkZXZpY2VfZGVzdHJveSh2ZHVzZV9jbGFzcywgTUtERVYoTUFKT1IodmR1c2VfbWFqb3IpLCBk
ZXYtPm1pbm9yKSk7Cj4gKyAgICAgICBkZXZpY2VfZGVzdHJveSgmdmR1c2VfY2xhc3MsIE1LREVW
KE1BSk9SKHZkdXNlX21ham9yKSwgZGV2LT5taW5vcikpOwo+ICBlcnJfZGV2Ogo+ICAgICAgICAg
aWRyX3JlbW92ZSgmdmR1c2VfaWRyLCBkZXYtPm1pbm9yKTsKPiAgZXJyX2lkcjoKPiBAQCAtMTkz
NCwxMSArMTk0Myw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHZkdXNl
X2N0cmxfZm9wcyA9IHsKPiAgICAgICAgIC5sbHNlZWsgICAgICAgICA9IG5vb3BfbGxzZWVrLAo+
ICB9Owo+Cj4gLXN0YXRpYyBjaGFyICp2ZHVzZV9kZXZub2RlKGNvbnN0IHN0cnVjdCBkZXZpY2Ug
KmRldiwgdW1vZGVfdCAqbW9kZSkKPiAtewo+IC0gICAgICAgcmV0dXJuIGthc3ByaW50ZihHRlBf
S0VSTkVMLCAidmR1c2UvJXMiLCBkZXZfbmFtZShkZXYpKTsKPiAtfQo+IC0KPiAgc3RydWN0IHZk
dXNlX21nbXRfZGV2IHsKPiAgICAgICAgIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1nbXRfZGV2Owo+
ICAgICAgICAgc3RydWN0IGRldmljZSBkZXY7Cj4gQEAgLTIwODIsMTEgKzIwODYsOSBAQCBzdGF0
aWMgaW50IHZkdXNlX2luaXQodm9pZCkKPiAgICAgICAgIGludCByZXQ7Cj4gICAgICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXY7Cj4KPiAtICAgICAgIHZkdXNlX2NsYXNzID0gY2xhc3NfY3JlYXRlKCJ2
ZHVzZSIpOwo+IC0gICAgICAgaWYgKElTX0VSUih2ZHVzZV9jbGFzcykpCj4gLSAgICAgICAgICAg
ICAgIHJldHVybiBQVFJfRVJSKHZkdXNlX2NsYXNzKTsKPiAtCj4gLSAgICAgICB2ZHVzZV9jbGFz
cy0+ZGV2bm9kZSA9IHZkdXNlX2Rldm5vZGU7Cj4gKyAgICAgICByZXQgPSBjbGFzc19yZWdpc3Rl
cigmdmR1c2VfY2xhc3MpOwo+ICsgICAgICAgaWYgKHJldCkKPiArICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsKPgo+ICAgICAgICAgcmV0ID0gYWxsb2NfY2hyZGV2X3JlZ2lvbigmdmR1c2VfbWFq
b3IsIDAsIFZEVVNFX0RFVl9NQVgsICJ2ZHVzZSIpOwo+ICAgICAgICAgaWYgKHJldCkKPiBAQCAt
MjA5OSw3ICsyMTAxLDcgQEAgc3RhdGljIGludCB2ZHVzZV9pbml0KHZvaWQpCj4gICAgICAgICBp
ZiAocmV0KQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9jdHJsX2NkZXY7Cj4KPiAtICAgICAg
IGRldiA9IGRldmljZV9jcmVhdGUodmR1c2VfY2xhc3MsIE5VTEwsIHZkdXNlX21ham9yLCBOVUxM
LCAiY29udHJvbCIpOwo+ICsgICAgICAgZGV2ID0gZGV2aWNlX2NyZWF0ZSgmdmR1c2VfY2xhc3Ms
IE5VTEwsIHZkdXNlX21ham9yLCBOVUxMLCAiY29udHJvbCIpOwo+ICAgICAgICAgaWYgKElTX0VS
UihkZXYpKSB7Cj4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoZGV2KTsKPiAgICAgICAg
ICAgICAgICAgZ290byBlcnJfZGV2aWNlOwo+IEBAIC0yMTQxLDEzICsyMTQzLDEzIEBAIHN0YXRp
YyBpbnQgdmR1c2VfaW5pdCh2b2lkKQo+ICBlcnJfd3E6Cj4gICAgICAgICBjZGV2X2RlbCgmdmR1
c2VfY2Rldik7Cj4gIGVycl9jZGV2Ogo+IC0gICAgICAgZGV2aWNlX2Rlc3Ryb3kodmR1c2VfY2xh
c3MsIHZkdXNlX21ham9yKTsKPiArICAgICAgIGRldmljZV9kZXN0cm95KCZ2ZHVzZV9jbGFzcywg
dmR1c2VfbWFqb3IpOwo+ICBlcnJfZGV2aWNlOgo+ICAgICAgICAgY2Rldl9kZWwoJnZkdXNlX2N0
cmxfY2Rldik7Cj4gIGVycl9jdHJsX2NkZXY6Cj4gICAgICAgICB1bnJlZ2lzdGVyX2NocmRldl9y
ZWdpb24odmR1c2VfbWFqb3IsIFZEVVNFX0RFVl9NQVgpOwo+ICBlcnJfY2hhcmRldl9yZWdpb246
Cj4gLSAgICAgICBjbGFzc19kZXN0cm95KHZkdXNlX2NsYXNzKTsKPiArICAgICAgIGNsYXNzX3Vu
cmVnaXN0ZXIoJnZkdXNlX2NsYXNzKTsKPiAgICAgICAgIHJldHVybiByZXQ7Cj4gIH0KPiAgbW9k
dWxlX2luaXQodmR1c2VfaW5pdCk7Cj4gQEAgLTIxNTksMTAgKzIxNjEsMTAgQEAgc3RhdGljIHZv
aWQgdmR1c2VfZXhpdCh2b2lkKQo+ICAgICAgICAgZGVzdHJveV93b3JrcXVldWUodmR1c2VfaXJx
X2JvdW5kX3dxKTsKPiAgICAgICAgIGRlc3Ryb3lfd29ya3F1ZXVlKHZkdXNlX2lycV93cSk7Cj4g
ICAgICAgICBjZGV2X2RlbCgmdmR1c2VfY2Rldik7Cj4gLSAgICAgICBkZXZpY2VfZGVzdHJveSh2
ZHVzZV9jbGFzcywgdmR1c2VfbWFqb3IpOwo+ICsgICAgICAgZGV2aWNlX2Rlc3Ryb3koJnZkdXNl
X2NsYXNzLCB2ZHVzZV9tYWpvcik7Cj4gICAgICAgICBjZGV2X2RlbCgmdmR1c2VfY3RybF9jZGV2
KTsKPiAgICAgICAgIHVucmVnaXN0ZXJfY2hyZGV2X3JlZ2lvbih2ZHVzZV9tYWpvciwgVkRVU0Vf
REVWX01BWCk7Cj4gLSAgICAgICBjbGFzc19kZXN0cm95KHZkdXNlX2NsYXNzKTsKPiArICAgICAg
IGNsYXNzX3VucmVnaXN0ZXIoJnZkdXNlX2NsYXNzKTsKPiAgfQo+ICBtb2R1bGVfZXhpdCh2ZHVz
ZV9leGl0KTsKPgo+IC0tCj4gMi40Mi4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
