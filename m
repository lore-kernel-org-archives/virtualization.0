Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5AC4320A
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9CD6105A
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF9CD6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E5D740186;
	Tue,  3 Aug 2021 07:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoLojgqM3_4H; Tue,  3 Aug 2021 07:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E01EB40101;
	Tue,  3 Aug 2021 07:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7570C0010;
	Tue,  3 Aug 2021 07:41:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3E47C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3E8E606EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9Ae7yBNujun
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:41:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CC0A606E2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627976508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEW12L7lEJwVitr0islGtcOwaqb3auoW/6llqcQs9Bo=;
 b=Okn0H+JgfP7Ekiwvw8197e1vYRmbD5ZVcTUxfi/nRpSE8nYhx41ugWGaCS2tG1k4HajPQg
 GXNJ2aLvH1agvkb1gkMMFLZ2udVwh0LwUNCZZnHXHiJ1PGBPHsrBPlCw0dJGY6/5uH36PM
 ZBg72B/ZJ65qM+iFqk7RwPexeStmbOc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-VbcPws3QNS-3NFqoi0m_eA-1; Tue, 03 Aug 2021 03:41:44 -0400
X-MC-Unique: VbcPws3QNS-3NFqoi0m_eA-1
Received: by mail-pj1-f69.google.com with SMTP id
 n4-20020a17090ac684b0290177656cfbc7so2726008pjt.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 00:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sEW12L7lEJwVitr0islGtcOwaqb3auoW/6llqcQs9Bo=;
 b=cz5tDkdpiCTXM6UpEG7n5Y2nd+KIES4ZfmjA5RJI54aWRHLxJsSQtflqd8fSH3ISys
 VpkySXynCL1p04fXhbX2SIXPJElx0MWz9YC315m+k6HL8H4ybXFGMw5ySob3uUfSoY+u
 qpGA/FlqT7TpjfndihCyxruKzmQzvd7kODEu5yL+ghYai2yoXdITVzyrcJXpZnAKL2WM
 h2GXxCrubdFBL2Uwd766MoeJLn1hzaB0Qb3v80mMiOf0C0Ib24GWFBXLGDa9wPTfGN8s
 sS30JlOitWmF6l6jcEG/0JDPZ4CzRYdlMY5/K4JuqYjEQD+GjYMSAdDimd2+KEmUWGfA
 +u+w==
X-Gm-Message-State: AOAM5310hkw58lOzD6zWIau1e5zanQdkuefHTA0P7Qrkr4sQdpsUz/Rs
 wogHFCC8zFR+WBnm9AfAux5cOV81w2a0pXQnCOCHvWMPHzHY0m7RRQEmWYeP693NWqWPWi/JTJz
 3Umx8kTp2UTGrTZi56G/V/wcjQM1KMr7NTXvel3gvZw==
X-Received: by 2002:a65:6658:: with SMTP id z24mr924196pgv.266.1627976503818; 
 Tue, 03 Aug 2021 00:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTQ9FIMwD850kYRySFMOvwSa2Mh3zZSaM4w5MdRtHBvqDzhjK3JTqHR+x1mQoJbyhltJ0O8Q==
X-Received: by 2002:a65:6658:: with SMTP id z24mr924161pgv.266.1627976503586; 
 Tue, 03 Aug 2021 00:41:43 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r15sm13016701pjl.29.2021.08.03.00.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 00:41:42 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
Date: Tue, 3 Aug 2021 15:41:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-2-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCBhbGxvY19p
b3ZhX2Zhc3QoKSBhbmQgZnJlZV9pb3ZhX2Zhc3QoKSBzbyB0aGF0Cj4gc29tZSBtb2R1bGVzIGNh
biB1c2UgaXQgdG8gaW1wcm92ZSBpb3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeS4KCgpJdCdzIGJl
dHRlciB0byBleHBsYWluIHdoeSBhbGxvY19pb3ZhKCkgaXMgbm90IHN1ZmZpY2llbnQgaGVyZS4K
ClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRh
bmNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMiArKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiBpbmRleCBiNmNmNWYxNjEyM2IuLjM5NDFl
ZDZiYjk5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEuYwo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW92YS5jCj4gQEAgLTUyMSw2ICs1MjEsNyBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3Ry
dWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBzaXplLAo+ICAgCj4gICAJcmV0
dXJuIG5ld19pb3ZhLT5wZm5fbG87Cj4gICB9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKGFsbG9jX2lv
dmFfZmFzdCk7Cj4gICAKPiAgIC8qKgo+ICAgICogZnJlZV9pb3ZhX2Zhc3QgLSBmcmVlIGlvdmEg
cGZuIHJhbmdlIGludG8gcmNhY2hlCj4gQEAgLTUzOCw2ICs1MzksNyBAQCBmcmVlX2lvdmFfZmFz
dChzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCB1bnNpZ25lZCBsb25nIHBmbiwgdW5zaWduZWQg
bG9uZyBzaXplKQo+ICAgCj4gICAJZnJlZV9pb3ZhKGlvdmFkLCBwZm4pOwo+ICAgfQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChmcmVlX2lvdmFfZmFzdCk7Cj4gICAKPiAgICNkZWZpbmUgZnFfcmluZ19m
b3JfZWFjaChpLCBmcSkgXAo+ICAgCWZvciAoKGkpID0gKGZxKS0+aGVhZDsgKGkpICE9IChmcSkt
PnRhaWw7IChpKSA9ICgoaSkgKyAxKSAlIElPVkFfRlFfU0laRSkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
