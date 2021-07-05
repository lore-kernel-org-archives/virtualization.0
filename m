Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F229AC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 17:59:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D10561958
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D10561958
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6244283A4C;
	Mon,  5 Jul 2021 17:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzsfCjU_U3_E; Mon,  5 Jul 2021 17:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 082F683A97;
	Mon,  5 Jul 2021 17:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFBA9C001A;
	Mon,  5 Jul 2021 17:59:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A981C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 17:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BD3F60802
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 17:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yZKI5ITKQRj1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 17:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62B8E606F2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625507978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5H38ZiEbwdys/XKq02eU1KZlFMkGpzH6Mp6cE7wcdag=;
 b=MZ6mV90zngTbe5E1qSzQzx74mzrUuFRaZwoUPdVblmllRnXQyrDtEPwsGbTs/5RdT2qI62
 kWgfQRg7XJaseZwJh2P2tDqEPiPv1TMkJ15o6AN1QaLxjorbou5sZXKU+h0tV7p4Mi+Nq8
 uFPHtXFQEGYCF1LXhVp7qw9HtXplHE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-R9eNgGXGM7aLFTIkwkoJCg-1; Mon, 05 Jul 2021 13:59:36 -0400
X-MC-Unique: R9eNgGXGM7aLFTIkwkoJCg-1
Received: by mail-wr1-f71.google.com with SMTP id
 z2-20020a5d4d020000b0290130e19b0ddbso2820774wrt.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 10:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5H38ZiEbwdys/XKq02eU1KZlFMkGpzH6Mp6cE7wcdag=;
 b=Be1+IvSvht+OZbE5+Z3D80qdEufcgADcOZLvIuWIWodXa/2E2BkKCIiOyGK90E3AZf
 JAgx11uknw6ZOz5Z3760zO6N0roq/tejTODfjnxWakV2r3TC16AZ/pg4v4lbIIqcdn73
 /OkvLXs4lwQQUy3FAWzQ3yjxMOoOohpajQbMQ0fhEbgFeV2qeFexJWV4aA+Q42aUbqQP
 +GnzhM7/BaQ8JhvsEb/KRRJ2ENfqN3ME3e0RkFFJY4uGyCb38AM5ax1ALvHdyjemjEye
 3wvCuHGQ8j6xHxcBepXSl0FgVgMS6nAdRVEYOwz5OJ2U3dbOVk7WHmyJo3WynFmL+FJl
 ULNA==
X-Gm-Message-State: AOAM532wSUfgymyj9YaRbAIprWHUggiuL+I20cWbkd0/Vuyk/8eBJP8x
 IWVFz7AySBCS+OWUUBklrWNf36fINgbfLXI0to6ObaCmCJL7yDvqh5mhH69n1ZeTjW+qsQ+jnre
 OOG+rXLlXr3tCgAPQXLd7tm0kowyWWebgF+3rybhVZA==
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr17129686wrt.249.1625507975903; 
 Mon, 05 Jul 2021 10:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5s5Q0gB/0vxcQB2xCkwrdclED6Lm4U5rUd1KxdAr0pLnHm/bJh1UbIAHK2B4wx7WbXxmQw==
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr17129668wrt.249.1625507975669; 
 Mon, 05 Jul 2021 10:59:35 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id s9sm3028372wrn.87.2021.07.05.10.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 10:59:34 -0700 (PDT)
Date: Mon, 5 Jul 2021 13:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum
 virtqueue size
Message-ID: <20210705065534-mutt-send-email-mst@kernel.org>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
 <20210705032602-mutt-send-email-mst@kernel.org>
 <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

T24gTW9uLCBKdWwgMDUsIDIwMjEgYXQgMDM6Mjk6NDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS83LzUg5LiL5Y2IMzoyNiwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIE1vbiwgSnVsIDA1LCAyMDIxIGF0IDAzOjE5OjEwUE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+IFRoaXMgcGF0Y2ggc3dpdGNoIHRvIHJlYWQgdmlydHF1ZXVlIHNpemUg
ZnJvbSB0aGUgY2FwYWJpbGl0eSBpbnN0ZWFkCj4gPiA+IG9mIGRlcGVuZGluZyBvbiB0aGUgaGFy
ZGNvZGVkIHZhbHVlLiBUaGlzIGFsbG93cyB0aGUgcGVyIHZpcnRxdWV1ZQo+ID4gPiBzaXplIGNv
dWxkIGJlIGFkdmVydGlzZWQuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gU28gbGV0J3MgYWRkIGFuIGlvY3RsIGZvciB0aGlz
PyBJdCdzIHJlYWxseSBhIGJ1ZyB3ZSBkb24ndC4uCj4gCj4gCj4gQXMgZXhwbGFpbmVkIGluIHBh
dGNoIDEuIFFlbXUgZG9lc24ndCB1c2UgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVNIGFjdHVhbGx5
Lgo+IEluc3RlYWQgaXQgY2hlY2tzIHRoZSByZXN1bHQgVkhPU1RfVkRQQV9TRVRfVlJJTkdfTlVN
Lgo+IAo+IFNvIEkgY2hhbmdlIFZIT1NUX1ZEUEFfR0VUX1ZSSU5HX05VTSB0byByZXR1cm4gdGhl
IG1pbmltYWwgc2l6ZSBvZiBhbGwgdGhlCj4gdmlydHF1ZXVlcy4KPiAKPiBJZiB5b3Ugd2lzaCB3
ZSBjYW4gYWRkIGEgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVNMiwgYnV0IEknbSBub3Qgc3VyZSBp
dCB3aWxsCj4gaGF2ZSBhIHVzZXIgb3Igbm90Lgo+IAo+IFRoYW5rcwoKUXVlc3Rpb24gaXMgaG93
IGRvIHdlIGtub3cgcmV0dXJuaW5nIHRoZSBtaW5pbWFsIGFuZCBub3QgZS5nLiB0aGUgbWF4CnNp
emUgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvPwoKCj4gCj4gPiAKPiA+ID4gLS0tCj4gPiA+ICAg
ZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgNiArKysrLS0KPiA+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyBiL2RyaXZlcnMv
dmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gPiBpbmRleCAyOTI2NjQxZmI1ODYuLjE5OGY3
MDc2ZTRkOSAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRw
YS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gPiBA
QCAtMTgsNyArMTgsNiBAQAo+ID4gPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4g
PiA+ICAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmg+Cj4gPiA+IC0jZGVmaW5l
IFZQX1ZEUEFfUVVFVUVfTUFYIDI1Ngo+ID4gPiAgICNkZWZpbmUgVlBfVkRQQV9EUklWRVJfTkFN
RSAidnBfdmRwYSIKPiA+ID4gICAjZGVmaW5lIFZQX1ZEUEFfTkFNRV9TSVpFIDI1Ngo+ID4gPiBA
QCAtMTk3LDcgKzE5NiwxMCBAQCBzdGF0aWMgdm9pZCB2cF92ZHBhX3NldF9zdGF0dXMoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhLCB1OCBzdGF0dXMpCj4gPiA+ICAgc3RhdGljIHUxNiB2cF92ZHBh
X2dldF92cV9udW1fbWF4KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTE2IHFpZCkKPiA+ID4g
ICB7Cj4gPiA+IC0JcmV0dXJuIFZQX1ZEUEFfUVVFVUVfTUFYOwo+ID4gPiArCXN0cnVjdCB2cF92
ZHBhICp2cF92ZHBhID0gdmRwYV90b192cCh2ZHBhKTsKPiA+ID4gKwlzdHJ1Y3QgdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX3ZkcGEtPm1kZXY7Cj4gPiA+ICsKPiA+ID4gKwly
ZXR1cm4gdnBfbW9kZXJuX2dldF9xdWV1ZV9zaXplKG1kZXYsIHFpZCk7Cj4gPiA+ICAgfQo+ID4g
PiAgIHN0YXRpYyBpbnQgdnBfdmRwYV9nZXRfdnFfc3RhdGUoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhLCB1MTYgcWlkLAo+ID4gPiAtLSAKPiA+ID4gMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
