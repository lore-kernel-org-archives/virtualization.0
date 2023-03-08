Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8432C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 573FC81F2D;
	Wed,  8 Mar 2023 14:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 573FC81F2D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dh4YfKzY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sehNp3Z_Va3H; Wed,  8 Mar 2023 14:29:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA67981F3D;
	Wed,  8 Mar 2023 14:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA67981F3D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E385C0071;
	Wed,  8 Mar 2023 14:29:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 940A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6198E61222
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6198E61222
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dh4YfKzY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jNamVUO0oc3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA49260B06
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA49260B06
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678285743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiLCxa5R4eTbWMfdTIM20tjq3AuaDrZaN1Rif80B7JI=;
 b=Dh4YfKzYDKdEstE+kv5ekHM2hhBTJTfJIcTDU+sRF+J9GVPqHFqOKUlfAWp9bAytkfsKwW
 mJDKOWc+6tfm4xEGMvIw4EgJIPo3/KbjqEKysZZxP+fJ+GEcBDJuQmBwtK78zqBmQoHwkM
 5dkA/eQBqlS2VdxMM6zzpjWLCnocA2A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-bnITvA94Mgm9CeWsEKdxhQ-1; Wed, 08 Mar 2023 09:29:02 -0500
X-MC-Unique: bnITvA94Mgm9CeWsEKdxhQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 y1-20020a056402358100b004ea439d57b7so12006942edc.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678285741;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UiLCxa5R4eTbWMfdTIM20tjq3AuaDrZaN1Rif80B7JI=;
 b=4vYB0294pi82lL4BoM1q0QF9qaC5ZBhHci/SnQaFwo10alF27hpDI1f6UqMu2M6tef
 7n8AqWIu0mGcncsZGu+GChGAdvAd1H/LpC2QdEbTuttlUyX/2o/QA5uU/NUrwWJ9T8z0
 8hvRMktR3kbPZGiPMZRBG3FBZ+SLpWQvLMtTOf7vj2ZuLb7PetAA0HxTkSVe+nbu0lcP
 SOpYD5WFo0EJ2pXbkgEjY+50vHaDAoRbFnP/W4n5G5QWuaBMpsqyOpuXC+IQG4MkDrtC
 KSClI8fxFR5dR8BA7eOOZadphmp3H2iAIc6LbTz+3FQNDujVF3coMN/EyuP+njEvHDMF
 vhIQ==
X-Gm-Message-State: AO0yUKV0pB6Xlbjlkjn+3W5AVRpFNORhVL6WbH/EE1xAIqxBnujU3uPl
 kDdyjGL9Vt9egvqan2X+CFIDDK9/2CV3Z9ntUq5HRvynejtTf+n6R5q88rtujzxm2TOP15iXP10
 3VLM8zxmIX6dCKUSJ8pocotsWHejhB9d6vBCQcwwr4w==
X-Received: by 2002:aa7:d84f:0:b0:4ae:eb0f:4273 with SMTP id
 f15-20020aa7d84f000000b004aeeb0f4273mr18134893eds.15.1678285740974; 
 Wed, 08 Mar 2023 06:29:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8mXIA4p2qBLmKibx1jYwjwP+Buf6HA2Zwy5Ck5SXzGBlh/ES+/CFmeXTbZQotGZgREft6vWw==
X-Received: by 2002:aa7:d84f:0:b0:4ae:eb0f:4273 with SMTP id
 f15-20020aa7d84f000000b004aeeb0f4273mr18134875eds.15.1678285740726; 
 Wed, 08 Mar 2023 06:29:00 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 g10-20020a50d0ca000000b004bc9d44478fsm8280227edf.51.2023.03.08.06.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:29:00 -0800 (PST)
Date: Wed, 8 Mar 2023 09:28:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308092541-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
 <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDk6MTk6MzhBTSAtMDUwMCwgRmVuZyBMaXUgd3JvdGU6
Cj4gCj4gCj4gT24gMjAyMy0wMy0wOCBhLm0uOToxNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMKPiA+IAo+ID4gCj4gPiBPbiBXZWQsIE1hciAwOCwgMjAyMyBhdCAwOTowNzo0OUFNIC0w
NTAwLCBGZW5nIExpdSB3cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiBPbiAyMDIzLTAzLTA4IGEu
bS4xMjo1OCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+ID4gPiA+IAo+ID4gPiA+IAo+ID4g
PiA+IE9uIFR1ZSwgTWFyIDcsIDIwMjMgYXQgMTE6NTfigK9BTSBGZW5nIExpdSA8ZmVsaXVAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IEFkZCBjb25zdCB0byBtYWtlIHRo
ZSByZWFkLW9ubHkgcG9pbnRlciBwYXJhbWV0ZXJzIGNsZWFyLCBzaW1pbGFyIHRvCj4gPiA+ID4g
PiBtYW55IGV4aXN0aW5nIGZ1bmN0aW9ucy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTog
SmlyaSBQaXJrbyA8amlyaUBudmlkaWEuY29tPgo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFBhcmF2
IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBHYXZpbiBM
aSA8Z2F2aW5sQG52aWRpYS5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogQm9kb25nIFdhbmcg
PGJvZG9uZ0BudmlkaWEuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ID4gPiA+
ID4gICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8IDEyICsrKysrKy0tLS0tLQo+ID4g
PiA+ID4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkKPiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IFsuLi5dCj4gPiA+ID4gCj4gPiA+ID4gPiAK
PiA+ID4gPiA+IC0vKgo+ID4gPiA+ID4gLSAqIFRoaXMgc2hvdWxkIHByZXZlbnQgdGhlIGRldmlj
ZSBmcm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZlcnMgdG8KPiA+ID4gPiA+ICsvIFRoaXMg
c2hvdWxkIHByZXZlbnQgdGhlIGRldmljZSBmcm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZl
cnMgdG8KPiA+ID4gPiA+ICAgICAqIHJlY292ZXIuICBZb3UgbWF5IG5lZWQgdG8gZ3JhYiBhcHBy
b3ByaWF0ZSBsb2NrcyB0byBmbHVzaC4KPiA+ID4gPiA+ICAgICAqLwo+ID4gPiA+IAo+ID4gPiA+
IEFueSByZWFzb24gZm9yIHRoaXMgY2hhbmdlPwo+ID4gPiA+IAo+ID4gPiBIaSwgSmFzb24KPiA+
ID4gVGhlIG9yaWdpbmFsIGNvbW1lbnQgb2YgdGhlIGNvZGUgaGFkIGEgc3ludGF4IHByb2JsZW0g
YW5kIGNvdWxkbid0IGNvbXBpbGUsCj4gPiA+IEkgZml4ZWQgaXQgaGVyZQo+ID4gCj4gPiBUaGlz
IGlzIGhvdyBpdCBsb29rZWQgYmVmb3JlIHlvdXIgcGF0Y2g6Cj4gPiAKPiA+IC8qCj4gPiAgICog
VGhpcyBzaG91bGQgcHJldmVudCB0aGUgZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwgYWxsb3dpbmcg
ZHJpdmVycyB0bwo+ID4gICAqIHJlY292ZXIuICBZb3UgbWF5IG5lZWQgdG8gZ3JhYiBhcHByb3By
aWF0ZSBsb2NrcyB0byBmbHVzaC4KPiA+ICAgKi8KPiA+IAo+ID4gSSBzZWUgbm8gcHJvYmxlbSBo
ZXJlLgo+ID4gCj4gWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIG1hZGUgYSBtaXN0YWtlIGhlcmUsIEkg
d2lsbCBmaXggaXQKCk5pY2UgYnV0IHRoZSBiaWdnZXIgcHJvYmxlbSBpcyBub3QgdGhlIG1pc3Rh
a2UgLSBpdCBpcyB0aGUgcG9zdGluZyBvZgp1bnRlc3RlZCBjb2RlLiBJdCBtaWdodCBiZSBhbiBv
ayB0aGluZyB0byBkbyAtIGFzIGxvbmcgYXMgeW91IG1ha2UgaXQKc3VwZXIgYWJ1bmRhbnRybHkg
Y2xlYXIgdGhhdCB0aGlzIGlzIHdoYXQgaXQgaXMsIGFuZCBleHBsYWluIHdoeQp5b3UgYXJlIHBv
c3RpbmcgaXQgbm93IGFuZCBub3QgYWZ0ZXIgdGVzdGluZy4KCj4gPiAKPiA+ID4gPiBUaGFua3MK
PiA+ID4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
