Return-Path: <SRS0=w7gG=OQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060CC433F5
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 02:27:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E50610C9
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 02:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72E50610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B674828E3;
	Sun, 26 Sep 2021 02:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kF_tfOJiFaCi; Sun, 26 Sep 2021 02:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C411F828AF;
	Sun, 26 Sep 2021 02:26:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90470C000F;
	Sun, 26 Sep 2021 02:26:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30D53C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11CEE403F3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXQh00SdpwWv
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:26:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F215403ED
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632623215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZp3xnAES6bAUGTev2VfXmn+NF0yWoU2lNUUhQffVj0=;
 b=L77moiKVMPlw8SBVLv47MjcaB+NKBO5cFWqiL6JaiEoBvTNHok7PXynkmJPyVcLWPiFzA+
 wYjOsyfNOK3VYKdUzzKR+MvrB9N8UyhZppfLSaSzOgBK36i4UA5OpMfnWGEXeFShBCuBug
 /hTlqF2pmB7Ila28SVbPJh8Pk3VESAs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-QUmq2AUhMhSFkPm6eT_Rhg-1; Sat, 25 Sep 2021 22:26:53 -0400
X-MC-Unique: QUmq2AUhMhSFkPm6eT_Rhg-1
Received: by mail-pg1-f199.google.com with SMTP id
 g15-20020a63564f000000b00261998c1b70so9819880pgm.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Sep 2021 19:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bZp3xnAES6bAUGTev2VfXmn+NF0yWoU2lNUUhQffVj0=;
 b=WcaQVf9OZv0FxZE2MzIyeJMmQ7vC1HawPi074usFFdQlO4BOvNXTqu59b1BioX/DgU
 6p5/OR6q+A8Fb6tKrltzUBSxnYtBmlRxa5fxHlIIRSXXddk94f0rpRiHFZ3AMGzpL9rS
 lFXY1i29dLKJtJPJQU7HfBZUulvCfMiI5euNm5vGPFhM/Qz7VQcUVUN3LMxzdXtFl003
 qCiWswi4TkAcNWJDbYF7kxtLUancgJHaIAp0tzQHWLRrLV4QtwEd0SUxtobKk4nSkqKG
 HSl6XQ2Wui2K2q7UkCMd34ReyvLutWkaSwdX7jvuDw1NuvXmaxWlaFGchnS/Qgi24yAZ
 WWWw==
X-Gm-Message-State: AOAM5325FrcsFDl1GJmxPWi6lfFPIB/jESqOE7gvcZ9o6cQCcWSjR7Xg
 /xpixjko+TM2WZOVy4f/Olre34Yp5oDh96o0MHFTxO4O9p4nZ6A8Ir+rxLOnNAPoIuz8QoDYWuJ
 +TAUz/yS5nmVGloaCCH0h929EAHTRBUx5kipiBBrsfQ==
X-Received: by 2002:a17:90a:6401:: with SMTP id
 g1mr5333392pjj.228.1632623212647; 
 Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7KLo22gZhWpfJgkJwqMH222Hu0zANjiomgMWe6mB4nUvwQfhFNqK79qHgPTDvfLoznGRuRw==
X-Received: by 2002:a17:90a:6401:: with SMTP id
 g1mr5333376pjj.228.1632623212405; 
 Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z62sm15540013pjj.53.2021.09.25.19.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com>
Date: Sun, 26 Sep 2021 10:26:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
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

CtTaIDIwMjEvOS8yMiDPws7nODo0NiwgV3UgWm9uZ3lvbmcg0LS1wDoKPiArCj4gKyNpZmRlZiBf
X0xJVFRMRV9FTkRJQU4KCgpJIHRoaW5rIGRpc2FibGUgdGhlIGRldmljZSB2aWEgS2NvbmZpZyBp
cyBiZXR0ZXIgdGhhbiBsZXR0aW5nIHVzZXIgdG8gCm1lZXQgZXJyb3JzIGxpa2UgdGhpcy4KCihP
ciBpZiB0aGUgZGV2aWNlIGlzIGFsd2F5cyB1c2luZyBsaXR0bGUgZW5kaWFuLCB3ZSBkb24ndCBl
dmVuIG5lZWQgdG8gCmJvdGhlciB0aGlzKS4KClRoYW5rcwoKCj4gK3N0YXRpYyBpbnQgZW5pX3Zk
cGFfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
ICppZCkKPiArewo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKPiArCXN0cnVj
dCBlbmlfdmRwYSAqZW5pX3ZkcGE7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNl
ICpsZGV2Owo+ICsJaW50IHJldCwgaTsKPiArCj4gKwlyZXQgPSBwY2ltX2VuYWJsZV9kZXZpY2Uo
cGRldik7Cj4gKwlpZiAocmV0KQo+ICsJCXJldHVybiByZXQ7Cj4gKwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
