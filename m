Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E986AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 06:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84AF28199D;
	Fri, 11 Feb 2022 06:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dqsc_9SSos8e; Fri, 11 Feb 2022 06:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1700F81A65;
	Fri, 11 Feb 2022 06:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC821C001A;
	Fri, 11 Feb 2022 06:49:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9E60C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A19C940921
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJ747siCxZYX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1860B408E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644562153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqHQIWGXIFVxKI6GDzeMgJSaFCUeRQ0XbIBm2xgz2GI=;
 b=XLu1yq2NwZfSguWKE2oiPUHb9L/QPWL4afOQ1ohJcJvL9y4r7qKOVfCNP0GLp2H21wzS6Q
 M/GBpdV7fLy/yoAb61BkejNLW1rtet163Ry5H3b3EYLqU8LRqmru2Bkv711558Rhs9rI65
 fXpoJgibMfdBLa1AwAPxAqCzp3UWZn4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-PgzY5A3XP46ZUFOM92z3dw-1; Fri, 11 Feb 2022 01:49:12 -0500
X-MC-Unique: PgzY5A3XP46ZUFOM92z3dw-1
Received: by mail-pj1-f72.google.com with SMTP id
 iy10-20020a17090b16ca00b001b8a7ed5b2cso7720192pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 22:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QqHQIWGXIFVxKI6GDzeMgJSaFCUeRQ0XbIBm2xgz2GI=;
 b=MKhrBim0imEESzo7OnNv+LfkPQfbK7bpcew/R770ke1rX6gqEkyU4vLVU76fZkfdUf
 p7FUeksXOnG65dbK1nyXDokx1xgOyVN4ZzfTnRZPSytdEh3cDI3wTLSpGYdgsYlTPW8u
 M+UVKi2zWpIP24Vjub+fvE4A/p1tEKUrVoyyo+zOBafpbha+d8bIrJMd7tHtYg3LKJKP
 kG1q5aN7P1qS8ySEtwnbB10oqbDlq+CUf/hdXukJ78xXnSgFUHyD1uUqj3mTVs0Z72os
 OYFyQNEcgd8BmIVC5Vb3hT9ib4iVp7dSQHuoz7aWjSo/GGV6BcYoNB3jfeLZ+1FJhi5U
 VYTg==
X-Gm-Message-State: AOAM533mhntGp6a3IADT/HCil9CucpbJJSudUGNvlrzN2lFqv1C8RgH3
 MHHXpXXmOhnwsJV7IY33pS4d5dcRwDqNoc7Cxt4wDQ/YT7FlFiikLJBAiZQqK94Wn0t8JUrt/Nv
 N1JIi+iJFoG5EhjxvvDJTKp+HPZJ2Uj8h6oNQwh/vVA==
X-Received: by 2002:a17:90b:1c81:: with SMTP id
 oo1mr341210pjb.192.1644562151654; 
 Thu, 10 Feb 2022 22:49:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlp7DVScBoR+0Irx9Zpl3LczX5pbJo/8fIM1kdX/BqalYu4Z3jVejXSwwGCrfFZDw2RLQUBw==
X-Received: by 2002:a17:90b:1c81:: with SMTP id
 oo1mr341190pjb.192.1644562151294; 
 Thu, 10 Feb 2022 22:49:11 -0800 (PST)
Received: from [10.72.13.85] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f16sm27988160pfa.147.2022.02.10.22.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 22:49:10 -0800 (PST)
Message-ID: <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
Date: Fri, 11 Feb 2022 14:49:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzIvOSDkuIvljYg4OjI4LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFBlcmZvcm1pbmcg
cmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gZm91ciBzdGVwczoKPgo+IDEuIHJlc2V0
X3ZxOiByZXNldCBvbmUgdnEKPiAyLiByZWN5Y2xlIHRoZSBidWZmZXIgZnJvbSB2cSBieSB2aXJ0
cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKQo+IDMuIHJlbGVhc2UgdGhlIHJpbmcgb2YgdGhlIHZx
IGJ5IHZyaW5nX3JlbGVhc2VfdmlydHF1ZXVlKCkKPiA0LiBlbmFibGVfcmVzZXRfdnE6IHJlLWVu
YWJsZSB0aGUgcmVzZXQgcXVldWUKPgo+IFNvIGFkZCB0d28gY2FsbGJhY2tzIHJlc2V0X3ZxLCBl
bmFibGVfcmVzZXRfdnEgdG8gc3RydWN0Cj4gdmlydGlvX2NvbmZpZ19vcHMuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAg
aW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggfCAxMyArKysrKysrKysrKysrCj4gICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRl
eCA0ZDEwN2FkMzExNDkuLjBkMDFhNjRmMjU3NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3ZpcnRpb19jb25maWcuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4g
QEAgLTc0LDYgKzc0LDE3IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gICAgKiBAc2V0
X3ZxX2FmZmluaXR5OiBzZXQgdGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwp
Lgo+ICAgICogQGdldF92cV9hZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVl
dWUgKG9wdGlvbmFsKS4KPiAgICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9y
eSByZWdpb24gYmFzZWQgb24gdGhlIGluZGV4Lgo+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVl
dWUgaW5kaXZpZHVhbGx5CgoKVGhpcyBuZWVkcyB0byBiZSBtYXJrZWQgYXMgb3B0aW9uYWwgSSB0
aGluay4KCgo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKglSZXR1cm5zIDAgb24gc3VjY2Vz
cyBvciBlcnJvciBzdGF0dXMKCgpJdCBsb29rcyB0byBtZSB0aGUgY2FsbGVyIHNob3VsZCBhbHNv
IGd1YXJhbnRlZSB0aGF0IHRoZSB2cmluZyBpcyBub3QgCmFjY3NlZCBieSBhbnkgZnVuY3Rpb25z
IGUuZyBOQVBJLgoKCj4gKyAqCUFmdGVyIHN1Y2Nlc3NmdWxseSBjYWxsaW5nIHRoaXMsIGJlIHN1
cmUgdG8gY2FsbAo+ICsgKgl2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSB0byByZWN5Y2xl
IHRoZSBidWZmZXIgaW4gdGhlIHJpbmcsIGFuZAo+ICsgKgl0aGVuIGNhbGwgdnJpbmdfcmVsZWFz
ZV92aXJ0cXVldWUoKSB0byByZWxlYXNlIHRoZSB2cSByaW5nLgo+ICsgKiBAZW5hYmxlX3Jlc2V0
X3ZxOiBlbmFibGUgYSByZXNldCBxdWV1ZQo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKgly
aW5nX251bTogc3BlY2lmeSByaW5nIG51bSBmb3IgdGhlIHZxIHRvIGJlIHJlLWVuYWJsZWQuIDAg
bWVhbnMgdXNlIHRoZQo+ICsgKgkgICAgICAgICAgZGVmYXVsdCB2YWx1ZS4gTVVTVCBiZSBhIHBv
d2VyIG9mIDIuCgoKTm90ZSB0aGF0IHdlIGRvbid0IGhhdmUgcG93ZXIgb2YgMiByZXF1aXJlbWVu
dCBmb3IgcGFja2VkIHZpcnRxdWV1ZS4KCkFuZCBJIHdvbmRlciBpZiBpdCdzIGNsZWFuZXIgdG8g
aGF2ZSBhIGZpbmRfdnEoKSBvcHMgaW5zdGVhZCB0byBkZWFsaW5nIAp3aXRoIHRoZSByZS1hbGxv
Y2F0aW9uIGFuZCBwb3NzaWJsZSBzaXplIGNoYW5nZSwgb3IgaGF2ZSBhIGRlZGljYXRlZCAKaGVs
cGVyIHRvIHNldCB2cmluZyBzaXplIHNvIGRyaXZlciBjYW4gZG8uCgpyZXNldF92cSgpCgp2aXJ0
cXVldWVfc2V0X3ZyaW5nX3NpemUoKQoKZW5hYmxlX3Jlc2V0X3ZxKCkKCgo+ICsgKglSZXR1cm5z
IDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiAgICAqLwo+ICAgdHlwZWRlZiB2b2lkIHZx
X2NhbGxiYWNrX3Qoc3RydWN0IHZpcnRxdWV1ZSAqKTsKPiAgIHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyB7Cj4gQEAgLTEwMCw2ICsxMTEsOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ICAgCQkJaW50IGluZGV4KTsKPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LAo+ICAgCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiAq
cmVnaW9uLCB1OCBpZCk7Cj4gKwlpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ICsJaW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTE2IHJp
bmdfbnVtKTsKCgpOb3RlIHRoYXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50IGlzIGJlc3QtZWZmb3J0
LCBzbyBpdCdzIG5vdCBndWFyYW50ZWUgCnRoYXQgd2UgY2FuIGhhdmUgYSB2cmluZyB3aXRoIHJp
bmdfbnVtLCB3ZSBtYXkgZ2V0IGxlc3MgdW5kZXIgbWVtb3J5IApwcmVzc3VyZSBvciBldmVuIGZh
aWwuIFdlIHByb2JhYmx5IG5lZWQgdG8gaGF2ZSBhIHBhbWF0ZXIgdG8gbWFuZGF0ZSB0aGUgCnJp
bmdfbnVtIG90aGVyd2lzZSB1c2VyIG1heSBzdXJwcmlzZSB0byBzZWUgYSBkZWNyZWFzZWQgc2l6
ZSBvZiB0aGUgcmluZyAKd2hlbiBhIGluY3JlYXNpbmcgaXMgYWN0dWFsbHkgcmVxdWVzdGVkLgoK
VGhhbmtzCgoKPiAgIH07Cj4gICAKPiAgIC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNlIHRo
ZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVyIGFwcGVhci4gKi8KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
