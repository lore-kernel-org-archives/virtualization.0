Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2605C4707F
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 02:36:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EE461429
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 02:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EE461429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1607D83BC5;
	Wed, 26 May 2021 02:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z786AlGFd2oo; Wed, 26 May 2021 02:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA92B83BC0;
	Wed, 26 May 2021 02:36:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA33C000D;
	Wed, 26 May 2021 02:36:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48716C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33CF740025
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:36:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ou_vk5vklgEu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58B6F4000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621996584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJC3K6l6gJPi4CUzLhheMs0LRbWxiui4b9xku04/3mg=;
 b=FLTML3az9GlmnIZWqYMuqNDvbo0kAbcKdtWA/qQOtP61hXvjCRvJbYxmobEYwQDKmY6umM
 CMe6gi/fjyBY5zthf+zP1YJl0HGmBeB1IAY7/x9edoBsTt7D8QmHGLw7N91wm00e1nbpex
 dp1rdxIvq45sG53RU8N+vKjVcPTav40=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-2K9S1V6GN2iqj6LVICtcdQ-1; Tue, 25 May 2021 22:36:22 -0400
X-MC-Unique: 2K9S1V6GN2iqj6LVICtcdQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so22399586pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 19:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IJC3K6l6gJPi4CUzLhheMs0LRbWxiui4b9xku04/3mg=;
 b=kVm0EFC+3LmgO62WnRkEloT8cNnksr8Ub5LA52lXyYY0kzq6CMK/QGNjDxBovqnKco
 gsGAdX68RWtkIqDF8JJaWT5zfh3uUBjDfa5J0o6V3ZgMGgMf7YUr4xYdL+5suBKjPdzs
 K3kDV5yS5IZOuGt5qSdfS+z1KuN10MQbxOlBMqyAzAtMdjrnd/rPMFTmMwWslKbfyxn9
 wFJWxVtnQ4eIE7tbdsPTfvnTS5HSfxdbYufTwW3uiXvzjpQ5qm2VsVLQAPOkvH/pkwcs
 685frKTbYGBhlkH/Ww6pfhTDt+QN0QuvO43ttJ+tl5Q6EFYJzunMX43LkAa28OQIBjsS
 ETNA==
X-Gm-Message-State: AOAM530HD1G0/zLpzMQh0WQZq6JSOjZ7k9qbf9TU3ngQ3vsL2n5B/tkw
 HB0KZMUQfmF4efbjh7nfpldWjr+MbmCq0lwvmYioV81OzvYPf+DeqkmHbOo4+51G4+RjAFy0HHb
 VEcSlAvdOnUwylTx/Pjfl9iSC0uf/WaRwGxK44Tfy2Q==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id
 k1-20020a170902f281b02900f0bdf22fe5mr32724310plc.68.1621996581539; 
 Tue, 25 May 2021 19:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylcchXGFUiLMl0CERc9pjyfUvd7s5BV6gdMSkLdsrvpEyh07CtgmlI9vttP0fXdJsLVzRn5Q==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id
 k1-20020a170902f281b02900f0bdf22fe5mr32724300plc.68.1621996581246; 
 Tue, 25 May 2021 19:36:21 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b12sm2984392pjd.22.2021.05.25.19.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 19:36:20 -0700 (PDT)
Subject: Re: [PATCH v7 01/12] iova: Export alloc_iova_fast()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
Date: Wed, 26 May 2021 10:36:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvNS8xNyDPws7nNTo1NSwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCBhbGxvY19p
b3ZhX2Zhc3QoKSBzbyB0aGF0IHNvbWUgbW9kdWxlcyBjYW4gdXNlIGl0Cj4gdG8gaW1wcm92ZSBp
b3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeS4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkg
PHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9pb3ZhLmMg
fCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiBpbmRleCBlNmUy
ZmE4NTI3MWMuLjMxN2VlZjY0ZmZlZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEu
Ywo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gQEAgLTQ1MCw2ICs0NTAsNyBAQCBhbGxv
Y19pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBzaXpl
LAo+ICAgCj4gICAJcmV0dXJuIG5ld19pb3ZhLT5wZm5fbG87Cj4gICB9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGFsbG9jX2lvdmFfZmFzdCk7Cj4gICAKPiAgIC8qKgo+ICAgICogZnJlZV9pb3ZhX2Zh
c3QgLSBmcmVlIGlvdmEgcGZuIHJhbmdlIGludG8gcmNhY2hlCgoKSW50ZXJlc3RpbmcsIGRvIHdl
IG5lZWQgZXhwb3J0IGZyZWVfaW92YV9mYXN0KCkgYXMgd2VsbD8KClRoYW5rcwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
