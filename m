Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FFC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:29:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A12960E9B
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A12960E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FBCC402C0;
	Tue, 14 Sep 2021 02:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k_XTasNBlqxD; Tue, 14 Sep 2021 02:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A024400C7;
	Tue, 14 Sep 2021 02:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6117AC0011;
	Tue, 14 Sep 2021 02:29:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC00C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89ED54030A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kHCLUdomWolT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAD1E4029B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631586582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWpNoDWZfo5O44DTcs5Qn11a6fTtXXK38bHt1D2HGgI=;
 b=cJ0KMmIzj0qvm91jbnziWDZwz/KtiT1XHJdinXoBcEAeyX7UTzYNJeD2tsJlphJsrDukNG
 tRp5x71ac6jBS8YO9N7GtluvonkIlKARh4B+9znqo2X4ksrwESdLK6MUgEKeXhoLM/pMjT
 n4coADXy5tsuJTawv1o2w65ZRoH/dw4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ikkvytkJPIuOk3CSMqv1eA-1; Mon, 13 Sep 2021 22:29:40 -0400
X-MC-Unique: ikkvytkJPIuOk3CSMqv1eA-1
Received: by mail-pj1-f69.google.com with SMTP id
 h1-20020a17090adb8100b001997671e011so2271197pjv.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jWpNoDWZfo5O44DTcs5Qn11a6fTtXXK38bHt1D2HGgI=;
 b=zxyyWe+3NASt23gDw2BQ0ECVYBkjyK9EFH59rinWEkM7HZjpw6p5zhF4PaPE66XtGk
 4B7nyP6jXKeepCb/vuoJj17uvaLkG1SXuvqfLFd9DVREXbBGD1d0HUouBJej5G7npOTe
 Xq3yAuYINdxpZG3CORR23mIDvjy3YLtWwEafvgwwDyiR3IXrwUN4IJnobhAALx48fjZG
 yhL87YHgj/meHxFeyNlaAjbINgMJhWbJ1d8tMFIvK6HjUUzIBG8DclKwlw0NXp8bWqPH
 wih6DySyqXbmCDXG1Wwly5P3dITqbH+4OGEHlfDXOGX95fMoElCzr0tY2lyOwjSCzfIU
 cj6Q==
X-Gm-Message-State: AOAM530rtzAQKmJ6kC0cC1RJAh8L56ZgfhotbMeUBYhCf1skKEA2BFnb
 6Lthm7pf/SSyF1HGLtxvsdwRmRbaZKM84VgTTVIYeIhZLnsMM+eM1TSze6La3d9F5r/7dwPW5/h
 cG9IzHBdwShL3KS6isrk1HXi3O39Jw8va/upB2qs/cQ==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id
 e6-20020aa782460000b029039a1e0acd48mr2383685pfn.14.1631586579070; 
 Mon, 13 Sep 2021 19:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyDoDWWN1L4/NFxKEPHiQqcmOu9yl+2/kwaCFANAW481c4BvNQynvTcsuZh2QwKD1KzkZD6g==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id
 e6-20020aa782460000b029039a1e0acd48mr2383666pfn.14.1631586578768; 
 Mon, 13 Sep 2021 19:29:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y26sm8202998pfe.69.2021.09.13.19.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 19:29:38 -0700 (PDT)
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
 <20210913074814.wcrrisaomlhvtmo5@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e225518e-77c5-3fbd-ad79-a29dae564b20@redhat.com>
Date: Tue, 14 Sep 2021 10:29:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913074814.wcrrisaomlhvtmo5@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

CuWcqCAyMDIxLzkvMTMg5LiL5Y2IMzo0OCwgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiBP
biBNb24sIFNlcCAxMywgMjAyMSBhdCAwMTo1Mzo0NVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiBJZiBhbiB1bnRydXN0ZWQgZGV2aWNlIG5lb2dpdGF0ZXMgQkxLX0ZfTVEgYnV0IGFkdmVy
dGlzZXMgYSB6ZXJvCj4+IG51bV9xdWV1ZXMsIHRoZSBkcml2ZXIgbWF5IGVuZCB1cCB0cnlpbmcg
dG8gYWxsb2NhdGluZyB6ZXJvIHNpemUKPj4gYnVmZmVycyB3aGVyZSBaRVJPX1NJWkVfUFRSIGlz
IHJldHVybmVkIHdoaWNoIG1heSBwYXNzIHRoZSBjaGVja2luZwo+PiBhZ2FpbnN0IHRoZSBOVUxM
LiBUaGlzIHdpbGwgbGVhZCB1bmV4cGVjdGVkIHJlc3VsdHMuCj4+Cj4+IEZpeGluZyB0aGlzIGJ5
IHVzaW5nIHNpbmdsZSBxdWV1ZSBpZiBudW1fcXVldWVzIGlzIHplcm8uCj4+Cj4+IENjOiBQYW9s
byBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgo+PiBDYzogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgfCAzICsr
LQo+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2sv
dmlydGlvX2Jsay5jCj4+IGluZGV4IGU1NzRmYmY1ZTZkZi4uZjEzMGQxMmRmNGI5IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+PiArKysgYi9kcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYwo+PiBAQCAtNDk4LDcgKzQ5OCw4IEBAIHN0YXRpYyBpbnQgaW5pdF92cShz
dHJ1Y3QgdmlydGlvX2JsayAqdmJsaykKPj4gwqDCoMKgwqBlcnIgPSB2aXJ0aW9fY3JlYWRfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fQkxLX0ZfTVEsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcsIG51bV9xdWV1ZXMsCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmbnVtX3Zxcyk7Cj4+IC3CoMKgwqAgaWYg
KGVycikKPj4gK8KgwqDCoCAvKiBXZSBuZWVkIGF0IGxlYXN0IG9uIHZpcnRxdWV1ZSAqLwo+Cj4g
cy9vbi9vbmUvCj4KPiBUaGUgcmVzdCBMR1RNLgo+Cj4gU3RlZmFubwoKCldpbGwgZml4IGluIG5l
eHQgdmVyc2lvbi4KClRoYW5rcwoKCj4KPj4gK8KgwqDCoCBpZiAoZXJyIHx8ICFudW1fdnFzKQo+
PiDCoMKgwqDCoMKgwqDCoCBudW1fdnFzID0gMTsKPj4KPj4gwqDCoMKgwqBudW1fdnFzID0gbWlu
X3QodW5zaWduZWQgaW50LCBucl9jcHVfaWRzLCBudW1fdnFzKTsKPj4gLS0gCj4+IDIuMjUuMQo+
Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKPj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
