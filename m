Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E55C433FE
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:30:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F32360F56
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F32360F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D731940504;
	Fri, 15 Oct 2021 08:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvamDZS7Sixt; Fri, 15 Oct 2021 08:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 751D5404BC;
	Fri, 15 Oct 2021 08:30:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5942CC000F;
	Fri, 15 Oct 2021 08:30:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C13C7C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0055401F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMVfwBbA8yrH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DDAD40001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634286622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RellDte0zX0H6EBtcv6aJfrwrLR3zqUQWiXwLFeHX28=;
 b=DQJScMM1vhIjSoI536w33KH+ShCydgcY0zvhk+BT8z1wgI6GSq5e4lSCDQiU1CcwPGwu+L
 UdX9vMg7eB6QVpvHyQVrGHj2XRchzg+jd0zEQU+YXLNNRq2cTp9EJ7GsSZHBbJdyYGFsLO
 LyzRSb7avMPrXA3zdh543QxmVlMgA8E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-24qDkhUzNxujJPgweHnLgg-1; Fri, 15 Oct 2021 04:30:19 -0400
X-MC-Unique: 24qDkhUzNxujJPgweHnLgg-1
Received: by mail-pl1-f197.google.com with SMTP id
 h3-20020a170902704300b0013dbfc88e14so3600126plt.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RellDte0zX0H6EBtcv6aJfrwrLR3zqUQWiXwLFeHX28=;
 b=BOjOZleuFonijnqFV7ftl6QZP8XgsRfbUSsx67tyUiS4CkiHfKZaq3xUaB0me3UhAn
 YAWf1/gecnjay5Qyaf4sMfajbVrpxphtZpckFZlf68BngrqXgG4f2a5QM3r83Gi+QUGC
 IkdcFK43H894YQxm6ICOw6lsOGvWL9ZazTble9yhRC6zHl2Y1w3ZxraFDqMCC/rSOx5p
 1DqaKrP0mPLXjMSdUs1tWVY/rzx/OvhqxAt+AGi1X09R+Q6yU8nW/9+ngnkV6D2lvViU
 hJrhL93IjqsZGHUmS7FnvRYVvsxkUPhg+BIJlNw8JcDNgRIA6Agvj/zdiL4eCNI9Vgu2
 HeqQ==
X-Gm-Message-State: AOAM533ALfLfvQJFWz5xSb4O4hPuzJj3noyufe3EteEDOrwUSLWgZPJ2
 /6aD+60K2bEWTNxW7v8DetkFOcbJBmaaLYNYESqkFTHRE2H1kWkGJSIHJpVEpU64cuKPTQJCNQY
 LuI2cySGf2F9nuLPd4DokgbDmpBKLDs8U3TrHRjBJIA==
X-Received: by 2002:a63:1950:: with SMTP id 16mr8153916pgz.346.1634286618465; 
 Fri, 15 Oct 2021 01:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbABnhLHpf7APWDI+RKZdiwFZSAfJs/yrcMCfsG+yMNY3x84Rr3xP8R5MGC5PDyUyHBxKwug==
X-Received: by 2002:a63:1950:: with SMTP id 16mr8153898pgz.346.1634286618133; 
 Fri, 15 Oct 2021 01:30:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u11sm4691374pfg.2.2021.10.15.01.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:30:17 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <4fae24ebd63ac4ec513bfe0688051469ea0588c0.1634281805.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8dcb7f03-2d68-9e74-7f54-4d3ffbe49069@redhat.com>
Date: Fri, 15 Oct 2021 16:30:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4fae24ebd63ac4ec513bfe0688051469ea0588c0.1634281805.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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

CtTaIDIwMjEvMTAvMTUgz8LO5zM6MTQsIFd1IFpvbmd5b25nINC0tcA6Cj4gRm9yIHRoZSBkZXZp
Y2VzIHdoaWNoIGltcGxlbWVudCB0aGUgZ2V0X3ZxX251bV9taW4gY2FsbGJhY2ssIHRoZSBkcml2
ZXIKPiBzaG91bGQgbm90IG5lZ290aWF0ZSB3aXRoIHZpcnRxdWV1ZSBzaXplIHdpdGggdGhlIGJh
Y2tlbmQgdmRwYSBkZXZpY2UgaWYKPiB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgZ2V0X3ZxX251bV9t
aW4gZXF1YWxzIHRvIHRoZSB2YWx1ZSByZXR1cm5lZCBieQo+IGdldF92cV9udW1fbWF4Lgo+IFRo
aXMgaXMgdXNlZnVsIGZvciB2ZHBhIGRldmljZXMgYmFzZWQgb24gbGVnYWN5IHZpcnRpbyBzcGVj
ZmljYXRpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBXdSBab25neW9uZyA8d3V6b25neW9uZ0BsaW51
eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAy
MSArKysrKysrKysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gaW5kZXggNzJlYWVmMmNh
ZWIxLi5lNDJhY2UyOWRhYTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Zk
cGEuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBAQCAtMTQ1LDcgKzE0
NSw4IEBAIHZpcnRpb192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJLyogQXNzdW1lIHNwbGl0IHZpcnRxdWV1ZSwgc3dpdGNo
IHRvIHBhY2tlZCBpZiBuZWNlc3NhcnkgKi8KPiAgIAlzdHJ1Y3QgdmRwYV92cV9zdGF0ZSBzdGF0
ZSA9IHswfTsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+IC0JdTMyIGFsaWduLCBudW07Cj4g
Kwl1MzIgYWxpZ24sIG1heF9udW0sIG1pbl9udW0gPSAwOwo+ICsJYm9vbCBtYXlfcmVkdWNlX251
bSA9IHRydWU7Cj4gICAJaW50IGVycjsKPiAgIAo+ICAgCWlmICghbmFtZSkKPiBAQCAtMTYzLDIy
ICsxNjQsMzIgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlpZiAoIWluZm8pCj4gICAJCXJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOwo+ICAgCj4gLQludW0gPSBvcHMtPmdldF92cV9udW1fbWF4KHZkcGEpOwo+
IC0JaWYgKG51bSA9PSAwKSB7Cj4gKwltYXhfbnVtID0gb3BzLT5nZXRfdnFfbnVtX21heCh2ZHBh
KTsKPiArCWlmIChtYXhfbnVtID09IDApIHsKPiAgIAkJZXJyID0gLUVOT0VOVDsKPiAgIAkJZ290
byBlcnJvcl9uZXdfdmlydHF1ZXVlOwo+ICAgCX0KPiAgIAo+ICsJaWYgKG9wcy0+Z2V0X3ZxX251
bV9taW4pCj4gKwkJbWluX251bSA9IG9wcy0+Z2V0X3ZxX251bV9taW4odmRwYSk7Cj4gKwo+ICsJ
bWF5X3JlZHVjZV9udW0gPSAobWF4X251bSA9PSBtaW5fbnVtKSA/IGZhbHNlIDogdHJ1ZTsKPiAr
Cj4gICAJLyogQ3JlYXRlIHRoZSB2cmluZyAqLwo+ICAgCWFsaWduID0gb3BzLT5nZXRfdnFfYWxp
Z24odmRwYSk7Cj4gLQl2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoaW5kZXgsIG51bSwgYWxp
Z24sIHZkZXYsCj4gLQkJCQkgICAgdHJ1ZSwgdHJ1ZSwgY3R4LAo+ICsJdnEgPSB2cmluZ19jcmVh
dGVfdmlydHF1ZXVlKGluZGV4LCBtYXhfbnVtLCBhbGlnbiwgdmRldiwKPiArCQkJCSAgICB0cnVl
LCBtYXlfcmVkdWNlX251bSwgY3R4LAo+ICAgCQkJCSAgICB2aXJ0aW9fdmRwYV9ub3RpZnksIGNh
bGxiYWNrLCBuYW1lKTsKPiAgIAlpZiAoIXZxKSB7Cj4gICAJCWVyciA9IC1FTk9NRU07Cj4gICAJ
CWdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiAgIAl9Cj4gICAKPiArCWlmICh2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUodnEpIDwgbWluX251bSkgewo+ICsJCWVyciA9IC1FSU5WQUw7Cj4gKwkJ
Z290byBlcnJfdnE7Cj4gKwl9CgoKVW5kZXIgd2hpY2ggY29uZGl0aW9uIGNhbiB3ZSBoaXQgdGhp
cyBlcnJvcj8KClRoYW5rcwoKCj4gKwo+ICAgCS8qIFNldHVwIHZpcnRxdWV1ZSBjYWxsYmFjayAq
Lwo+ICAgCWNiLmNhbGxiYWNrID0gdmlydGlvX3ZkcGFfdmlydHF1ZXVlX2NiOwo+ICAgCWNiLnBy
aXZhdGUgPSBpbmZvOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
