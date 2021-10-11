Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D065C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4438B60F38
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4438B60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08982823DD;
	Mon, 11 Oct 2021 03:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTgFkhn08sth; Mon, 11 Oct 2021 03:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BD49823C0;
	Mon, 11 Oct 2021 03:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 815CBC000F;
	Mon, 11 Oct 2021 03:03:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C2F3C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4588E4012E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxZGiAW-qX5A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E59040121
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633921418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNTJo3xMwhtD2Ct5YhzwdlgtFwaRmbmFekAViw3kEZo=;
 b=XU2Qsvf2HGQTdHSyntUOSsUsJd/KkbS9tYeZNnTpIXzmPvSLxLNWeVpeEsp0bnR4id4Wg2
 H4G5hEZ932SX8W8GYuFl165huSqKhpMUjJnjzN+tncAe03NdF9U8a3I4punbUyMIkF1Agr
 f2lui0yer2QG++d1fbCh7CTTvq1RxT4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-WZyENrKwOP6H4zWFsQcmXw-1; Sun, 10 Oct 2021 23:03:37 -0400
X-MC-Unique: WZyENrKwOP6H4zWFsQcmXw-1
Received: by mail-pf1-f197.google.com with SMTP id
 f16-20020a056a0022d000b0044bbc586598so6638764pfj.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 20:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GNTJo3xMwhtD2Ct5YhzwdlgtFwaRmbmFekAViw3kEZo=;
 b=RFJwdw0QeJ7qdsyM+Upy/UbanWJhpuqJH7NL447GNEzCAEuIPkHpO7OaXWCX3yMNsE
 xKA8ViGMWEohFvF/FNjZQMVfBU8P09ECl3mK0vTpChX93twF8HktuHGAJRTyh2BHJu8o
 k4uH2MZLxqVmSn2BkfMhknef+41nYlhr5CNfaQx+6HULFkvWoI4IjIG61q7f/S4ccaBM
 6EUP/Y+XN6RgjYNkWGZD/l2CGbU80xMEfnIqYZXUrpUkhdUkI0iLm4zbxv10x67cjS1A
 V7XjbEgeMwNRMMl3AC5zyWlCTxzWvT2/jeV9LjYyAhbvKKCoFApiX9e9zYV5M+r0IW59
 Ghog==
X-Gm-Message-State: AOAM531oaTbfNQUjWqTKv51HQf+9CZkadd0IA4H/ph5xmF0Sbcp2d6rm
 4ofZ6L4cbJw8kYR0oicjngCnF8asw0u+i+ZrlBPv6vqReRX/ktbxU9BgQftV4UmmdYie5/aUhhj
 YKZ+TQB/No7/ik1y/x//ZIHONfiiu0rdl94PAv2Wgdg==
X-Received: by 2002:a17:90a:718c:: with SMTP id
 i12mr28009011pjk.182.1633921415789; 
 Sun, 10 Oct 2021 20:03:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq4zA/dNRtVObkbAmXCEJFwrbLkG4kJ1DIqXUVxuOyW2xs/XAp5XD/L+Pi+lC7Rycj6uQiuA==
X-Received: by 2002:a17:90a:718c:: with SMTP id
 i12mr28008982pjk.182.1633921415533; 
 Sun, 10 Oct 2021 20:03:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d67sm6051904pga.67.2021.10.10.20.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Oct 2021 20:03:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] vdpa: fix typo
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <49dc74038cdfaa7af7dab1565ba5da5d6cc4ec7d.1632882380.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9cbeb29f-63ec-9a5d-3614-4da1736806ee@redhat.com>
Date: Mon, 11 Oct 2021 11:03:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <49dc74038cdfaa7af7dab1565ba5da5d6cc4ec7d.1632882380.git.wuzongyong@linux.alibaba.com>
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

CtTaIDIwMjEvOS8yOSDPws7nMjoxMSwgV3UgWm9uZ3lvbmcg0LS1wDoKPiBTaWduZWQtb2ZmLWJ5
OiBXdSBab25neW9uZyA8d3V6b25neW9uZ0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgaW5jbHVkZS9saW51
eC92ZHBhLmggfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUv
bGludXgvdmRwYS5oCj4gaW5kZXggMzk3MmFiNzY1ZGUxLi5hODk2ZWUwMjFlNWYgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
IEBAIC0yNTcsNyArMjU3LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAJc3RydWN0
IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEKPiAgIAkoKmdldF92cV9ub3RpZmljYXRpb24pKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4gICAJLyogdnEgaXJxIGlzIG5vdCBleHBl
Y3RlZCB0byBiZSBjaGFuZ2VkIG9uY2UgRFJJVkVSX09LIGlzIHNldCAqLwo+IC0JaW50ICgqZ2V0
X3ZxX2lycSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHYsIHUxNiBpZHgpOwo+ICsJaW50ICgqZ2V0
X3ZxX2lycSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPiAgIAo+ICAgCS8q
IERldmljZSBvcHMgKi8KPiAgIAl1MzIgKCpnZXRfdnFfYWxpZ24pKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
