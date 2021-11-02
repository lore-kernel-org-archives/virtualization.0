Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369CAC433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 05:37:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C696760E52
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 05:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C696760E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B3F260727;
	Tue,  2 Nov 2021 05:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjvnD3fvdNYC; Tue,  2 Nov 2021 05:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E7D7606CC;
	Tue,  2 Nov 2021 05:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEA0C0012;
	Tue,  2 Nov 2021 05:37:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 576D9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F5AA40112
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mCR8jwTPhaRo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBD07400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635831414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qlKprhKf9sz/a8k/Ws+tF+ljFLc+MMt1FoHztZKXko=;
 b=TL2egKQd16KGoWi56mxu+X+UKMVcFkk0nkgF5yghxknwoJ72Ak0Zqmp1SjmmjTuRPBu78B
 99vGDGO6ZsO/CkqPgVTDCNDPJH7huNSEA9XJV8xwWtrgRi6Nws9xJ6JPP9Vl+8Zp2wIDw5
 2RYE+u2FaHYhUBrQqYTp/C+Bo2xNeBE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-zGASMYWAOlatsemLcMo1sQ-1; Tue, 02 Nov 2021 01:36:53 -0400
X-MC-Unique: zGASMYWAOlatsemLcMo1sQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 x25-20020aa79199000000b0044caf0d1ba8so10847232pfa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 22:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0qlKprhKf9sz/a8k/Ws+tF+ljFLc+MMt1FoHztZKXko=;
 b=f+CX6VejvKaG1xGHGFtY6LNBaC6HZfB/2FzKNoFtVCd3R22c763siDr53AgK3Uy4+o
 Q9UJqnEyegE4JlFs+V1noIYsPc9X+DJJwfK2T2vjQQYF7vpJwJGAKRgCt+fMhBlol/CH
 l/bMnKAGrz1x95UWQBKYTdiTygCMtCzEIgS2+LbpG650yiUIerIvDqhcPU2ssIfJ68ts
 KYMKJpIjlkfSJeix1sx02jWWzSPX8RdmTYNLIsU1YsAXaeDRKjQ1QOJvQm8j2ugjGQtt
 7U654Wo2jrt5Jur0nyF5qrAfAC8xhNeI1l6MafuRQMM/EZDOVgADy/lVwrxX1d8WOPw9
 FMuA==
X-Gm-Message-State: AOAM532RiNnkfVtwcWdjeJgyVVzUA3ILyPzkuZfMRk7KwBj3BGYxt8pR
 Ryb4G7FGuGAjwB2Ywc+YsZmxGMXr7t+pxj/j+rCrkXFgeyGrHmCCAxvdeFIaIVjkgIgseErqA7H
 ctHt/6HlcKdKW9CsuAWVg6rWRoeJApbUlOUell5xmzfueJ2zoU3loS77PR9PbnXk+Tmc9sk5lX1
 v/LGH56UtFZBuMzGAU7A==
X-Received: by 2002:a62:7642:0:b0:480:fcd3:110e with SMTP id
 r63-20020a627642000000b00480fcd3110emr15479460pfc.39.1635831412198; 
 Mon, 01 Nov 2021 22:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbsGtfjCSSgvkrY6wzYtRSS8vOXpZ1EiZW+RTDW1pLNLNTRLZI94bru6SiR/xlYx9HK4k6Yw==
X-Received: by 2002:a62:7642:0:b0:480:fcd3:110e with SMTP id
 r63-20020a627642000000b00480fcd3110emr15479418pfc.39.1635831411853; 
 Mon, 01 Nov 2021 22:36:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w11sm14887120pge.48.2021.11.01.22.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Nov 2021 22:36:51 -0700 (PDT)
Subject: Re: [RFC PATCH v5 12/26] vhost: Route guest->host notification
 through shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-13-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <59e7f05d-6d1d-8c6f-cdba-d02034b49f20@redhat.com>
Date: Tue, 2 Nov 2021 13:36:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211029183525.1776416-13-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzEwLzMwIOS4iuWNiDI6MzUsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiArLyoq
Cj4gKyAqIEVuYWJsZSBvciBkaXNhYmxlIHNoYWRvdyB2aXJ0cXVldWUgaW4gYSB2aG9zdCB2ZHBh
IGRldmljZS4KPiArICoKPiArICogVGhpcyBmdW5jdGlvbiBpcyBpZGVtcG90ZW50LCB0byBjYWxs
IGl0IG1hbnkgdGltZXMgd2l0aCB0aGUgc2FtZSB2YWx1ZSBmb3IKPiArICogZW5hYmxlX3N2cSB3
aWxsIHNpbXBseSByZXR1cm4gc3VjY2Vzcy4KPiArICoKPiArICogQHYgICAgICAgVmhvc3QgdmRw
YSBkZXZpY2UKPiArICogQGVuYWJsZSAgVHJ1ZSB0byBzZXQgU1ZRIG1vZGUKPiArICogQGVycnAg
ICAgRXJyb3IgcG9pbnRlcgo+ICsgKi8KPiArdm9pZCB2aG9zdF92ZHBhX2VuYWJsZV9zdnEoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsIGJvb2wgZW5hYmxlLCBFcnJvciAqKmVycnApCj4gK3sKCgpXaGF0
IGhhcHBlbnMgaWYgdmhvc3RfdnBkYSBpcyBub3Qgc3RhdGVkIHdoZW4gd2UgdHJ5IHRvIGVuYWJs
ZSBzdnE/IApBbm90aGVyIG5vdGUgaXMgdGhhdCwgdGhlIHZob3N0IGRldmljZSBjb3VsZCBiZSBz
dG9wcGVkIGFuZCBzdGFydGVkIAphZnRlciBzdnEgaXMgZW5hYmxlZC9kaXNhYmxlZC4gV2UgbmVl
ZCB0byBkZWFsIHdpdGggdGhlbS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
