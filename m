Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C639C432BE
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:38:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A587E61104
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A587E61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FD8B40785;
	Thu, 19 Aug 2021 03:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ReF0eeT1sZf7; Thu, 19 Aug 2021 03:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12CA14074C;
	Thu, 19 Aug 2021 03:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD081C001A;
	Thu, 19 Aug 2021 03:38:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F5A0C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A25E400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zY7jeUGhgtCH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:38:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0218B400B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629344287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLcUBNR300GL+dQUPeb8PXuVHf0dD9sBvfvKLM3hRBM=;
 b=QPQvGOWi9mo9Im59GpPvgUiTOr/HVaLqOr5HQnq+Ed0Bg0AxsC3s3dpYgQQcpC0FGW8bAv
 YBNOAfll+vwVE9f0Yc+VUoh9JiblglYYyZCEbDqTdbiccFOlInz2Jw+jNPO0sT2M67Vh5s
 k8EMtjBICJkCfexlmIlrE0+669uWKd8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-PU2aeiYXO3iwO_N30zfIcQ-1; Wed, 18 Aug 2021 23:38:06 -0400
X-MC-Unique: PU2aeiYXO3iwO_N30zfIcQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 o23-20020a17090a4217b02901774c248202so1101757pjg.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 20:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XLcUBNR300GL+dQUPeb8PXuVHf0dD9sBvfvKLM3hRBM=;
 b=UowwhamVFFwGUU+4+FMdqkAedHAE0Jw07T0IKZ8vi7j2gg/g9MavDbOHLIVwh86ddS
 trTppj10ncnNWd38LEDM3pBr+S2MnXH1kqv43sR6+Fr3yFIxVJxippSGA/GlMH/vjAUQ
 s2EgeEK/bsv9WnnxfFLYQvCeTe0w1Gri0rPs6gcCKMZWIqJBIXG0oAVZkMRdM7XX9JCU
 MXcEHKArth32hH7NN+TGBpycSD0AmW1GbfTAkiL4tpSdzdSBAawAnUCVdQQEIF7GAH2G
 Ny9VZRYvcd8kfBS5O2BslvdEvmoz6SENQrkpKKTAEkHbfs8XPhaKQcxczjI1NO9Q5K1G
 QDAQ==
X-Gm-Message-State: AOAM532DI4VjxGNK34Beg2Z4pQBPdllXywHzGXIIXOWkxhILQdd1849y
 Cxbbo3VWMI/WPxlPRo7QFfKUD2ZlYmXX0oJKOdKnaJ6LpCQfkF5q+LS3TsYyEZGa3sZqAqOsL3l
 AwX6zU/yfY/9HfdAsX9GVPUPhO+KZ/7NdjkcZHeyF3g==
X-Received: by 2002:a17:90b:504:: with SMTP id
 r4mr12341491pjz.77.1629344285179; 
 Wed, 18 Aug 2021 20:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5fTKOZKGTbBY8tK8HncH0dnHraaTuNE/FLooMXDYKRCNfAq5Wncyh/6dG137QZthX1oTUNg==
X-Received: by 2002:a17:90b:504:: with SMTP id
 r4mr12341475pjz.77.1629344284924; 
 Wed, 18 Aug 2021 20:38:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r16sm1164453pje.10.2021.08.18.20.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 20:38:04 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] vdpa/mlx5: Decouple virtqueue callback from struct
 mlx5_vdpa_virtqueue
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210817060250.188705-1-elic@nvidia.com>
 <20210817060250.188705-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ccf36dfb-0bd5-5dc4-b713-a2018ffd8b50@redhat.com>
Date: Thu, 19 Aug 2021 11:37:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817060250.188705-4-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xNyDPws7nMjowMiwgRWxpIENvaGVuINC0tcA6Cj4gSW5zdGVhZCwgZGVmaW5l
IGFuIGFycmF5IG9mIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIG9uIHN0cnVjdCBtbHg1X3ZkcGFfbmV0
Cj4gYW5kIHVzZSBpdCB0byBzdG9yZSBjYWxsYmFja3MgZm9yIGFueSB2aXJ0cXVldWUgcHJvdmlk
ZWQuIFRoaXMgaXMKPiByZXF1aXJlZCBkdWUgdG8gdGhlIGZhY3QgdGhhdCBjYWxsYmFjayBjb25m
aWd1cmF0aW9ucyBhcnJpdmUgYmVmb3JlIGZlYXR1cmUKPiBuZWdvdGlhdGlvbi4gV2l0aCBjb250
cm9sIFZRIGFuZCBtdWx0aXF1ZXVlIGludHJvZHVjZWQgbmV4dCB3ZSB3YW50IHRvCj4gc2F2ZSB0
aGUgaW5mb3JtYXRpb24gdW50aWwgYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiB3aGVyZSB3ZSBr
bm93IHRoZQo+IENWUSBpbmRleC4KPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
QSBxdWVzdGlvbjogRG8gd2UgbmVlZCB0byByZXNldCB0aGUgY2IgZHVyaW5nIGRldmljZSByZXNl
dD8KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMg
fCAxNiArKysrKysrKy0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IGEx
Y2Y1OGE1M2Q0Mi4uMjIyZGRmYmRlMTE2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+IEBAIC05MCw3ICs5MCw2IEBAIHN0cnVjdCBtbHg1X3ZxX3Jlc3RvcmVfaW5mbyB7Cj4gICAJ
dTE2IGF2YWlsX2luZGV4Owo+ICAgCXUxNiB1c2VkX2luZGV4Owo+ICAgCWJvb2wgcmVhZHk7Cj4g
LQlzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPiAgIAlib29sIHJlc3RvcmU7Cj4gICB9Owo+ICAg
Cj4gQEAgLTEwMCw3ICs5OSw2IEBAIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlIHsKPiAgIAl1
NjQgZGV2aWNlX2FkZHI7Cj4gICAJdTY0IGRyaXZlcl9hZGRyOwo+ICAgCXUzMiBudW1fZW50Owo+
IC0Jc3RydWN0IHZkcGFfY2FsbGJhY2sgZXZlbnRfY2I7Cj4gICAKPiAgIAkvKiBSZXNvdXJjZXMg
Zm9yIGltcGxlbWVudGluZyB0aGUgbm90aWZpY2F0aW9uIGNoYW5uZWwgZnJvbSB0aGUgZGV2aWNl
Cj4gICAJICogdG8gdGhlIGRyaXZlci4gZndxcCBpcyB0aGUgZmlybXdhcmUgZW5kIG9mIGFuIFJD
IGNvbm5lY3Rpb247IHRoZQo+IEBAIC0xNDAsNiArMTM4LDcgQEAgc3RydWN0IG1seDVfdmRwYV9u
ZXQgewo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0X3Jlc291cmNlcyByZXM7Cj4gICAJc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnIGNvbmZpZzsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1
ZSB2cXNbTUxYNV9NQVhfU1VQUE9SVEVEX1ZRU107Cj4gKwlzdHJ1Y3QgdmRwYV9jYWxsYmFjayBl
dmVudF9jYnNbTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyArIDFdOwo+ICAgCj4gICAJLyogU2VyaWFs
aXplIHZxIHJlc291cmNlcyBjcmVhdGlvbiBhbmQgZGVzdHJ1Y3Rpb24uIFRoaXMgaXMgcmVxdWly
ZWQKPiAgIAkgKiBzaW5jZSBtZW1vcnkgbWFwIG1pZ2h0IGNoYW5nZSBhbmQgd2UgbmVlZCB0byBk
ZXN0cm95IGFuZCBjcmVhdGUKPiBAQCAtNDgxLDYgKzQ4MCwxMCBAQCBzdGF0aWMgaW50IG1seDVf
dmRwYV9wb2xsX29uZShzdHJ1Y3QgbWx4NV92ZHBhX2NxICp2Y3EpCj4gICAKPiAgIHN0YXRpYyB2
b2lkIG1seDVfdmRwYV9oYW5kbGVfY29tcGxldGlvbnMoc3RydWN0IG1seDVfdmRwYV92aXJ0cXVl
dWUgKm12cSwgaW50IG51bSkKPiAgIHsKPiArCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0g
bXZxLT5uZGV2Owo+ICsJc3RydWN0IHZkcGFfY2FsbGJhY2sgKmV2ZW50X2NiOwo+ICsKPiArCWV2
ZW50X2NiID0gJm5kZXYtPmV2ZW50X2Nic1ttdnEtPmluZGV4XTsKPiAgIAltbHg1X2NxX3NldF9j
aSgmbXZxLT5jcS5tY3EpOwo+ICAgCj4gICAJLyogbWFrZSBzdXJlIENRIGNvc3VtZXIgdXBkYXRl
IGlzIHZpc2libGUgdG8gdGhlIGhhcmR3YXJlIGJlZm9yZSB1cGRhdGluZwo+IEBAIC00ODgsOCAr
NDkxLDggQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2hhbmRsZV9jb21wbGV0aW9ucyhzdHJ1Y3Qg
bWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxLCBpbnQgbnUKPiAgIAkgKi8KPiAgIAlkbWFfd21iKCk7
Cj4gICAJcnhfcG9zdCgmbXZxLT52cXFwLCBudW0pOwo+IC0JaWYgKG12cS0+ZXZlbnRfY2IuY2Fs
bGJhY2spCj4gLQkJbXZxLT5ldmVudF9jYi5jYWxsYmFjayhtdnEtPmV2ZW50X2NiLnByaXZhdGUp
Owo+ICsJaWYgKGV2ZW50X2NiLT5jYWxsYmFjaykKPiArCQlldmVudF9jYi0+Y2FsbGJhY2soZXZl
bnRfY2ItPnByaXZhdGUpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfY3Ff
Y29tcChzdHJ1Y3QgbWx4NV9jb3JlX2NxICptY3EsIHN0cnVjdCBtbHg1X2VxZSAqZXFlKQo+IEBA
IC0xMzg1LDkgKzEzODgsOCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3ZxX2NiKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgc3RydWN0IHZkcGFfYwo+ICAgewo+ICAgCXN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ICAgCXN0cnVjdCBt
bHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+IC0Jc3RydWN0
IG1seDVfdmRwYV92aXJ0cXVldWUgKnZxID0gJm5kZXYtPnZxc1tpZHhdOwo+ICAgCj4gLQl2cS0+
ZXZlbnRfY2IgPSAqY2I7Cj4gKwluZGV2LT5ldmVudF9jYnNbaWR4XSA9ICpjYjsKPiAgIH0KPiAg
IAo+ICAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF92cV9yZWFkeShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHUxNiBpZHgsIGJvb2wgcmVhZHkpCj4gQEAgLTE2MjQsNyArMTYyNiw2IEBAIHN0
YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0
cnVjdCBtbHg1X3ZkcGFfdmlydHF1Cj4gICAJcmktPmRlc2NfYWRkciA9IG12cS0+ZGVzY19hZGRy
Owo+ICAgCXJpLT5kZXZpY2VfYWRkciA9IG12cS0+ZGV2aWNlX2FkZHI7Cj4gICAJcmktPmRyaXZl
cl9hZGRyID0gbXZxLT5kcml2ZXJfYWRkcjsKPiAtCXJpLT5jYiA9IG12cS0+ZXZlbnRfY2I7Cj4g
ICAJcmktPnJlc3RvcmUgPSB0cnVlOwo+ICAgCXJldHVybiAwOwo+ICAgfQo+IEBAIC0xNjY5LDcg
KzE2NzAsNiBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX2NoYW5uZWxzX2luZm8oc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYpCj4gICAJCW12cS0+ZGVzY19hZGRyID0gcmktPmRlc2NfYWRkcjsKPiAg
IAkJbXZxLT5kZXZpY2VfYWRkciA9IHJpLT5kZXZpY2VfYWRkcjsKPiAgIAkJbXZxLT5kcml2ZXJf
YWRkciA9IHJpLT5kcml2ZXJfYWRkcjsKPiAtCQltdnEtPmV2ZW50X2NiID0gcmktPmNiOwo+ICAg
CX0KPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
