Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4711C48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:20:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8688D6109D
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8688D6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41F80401AD;
	Fri, 18 Jun 2021 07:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-vi7Forau40; Fri, 18 Jun 2021 07:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFB92401F2;
	Fri, 18 Jun 2021 07:20:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C552C000D;
	Fri, 18 Jun 2021 07:20:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1BEC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06C6B605BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q04OGWwdCCkN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE737605B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624000830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08bKtYLw8+WJMSJXFwmWg9TmqP7htBCNATjR/bZl300=;
 b=al7hTH5aExYcvVRrXULF4OoQvo/fHV1SohNltk1O29F4pbOYJcb8sOssb7EeCrRbikb6wr
 R43YR+xwQyXnR4ItNDYkfIgiWW1LGkO658iHGnVULX8Sk5yqDj0KfVdHOelEb7q+jvVlc5
 Fx/5OwTjQ6/7GyT9TgiCzztheZUk6Bg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-nHDXRhH8O3-K1fHeDsAgGw-1; Fri, 18 Jun 2021 03:20:27 -0400
X-MC-Unique: nHDXRhH8O3-K1fHeDsAgGw-1
Received: by mail-pg1-f200.google.com with SMTP id
 k193-20020a633dca0000b029021ff326b222so5422593pga.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 00:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=08bKtYLw8+WJMSJXFwmWg9TmqP7htBCNATjR/bZl300=;
 b=alejdm9VIeP8D+TpucFuLq5ST/VUz58jVON6RP/6FiuIV+ToZdKfOtGDsLNE/EDRID
 u1YoPH5KQRodEILf/rFqP6wNnwHDF7y1KT3Q0klPi1oRv0Q2TY3zG9oQaGlKVnJdtrNa
 E0yJOqAYITjHOJvz2zwD2v9IsU5eO+c8v2s0TBcUBJjNu6YF7gMHJ/2ddTscga76GYv1
 mFWRpDx3R8A964DxXY5gzHOLaJmIclcugn+bSv2/vOJLI1iE9V/Nvdvk+O3blYqFFB8J
 I56zBX9q7MQ9/xtkROahFxuLE4i42gcDEI2DVIHDXjU3c27ilTGcVB156pyP6+5lZJPb
 QCEw==
X-Gm-Message-State: AOAM533QwS1WZ8xojlElvbfGkJwG4ywRKYOTBVhjZmsrILmqGPGy6ODD
 iBwDTfsEjGXRsph8mU9IFWO7d5QBo5e8JYxzaFkHW7+wCGcK7i8FHUSq9ZaNsnEjVkVlLUUS3ue
 WU6zSrMaA5Pyfc9IFW4i3xPJ3q1x8yZ5Cq8wcd2X0uQ==
X-Received: by 2002:a63:5d5:: with SMTP id 204mr8666307pgf.72.1624000826236;
 Fri, 18 Jun 2021 00:20:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEQkh9qhMUesoxoT0WlU7iHzOuiibkI62nhu2NHrn8HyNbptwaeYz6rc1kpnZvt7mx+SI2wg==
X-Received: by 2002:a63:5d5:: with SMTP id 204mr8666288pgf.72.1624000826020;
 Fri, 18 Jun 2021 00:20:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d92sm7246815pjk.38.2021.06.18.00.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jun 2021 00:20:25 -0700 (PDT)
Subject: Re: [PATCH] vhost-vdpa: fix bug-"v->vqs" and "v" don't free
To: Cai Huoqing <caihuoqing@baidu.com>, mst@redhat.com
References: <20210618065307.183-1-caihuoqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5f046ae5-2a1a-e843-bcae-f16ac0167c0e@redhat.com>
Date: Fri, 18 Jun 2021 15:20:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618065307.183-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNi8xOCDPws7nMjo1MywgQ2FpIEh1b3Fpbmcg0LS1wDoKPiAidi0+dnFzIiBhbmQg
InYiIGRvbid0IGZyZWUgd2hlbiAiY2Rldl9kZXZpY2VfYWRkIiByZXR1cm5zIGVycm9yCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDYWkgSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gaW5kZXggZmI0MWRiM2RhNjExLi42ZTVkNWRmNWVlNzAgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
IEBAIC0xMDY1LDYgKzEwNjUsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvYmUoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgCj4gICBlcnI6Cj4gICAgICAgICAgcHV0X2RldmljZSgm
di0+ZGV2KTsKPiArICAgICAgIGtmcmVlKHYtPnZxcyk7Cj4gKyAgICAgICBrZnJlZSh2KTsKCgpJ
c24ndCB0aGlzIHRoZSBjaGFyZ2Ugb2Ygdmhvc3RfdmRwYV9yZWxlYXNlX2RldigpPwoKVGhhbmtz
CgoKPiAgICAgICAgICByZXR1cm4gcjsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
