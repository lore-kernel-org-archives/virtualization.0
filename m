Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB49C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:08:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA45C610D1
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45C610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B270883D3F;
	Thu, 15 Jul 2021 08:08:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDaVErCQqHbn; Thu, 15 Jul 2021 08:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63ED0828EF;
	Thu, 15 Jul 2021 08:08:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4511DC001B;
	Thu, 15 Jul 2021 08:08:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE4CC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C959828EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15xz_Rwh4IXz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:08:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3860183BBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626336533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxNNLlcE8rIp3LWzPErIy9f88JTcquKQ1ZhKuQYRNy0=;
 b=MEDz6ib/O7mMGryWf9+FuXYMCT1xZVoB7bYjZ2yL9ezYobZ+JSzX34ojPeMV2qHLwYHxwq
 nNk/mXk87qlTcA2HqEfb0MgRNtOWHmCR281TBJqDBdJutB98zw1nZWpTYX/fNloAhfzm0X
 x/e2Vj6SPCABB1KWfoXtA5RtyMKqAh8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-46eYHGnDPAW4MpWUWoy_TQ-1; Thu, 15 Jul 2021 04:08:51 -0400
X-MC-Unique: 46eYHGnDPAW4MpWUWoy_TQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 k23-20020a17090a5917b02901739510b17fso2841038pji.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NxNNLlcE8rIp3LWzPErIy9f88JTcquKQ1ZhKuQYRNy0=;
 b=L//fVn5lwOBHzCmMq9Oy/a7D4z7POuyr1UB+OPBjDZX5gp6wxxQBzvgQEWz+IPwIux
 4fIZYtGNT8PdtpOQmiP/8t/SkCm3SmkE3MUhxBZC7QBOxcbknI8k2VpDjtd8KGfHiyfE
 leah9TK/orUNkPBJpi3sAERD01Buo6MlMIivfNLtHok/sTjPoIxq+W+qrkvYCfVm75rL
 ghTqCUaPr5hhEM5nkuVpIrh3VDp3Eb1w+TWjN/B6o6EmvjJgY6GxdhA0SH2cNsuc+2Zi
 sEuGEn0u9FtRYGPGf3s0YVltJ0lpESYf1dP8FxGdwLBbk56G4cBLN8nGC7gBM8x746+p
 bJJA==
X-Gm-Message-State: AOAM532TD7wVjBp0e8j4KVzBdpyvgZHzX0V6DHKhuJnQ0WMrAdzcr0nE
 b+l7KAPmx4wvZfPV762m+WABD7oIwA7jfD2t8qaNRnAInN5PX/Lj863HQ7wnaRSJViEZKJFy/fz
 mWqtku60LUwIDAs3eyAZeV5F7iL539fVRSqbCvs00cA==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id
 z14mr3216895pjr.69.1626336530476; 
 Thu, 15 Jul 2021 01:08:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLSNkFoNf94fgb3Hf2PR/IplYN8HZXkYeF3grAaA1yAItdsZ2JSh18gI3qyBKyPG22b00Nw==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id
 z14mr3216870pjr.69.1626336530270; 
 Thu, 15 Jul 2021 01:08:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x26sm5563647pfj.71.2021.07.15.01.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 01:08:49 -0700 (PDT)
Subject: Re: [PATCH 2/4] vp_vdpa: Fix return value check for
 vdpa_alloc_device()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <edde9c7f-69b0-ce8d-de6d-16bad7d52978@redhat.com>
Date: Thu, 15 Jul 2021 16:08:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-2-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8xNSDPws7nNDowMCwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSB2ZHBhX2FsbG9j
X2RldmljZSgpIHJldHVybnMgYW4gZXJyb3IgcG9pbnRlciB1cG9uCj4gZmFpbHVyZSwgbm90IE5V
TEwuIFRvIGhhbmRsZSB0aGUgZmFpbHVyZSBjb3JyZWN0bHksIHRoaXMKPiByZXBsYWNlcyBOVUxM
IGNoZWNrIHdpdGggSVNfRVJSKCkgY2hlY2sgYW5kIHByb3BhZ2F0ZSB0aGUKPiBlcnJvciB1cHdh
cmRzLgo+Cj4gRml4ZXM6IDY0YjlmNjRmODBhNiAoInZkcGE6IGludHJvZHVjZSB2aXJ0aW8gcGNp
IGRyaXZlciIpCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3Jh
Y2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgNCArKy0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92aXJ0
aW9fcGNpL3ZwX3ZkcGEuYwo+IGluZGV4IDdiNGE2Mzk2YzU1My4uZmUwNTI3MzI5ODU3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ICsrKyBiL2RyaXZl
cnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+IEBAIC00MzYsOSArNDM2LDkgQEAgc3RhdGlj
IGludCB2cF92ZHBhX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNp
X2RldmljZV9pZCAqaWQpCj4gICAKPiAgIAl2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3Ry
dWN0IHZwX3ZkcGEsIHZkcGEsCj4gICAJCQkJICAgIGRldiwgJnZwX3ZkcGFfb3BzLCBOVUxMKTsK
PiAtCWlmICh2cF92ZHBhID09IE5VTEwpIHsKPiArCWlmIChJU19FUlIodnBfdmRwYSkpIHsKPiAg
IAkJZGV2X2VycihkZXYsICJ2cF92ZHBhOiBGYWlsZWQgdG8gYWxsb2NhdGUgdkRQQSBzdHJ1Y3R1
cmVcbiIpOwo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICsJCXJldHVybiBQVFJfRVJSKHZwX3ZkcGEp
Owo+ICAgCX0KPiAgIAo+ICAgCW1kZXYgPSAmdnBfdmRwYS0+bWRldjsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
