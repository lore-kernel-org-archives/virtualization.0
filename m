Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162CC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C3BB410E7;
	Wed,  9 Feb 2022 04:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ciayDAbV3D4K; Wed,  9 Feb 2022 04:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC66E408D6;
	Wed,  9 Feb 2022 04:39:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B67FEC001A;
	Wed,  9 Feb 2022 04:39:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1734C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FA0A81368
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8Rms2xgAnvJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7314A81358
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644381564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1kf6j/pfO95p2NADuTOz6pxSpChN6rEDgT0nLmQL7w4=;
 b=S0X4YSwdl/JvPVEEpFKgmJdqg/TfhwJC6VT8iuyZKT0TrvTw9p3Pq94xVeWcB1x1OaDWGT
 TopLUBEx8aH0/uNeEh8VW59/FnGjI3IWU/XhjHdZWfSlggUeRf2fKRX9/g8+8eVrYRrXON
 DT3AERrbizwFqzHGedhlJ41fakEMyJU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-m93Ek2cPOqC6-BEzko7QIw-1; Tue, 08 Feb 2022 23:39:19 -0500
X-MC-Unique: m93Ek2cPOqC6-BEzko7QIw-1
Received: by mail-pl1-f197.google.com with SMTP id
 p7-20020a1709026b8700b0014a8d8fbf6fso905502plk.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1kf6j/pfO95p2NADuTOz6pxSpChN6rEDgT0nLmQL7w4=;
 b=eqkoFli1r6nkyVCbScqno5XPG+GKgbIjswPXHQdevt365qSZTkEgtcvYpzD4w8GpgP
 ZSxC3UbrwNfW1TKpMmGDkXO81ONNQNiKC30GDiNA+b703oqlC86X6SEKVS5PA0xsZKWB
 v3VAQePhET7z1I2XkLs2nbPQRK0hD0xDq/gfJkJJ0QiQH9+5G/Pkk3ZHEBa1L7BOHTqq
 68zSycmcz97wpIKs1M7LUflLp26ldANFNU4QZ/TPhkCan7RcQIV6d2feYCUL6qQLlZqX
 UPqZf2M5he2E7FGt0X7NOeKdVVHnBZ8Mtsn/kWhTm0trIs2afNw7GBc/IrIftrUyFPMg
 xy3g==
X-Gm-Message-State: AOAM530xwfy1gMcVTzXZZO2cOidTIa1nSJsXuEtFMZrrJQ0q/3g0wqrr
 vgiJn/wZdrGK8Xj76kGNoHufRNIEsDWbEnE3fjK/dkW2oIH6VsHo5IxdNZTtAJ1wbmu4YmCpN5r
 gJ/ZIDB83tNntrMzDpELmpqm/yUVR54+JJV10sgI7ww==
X-Received: by 2002:a17:90b:351:: with SMTP id
 fh17mr1494244pjb.28.1644381557329; 
 Tue, 08 Feb 2022 20:39:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMXR6X2J1CaA2tRB0gLeu4mXToGnDAqW9oiqkiF+2CcatJHXLt3XWFCBXLi/0YasKKk8UpiQ==
X-Received: by 2002:a17:90b:351:: with SMTP id
 fh17mr1494231pjb.28.1644381557019; 
 Tue, 08 Feb 2022 20:39:17 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j10sm17444059pfu.93.2022.02.08.20.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 20:39:16 -0800 (PST)
Message-ID: <5ac96035-2448-2a25-5bc9-677a7eb0a271@redhat.com>
Date: Wed, 9 Feb 2022 12:39:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 2/5] driver/net/tun: Added features for USO.
To: Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-3-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-3-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

CuWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0NiwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBB
ZGRlZCBzdXBwb3J0IGZvciBVU080IGFuZCBVU082LCBhbHNvIGFkZGVkIGNvZGUgZm9yIG5ldyBp
b2N0bCBUVU5HRVRTVVBQT1JURURPRkZMT0FEUy4KPiBGb3Igbm93LCB0byAiZW5hYmxlIiBVU08s
IGl0J3MgcmVxdWlyZWQgdG8gc2V0IGJvdGggVVNPNCBhbmQgVVNPNiBzaW11bHRhbmVvdXNseS4K
PiBVU08gZW5hYmxlcyBORVRJRl9GX0dTT19VRFBfTDQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXcgTWVsbnljaGVua28gPGFuZHJld0BkYXluaXguY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQv
dGFwLmMgfCAxOCArKysrKysrKysrKysrKysrLS0KPiAgIGRyaXZlcnMvbmV0L3R1bi5jIHwgMTUg
KysrKysrKysrKysrKystCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdGFwLmMgYi9kcml2ZXJz
L25ldC90YXAuYwo+IGluZGV4IDhlM2EyOGJhNmIyOC4uODJkNzQyYmE3OGIxIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3RhcC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdGFwLmMKPiBAQCAtOTQw
LDYgKzk0MCwxMCBAQCBzdGF0aWMgaW50IHNldF9vZmZsb2FkKHN0cnVjdCB0YXBfcXVldWUgKnEs
IHVuc2lnbmVkIGxvbmcgYXJnKQo+ICAgCQkJaWYgKGFyZyAmIFRVTl9GX1RTTzYpCj4gICAJCQkJ
ZmVhdHVyZV9tYXNrIHw9IE5FVElGX0ZfVFNPNjsKPiAgIAkJfQo+ICsKPiArCQkvKiBUT0RPOiBm
b3Igbm93IFVTTzQgYW5kIFVTTzYgc2hvdWxkIHdvcmsgc2ltdWx0YW5lb3VzbHkgKi8KPiArCQlp
ZiAoYXJnICYgKFRVTl9GX1VTTzQgfCBUVU5fRl9VU082KSA9PSAoVFVOX0ZfVVNPNCB8IFRVTl9G
X1VTTzYpKQo+ICsJCQlmZWF0dXJlcyB8PSBORVRJRl9GX0dTT19VRFBfTDQ7CgoKSWYga2VybmVs
IGRvZXNuJ3Qgd2FudCB0byBzcGxpdCB0aGUgR1NPX1VEUCBmZWF0dXJlcywgSSB3b25kZXIgaG93
IG11Y2ggCnZhbHVlIHRvIGtlZXAgc2VwYXJhdGVkIGZlYXR1cmVzIGZvciBUVU4gYW5kIHZpcnRp
by4KClRoYW5rcwoKCj4gICAJfQo+ICAgCj4gICAJLyogdHVuL3RhcCBkcml2ZXIgaW52ZXJ0cyB0
aGUgdXNhZ2UgZm9yIFRTTyBvZmZsb2Fkcywgd2hlcmUKPiBAQCAtOTUwLDcgKzk1NCw4IEBAIHN0
YXRpYyBpbnQgc2V0X29mZmxvYWQoc3RydWN0IHRhcF9xdWV1ZSAqcSwgdW5zaWduZWQgbG9uZyBh
cmcpCj4gICAJICogV2hlbiB1c2VyIHNwYWNlIHR1cm5zIG9mZiBUU08sIHdlIHR1cm4gb2ZmIEdT
Ty9MUk8gc28gdGhhdAo+ICAgCSAqIHVzZXItc3BhY2Ugd2lsbCBub3QgcmVjZWl2ZSBUU08gZnJh
bWVzLgo+ICAgCSAqLwo+IC0JaWYgKGZlYXR1cmVfbWFzayAmIChORVRJRl9GX1RTTyB8IE5FVElG
X0ZfVFNPNikpCj4gKwlpZiAoZmVhdHVyZV9tYXNrICYgKE5FVElGX0ZfVFNPIHwgTkVUSUZfRl9U
U082KSB8fAo+ICsJICAgIGZlYXR1cmVfbWFzayAmIChUVU5fRl9VU080IHwgVFVOX0ZfVVNPNikg
PT0gKFRVTl9GX1VTTzQgfCBUVU5fRl9VU082KSkKPiAgIAkJZmVhdHVyZXMgfD0gUlhfT0ZGTE9B
RFM7Cj4gICAJZWxzZQo+ICAgCQlmZWF0dXJlcyAmPSB+UlhfT0ZGTE9BRFM7Cj4gQEAgLTk3OSw2
ICs5ODQsNyBAQCBzdGF0aWMgbG9uZyB0YXBfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2ln
bmVkIGludCBjbWQsCj4gICAJdW5zaWduZWQgc2hvcnQgdTsKPiAgIAlpbnQgX191c2VyICpzcCA9
IGFyZ3A7Cj4gICAJc3RydWN0IHNvY2thZGRyIHNhOwo+ICsJdW5zaWduZWQgaW50IHN1cHBvcnRl
ZF9vZmZsb2FkczsKPiAgIAlpbnQgczsKPiAgIAlpbnQgcmV0Owo+ICAgCj4gQEAgLTEwNzQsNyAr
MTA4MCw4IEBAIHN0YXRpYyBsb25nIHRhcF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWdu
ZWQgaW50IGNtZCwKPiAgIAljYXNlIFRVTlNFVE9GRkxPQUQ6Cj4gICAJCS8qIGxldCB0aGUgdXNl
ciBjaGVjayBmb3IgZnV0dXJlIGZsYWdzICovCj4gICAJCWlmIChhcmcgJiB+KFRVTl9GX0NTVU0g
fCBUVU5fRl9UU080IHwgVFVOX0ZfVFNPNiB8Cj4gLQkJCSAgICBUVU5fRl9UU09fRUNOIHwgVFVO
X0ZfVUZPKSkKPiArCQkJICAgIFRVTl9GX1RTT19FQ04gfCBUVU5fRl9VRk8gfAo+ICsJCQkgICAg
VFVOX0ZfVVNPNCB8IFRVTl9GX1VTTzYpKQo+ICAgCQkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAg
IAkJcnRubF9sb2NrKCk7Cj4gQEAgLTEwODIsNiArMTA4OSwxMyBAQCBzdGF0aWMgbG9uZyB0YXBf
aW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4gICAJCXJ0bmxfdW5s
b2NrKCk7Cj4gICAJCXJldHVybiByZXQ7Cj4gICAKPiArCWNhc2UgVFVOR0VUU1VQUE9SVEVET0ZG
TE9BRFM6Cj4gKwkJc3VwcG9ydGVkX29mZmxvYWRzID0gVFVOX0ZfQ1NVTSB8IFRVTl9GX1RTTzQg
fCBUVU5fRl9UU082IHwKPiArCQkJCQkJVFVOX0ZfVFNPX0VDTiB8IFRVTl9GX1VGTyB8IFRVTl9G
X1VTTzQgfCBUVU5fRl9VU082Owo+ICsJCWlmIChjb3B5X3RvX3VzZXIoJmFyZywgJnN1cHBvcnRl
ZF9vZmZsb2Fkcywgc2l6ZW9mKHN1cHBvcnRlZF9vZmZsb2FkcykpKQo+ICsJCQlyZXR1cm4gLUVG
QVVMVDsKPiArCQlyZXR1cm4gMDsKPiArCj4gICAJY2FzZSBTSU9DR0lGSFdBRERSOgo+ICAgCQly
dG5sX2xvY2soKTsKPiAgIAkJdGFwID0gdGFwX2dldF90YXBfZGV2KHEpOwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jCj4gaW5kZXggZmVkODU0NDc3
MDFhLi40ZjIxMDVkMWU2ZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMKPiArKysg
Yi9kcml2ZXJzL25ldC90dW4uYwo+IEBAIC0xODUsNyArMTg1LDcgQEAgc3RydWN0IHR1bl9zdHJ1
Y3Qgewo+ICAgCXN0cnVjdCBuZXRfZGV2aWNlCSpkZXY7Cj4gICAJbmV0ZGV2X2ZlYXR1cmVzX3QJ
c2V0X2ZlYXR1cmVzOwo+ICAgI2RlZmluZSBUVU5fVVNFUl9GRUFUVVJFUyAoTkVUSUZfRl9IV19D
U1VNfE5FVElGX0ZfVFNPX0VDTnxORVRJRl9GX1RTT3wgXAo+IC0JCQkgIE5FVElGX0ZfVFNPNikK
PiArCQkJICBORVRJRl9GX1RTTzYgfCBORVRJRl9GX0dTT19VRFBfTDQpCj4gICAKPiAgIAlpbnQJ
CQlhbGlnbjsKPiAgIAlpbnQJCQl2bmV0X2hkcl9zejsKPiBAQCAtMjgyMSw2ICsyODIxLDEyIEBA
IHN0YXRpYyBpbnQgc2V0X29mZmxvYWQoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgdW5zaWduZWQg
bG9uZyBhcmcpCj4gICAJCX0KPiAgIAo+ICAgCQlhcmcgJj0gflRVTl9GX1VGTzsKPiArCj4gKwkJ
LyogVE9ETzogZm9yIG5vdyBVU080IGFuZCBVU082IHNob3VsZCB3b3JrIHNpbXVsdGFuZW91c2x5
ICovCj4gKwkJaWYgKGFyZyAmIFRVTl9GX1VTTzQgJiYgYXJnICYgVFVOX0ZfVVNPNikgewo+ICsJ
CQlmZWF0dXJlcyB8PSBORVRJRl9GX0dTT19VRFBfTDQ7Cj4gKwkJCWFyZyAmPSB+KFRVTl9GX1VT
TzQgfCBUVU5fRl9VU082KTsKPiArCQl9Cj4gICAJfQo+ICAgCj4gICAJLyogVGhpcyBnaXZlcyB0
aGUgdXNlciBhIHdheSB0byB0ZXN0IGZvciBuZXcgZmVhdHVyZXMgaW4gZnV0dXJlIGJ5Cj4gQEAg
LTI5OTEsNiArMjk5Nyw3IEBAIHN0YXRpYyBsb25nIF9fdHVuX2Nocl9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPiAgIAlpbnQgc25kYnVmOwo+ICAgCWludCB2bmV0
X2hkcl9zejsKPiAgIAlpbnQgbGU7Cj4gKwl1bnNpZ25lZCBpbnQgc3VwcG9ydGVkX29mZmxvYWRz
Owo+ICAgCWludCByZXQ7Cj4gICAJYm9vbCBkb19ub3RpZnkgPSBmYWxzZTsKPiAgIAo+IEBAIC0z
MTU0LDYgKzMxNjEsMTIgQEAgc3RhdGljIGxvbmcgX190dW5fY2hyX2lvY3RsKHN0cnVjdCBmaWxl
ICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCWNhc2UgVFVOU0VUT0ZGTE9BRDoKPiAgIAkJ
cmV0ID0gc2V0X29mZmxvYWQodHVuLCBhcmcpOwo+ICAgCQlicmVhazsKPiArCWNhc2UgVFVOR0VU
U1VQUE9SVEVET0ZGTE9BRFM6Cj4gKwkJc3VwcG9ydGVkX29mZmxvYWRzID0gVFVOX0ZfQ1NVTSB8
IFRVTl9GX1RTTzQgfCBUVU5fRl9UU082IHwKPiArCQkJCVRVTl9GX1RTT19FQ04gfCBUVU5fRl9V
Rk8gfCBUVU5fRl9VU080IHwgVFVOX0ZfVVNPNjsKPiArCQlpZiAoY29weV90b191c2VyKCZhcmcs
ICZzdXBwb3J0ZWRfb2ZmbG9hZHMsIHNpemVvZihzdXBwb3J0ZWRfb2ZmbG9hZHMpKSkKPiArCQkJ
cmV0ID0gLUVGQVVMVDsKPiArCQlicmVhazsKPiAgIAo+ICAgCWNhc2UgVFVOU0VUVFhGSUxURVI6
Cj4gICAJCS8qIENhbiBiZSBzZXQgb25seSBmb3IgVEFQcyAqLwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
