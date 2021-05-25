Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BCC2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:10:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D96E61413
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D96E61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0633382F41;
	Tue, 25 May 2021 06:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOfmx9G9GuVW; Tue, 25 May 2021 06:10:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F9C82CF9;
	Tue, 25 May 2021 06:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D26AC000D;
	Tue, 25 May 2021 06:10:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C70C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 521B982E13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6E_AsHh-BD-8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4988B82CF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621923039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+ve4EsgwRWH3fX93e3xnVlqn74wnn5/jWlsUyNe/eQ=;
 b=hrU8XCc1zqfCN2AI0JcYyQiIlOUJbrx8RfrSVF6BCjSe9xUNYwrQHh50100Wfb7W9wEk4T
 yubJClQSxdBRvy7GudvM3Ipg84RXB4T53gRpm3lsFqMBxI0iWzuGTotM0aCDJV1rjTZDQy
 QjZZqqCfxmsjeuFNUi7tL4sSOT/dOfI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-EJDUxoI9MJ-7Jj0NF9VpBg-1; Tue, 25 May 2021 02:10:38 -0400
X-MC-Unique: EJDUxoI9MJ-7Jj0NF9VpBg-1
Received: by mail-pf1-f200.google.com with SMTP id
 o11-20020a62f90b0000b02902db3045f898so17729076pfh.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 23:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7+ve4EsgwRWH3fX93e3xnVlqn74wnn5/jWlsUyNe/eQ=;
 b=hbzyBzVk1SIxYtIhj5uGfHaxMzJQK0ry/1zvQCtmOrbmVeO+XuKKwFY5Qx5gtg/LrV
 +PmDuTdxYUgitkZpR13v+vg4La+RNZaw8aNMc9Q1Au1PQYBDqTeFjjxHoimXjlCU2Le3
 V80EX1vQJDmwWlUxEUTdIZzo7/c5Nkk3xgxiXZVGiC7XBwdz5izZqR5Fnj+7rRhOxgd8
 LkmGMpKBOvjotwHJuhFxxrCDIQyHqBLkYWzQPDuNuu9uQl0NQZRnr/GSuGij0P9Zmspb
 jJg1FTOpY9lQ3nu8N9pO1Lc605DU6LFjzkL+7HJwnd38XWme9Ja2nTDb6Br1dyoAq7li
 vRfg==
X-Gm-Message-State: AOAM5318RSCHfaLY306+i6P9qVQCLab40JSHFi3N+SffbPbe0rEqbw/L
 oR7n4AL8dN9BxvaRWEnQcJhAtiTmLx9jP1WwlvZD2AP3xp4G0ajsr/LXcJlPDEUVnsM/yDLGT6G
 mesvUahtGcZRULQQSNVeWs41ZlOD1tGjSnM2eGW93nQ==
X-Received: by 2002:a62:e21a:0:b029:2de:4440:3a with SMTP id
 a26-20020a62e21a0000b02902de4440003amr28091152pfi.23.1621923037218; 
 Mon, 24 May 2021 23:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcul8Osk5YUUxMqw8lYyZbg9J74NcgDmptA1ycXjYhsCuAI8yoBr2KodL1zkGCBnHfRNoPlg==
X-Received: by 2002:a62:e21a:0:b029:2de:4440:3a with SMTP id
 a26-20020a62e21a0000b02902de4440003amr28091140pfi.23.1621923036908; 
 Mon, 24 May 2021 23:10:36 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y66sm12812325pgb.14.2021.05.24.23.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 23:10:36 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Fix error handling in virtnet_restore()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com
References: <20210517084516.332-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <782e9d35-99be-b77e-73f7-3291e03d6fe6@redhat.com>
Date: Tue, 25 May 2021 14:10:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517084516.332-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNS8xNyDPws7nNDo0NSwgWGllIFlvbmdqaSDQtLXAOgo+IERvIHNvbWUgY2xlYW51
cHMgaW4gdmlydG5ldF9yZXN0b3JlKCkgd2hlbiB2aXJ0bmV0X2NwdV9ub3RpZl9hZGQoKSBmYWls
ZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNSArKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDdiZTkz
Y2EwMTY1MC4uNWNhN2Q2NzgwYWRkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0zMjUwLDggKzMyNTAs
MTEgQEAgc3RhdGljIF9fbWF5YmVfdW51c2VkIGludCB2aXJ0bmV0X3Jlc3RvcmUoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYpCj4gICAJdmlydG5ldF9zZXRfcXVldWVzKHZpLCB2aS0+Y3Vycl9x
dWV1ZV9wYWlycyk7Cj4gICAKPiAgIAllcnIgPSB2aXJ0bmV0X2NwdV9ub3RpZl9hZGQodmkpOwo+
IC0JaWYgKGVycikKPiArCWlmIChlcnIpIHsKPiArCQl2aXJ0bmV0X2ZyZWV6ZV9kb3duKHZkZXYp
Owo+ICsJCXJlbW92ZV92cV9jb21tb24odmkpOwo+ICAgCQlyZXR1cm4gZXJyOwo+ICsJfQo+ICAg
Cj4gICAJcmV0dXJuIDA7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
