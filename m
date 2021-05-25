Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80978C2B9F7
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 01:31:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2056A61403
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 01:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2056A61403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C89CC404FC;
	Tue, 25 May 2021 01:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RSqlP3yXVhz; Tue, 25 May 2021 01:31:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id F09A3404F9;
	Tue, 25 May 2021 01:31:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1442C000D;
	Tue, 25 May 2021 01:31:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75D8FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6444A83C2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5CFiglNxBF5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6855383C2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621906310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDdaKbZRoEfpRx7jvBHZ30BNzMElKWImpQ5xMxNgdjo=;
 b=SPaWprsSsB1ZLHOUyMMyhdooyzntC2HvquYUQzhmapEOVO3rEZ6vAZv/nKY8iDEmdd2S1l
 M4AsHu+brNZAGeJI10osdJdod8zSn+opAH42SKDy8Kfpmt9doHkzLY7AMMwtEDpZ7kaXNb
 6Kd2dkBdtiSnyPf7ED4XsqZF4ejQdVE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-kem_vB2ZP627Vm6fPszxJg-1; Mon, 24 May 2021 21:31:46 -0400
X-MC-Unique: kem_vB2ZP627Vm6fPszxJg-1
Received: by mail-pf1-f197.google.com with SMTP id
 g14-20020a056a00078eb02902d7e2fb2c06so19141118pfu.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 18:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cDdaKbZRoEfpRx7jvBHZ30BNzMElKWImpQ5xMxNgdjo=;
 b=KIH8qQtdjdApE58QwD5XCEtKCXzs5pTvZ2t8ck1faxml5jU+EUVY4+hkVhDUxIC6qn
 q6GddXuEeCuSpB3oa9laXAqAchPnlWV2gyVZsvXfB/ljU0l0euuzBuAQrdWcYQ/B0+cI
 7aNli9hemBnWH587Ud5QledIXZbFq8thrCjfo6UM4IEfcEc3SEts6PjcCFSpV8GlkqIK
 9PswocEzHu8k3FC6rcsR52HbyBYvMhubaLiQnLcUWAMLkBo82R5Tr0CgB5YhUjeRmQHy
 To6+wlZHQPoyE7mcLHVmNnh/6ixPIvYf80gNfk/kCTsCKSIRz4zwu8ERVnDXzn2APBD4
 hkyA==
X-Gm-Message-State: AOAM531EYFgB+Pw/QgoOdgLwcT/EwujjV9yFQKmSaDoXPZJvzTb+Z3qu
 Tb36YWOuuYsx0lTiegT64QWCY6puQAsZN0/uJpc8Phxt/Bok9tLiaesrcHJWK1lyOWMqd/9bFxm
 AFfv4vOjJK17XEQvOmR6O9q3waukP0tRaFnqPhZl0Eg==
X-Received: by 2002:a17:90b:1b4c:: with SMTP id
 nv12mr27605008pjb.55.1621906305651; 
 Mon, 24 May 2021 18:31:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaC2zarJrBIyP6vFqRiVxlMn0IGK6h9Za0XGOhe7G4c1aNDy85YgjxCOlh7xcd0n+tZ+3O1A==
X-Received: by 2002:a17:90b:1b4c:: with SMTP id
 nv12mr27604972pjb.55.1621906305157; 
 Mon, 24 May 2021 18:31:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f80sm11774204pfa.160.2021.05.24.18.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 18:31:44 -0700 (PDT)
Subject: Re: [RFC PATCH 17/17] virtio_ring: Add validation for used length
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517090836.533-18-xieyongji@bytedance.com>
 <20210517193641-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3cda643a-1363-65bf-be84-f6dea6714477@redhat.com>
Date: Tue, 25 May 2021 09:31:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517193641-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ohad@wizery.com, amit@kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, miklos@szeredi.hu,
 stefanha@redhat.com, dan.j.williams@intel.com,
 virtualization@lists.linux-foundation.org, johannes@sipsolutions.net,
 vgoyal@redhat.com
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

CtTaIDIwMjEvNS8xOCDJz87nNzozOSwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gTW9u
LCBNYXkgMTcsIDIwMjEgYXQgMDU6MDg6MzZQTSArMDgwMCwgWGllIFlvbmdqaSB3cm90ZToKPj4g
VGhpcyBhZGRzIHZhbGlkYXRpb24gZm9yIHVzZWQgbGVuZ3RoIChtaWdodCBjb21lCj4+IGZyb20g
YW4gdW50cnVzdGVkIGRldmljZSkgd2hlbiBpdCB3aWxsIGJlIHVzZWQgYnkKPj4gdmlydGlvIGRl
dmljZSBkcml2ZXIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwg
MjIgKysrKysrKysrKysrKysrKysrKy0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gaW5kZXggZDk5
OWExZDZkMjcxLi43ZDQ4NDVkMDZmMjEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBAQCAt
NjgsMTEgKzY4LDEzIEBACj4+ICAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQgewo+PiAg
IAl2b2lkICpkYXRhOwkJCS8qIERhdGEgZm9yIGNhbGxiYWNrLiAqLwo+PiAgIAlzdHJ1Y3QgdnJp
bmdfZGVzYyAqaW5kaXJfZGVzYzsJLyogSW5kaXJlY3QgZGVzY3JpcHRvciwgaWYgYW55LiAqLwo+
PiArCXUzMiBpbl9sZW47CQkJLyogVG90YWwgbGVuZ3RoIG9mIHdyaXRhYmxlIGJ1ZmZlciAqLwo+
PiAgIH07Cj4+ICAgCj4+ICAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkIHsKPj4gICAJ
dm9pZCAqZGF0YTsJCQkvKiBEYXRhIGZvciBjYWxsYmFjay4gKi8KPj4gICAJc3RydWN0IHZyaW5n
X3BhY2tlZF9kZXNjICppbmRpcl9kZXNjOyAvKiBJbmRpcmVjdCBkZXNjcmlwdG9yLCBpZiBhbnku
ICovCj4+ICsJdTMyIGluX2xlbjsJCQkvKiBUb3RhbCBsZW5ndGggb2Ygd3JpdGFibGUgYnVmZmVy
ICovCj4+ICAgCXUxNiBudW07CQkJLyogRGVzY3JpcHRvciBsaXN0IGxlbmd0aC4gKi8KPj4gICAJ
dTE2IGxhc3Q7CQkJLyogVGhlIGxhc3QgZGVzYyBzdGF0ZSBpbiBhIGxpc3QuICovCj4+ICAgfTsK
Pgo+IEhtbSBmb3IgcGFja2VkIGl0J3MgYWxpZ25lZCB0byA2NCBiaXQgYW55d2F5LCBzbyB3ZSBh
cmUgbm90IG1ha2luZyBpdAo+IGFueSB3b3JzZS4gQnV0IGZvciBzcGxpdCB0aGlzIHB1c2hlcyBz
dHJ1Y3Qgc2l6ZSB1cCBieSAxLzMgaW5jcmVhc2luZwo+IGNhY2hlIHByZXNzdXJlLgoKCldlIGNh
biBlbGltaW5hdGUgdGhpcyBieSB2YWxpZGF0aW5nIHRocm91Z2ggdmlydGlvIGRldmljZSBkcml2
ZXIgaW5zdGVhZCAKb2YgdmlydGlvIGNvcmUuCgpFLmcgZm9yIHZpcnRpby1uZXQgd2Uga25vdyB0
aGUgcnggYnVmZmVyIHNpemUgc28gdGhlcmUncyBubyBuZWVkIHRvIApzdG9yZSBpbiB0d2ljZSBp
biB0aGUgY29yZS4KClRoYW5rcwoKCj4KPgo+PiBAQCAtNDg2LDcgKzQ4OCw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+PiAg
IAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+PiAgIAlzdHJ1Y3Qg
c2NhdHRlcmxpc3QgKnNnOwo+PiAgIAlzdHJ1Y3QgdnJpbmdfZGVzYyAqZGVzYzsKPj4gLQl1bnNp
Z25lZCBpbnQgaSwgbiwgYXZhaWwsIGRlc2NzX3VzZWQsIHByZXYsIGVycl9pZHg7Cj4+ICsJdW5z
aWduZWQgaW50IGksIG4sIGF2YWlsLCBkZXNjc191c2VkLCBwcmV2LCBlcnJfaWR4LCBpbl9sZW4g
PSAwOwo+PiAgIAlpbnQgaGVhZDsKPj4gICAJYm9vbCBpbmRpcmVjdDsKPj4gICAKPj4gQEAgLTU3
MCw2ICs1NzIsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVj
dCB2aXJ0cXVldWUgKl92cSwKPj4gICAJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9ORVhUIHwKPj4g
ICAJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9XUklURSwKPj4gICAJCQkJCQkgICAgIGluZGlyZWN0
KTsKPj4gKwkJCWluX2xlbiArPSBzZy0+bGVuZ3RoOwo+PiAgIAkJfQo+PiAgIAl9Cj4+ICAgCS8q
IExhc3Qgb25lIGRvZXNuJ3QgY29udGludWUuICovCj4+IEBAIC02MDQsNiArNjA3LDcgQEAgc3Rh
dGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEs
Cj4+ICAgCj4+ICAgCS8qIFN0b3JlIHRva2VuIGFuZCBpbmRpcmVjdCBidWZmZXIgc3RhdGUuICov
Cj4+ICAgCXZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmRhdGEgPSBkYXRhOwo+PiArCXZxLT5z
cGxpdC5kZXNjX3N0YXRlW2hlYWRdLmluX2xlbiA9IGluX2xlbjsKPj4gICAJaWYgKGluZGlyZWN0
KQo+PiAgIAkJdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYyA9IGRlc2M7Cj4+
ICAgCWVsc2UKPj4gQEAgLTc4NCw2ICs3ODgsMTAgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9n
ZXRfYnVmX2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4+ICAgCQlCQURfUklORyh2
cSwgImlkICV1IGlzIG5vdCBhIGhlYWQhXG4iLCBpKTsKPj4gICAJCXJldHVybiBOVUxMOwo+PiAg
IAl9Cj4+ICsJaWYgKHVubGlrZWx5KGxlbiAmJiB2cS0+c3BsaXQuZGVzY19zdGF0ZVtpXS5pbl9s
ZW4gPCAqbGVuKSkgewo+PiArCQlCQURfUklORyh2cSwgImlkICV1IGhhcyBpbnZhbGlkIGxlbmd0
aDogJXUhXG4iLCBpLCAqbGVuKTsKPj4gKwkJcmV0dXJuIE5VTEw7Cj4+ICsJfQo+PiAgIAo+PiAg
IAkvKiBkZXRhY2hfYnVmX3NwbGl0IGNsZWFycyBkYXRhLCBzbyBncmFiIGl0IG5vdy4gKi8KPj4g
ICAJcmV0ID0gdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaV0uZGF0YTsKPj4gQEAgLTEwNTksNyArMTA2
Nyw3IEBAIHN0YXRpYyBpbnQgdmlydHF1ZXVlX2FkZF9pbmRpcmVjdF9wYWNrZWQoc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEsCj4+ICAgewo+PiAgIAlzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2Mg
KmRlc2M7Cj4+ICAgCXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7Cj4+IC0JdW5zaWduZWQgaW50IGks
IG4sIGVycl9pZHg7Cj4+ICsJdW5zaWduZWQgaW50IGksIG4sIGVycl9pZHgsIGluX2xlbiA9IDA7
Cj4+ICAgCXUxNiBoZWFkLCBpZDsKPj4gICAJZG1hX2FkZHJfdCBhZGRyOwo+PiAgIAo+PiBAQCAt
MTA4NCw2ICsxMDkyLDcgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tl
ZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPj4gICAJCQlpZiAodnJpbmdfbWFwcGluZ19l
cnJvcih2cSwgYWRkcikpCj4+ICAgCQkJCWdvdG8gdW5tYXBfcmVsZWFzZTsKPj4gICAKPj4gKwkJ
CWluX2xlbiArPSAobiA8IG91dF9zZ3MpID8gMCA6IHNnLT5sZW5ndGg7Cj4+ICAgCQkJZGVzY1tp
XS5mbGFncyA9IGNwdV90b19sZTE2KG4gPCBvdXRfc2dzID8KPj4gICAJCQkJCQkwIDogVlJJTkdf
REVTQ19GX1dSSVRFKTsKPj4gICAJCQlkZXNjW2ldLmFkZHIgPSBjcHVfdG9fbGU2NChhZGRyKTsK
Pj4gQEAgLTExNDEsNiArMTE1MCw3IEBAIHN0YXRpYyBpbnQgdmlydHF1ZXVlX2FkZF9pbmRpcmVj
dF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+ICAgCXZxLT5wYWNrZWQuZGVz
Y19zdGF0ZVtpZF0uZGF0YSA9IGRhdGE7Cj4+ICAgCXZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0u
aW5kaXJfZGVzYyA9IGRlc2M7Cj4+ICAgCXZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubGFzdCA9
IGlkOwo+PiArCXZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0uaW5fbGVuID0gaW5fbGVuOwo+PiAg
IAo+PiAgIAl2cS0+bnVtX2FkZGVkICs9IDE7Cj4+ICAgCj4+IEBAIC0xMTczLDcgKzExODMsNyBA
QCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsCj4+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+
ICAgCXN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqZGVzYzsKPj4gICAJc3RydWN0IHNjYXR0ZXJs
aXN0ICpzZzsKPj4gLQl1bnNpZ25lZCBpbnQgaSwgbiwgYywgZGVzY3NfdXNlZCwgZXJyX2lkeDsK
Pj4gKwl1bnNpZ25lZCBpbnQgaSwgbiwgYywgZGVzY3NfdXNlZCwgZXJyX2lkeCwgaW5fbGVuID0g
MDsKPj4gICAJX19sZTE2IGhlYWRfZmxhZ3MsIGZsYWdzOwo+PiAgIAl1MTYgaGVhZCwgaWQsIHBy
ZXYsIGN1cnIsIGF2YWlsX3VzZWRfZmxhZ3M7Cj4+ICAgCj4+IEBAIC0xMjIzLDYgKzEyMzMsNyBA
QCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsCj4+ICAgCQkJaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFkZHIpKQo+PiAgIAkJ
CQlnb3RvIHVubWFwX3JlbGVhc2U7Cj4+ICAgCj4+ICsJCQlpbl9sZW4gKz0gKG4gPCBvdXRfc2dz
KSA/IDAgOiBzZy0+bGVuZ3RoOwo+PiAgIAkJCWZsYWdzID0gY3B1X3RvX2xlMTYodnEtPnBhY2tl
ZC5hdmFpbF91c2VkX2ZsYWdzIHwKPj4gICAJCQkJICAgICgrK2MgPT0gdG90YWxfc2cgPyAwIDog
VlJJTkdfREVTQ19GX05FWFQpIHwKPj4gICAJCQkJICAgIChuIDwgb3V0X3NncyA/IDAgOiBWUklO
R19ERVNDX0ZfV1JJVEUpKTsKPj4gQEAgLTEyNjgsNiArMTI3OSw3IEBAIHN0YXRpYyBpbmxpbmUg
aW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPj4gICAJdnEt
PnBhY2tlZC5kZXNjX3N0YXRlW2lkXS5kYXRhID0gZGF0YTsKPj4gICAJdnEtPnBhY2tlZC5kZXNj
X3N0YXRlW2lkXS5pbmRpcl9kZXNjID0gY3R4Owo+PiAgIAl2cS0+cGFja2VkLmRlc2Nfc3RhdGVb
aWRdLmxhc3QgPSBwcmV2Owo+PiArCXZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0uaW5fbGVuID0g
aW5fbGVuOwo+PiAgIAo+PiAgIAkvKgo+PiAgIAkgKiBBIGRyaXZlciBNVVNUIE5PVCBtYWtlIHRo
ZSBmaXJzdCBkZXNjcmlwdG9yIGluIHRoZSBsaXN0Cj4+IEBAIC0xNDU2LDYgKzE0NjgsMTAgQEAg
c3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxLAo+PiAgIAkJQkFEX1JJTkcodnEsICJpZCAldSBpcyBub3QgYSBoZWFkIVxuIiwgaWQp
Owo+PiAgIAkJcmV0dXJuIE5VTEw7Cj4+ICAgCX0KPj4gKwlpZiAodW5saWtlbHkobGVuICYmIHZx
LT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0uaW5fbGVuIDwgKmxlbikpIHsKPj4gKwkJQkFEX1JJTkco
dnEsICJpZCAldSBoYXMgaW52YWxpZCBsZW5ndGg6ICV1IVxuIiwgaWQsICpsZW4pOwo+PiArCQly
ZXR1cm4gTlVMTDsKPj4gKwl9Cj4+ICAgCj4+ICAgCS8qIGRldGFjaF9idWZfcGFja2VkIGNsZWFy
cyBkYXRhLCBzbyBncmFiIGl0IG5vdy4gKi8KPj4gICAJcmV0ID0gdnEtPnBhY2tlZC5kZXNjX3N0
YXRlW2lkXS5kYXRhOwo+PiAtLSAKPj4gMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
