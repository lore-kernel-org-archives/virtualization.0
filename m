Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED3C47087
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 02:42:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A08613D6
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 02:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A08613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FC77405D3;
	Wed, 26 May 2021 02:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cS37ML7JdAu5; Wed, 26 May 2021 02:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECA0540621;
	Wed, 26 May 2021 02:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4CD4C000D;
	Wed, 26 May 2021 02:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F46EC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39C07405F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4kwD36lmJNT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EBFE405D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621996914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bc/2MmUW+pgbFW2qFMtYQUjTQyUaBFo1vkB8ZkWRL6s=;
 b=TwLpwVGcRRBQVe1PFOmqc/Qevs6nMDSwfwmClvlMpypXNcYFp2s6FHox1d/J3WURDwci07
 MkPOr4CKqPoXMUvyMFDQfjvxPPv+MXLTDcoVGSpoyxiFf5jj9TP4o+7WA10gBrGBu3Lwid
 oy3g7MmfBOIkbJXLpQUu1Sk5WBNJrWc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-SHncxIrqORWmXX36uYY4mw-1; Tue, 25 May 2021 22:41:50 -0400
X-MC-Unique: SHncxIrqORWmXX36uYY4mw-1
Received: by mail-pg1-f200.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so22406387pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 19:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bc/2MmUW+pgbFW2qFMtYQUjTQyUaBFo1vkB8ZkWRL6s=;
 b=P8eFrVz8Kl9cIPkL9AsmxT3iaeLnpT1DccDAHQThEyQVttNoyrqPFdiL9BzUYpj4EC
 EtpEVBgFE8Pftjs+IpkYcCnjVKDVyV2pVDZMI3MQiCRCivhAj0zUxRiZm8a53Iu5dCp4
 EtTmkpepLIu94STRsJFBTgP3/03/cuGU2GPQpvTZkCZ2e5BVHXf5xQ/copV1rhETFm3s
 20+A/8Sy9mM1wk3/IZ7/4Elv7hb4CeEf+eD4IIAibv8tQYjA6F/GkKI8jUqkd0Dr987H
 FPht4lCFuQ1tIX2tOvZe3fSzik0v1DGtAIVi/epDZHWIpNJKTTXX0+6F499uNlXYGFKO
 7Urg==
X-Gm-Message-State: AOAM533pIvN/YPP1nQ5w+Bz8MHISFyD4yLuWS16o3PcjZqfRPU+VWsxH
 WLv/Gqe7VpXigoEMMAZNTlZnwgP11yBLTUhgOUsf0zkue/9+NPDt/u5ku45OqEZ5jrkNK2vaulc
 Ei9zVHJVF7u7sIPDC+2LOLBvuGFos5dvT8TL/ozqahg==
X-Received: by 2002:a62:ab10:0:b029:2e8:d5a8:d635 with SMTP id
 p16-20020a62ab100000b02902e8d5a8d635mr15164714pff.74.1621996909410; 
 Tue, 25 May 2021 19:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdM51fqapZ+TAydQBf1YBCQBeMJGeM8QJFnRIR/jK472sF6Fh8jpb1mmntXjLVehm11MPEGA==
X-Received: by 2002:a62:ab10:0:b029:2e8:d5a8:d635 with SMTP id
 p16-20020a62ab100000b02902e8d5a8d635mr15164685pff.74.1621996909140; 
 Tue, 25 May 2021 19:41:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a8sm14716088pfk.11.2021.05.25.19.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 19:41:48 -0700 (PDT)
Subject: Re: [PATCH v7 05/12] virtio_scsi: Add validation for residual bytes
 from response
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <94abb1de-921d-8bf2-4cfc-55c7fc86c5a0@redhat.com>
Date: Wed, 26 May 2021 10:41:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-6-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNS8xNyDPws7nNTo1NSwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgZW5zdXJlcyB0
aGF0IHRoZSByZXNpZHVhbCBieXRlcyBpbiByZXNwb25zZSAobWlnaHQgY29tZQo+IGZyb20gYW4g
dW50cnVzdGVkIGRldmljZSkgd2lsbCBub3QgZXhjZWVkIHRoZSBkYXRhIGJ1ZmZlciBsZW5ndGgu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4K
PiAtLS0KPiAgIGRyaXZlcnMvc2NzaS92aXJ0aW9fc2NzaS5jIHwgMiArLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zY3NpL3ZpcnRpb19zY3NpLmMgYi9kcml2ZXJzL3Njc2kvdmlydGlvX3Njc2kuYwo+IGlu
ZGV4IGVmY2FmMDY3NGM4ZC4uYWQ3ZDhjZWNlYzMyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2Nz
aS92aXJ0aW9fc2NzaS5jCj4gKysrIGIvZHJpdmVycy9zY3NpL3ZpcnRpb19zY3NpLmMKPiBAQCAt
OTcsNyArOTcsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBTY3NpX0hvc3QgKnZpcnRpb19zY3Np
X2hvc3Qoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICBzdGF0aWMgdm9pZCB2aXJ0c2Nz
aV9jb21wdXRlX3Jlc2lkKHN0cnVjdCBzY3NpX2NtbmQgKnNjLCB1MzIgcmVzaWQpCj4gICB7Cj4g
ICAJaWYgKHJlc2lkKQo+IC0JCXNjc2lfc2V0X3Jlc2lkKHNjLCByZXNpZCk7Cj4gKwkJc2NzaV9z
ZXRfcmVzaWQoc2MsIG1pbihyZXNpZCwgc2NzaV9idWZmbGVuKHNjKSkpOwo+ICAgfQo+ICAgCj4g
ICAvKgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
