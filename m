Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8EEEB64DD
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 06:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 671C28227C;
	Wed,  9 Aug 2023 06:51:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 671C28227C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f37QHqT1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRvIpnuGjC9z; Wed,  9 Aug 2023 06:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8E308219E;
	Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8E308219E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBC45C0072;
	Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59474C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34459611D7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34459611D7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f37QHqT1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ft_46xDrrpHd
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:51:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68C2A60FBB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68C2A60FBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691563862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/nEU7noPALINH6/4nqQIqQSMTGun1SlIDSuNUh4s1g=;
 b=f37QHqT1Ug16d0pPKbaT9h1Bsq61iTkJ/p8s5Ec9ZTzb0z1jKEEF0KlaBfyFcZt9aK4tdK
 WGK2PJVAWwfR2hpfzf7SVUUOzQ/a1PNeKad8UwW/lVTjX4r3+k5Gtz6fox6X93/Z4w8QN7
 a6NBjCn+8hsmn1zcbk1Lq5uu1DOQQEM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-cbq50Tg2NsKzEWvo_T15wg-1; Wed, 09 Aug 2023 02:51:01 -0400
X-MC-Unique: cbq50Tg2NsKzEWvo_T15wg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d41cbc31so456675766b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 23:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691563860; x=1692168660;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/nEU7noPALINH6/4nqQIqQSMTGun1SlIDSuNUh4s1g=;
 b=PqTNvWME/9+RpwTm0pLI1Q+C9xPyxH8UzMebuE309dmDHYLsV8ex3UHHIz+wCC9g9m
 XnFhkje/pBKvCdWm+0F3yF2tcxZfqipqe5ze2toE+vZ7+oBgZcO9PDym3KvJYLCPGGcU
 djU3QPNcBkdRwodrOVwMOjf+N0pD/SvePXANxzKliJFsiFRBfkuKcnufFVxA2GYrOKj2
 j111Ir2lYLdSAkHL0UW5mm1mNzCrnDrV0P8U0G+kbByF/j65XDnzw3FuuI+BlTVxYZk/
 /4AzYv42YRqNt+4fX2rJuspVXk8jwJuqe84G+obMvBZTDcUwNvmmj6dsScAs5dNZ1LUy
 +/RQ==
X-Gm-Message-State: AOJu0YwVevDFSjZSgaV7b13CShd3RQSlh6gy/j7VZN2iHwEXm/9UeuBB
 a4iFBU7DiBq2t/ACtOE8Tg6OeL6YeZ9wjso7cq8ipbsNyKi/Qnghn0gzc/c9rTuMsaPemXu0ow1
 /H3R+rM5zdkpWcWJVTsjV1SiC+b34+MbSFUr2zuVqlw==
X-Received: by 2002:a17:906:5356:b0:96a:63d4:24c5 with SMTP id
 j22-20020a170906535600b0096a63d424c5mr1275922ejo.77.1691563859966; 
 Tue, 08 Aug 2023 23:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFT08LSEXNfTTejf1CndLl/NlP49/szNnPfJQexLpnHSciLvGOx9gyDFsaR7QCEUj/Ah4kzQ==
X-Received: by 2002:a17:906:5356:b0:96a:63d4:24c5 with SMTP id
 j22-20020a170906535600b0096a63d424c5mr1275917ejo.77.1691563859692; 
 Tue, 08 Aug 2023 23:50:59 -0700 (PDT)
Received: from redhat.com ([2.52.159.103]) by smtp.gmail.com with ESMTPSA id
 le3-20020a170907170300b0099cf840527csm1614058ejc.153.2023.08.08.23.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 23:50:58 -0700 (PDT)
Date: Wed, 9 Aug 2023 02:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
Message-ID: <20230809025039-mutt-send-email-mst@kernel.org>
References: <20230809031329.251362-1-jasowang@redhat.com>
 <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
 <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gV2VkLCBBdWcgMDksIDIwMjMgYXQgMDI6NDU6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEF1ZyA5LCAyMDIzIGF0IDI6MjPigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRh
dHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCAyMDIzLTA4LTA4IGF0IDIz
OjEzIC0wNDAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiBDb21taXQgMjUyNjYxMjhmZTE2ICgi
dmlydGlvLW5ldDogZml4IHJhY2UgYmV0d2VlbiBzZXQgcXVldWVzIGFuZAo+ID4gPiBwcm9iZSIp
IHRyaWVzIHRvIGZpeCB0aGUgcmFjZSBiZXR3ZWVuIHNldCBxdWV1ZXMgYW5kIHByb2JlIGJ5IGNh
bGxpbmcKPiA+ID4gX3ZpcnRuZXRfc2V0X3F1ZXVlcygpIGJlZm9yZSBEUklWRVJfT0sgaXMgc2V0
LiBUaGlzIHZpb2xhdGVzIHZpcnRpbwo+ID4gPiBzcGVjLiBGaXhpbmcgdGhpcyBieSBzZXR0aW5n
IHF1ZXVlcyBhZnRlciB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkuCj4gPiA+Cj4gPiA+IEZpeGVzOiAy
NTI2NjEyOGZlMTYgKCJ2aXJ0aW8tbmV0OiBmaXggcmFjZSBiZXR3ZWVuIHNldCBxdWV1ZXMgYW5k
IHByb2JlIikKPiA+ID4gUmVwb3J0ZWQtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlk
aWEuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+ID4gPiAtLS0KPiA+ID4gVGhlIHBhdGNoIGlzIG5lZWRlZCBmb3IgLXN0YWJsZS4KPiA+
ID4gLS0tCj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0ICsrLS0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gaW5kZXggMTI3MGM4ZDIzNDYzLi5mZjAzOTIxZTQ2ZGYgMTAwNjQ0Cj4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTQyMTksOCArNDIxOSw2IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gICAgICAgICBpZiAo
dmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiA+ICAgICAgICAgICAg
ICAgICB2aXJ0bmV0X2luaXRfZGVmYXVsdF9yc3ModmkpOwo+ID4gPgo+ID4gPiAtICAgICAgIF92
aXJ0bmV0X3NldF9xdWV1ZXModmksIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsKPiA+ID4gLQo+ID4g
PiAgICAgICAgIC8qIHNlcmlhbGl6ZSBuZXRkZXYgcmVnaXN0ZXIgKyB2aXJ0aW9fZGV2aWNlX3Jl
YWR5KCkgd2l0aCBuZG9fb3BlbigpCj4gPiA+ICovCj4gPiA+ICAgICAgICAgcnRubF9sb2NrKCk7
Cj4gPiA+Cj4gPiA+IEBAIC00MjMzLDYgKzQyMzEsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJv
YmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+Cj4gPiA+ICAgICAgICAgdmlydGlv
X2RldmljZV9yZWFkeSh2ZGV2KTsKPiA+ID4KPiA+ID4gKyAgICAgICBfdmlydG5ldF9zZXRfcXVl
dWVzKHZpLCB2aS0+Y3Vycl9xdWV1ZV9wYWlycyk7Cj4gPiA+ICsKPiA+ID4gICAgICAgICAvKiBh
IHJhbmRvbSBNQUMgYWRkcmVzcyBoYXMgYmVlbiBhc3NpZ25lZCwgbm90aWZ5IHRoZSBkZXZpY2Uu
Cj4gPiA+ICAgICAgICAgICogV2UgZG9uJ3QgZmFpbCBwcm9iZSBpZiBWSVJUSU9fTkVUX0ZfQ1RS
TF9NQUNfQUREUiBpcyBub3QgdGhlcmUKPiA+ID4gICAgICAgICAgKiBiZWNhdXNlIG1hbnkgZGV2
aWNlcyB3b3JrIGZpbmUgd2l0aG91dCBnZXR0aW5nIE1BQyBleHBsaWNpdGx5Cj4gPgo+ID4gVGhh
bmtzIGZvciB0aGUgcXVpY2sgZml4LiBEb2Vzbid0IHRoaXMgZml4IHRob3VnaCBicmluZyBiYWNr
IHRoZSBvcmlnaW5hbCByYWNlCj4gPiB0aGF0IHdhcyBmaXhlZCBpbiBjb21taXQgMjUyNjYxMjhm
ZTE2ICgidmlydGlvLW5ldDogZml4IHJhY2UgYmV0d2VlbiBzZXQgcXVldWVzCj4gPiBhbmQgcHJv
YmUiKT8gT3IgaXMgYmVpbmcgdW5kZXIgdGhlIHNhbWUgcm50bF9sb2NrIHNlc3Npb24gYXMgcmVn
aXN0ZXJfbmV0ZGV2Cj4gPiBlbm91Z2ggdG8gYXZvaWQgdGhlIHJhY2U/Cj4gCj4gWWVzLCBydG5s
IG5lZWRzIHRvIGJlIGhlbGQgZm9yIHVzZXJzcGFjZSByZXF1ZXN0cyB0byBjaGFuZ2UgdGhlIG51
bWJlcgo+IG9mIHF1ZXVlcy4gU28gd2UgYXJlIHNlcmlhbGl6ZWQgaW4gdGhpcyB3YXkuCj4gCj4g
VGhhbmtzCgptYXliZSBwb3N0IHYyIGFkZGluZyB0aGlzIGluIHRoZSBjb21taXQgbG9nLgoKCj4g
Pgo+ID4gVGhhbmtzLAo+ID4gRHJhZ29zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
