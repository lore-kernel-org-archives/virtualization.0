Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6D9C4320A
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:52:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4807C61058
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4807C61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1885D4063C;
	Wed,  1 Sep 2021 06:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UdHWaj_SWKUq; Wed,  1 Sep 2021 06:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B248B40304;
	Wed,  1 Sep 2021 06:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82BD0C0010;
	Wed,  1 Sep 2021 06:52:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEFFC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19C2A400CF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u5IMUa6cUUb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EBB6400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630479152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sS+ENc/4EvCCf2zYfOqIzQcGTVPDUUcKwCPkNAq9cUI=;
 b=RYFom7Sg4ICvHbInMaklbLildyPBgpCrujyWUVkGfXiR2UcOHQhTe9KNeak5Gi45R0FY8J
 DiCRh2+Dv03hRa8Lkil39FzCC0cY17DunthWvJDQdlBTEvjPvqJOiRRK/FxgcuFgH26CwI
 1vULeiN5KTgv59rhaClZo7tgLopHEmA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-msAKmFNvMY6pXERDVOaKow-1; Wed, 01 Sep 2021 02:52:31 -0400
X-MC-Unique: msAKmFNvMY6pXERDVOaKow-1
Received: by mail-pg1-f198.google.com with SMTP id
 z127-20020a633385000000b002618d24cfacso1150151pgz.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 23:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sS+ENc/4EvCCf2zYfOqIzQcGTVPDUUcKwCPkNAq9cUI=;
 b=C27RjZubQKPq+xo0WQRhqP4DdPPR1UJNslycHzK+rh+wClehFlxJ1hGtw2AXpQT3uJ
 lEpbNS3wvsabkrrhYZpBrp5b/YPxx+zznqTLmadV4AMMzVEuogxCDdvnOnFk0L2jiveZ
 z497nFm9EqAH0GUlf3J/0RK1DD7RzH3KInnQ5OTBv9jxQKjf3PoJv6wY2NldJhWSvO2c
 vSZclX6L2d9DYpSiPQOqYmdHYPCd/3LNaCkWuPFS7VrLebnUDxxRf6KrGI4XEoSi0kSS
 MYdjQ3OT/OzSgZV7QgUOQ2LuKz9DfKhZNcrIIkVrp++rHxxDeOFo+oUJWlvwKn/gnBpO
 GTgg==
X-Gm-Message-State: AOAM531oRT0Ic2Gb0u/DSYy5ep2XAzkMhQ/GUUHyvynVzQ1uTyNyTpu9
 1niSjJXhHYBzvam547akKD+2nLcXfvdtW23q+d8mYjV950OszQkq53L7kvIb7RyYL2cuhQEwj+6
 TOp/iLU6ZB/OIpai8PH1sN8F3Z+tsydWdr1o8wjhWgA==
X-Received: by 2002:a17:90a:29a6:: with SMTP id
 h35mr9935657pjd.188.1630479149958; 
 Tue, 31 Aug 2021 23:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4M3DXDMra5cGnJcANgV7r3NSOaqkzwzYcCrm2jEsJTplrnszIxVJ/2Amugs0pRJMh26FPwA==
X-Received: by 2002:a17:90a:29a6:: with SMTP id
 h35mr9935634pjd.188.1630479149555; 
 Tue, 31 Aug 2021 23:52:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u24sm21205082pfm.81.2021.08.31.23.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Aug 2021 23:52:29 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] drivers/net/virtio_net: Fixed vheader to use v1.
To: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com,
 davem@davemloft.net, kuba@kernel.org
References: <20210818175440.128691-1-andrew@daynix.com>
 <20210818175440.128691-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <65fe6644-bccd-00aa-7c72-53da385bd47e@redhat.com>
Date: Wed, 1 Sep 2021 14:52:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818175440.128691-2-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzgvMTkg5LiK5Y2IMTo1NCwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBU
aGUgaGVhZGVyIHYxIHByb3ZpZGVzIGFkZGl0aW9uYWwgaW5mbyBhYm91dCBSU1MuCj4gQWRkZWQg
Y2hhbmdlcyB0byBjb21wdXRpbmcgcHJvcGVyIGhlYWRlciBsZW5ndGguCj4gSW4gdGhlIG5leHQg
cGF0Y2hlcywgdGhlIGhlYWRlciBtYXkgY29udGFpbiBSU1MgaGFzaCBpbmZvCj4gZm9yIHRoZSBo
YXNoIHBvcHVsYXRpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWVsbnljaGVua28gPGFu
ZHJld0BkYXluaXguY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTAg
KysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA1NmMzZjg1MTkwOTMuLjg1NDI3YjRmNTFiYyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBAQCAtMjQwLDEzICsyNDAsMTMgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7
Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAtCXN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl9tcmdfcnhidWYgaGRyOwo+ICsJc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hh
c2ggaGRyOwo+ICAgCS8qCj4gICAJICogaGRyIGlzIGluIGEgc2VwYXJhdGUgc2cgYnVmZmVyLCBh
bmQgZGF0YSBzZyBidWZmZXIgc2hhcmVzIHNhbWUgcGFnZQo+ICAgCSAqIHdpdGggdGhpcyBoZWFk
ZXIgc2cuIFRoaXMgcGFkZGluZyBtYWtlcyBuZXh0IHNnIDE2IGJ5dGUgYWxpZ25lZAo+ICAgCSAq
IGFmdGVyIHRoZSBoZWFkZXIuCj4gICAJICovCj4gLQljaGFyIHBhZGRpbmdbNF07Cj4gKwljaGFy
IHBhZGRpbmdbMTJdOwo+ICAgfTsKCgpTbyB3ZSBoYWQ6CgogwqDCoMKgwqDCoMKgwqAgaWYgKHZp
LT5tZXJnZWFibGVfcnhfYnVmcykKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZHJf
cGFkZGVkX2xlbiA9IHNpemVvZigqaGRyKTsKIMKgwqDCoMKgwqDCoMKgIGVsc2UKIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZHJfcGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFk
ZGVkX3ZuZXRfaGRyKTsKCkkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvIGFkZCBvbmUgb3JlIGNv
bmRpdGlvbiBmb3IgdGhlIGhhc2ggaGVhZGVyIAppbnN0ZWFkIG9mIGVuZm9yY2luZyBpdCBldmVu
IGlmIGl0IHdhcyBub3QgbmVnb3RpYXRlZC4KCgo+ICAgCj4gICBzdGF0aWMgYm9vbCBpc194ZHBf
ZnJhbWUodm9pZCAqcHRyKQo+IEBAIC0xMjU4LDcgKzEyNTgsNyBAQCBzdGF0aWMgdW5zaWduZWQg
aW50IGdldF9tZXJnZWFibGVfYnVmX2xlbihzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gICAJ
CQkJCSAgc3RydWN0IGV3bWFfcGt0X2xlbiAqYXZnX3BrdF9sZW4sCj4gICAJCQkJCSAgdW5zaWdu
ZWQgaW50IHJvb20pCj4gICB7Cj4gLQljb25zdCBzaXplX3QgaGRyX2xlbiA9IHNpemVvZihzdHJ1
Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmKTsKPiArCWNvbnN0IHNpemVfdCBoZHJfbGVuID0g
KChzdHJ1Y3QgdmlydG5ldF9pbmZvICopKHJxLT52cS0+dmRldi0+cHJpdikpLT5oZHJfbGVuOwo+
ICAgCXVuc2lnbmVkIGludCBsZW47Cj4gICAKPiAgIAlpZiAocm9vbSkKPiBAQCAtMTY0Miw3ICsx
NjQyLDcgQEAgc3RhdGljIGludCB4bWl0X3NrYihzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIHN0cnVj
dCBza19idWZmICpza2IpCj4gICAJY29uc3QgdW5zaWduZWQgY2hhciAqZGVzdCA9ICgoc3RydWN0
IGV0aGhkciAqKXNrYi0+ZGF0YSktPmhfZGVzdDsKPiAgIAlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSA9IHNxLT52cS0+dmRldi0+cHJpdjsKPiAgIAlpbnQgbnVtX3NnOwo+IC0JdW5zaWduZWQgaGRy
X2xlbiA9IHZpLT5oZHJfbGVuOwo+ICsJdW5zaWduZWQgaW50IGhkcl9sZW4gPSB2aS0+aGRyX2xl
bjsKCgpMb29rcyBsaWtlIGFuIHVubmVjZXNzYXJ5IGNoYW5nZS4KCgo+ICAgCWJvb2wgY2FuX3B1
c2g7Cj4gICAKPiAgIAlwcl9kZWJ1ZygiJXM6IHhtaXQgJXAgJXBNXG4iLCB2aS0+ZGV2LT5uYW1l
LCBza2IsIGRlc3QpOwo+IEBAIC0yODE5LDcgKzI4MTksNyBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0
X2RlbF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICAgKi8KPiAgIHN0YXRpYyB1bnNp
Z25lZCBpbnQgbWVyZ2VhYmxlX21pbl9idWZfbGVuKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBz
dHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiAgIHsKPiAtCWNvbnN0IHVuc2lnbmVkIGludCBoZHJfbGVu
ID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYpOwo+ICsJY29uc3QgdW5z
aWduZWQgaW50IGhkcl9sZW4gPSB2aS0+aGRyX2xlbjsKCgpJIHRoaW5rIHRoZSBjaGFuZ2UgaGVy
ZSBhbmQgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkgc2hvdWxkIGJlIGEgc2VwYXJhdGUgCnBhdGNo
LgoKVGhhbmtzCgoKPiAgIAl1bnNpZ25lZCBpbnQgcnFfc2l6ZSA9IHZpcnRxdWV1ZV9nZXRfdnJp
bmdfc2l6ZSh2cSk7Cj4gICAJdW5zaWduZWQgaW50IHBhY2tldF9sZW4gPSB2aS0+YmlnX3BhY2tl
dHMgPyBJUF9NQVhfTVRVIDogdmktPmRldi0+bWF4X210dTsKPiAgIAl1bnNpZ25lZCBpbnQgYnVm
X2xlbiA9IGhkcl9sZW4gKyBFVEhfSExFTiArIFZMQU5fSExFTiArIHBhY2tldF9sZW47CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
