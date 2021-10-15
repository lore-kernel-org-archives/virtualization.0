Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F3C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FEB6115C
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1FEB6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DE3883B32;
	Fri, 15 Oct 2021 08:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ox6x9w2fdM9P; Fri, 15 Oct 2021 08:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 526EA83AAF;
	Fri, 15 Oct 2021 08:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3837BC000F;
	Fri, 15 Oct 2021 08:22:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF70C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D8E060794
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIdMZhgmDccl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDA60607C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634286138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hVtSE3UAjwBOXw7iqPb3EiCk271xlAhTvppR9x36J8=;
 b=NGqLFdDnQCOgwDPqK9XQy175Z1gAmRO61mcSGFTQKqtcdwtqp7LHWX1jDDYNHUQQBWqJ4F
 s5oFPR6vEXNNpOplSFhU6xTXOzIlDrB/NaD60AXohrqvmVmafA/0gBxdUXCckg9WG0mcP4
 lMSSdRRDSYZBjz7F9BgU6vRPTvd4aNE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-QgpG3RFNPFiQWQQPelT-wA-1; Fri, 15 Oct 2021 04:22:17 -0400
X-MC-Unique: QgpG3RFNPFiQWQQPelT-wA-1
Received: by mail-pf1-f200.google.com with SMTP id
 c123-20020a621c81000000b004446be17615so4934787pfc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/hVtSE3UAjwBOXw7iqPb3EiCk271xlAhTvppR9x36J8=;
 b=SB4nOb62Xb7upPVy7eI7dl0bXNf+OhDQ0OkzLVE6DnTiyXvjSavC9EQVYHc/OaB0mH
 q27o3J6njDM16XeN5EaAd5r3ZWrYFT5VGYIPfzjdCrOuzLUslWqSHkqF5tRpaJMXmjS9
 eEX7aUzIJ4diWtp7pJYcDDzIMJ+Djkkv6jKRiaCklXST3NI+YTxaOcAE5pE3+argo3wy
 s2PSl7JhKak/yUjP2Wx+fpqc25UTnY2e/JpM1DUlqB4GlZJ2ChBdQ51tu7lGAvuQTVeZ
 sPXZPugfm6mfIZw9Qy3hctr77iYTyMcltL482PZ26ZeHeyC3bgwziqUA7j619yLGFGCK
 EVSA==
X-Gm-Message-State: AOAM533up1OXJgiQ7kMj9xU3+Aw4SD6r12NGI9v9iCSDvLEJE/1P+PBR
 NCpD91whSDp0t+J0UwzgY7vjCEDjj1MoA55ggSkfo00S+Sua7Lzw9UTadbXWLGatH3NfGZLJY3t
 vgAB93v96BfDgr/+ZykmuN6b2rFeBDqPpflgC30XZuQ==
X-Received: by 2002:a05:6a00:1883:b0:44c:e073:f2ce with SMTP id
 x3-20020a056a00188300b0044ce073f2cemr10065108pfh.37.1634286136498; 
 Fri, 15 Oct 2021 01:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrC0PzzXQnPwaFNb+dmRT5iTWFhKV0XBcPLsrEtEELLmF3JRURWafF67rkt2hIgZ25jkwhrw==
X-Received: by 2002:a05:6a00:1883:b0:44c:e073:f2ce with SMTP id
 x3-20020a056a00188300b0044ce073f2cemr10065073pfh.37.1634286136192; 
 Fri, 15 Oct 2021 01:22:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id oo9sm4771857pjb.53.2021.10.15.01.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:22:15 -0700 (PDT)
Subject: Re: [PATCH v5 1/8] virtio-pci: introduce legacy device module
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <17a38d70dd6f598f98eca68731746b6945a36d36.1634281805.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d6f47283-2bbf-e7b8-f52b-776914eb3015@redhat.com>
Date: Fri, 15 Oct 2021 16:22:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <17a38d70dd6f598f98eca68731746b6945a36d36.1634281805.git.wuzongyong@linux.alibaba.com>
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

CtTaIDIwMjEvMTAvMTUgz8LO5zM6MTQsIFd1IFpvbmd5b25nINC0tcA6Cj4gK3ZvaWQgdnBfbGVn
YWN5X3NldF9xdWV1ZV9lbmFibGUoc3RydWN0IHZpcnRpb19wY2lfbGVnYWN5X2RldmljZSAqbGRl
diwKPiArCQkJCXUxNiBpZHgsIGJvb2wgZW5hYmxlKTsKCgpTaW1pbGFyIHRvIHByZXZpb3VzIG9u
ZSwgdGhpcyBmdW5jdGlvbiBpcyBub3QgaW1wbGVtZW50ZWQgaW4gdGhpcyBwYXRjaC4KClRoYW5r
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
