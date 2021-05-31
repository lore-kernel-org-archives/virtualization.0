Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02109C47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 08:30:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D6C6127A
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 08:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D6C6127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5592B4034A;
	Mon, 31 May 2021 08:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGxqydrA8yzM; Mon, 31 May 2021 08:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C90B240350;
	Mon, 31 May 2021 08:29:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69140C000E;
	Mon, 31 May 2021 08:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A951AC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 08:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B59A830CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 08:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMq-N9ViCNui
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 08:29:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2B3C83096
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622449794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inr+zuiQM4jK2t4kQOlK3qn2dW0FR37ENWGawz0lq4U=;
 b=PL/cG9BVkKCT8HAYwljt3KIc0Ck185oJsKNR0cwjgp5djfLjCU9cmOc9IYNODABY5jQiSt
 Sj6QRv1KwqM9Z4TOJ6ooBbAHxtmX1B9ipTI3E7rZAgK32Eo6yqOAMiLeW812dwDiP9Jex2
 Xj/u0E6Uc7lvuximGNJYzjgekbbt+gY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-zb-roDNTPjeQ-GsmJKDpiw-1; Mon, 31 May 2021 04:29:51 -0400
X-MC-Unique: zb-roDNTPjeQ-GsmJKDpiw-1
Received: by mail-pg1-f199.google.com with SMTP id
 135-20020a63038d0000b0290220201658a7so896068pgd.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=inr+zuiQM4jK2t4kQOlK3qn2dW0FR37ENWGawz0lq4U=;
 b=T6tHZgtrbi1VJMko1O/DE5TCuufXawdYnGnqrsIkbLShaxXo6bb0bgk6j1qWbwLcBm
 SZ+sEF/tfaOOeivWAQ0wQ1nJoIzeScNRa0sN9yIJdHqCPAyMMBzQOO9omUnZ63qZGJA1
 rt9kzJ9kEPog48BmJkdCdIM3KmiIR6KDcrUZUNiNVL2/VEH/auYIPiGhBquTShsHbmJh
 CdR4GzbLd9hKGBAEFCxacxR390OWQyDl13r1p42e5DpU4SA9ukT+kAtBnPh/6KMoI8hP
 3mbwRswXsPVeyP/XIhkYUL7Qt74sKVY/pyMhnVKvG8sKNKtaTu92DV0WLXUNnLaJpzK0
 qXEA==
X-Gm-Message-State: AOAM530GGPpHX2EUXr7XjKAYS9tAZ42QqmrFjA36IPpDCsnhp78+Rln0
 DLOASOkhf3gvIItRVuIhmDkUKBP7pT81Q0OPfoqC+bPVqXnN2lZQiAN/BeqY4POFSbLvoKhxX/m
 BOHFZp76Qaz0I1Y07Q9XNHHyMIaQkcd9XNRljLiS2dg==
X-Received: by 2002:a62:c541:0:b029:2e8:c7c7:d96e with SMTP id
 j62-20020a62c5410000b02902e8c7c7d96emr15691267pfg.26.1622449790611; 
 Mon, 31 May 2021 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvMO2iCf1DBX0Bz84EkdLoS9QITer2XbpKjMQiElMdzUPSCzek7QWcLvYxad6JYHkCnpiRPg==
X-Received: by 2002:a62:c541:0:b029:2e8:c7c7:d96e with SMTP id
 j62-20020a62c5410000b02902e8c7c7d96emr15691247pfg.26.1622449790317; 
 Mon, 31 May 2021 01:29:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a21sm10305056pfk.152.2021.05.31.01.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 01:29:49 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Fix possible failure in umem size
 calculation
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210530090349.8360-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ecf0afb2-14cc-2350-894c-017ebffcdf35@redhat.com>
Date: Mon, 31 May 2021 16:29:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530090349.8360-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CtTaIDIwMjEvNS8zMCDPws7nNTowMywgRWxpIENvaGVuINC0tcA6Cj4gdW1lbSBzaXplIGlzIGEg
MzIgYml0IHVuc2lnbmVkIHZhbHVlIHNvIGFzc2lnbmluZyBpdCB0byBhbiBpbnQgY291bGQKPiBj
YXVzZSBmYWxzZSBmYWlsdXJlcy4gU2V0IHRoZSBjYWxjdWxhdGVkIHZhbHVlIGluc2lkZSB0aGUg
ZnVuY3Rpb24gYW5kCj4gbW9kaWZ5IGZ1bmN0aW9uIG5hbWUgdG8gcmVmbGVjdCB0aGUgZmFjdCBp
dCB1cGRhdGVzIHRoZSBzaXplLgo+Cj4gVGhpcyBidWcgd2FzIGZvdW5kIGR1cmluZyBjb2RlIHJl
dmlldyBidXQgbmV2ZXIgaGFkIHJlYWwgaW1wYWN0IHRvIHRoaXMKPiBkYXRlLgo+Cj4gRml4ZXM6
IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQg
bWx4NSBkZXZpY2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
IFYwIC0tPiBWMToKPiAgICBBZGQgbW9yZSBpbmZvIGluIGNoYW5nZWxvZwo+Cj4gICBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArKysrKy0tLS0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDUzMzEyZjA0NjBhZC4uZmRmM2U3NGJmZmJkIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC02MTAsOCArNjEwLDggQEAgc3RhdGlj
IHZvaWQgY3FfZGVzdHJveShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgdTE2IGlkeCkKPiAg
IAltbHg1X2RiX2ZyZWUobmRldi0+bXZkZXYubWRldiwgJnZjcS0+ZGIpOwo+ICAgfQo+ICAgCj4g
LXN0YXRpYyBpbnQgdW1lbV9zaXplKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3Qg
bWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxLCBpbnQgbnVtLAo+IC0JCSAgICAgc3RydWN0IG1seDVf
dmRwYV91bWVtICoqdW1lbXApCj4gK3N0YXRpYyB2b2lkIHNldF91bWVtX3NpemUoc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsIGludCBu
dW0sCj4gKwkJCSAgc3RydWN0IG1seDVfdmRwYV91bWVtICoqdW1lbXApCj4gICB7Cj4gICAJc3Ry
dWN0IG1seDVfY29yZV9kZXYgKm1kZXYgPSBuZGV2LT5tdmRldi5tZGV2Owo+ICAgCWludCBwX2E7
Cj4gQEAgLTYzNCw3ICs2MzQsNyBAQCBzdGF0aWMgaW50IHVtZW1fc2l6ZShzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cQo+ICAgCQkqdW1l
bXAgPSAmbXZxLT51bWVtMzsKPiAgIAkJYnJlYWs7Cj4gICAJfQo+IC0JcmV0dXJuIHBfYSAqIG12
cS0+bnVtX2VudCArIHBfYjsKPiArCSgqdW1lbXApLT5zaXplID0gcF9hICogbXZxLT5udW1fZW50
ICsgcF9iOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB1bWVtX2ZyYWdfYnVmX2ZyZWUoc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdW1lbSAqdW1lbSkKPiBA
QCAtNjUwLDE1ICs2NTAsMTAgQEAgc3RhdGljIGludCBjcmVhdGVfdW1lbShzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm0KPiAgIAl2b2lkICpp
bjsKPiAgIAlpbnQgZXJyOwo+ICAgCV9fYmU2NCAqcGFzOwo+IC0JaW50IHNpemU7Cj4gICAJc3Ry
dWN0IG1seDVfdmRwYV91bWVtICp1bWVtOwo+ICAgCj4gLQlzaXplID0gdW1lbV9zaXplKG5kZXYs
IG12cSwgbnVtLCAmdW1lbSk7Cj4gLQlpZiAoc2l6ZSA8IDApCj4gLQkJcmV0dXJuIHNpemU7Cj4g
LQo+IC0JdW1lbS0+c2l6ZSA9IHNpemU7Cj4gLQllcnIgPSB1bWVtX2ZyYWdfYnVmX2FsbG9jKG5k
ZXYsIHVtZW0sIHNpemUpOwo+ICsJc2V0X3VtZW1fc2l6ZShuZGV2LCBtdnEsIG51bSwgJnVtZW0p
Owo+ICsJZXJyID0gdW1lbV9mcmFnX2J1Zl9hbGxvYyhuZGV2LCB1bWVtLCB1bWVtLT5zaXplKTsK
PiAgIAlpZiAoZXJyKQo+ICAgCQlyZXR1cm4gZXJyOwo+ICAgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
