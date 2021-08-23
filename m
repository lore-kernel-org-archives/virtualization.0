Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1697C4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:25:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8746761356
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8746761356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 368D7400EF;
	Mon, 23 Aug 2021 06:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SPNOEyv5w19M; Mon, 23 Aug 2021 06:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5998401BF;
	Mon, 23 Aug 2021 06:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EFD7C001A;
	Mon, 23 Aug 2021 06:25:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8B1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D03A402AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u6-30miQKXV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C0A54028C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629699900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
 b=fqxAHtoN4SphINrLYoJJmXEm/QlDWmg4hP50b1vTYQNXXvBPxDE2UZN+EUdH44Ttrq/U+r
 T5tg+GD7vuHqeO5nQDz/LdPNGhATn3HxAqr4/OOZRsal/+Ci6Dvj5mOQGRxkZ0b4ZwWJNj
 1WwLv5t9BKUsgPY60trKCGHMi+Ngjbg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-bSRGBnW5PqmaWlBFuDDRSA-1; Mon, 23 Aug 2021 02:24:56 -0400
X-MC-Unique: bSRGBnW5PqmaWlBFuDDRSA-1
Received: by mail-pg1-f197.google.com with SMTP id
 k11-20020a6568cb0000b029023d00ca7bbcso9816899pgt.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Aug 2021 23:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
 b=YGWKiS58KoweNewlCJnQQBbV66YQUT24yjCN/lHGjNYBxB9PMXkHMj68uxDSEk+Myu
 uLIGnrCcXYBeMEglr44WMlXqAYaRV1TTKPrEn3WG4XQ7jBJz9XP7CrJOPbYKNfjVkCbi
 t72k91Y+qoK3RuJ6gq8GYcL4YA18OYWseM7V0zhuRq4pVSedsDG2vDMQnlgln2tEcnS4
 CCru4o7fO3OGkB3X22peHTicOTrMMrgr/3A2N2ulyiO2V+d7O7aCBoe0KxyX50rUDRQl
 DtQ0WJghFg6QzoW2aPaFgHgmHuEVirWtAI2VhcAWk9ltQSJTXP2QqgOvAq0v0kR3Pv/0
 Xh/Q==
X-Gm-Message-State: AOAM532s+2AIpDSbmCMgwTCgMqDtTgYSK6rRyRfXWnoYJpLTyw8ZmLBj
 LsaVEcjuctH1VpK314w55vEQADY1+pjV8KwJF3sKNVWWKNVovOfnGdlWNa0S+3OI79blCYRAOvL
 H3KPWPlcXAQHfR5gfy6raFVHI3dQ8ezZYPf20B0ujlA==
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr7315316pjq.205.1629699895447; 
 Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYnrO75usjjlrGCgZzdsLDtPE2dKORuqu4cQ6/SLHByjgTAawINCsTeerUMEDWc0TN8ooDAw==
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr7315281pjq.205.1629699895193; 
 Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g3sm14314416pfi.197.2021.08.22.23.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:24:54 -0700 (PDT)
Subject: Re: [PATCH v11 01/12] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3ff77bab-8bb7-ae5b-4cf1-a90ebcc00118@redhat.com>
Date: Mon, 23 Aug 2021 14:24:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCBhbGxvY19p
b3ZhX2Zhc3QoKSBhbmQgZnJlZV9pb3ZhX2Zhc3QoKSBzbyB0aGF0Cj4gc29tZSBtb2R1bGVzIGNh
biBtYWtlIHVzZSBvZiB0aGUgcGVyLUNQVSBjYWNoZSB0byBnZXQKPiByaWQgb2YgcmJ0cmVlIHNw
aW5sb2NrIGluIGFsbG9jX2lvdmEoKSBhbmQgZnJlZV9pb3ZhKCkKPiBkdXJpbmcgSU9WQSBhbGxv
Y2F0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5j
ZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgooSWYg
d2UgbmVlZCByZXNwaW4sIEknZCBzdWdnZXN0IHRvIHB1dCB0aGUgbnVtYmVycyB5b3UgbWVhc3Vy
ZWQgaGVyZSkKClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDIgKysK
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gaW5kZXggYjZjZjVmMTYx
MjNiLi4zOTQxZWQ2YmI5OWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiAr
KysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+IEBAIC01MjEsNiArNTIxLDcgQEAgYWxsb2NfaW92
YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiAg
IAo+ICAgCXJldHVybiBuZXdfaW92YS0+cGZuX2xvOwo+ICAgfQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TChhbGxvY19pb3ZhX2Zhc3QpOwo+ICAgCj4gICAvKioKPiAgICAqIGZyZWVfaW92YV9mYXN0IC0g
ZnJlZSBpb3ZhIHBmbiByYW5nZSBpbnRvIHJjYWNoZQo+IEBAIC01MzgsNiArNTM5LDcgQEAgZnJl
ZV9pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBwZm4s
IHVuc2lnbmVkIGxvbmcgc2l6ZSkKPiAgIAo+ICAgCWZyZWVfaW92YShpb3ZhZCwgcGZuKTsKPiAg
IH0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZnJlZV9pb3ZhX2Zhc3QpOwo+ICAgCj4gICAjZGVmaW5l
IGZxX3JpbmdfZm9yX2VhY2goaSwgZnEpIFwKPiAgIAlmb3IgKChpKSA9IChmcSktPmhlYWQ7IChp
KSAhPSAoZnEpLT50YWlsOyAoaSkgPSAoKGkpICsgMSkgJSBJT1ZBX0ZRX1NJWkUpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
