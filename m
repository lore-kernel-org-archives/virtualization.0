Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:23:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9839E61181
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9839E61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 633914028A;
	Fri, 15 Oct 2021 08:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id onFWRjB45Xiz; Fri, 15 Oct 2021 08:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C386D40281;
	Fri, 15 Oct 2021 08:23:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E880C000F;
	Fri, 15 Oct 2021 08:23:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC09C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F24F404D2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szYeGWV5r0XC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64AD5404BC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634286180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcA/AKdnJAyfY5MWpoSYVc+I5H9/vFXIYe/jlFy9tUs=;
 b=B9PSHY+H3pBUZI75BG4/g5+MJ571rd0c5R1dMxWDfFztRnAL8vwvQrz/sK5vN/G/feNNNT
 7lwJ2M55otDgNVOrSHEqhn/twajFrOu8gPNxwj8pruODNKAwFfMVWwt9s5EJ8wsovAlK4Q
 BgcUZ7+rxApw54z1ZuQ0PZmIvkDq0F0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-iWywCGHNOnWBHLaPSmP9-w-1; Fri, 15 Oct 2021 04:22:59 -0400
X-MC-Unique: iWywCGHNOnWBHLaPSmP9-w-1
Received: by mail-pj1-f72.google.com with SMTP id
 ob9-20020a17090b390900b001a0fd49248fso2450148pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XcA/AKdnJAyfY5MWpoSYVc+I5H9/vFXIYe/jlFy9tUs=;
 b=F3lr3fKbHfvS2CGErAZJ6ieCppmaEFMiZlD74qq1CR1JZ/cdv+Qkh8+SWZLEZ4RRHt
 hDbpQC7ggfYfFvBVYSL8xG5i2pTcAMRRH2RuzIx9pKqE1rkJI4qEtGU+P3RaG5Nn5qEX
 5+bjV+nGLrBDeNJF2FoQePJApzYN2tc4CNhZlcOIfZPeHw91zZPSyAB8Z3Zzp2N4K3Ft
 Y6yRxb752sXGLBlpsxAqHU+iRvOYJTl4tXEiU/G3ezjP+U53kThPfOOMIM/PeP/24Tqk
 J81sSSkA7V5NTRDQzfhzcpkWe5hHazOC0c8DHjEnbM08oNs0YcpUQOBsfG6sB3Rixwzx
 KuZw==
X-Gm-Message-State: AOAM5302YriNhbZCRrS/bGJFlDBIY3u8IPCIAsao2yZSlShdkbeNn79A
 G8DTmWY8zgXp0Qyp/+mv5EK3rYXQbO4Eg406JBkOQats8eKVBuYrD9pe/c7SqzPHo8giWEpgMLD
 nvMXzhtg/6Fz6q7ytoj6tOpzmdrdi/l/P3w9Nj3+rIg==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id
 f141-20020a623893000000b0044b93695de5mr10422263pfa.40.1634286178115; 
 Fri, 15 Oct 2021 01:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9xNgyFYLdtunayxJlaElANQTbK2Vwxt3HZMQjMl+A6afFTAZ2n7HSq2zfQBFbsHEzgY7crQ==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id
 f141-20020a623893000000b0044b93695de5mr10422247pfa.40.1634286177886; 
 Fri, 15 Oct 2021 01:22:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e12sm4288876pfl.67.2021.10.15.01.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:22:57 -0700 (PDT)
Subject: Re: [PATCH v5 4/8] vdpa: add new callback get_vq_num_min in
 vdpa_config_ops
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <25435d5cde12f298133196e866662b0ef2225205.1634281805.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e658c9e3-9949-6451-c555-a3ffbe1568db@redhat.com>
Date: Fri, 15 Oct 2021 16:22:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <25435d5cde12f298133196e866662b0ef2225205.1634281805.git.wuzongyong@linux.alibaba.com>
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

CtTaIDIwMjEvMTAvMTUgz8LO5zM6MTQsIFd1IFpvbmd5b25nINC0tcA6Cj4gVGhpcyBjYWxsYmFj
ayBpcyBvcHRpb25hbC4gRm9yIHZkcGEgZGV2aWNlcyB0aGF0IG5vdCBzdXBwb3J0IHRvIGNoYW5n
ZQo+IHZpcnRxdWV1ZSBzaXplLCBnZXRfdnFfbnVtX21pbiBhbmQgZ2V0X3ZxX251bV9tYXggd2ls
bCByZXR1cm4gdGhlIHNhbWUKPiB2YWx1ZSwgc28gdGhhdCB1c2VycyBjYW4gY2hvb3NlIGEgY29y
cmVjdCB2YWx1ZSBmb3IgdGhhdCBkZXZpY2UuCj4KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogV3UgWm9uZ3lvbmcgPHd1em9u
Z3lvbmdAbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgNCArKysrCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IGE4OTZlZTAyMWU1
Zi4uMzA4NjQ4NDg5NTBiIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gKysr
IGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtMTcxLDYgKzE3MSw5IEBAIHN0cnVjdCB2ZHBh
X21hcF9maWxlIHsKPiAgICAqIEBnZXRfdnFfbnVtX21heDoJCUdldCB0aGUgbWF4IHNpemUgb2Yg
dmlydHF1ZXVlCj4gICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiAgICAqCQkJCVJldHVybnMg
dTE2OiBtYXggc2l6ZSBvZiB2aXJ0cXVldWUKPiArICogQGdldF92cV9udW1fbWluOgkJR2V0IHRo
ZSBtaW4gc2l6ZSBvZiB2aXJ0cXVldWUgKG9wdGlvbmFsKQo+ICsgKgkJCQlAdmRldjogdmRwYSBk
ZXZpY2UKPiArICoJCQkJUmV0dXJucyB1MTY6IG1pbiBzaXplIG9mIHZpcnRxdWV1ZQo+ICAgICog
QGdldF9kZXZpY2VfaWQ6CQlHZXQgdmlydGlvIGRldmljZSBpZAo+ICAgICoJCQkJQHZkZXY6IHZk
cGEgZGV2aWNlCj4gICAgKgkJCQlSZXR1cm5zIHUzMjogdmlydGlvIGRldmljZSBpZAo+IEBAIC0y
NjYsNiArMjY5LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAJdm9pZCAoKnNldF9j
b25maWdfY2IpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPiAgIAkJCSAgICAgIHN0cnVjdCB2
ZHBhX2NhbGxiYWNrICpjYik7Cj4gICAJdTE2ICgqZ2V0X3ZxX251bV9tYXgpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldik7Cj4gKwl1MTYgKCpnZXRfdnFfbnVtX21pbikoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2KTsKPiAgIAl1MzIgKCpnZXRfZGV2aWNlX2lkKShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYpOwo+ICAgCXUzMiAoKmdldF92ZW5kb3JfaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
dik7Cj4gICAJdTggKCpnZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
