Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F4C4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:11:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A411D60EBD
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A411D60EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CD7882882;
	Tue,  3 Aug 2021 08:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dasy81fUZWES; Tue,  3 Aug 2021 08:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44E1482862;
	Tue,  3 Aug 2021 08:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20EBFC0010;
	Tue,  3 Aug 2021 08:11:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC55BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBABD606F1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K18uqVXOY5Gu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EEC2605DF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627978260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
 b=cpBqDQAMX0HLHf2BuxE456thzfL63D9uFJLa5YmTTFPpH3SvlbX0ac0xiKg4/50zcN6BA/
 weuJAf/YQNrBJA6Sb4uq/6qUOAZYAn4ssJS2dYRZb2iQ5HQiMxzZRbVVl6lvIYhl6rddIl
 Lxvf9mscaXiJv+OSgpbD9cKFXjn11Ig=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-03tj2-nNNKyEBZu6GhOv9w-1; Tue, 03 Aug 2021 04:10:57 -0400
X-MC-Unique: 03tj2-nNNKyEBZu6GhOv9w-1
Received: by mail-pj1-f69.google.com with SMTP id
 s20-20020a17090a5d14b0290177ee10728cso2794422pji.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 01:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
 b=Wdom8eUSd8AgtFLiqKNJaj96/Q05Dtmvnb6quf+P+8Wk+V4USN5gLn2Fk/uZfOfuV2
 k40YjzpHWiKyz81DuwYnP57k939/7gBfbnDQNuAKiDQ+zHEvlCBuSKDevpvkXyLUBM5e
 HVNEJxUqEFctfYl6SGg3RNxZGjM+YQrj143shc31A6D+htXTULcn72QvrLGE80etTxh+
 ttkGuH9gjNRqe3U9o1Hw22TgFj4hPKMhViT5oRUcYQk/FK/nFV/APjD+B3IzbamuwMP8
 ShYAgfVY1R6EK7h6i0zrYagPeDE5KB7eUySJCcJgkpVJwnxfC30J9dOyY2TBqjZvTf/O
 gkbw==
X-Gm-Message-State: AOAM5321Pz8HGUq9DGwcR/adLSjNaFG20ZggQrz8HEWT8dABLw5J92BC
 0Zk7I2MwPmSPZ/P1HZfeWZ3tob9+JWQdj7BC4h3obtRcM//RBXIMDCQbJBGwYtLHD5LuUgN7mjw
 tqsoskzcS+Yy5bOA8cJCVXEuMovRJZOPHsJMul16EXQ==
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936165pgi.238.1627978255981; 
 Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH8hbLkAijKqHClsGdxbrFT2e5OFHsYSjNhxOgbwifClMzXSHDtPi9YbQ4DmXvoCPE/e8DcA==
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936146pgi.238.1627978255811; 
 Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u21sm14097827pfh.163.2021.08.03.01.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Subject: Re: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
Date: Tue, 3 Aug 2021 16:10:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-6-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IFJlLXJlYWQgdGhlIGRl
dmljZSBzdGF0dXMgdG8gZW5zdXJlIGl0J3Mgc2V0IHRvIHplcm8gZHVyaW5nCj4gcmVzZXR0aW5n
LiBPdGhlcndpc2UsIGZhaWwgdGhlIHZob3N0X3ZkcGFfc2V0X3N0YXR1cygpIGFmdGVyIHRpbWVv
dXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTEgKysrKysrKysrKy0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4
IGIwN2FhMTYxZjdhZC4uZGQwNWMxZTExMzNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtMTU3LDcgKzE1Nyw3IEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwg
dTggX191c2VyICpzdGF0dXNwKQo+ICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZk
cGE7Cj4gICAJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmln
Owo+ICAgCXU4IHN0YXR1cywgc3RhdHVzX29sZDsKPiAtCWludCBudnFzID0gdi0+bnZxczsKPiAr
CWludCB0aW1lb3V0ID0gMCwgbnZxcyA9IHYtPm52cXM7Cj4gICAJdTE2IGk7Cj4gICAKPiAgIAlp
ZiAoY29weV9mcm9tX3VzZXIoJnN0YXR1cywgc3RhdHVzcCwgc2l6ZW9mKHN0YXR1cykpKQo+IEBA
IC0xNzMsNiArMTczLDE1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAgCQlyZXR1cm4gLUVJTlZB
TDsKPiAgIAo+ICAgCW9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+ICsJaWYgKHN0YXR1
cyA9PSAwKSB7Cj4gKwkJd2hpbGUgKG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKSkgewo+ICsJCQl0aW1l
b3V0ICs9IDIwOwo+ICsJCQlpZiAodGltZW91dCA+IFZEUEFfUkVTRVRfVElNRU9VVF9NUykKPiAr
CQkJCXJldHVybiAtRUlPOwo+ICsKPiArCQkJbXNsZWVwKDIwKTsKPiArCQl9CgoKU3BlYyBoYXMg
aW50cm9kdWNlZCB0aGUgcmVzZXQgYSBvbmUgb2YgdGhlIGJhc2ljIGZhY2lsaXR5LiBBbmQgY29u
c2lkZXIgCndlIGRpZmZlciByZXNldCBoZXJlLgoKVGhpcyBtYWtlcyBtZSB0aGluayBpZiBpdCdz
IGJldHRlciB0byBpbnRyb2R1Y2UgYSBkZWRpY2F0ZWQgdmRwYSBvcHMgZm9yIApyZXNldD8KClRo
YW5rcwoKCj4gKwl9Cj4gICAKPiAgIAlpZiAoKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklW
RVJfT0spICYmICEoc3RhdHVzX29sZCAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spKQo+ICAg
CQlmb3IgKGkgPSAwOyBpIDwgbnZxczsgaSsrKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
