Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5089C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C6DB4184B;
	Tue, 28 Mar 2023 06:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C6DB4184B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoWhC7OP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXJ5JcimoOrx; Tue, 28 Mar 2023 06:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 42D9F415E2;
	Tue, 28 Mar 2023 06:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42D9F415E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4557C0036;
	Tue, 28 Mar 2023 06:24:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8BAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F12DB6114F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F12DB6114F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoWhC7OP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id inJ8GqvBOVfu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:24:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A56FD61156
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A56FD61156
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6HhqncZRo8NJV7lOJ+dDNG18AYTIFOErbmQ2bJKUTA=;
 b=GoWhC7OPfUhxy2FJz1yTdJm+6GvjgCi1LKhHMpko8l6LflWGmfk1veSTVPZ7HEkJZSCFoU
 oonpcriMQ38qFIwQ1Djp9JjFzszvSb97HswuqDjZbiNRYJgEP1S+F2mjHd4k+KlBEFzs8n
 0nUQnDAU632EDWn8gtf60vo03+FJ/lE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ohvVtj4UPFWPtB_aBmRJJg-1; Tue, 28 Mar 2023 02:24:24 -0400
X-MC-Unique: ohvVtj4UPFWPtB_aBmRJJg-1
Received: by mail-pf1-f197.google.com with SMTP id
 i7-20020a626d07000000b005d29737db06so5385650pfc.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6HhqncZRo8NJV7lOJ+dDNG18AYTIFOErbmQ2bJKUTA=;
 b=rNNs5optr55jryoSHmjEt78///FOgVTbDZ01FjMQ+HD3FOrSnP7CGqU1Rnv3ca02r+
 MepuveRHZLJyZlE8gfjKBtzBWdv8Mg5RzaHGMOelcBso/QOuoE+Bwwt+XrbOr4J1+04G
 g2gsLPWktB94BZoRw6sF4O1bgG/DIOlL+4OdkWuqYG3rKfUevkoo4lgUp9MIde3lELMK
 Qbf+V/ROmFqDehxsGuptfA3ubAAXxbO3elKrFj1iDfrhc9+n3jdbD2Uj0XPB41oUdaIr
 EpQNAixDOAwGyJR7Dh/qnUR41Qinv/t8Kyhgt0c917yB6NJZkxy/uDA2SejkTHqZpfPN
 pR3w==
X-Gm-Message-State: AAQBX9dzggcsILfZX/9kf3gmpV/u96jDAaePvFPWi/GtXUD1GsepjeVG
 QQ1npN0LLFLhDk0YSrYJyvPUV54L5UyD5WxFWrSfuBX91lumAxd4Kk6zxPnn0zDRHrsa7UdS/B5
 J9d14/94VQF/gGBsih+fhoqzDBv2BJJHuYQb2EZaIPwptKS6Qs2Ku
X-Received: by 2002:a17:90b:164b:b0:23d:50c6:2d17 with SMTP id
 il11-20020a17090b164b00b0023d50c62d17mr16661571pjb.10.1679984663202; 
 Mon, 27 Mar 2023 23:24:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTyze+vbaELF8Elz1W/0itD+Ohrp4bFH8FvCO642ay0EaLwP6tSClxdKHJpPvT5zGZaVtmOQ==
X-Received: by 2002:a17:90b:164b:b0:23d:50c6:2d17 with SMTP id
 il11-20020a17090b164b00b0023d50c62d17mr16661554pjb.10.1679984662906; 
 Mon, 27 Mar 2023 23:24:22 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090a684e00b00230ffcb2e24sm5354791pjm.13.2023.03.27.23.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:24:22 -0700 (PDT)
Message-ID: <792bd26a-03a0-9687-15c2-a70f173ba798@redhat.com>
Date: Tue, 28 Mar 2023 14:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH vhost v4 01/11] virtio_ring: split: separate dma codes
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
 <20230322025701.2955-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230322025701.2955-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzMvMjIgMTA6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gRE1BLXJlbGF0ZWQgbG9n
aWMgaXMgc2VwYXJhdGVkIGZyb20gdGhlIHZpcnRxdWV1ZV9hZGRfc3BsaXQoKSB0bwo+IG9uZSBu
ZXcgZnVuY3Rpb24uIERNQSBhZGRyZXNzIHdpbGwgYmUgc2F2ZWQgYXMgc2ctPmRtYV9hZGRyZXNz
IGlmCj4gdXNlX2RtYV9hcGkgaXMgdHJ1ZSwgdGhlbiB2aXJ0cXVldWVfYWRkX3NwbGl0KCkgd2ls
bCB1c2UgaXQgZGlyZWN0bHkuCj4gVW5tYXAgb3BlcmF0aW9uIHdpbGwgYmUgc2ltcGxlci4KPgo+
IFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8gZmFjaWxpdGF0ZSBzdWJzZXF1ZW50IHN1cHBvcnQg
dG8gcmVjZWl2ZQo+IGRtYSBhZGRyZXNzIG1hcHBlZCBieSBkcml2ZXJzLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTIxICsrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA0MTE0NGI1MjQ2YTguLmZlNzA0Y2E2
YzgxMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0zNzksNiArMzc5LDE0IEBAIHN0YXRp
YyBkbWFfYWRkcl90IHZyaW5nX21hcF9vbmVfc2coY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gICAJCQkgICAgZGlyZWN0aW9uKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgZG1hX2Fk
ZHJfdCB2cmluZ19zZ19hZGRyZXNzKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gK3sKPiArCWlm
IChzZy0+ZG1hX2FkZHJlc3MpCj4gKwkJcmV0dXJuIHNnLT5kbWFfYWRkcmVzczsKPiArCj4gKwly
ZXR1cm4gKGRtYV9hZGRyX3Qpc2dfcGh5cyhzZyk7Cj4gK30KPiArCj4gICBzdGF0aWMgZG1hX2Fk
ZHJfdCB2cmluZ19tYXBfc2luZ2xlKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+
ICAgCQkJCSAgIHZvaWQgKmNwdV9hZGRyLCBzaXplX3Qgc2l6ZSwKPiAgIAkJCQkgICBlbnVtIGRt
YV9kYXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24pCj4gQEAgLTUyMCw2ICs1MjgsODAgQEAgc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKnZxLAo+ICAgCXJldHVybiBuZXh0Owo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZp
cnRxdWV1ZV91bm1hcF9zZ3Moc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQlzdHJ1
Y3Qgc2NhdHRlcmxpc3QgKnNnc1tdLAo+ICsJCQkJdW5zaWduZWQgaW50IHRvdGFsX3NnLAo+ICsJ
CQkJdW5zaWduZWQgaW50IG91dF9zZ3MsCj4gKwkJCQl1bnNpZ25lZCBpbnQgaW5fc2dzKQo+ICt7
Cj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+ICsJdW5zaWduZWQgaW50IG47Cj4gKwo+ICsJ
aWYgKCF2cS0+dXNlX2RtYV9hcGkpCj4gKwkJcmV0dXJuOwo+ICsKPiArCWZvciAobiA9IDA7IG4g
PCBvdXRfc2dzOyBuKyspIHsKPiArCQlmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0
KHNnKSkgewo+ICsJCQlpZiAoIXNnLT5kbWFfYWRkcmVzcykKPiArCQkJCXJldHVybjsKPiArCj4g
KwkJCWRtYV91bm1hcF9wYWdlKHZyaW5nX2RtYV9kZXYodnEpLCBzZy0+ZG1hX2FkZHJlc3MsCj4g
KwkJCQkgICAgICAgc2ctPmxlbmd0aCwgRE1BX1RPX0RFVklDRSk7Cj4gKwkJfQo+ICsJfQo+ICsK
PiArCWZvciAoOyBuIDwgKG91dF9zZ3MgKyBpbl9zZ3MpOyBuKyspIHsKPiArCQlmb3IgKHNnID0g
c2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+ICsJCQlpZiAoIXNnLT5kbWFfYWRkcmVz
cykKPiArCQkJCXJldHVybjsKPiArCj4gKwkJCWRtYV91bm1hcF9wYWdlKHZyaW5nX2RtYV9kZXYo
dnEpLCBzZy0+ZG1hX2FkZHJlc3MsCj4gKwkJCQkgICAgICAgc2ctPmxlbmd0aCwgRE1BX0ZST01f
REVWSUNFKTsKPiArCQl9Cj4gKwl9Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX21h
cF9zZ3Moc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCSAgICAgc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZ3NbXSwKPiArCQkJICAgICB1bnNpZ25lZCBpbnQgdG90YWxfc2csCj4gKwkJCSAg
ICAgdW5zaWduZWQgaW50IG91dF9zZ3MsCj4gKwkJCSAgICAgdW5zaWduZWQgaW50IGluX3NncykK
PiArewo+ICsJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsKPiArCXVuc2lnbmVkIGludCBuOwo+ICsK
PiArCWlmICghdnEtPnVzZV9kbWFfYXBpKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWZvciAobiA9
IDA7IG4gPCBvdXRfc2dzOyBuKyspIHsKPiArCQlmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBz
Z19uZXh0KHNnKSkgewo+ICsJCQlkbWFfYWRkcl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZx
LCBzZywgRE1BX1RPX0RFVklDRSk7Cj4gKwo+ICsJCQlpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2
cSwgYWRkcikpCj4gKwkJCQlnb3RvIGVycjsKPiArCj4gKwkJCXNnLT5kbWFfYWRkcmVzcyA9IGFk
ZHI7Cj4gKwkJfQo+ICsJfQo+ICsKPiArCWZvciAoOyBuIDwgKG91dF9zZ3MgKyBpbl9zZ3MpOyBu
KyspIHsKPiArCQlmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+ICsJ
CQlkbWFfYWRkcl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX0ZST01fREVW
SUNFKTsKPiArCj4gKwkJCWlmICh2cmluZ19tYXBwaW5nX2Vycm9yKHZxLCBhZGRyKSkKPiArCQkJ
CWdvdG8gZXJyOwo+ICsKPiArCQkJc2ctPmRtYV9hZGRyZXNzID0gYWRkcjsKPiArCQl9Cj4gKwl9
Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gKwo+ICtlcnI6Cj4gKwl2aXJ0cXVldWVfdW5tYXBfc2dzKHZx
LCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpOwo+ICsJcmV0dXJuIC1FTk9NRU07Cj4g
K30KPiArCj4gICBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2
aXJ0cXVldWUgKl92cSwKPiAgIAkJCQkgICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnc1tdLAo+
ICAgCQkJCSAgICAgIHVuc2lnbmVkIGludCB0b3RhbF9zZywKPiBAQCAtNTMyLDkgKzYxNCw5IEBA
IHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxLAo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gICAJ
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsKPiAgIAlzdHJ1Y3QgdnJpbmdfZGVzYyAqZGVzYzsKPiAt
CXVuc2lnbmVkIGludCBpLCBuLCBhdmFpbCwgZGVzY3NfdXNlZCwgcHJldiwgZXJyX2lkeDsKPiAt
CWludCBoZWFkOwo+ICsJdW5zaWduZWQgaW50IGksIG4sIGF2YWlsLCBkZXNjc191c2VkLCBwcmV2
Owo+ICAgCWJvb2wgaW5kaXJlY3Q7Cj4gKwlpbnQgaGVhZDsKPiAgIAo+ICAgCVNUQVJUX1VTRSh2
cSk7Cj4gICAKPiBAQCAtNTg2LDMyICs2NjgsMzAgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1
ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJCXJldHVybiAtRU5PU1BD
Owo+ICAgCX0KPiAgIAo+ICsJaWYgKHZpcnRxdWV1ZV9tYXBfc2dzKHZxLCBzZ3MsIHRvdGFsX3Nn
LCBvdXRfc2dzLCBpbl9zZ3MpKQo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICsKPiAgIAlmb3IgKG4g
PSAwOyBuIDwgb3V0X3NnczsgbisrKSB7Cj4gICAJCWZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9
IHNnX25leHQoc2cpKSB7Cj4gLQkJCWRtYV9hZGRyX3QgYWRkciA9IHZyaW5nX21hcF9vbmVfc2co
dnEsIHNnLCBETUFfVE9fREVWSUNFKTsKPiAtCQkJaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEs
IGFkZHIpKQo+IC0JCQkJZ290byB1bm1hcF9yZWxlYXNlOwo+IC0KPiAgIAkJCXByZXYgPSBpOwo+
ICAgCQkJLyogTm90ZSB0aGF0IHdlIHRydXN0IGluZGlyZWN0IGRlc2NyaXB0b3IKPiAgIAkJCSAq
IHRhYmxlIHNpbmNlIGl0IHVzZSBzdHJlYW0gRE1BIG1hcHBpbmcuCj4gICAJCQkgKi8KPiAtCQkJ
aSA9IHZpcnRxdWV1ZV9hZGRfZGVzY19zcGxpdChfdnEsIGRlc2MsIGksIGFkZHIsIHNnLT5sZW5n
dGgsCj4gKwkJCWkgPSB2aXJ0cXVldWVfYWRkX2Rlc2Nfc3BsaXQoX3ZxLCBkZXNjLCBpLAo+ICsJ
CQkJCQkgICAgIHZyaW5nX3NnX2FkZHJlc3Moc2cpLAo+ICsJCQkJCQkgICAgIHNnLT5sZW5ndGgs
Cj4gICAJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9ORVhULAo+ICAgCQkJCQkJICAgICBpbmRpcmVj
dCk7Cj4gICAJCX0KPiAgIAl9Cj4gICAJZm9yICg7IG4gPCAob3V0X3NncyArIGluX3Nncyk7IG4r
Kykgewo+ICAgCQlmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+IC0J
CQlkbWFfYWRkcl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX0ZST01fREVW
SUNFKTsKPiAtCQkJaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFkZHIpKQo+IC0JCQkJZ290
byB1bm1hcF9yZWxlYXNlOwo+IC0KPiAgIAkJCXByZXYgPSBpOwo+ICAgCQkJLyogTm90ZSB0aGF0
IHdlIHRydXN0IGluZGlyZWN0IGRlc2NyaXB0b3IKPiAgIAkJCSAqIHRhYmxlIHNpbmNlIGl0IHVz
ZSBzdHJlYW0gRE1BIG1hcHBpbmcuCj4gICAJCQkgKi8KPiAtCQkJaSA9IHZpcnRxdWV1ZV9hZGRf
ZGVzY19zcGxpdChfdnEsIGRlc2MsIGksIGFkZHIsCj4gKwkJCWkgPSB2aXJ0cXVldWVfYWRkX2Rl
c2Nfc3BsaXQoX3ZxLCBkZXNjLCBpLAo+ICsJCQkJCQkgICAgIHZyaW5nX3NnX2FkZHJlc3Moc2cp
LAo+ICAgCQkJCQkJICAgICBzZy0+bGVuZ3RoLAo+ICAgCQkJCQkJICAgICBWUklOR19ERVNDX0Zf
TkVYVCB8Cj4gICAJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9XUklURSwKPiBAQCAtNjc5LDIyICs3
NTksNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSwKPiAgIAlyZXR1cm4gMDsKPiAgIAo+ICAgdW5tYXBfcmVsZWFzZToKPiAtCWVy
cl9pZHggPSBpOwo+IC0KPiAtCWlmIChpbmRpcmVjdCkKPiAtCQlpID0gMDsKPiAtCWVsc2UKPiAt
CQlpID0gaGVhZDsKPiAtCj4gLQlmb3IgKG4gPSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+IC0J
CWlmIChpID09IGVycl9pZHgpCj4gLQkJCWJyZWFrOwo+IC0JCWlmIChpbmRpcmVjdCkgewo+IC0J
CQl2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEsICZkZXNjW2ldKTsKPiAtCQkJaSA9
IHZpcnRpbzE2X3RvX2NwdShfdnEtPnZkZXYsIGRlc2NbaV0ubmV4dCk7Cj4gLQkJfSBlbHNlCj4g
LQkJCWkgPSB2cmluZ191bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+IC0JfQo+ICsJdmlydHF1ZXVl
X3VubWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKTsKPiAgIAo+ICAg
CWlmIChpbmRpcmVjdCkKPiAgIAkJa2ZyZWUoZGVzYyk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
