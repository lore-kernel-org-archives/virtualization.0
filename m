Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E85C6FA90
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 10:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DE8281495;
	Wed, 28 Sep 2022 10:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DE8281495
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1rmZdJ/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXaEco48DTCc; Wed, 28 Sep 2022 10:49:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B10FC81435;
	Wed, 28 Sep 2022 10:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B10FC81435
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81BCAC0032;
	Wed, 28 Sep 2022 10:49:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3815C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DA6881495
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DA6881495
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qenDjOIV6ggU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:49:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 487D181435
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 487D181435
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:49:20 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-127dca21a7dso16711186fac.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=K8J6h2C+8OvW8618gBgSinEb38C/HjqL0U9cL5CPULs=;
 b=1rmZdJ/kUw5GsNBKd0/4G79wW74ExGAGV74ZxAlyrnIKpYZJ99lNFnmjS2JUrmGCiV
 s9w5WkgRkdGO7lm5APnCHmZkfTIhUpuQgA8rEnn9mBAQyPGyueoP6sShFhN/Kr3MHqh9
 QEL29dfZcdT7aXZeU93/7waItGq2fO9B5zD5VR38A2Y1qNY+Xdzzf92TfGcBUJV6iIC8
 k0dWIRfCxSgggfrQufA46zvJ8zpWsN/J+3tacMwIaAWsDQ7a0SyHt0Lou8qiYNmchqmm
 57kTctxk0cL+6VKCvgRxpIP6htOV5zUdRpep4XmV5bSK88RHzTE1dIh4DGXT6UsiOlsw
 nL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=K8J6h2C+8OvW8618gBgSinEb38C/HjqL0U9cL5CPULs=;
 b=69ymZV2VCbpUU3J6ZIpScoK/erQRSOSE8KRZ3yaMNPqgFgiSyhR0b7fHDa5fi70QBj
 7XLdl0n15crE5w3TERvslg9AWuJU2duu+Fg6Bggfhg3ja3MZ8YERlKfisDFvwqAnM3GT
 DsPZ3axf9Ypq7fSi7ZFsqtogterONwQSe3FvAAZcJUPYyAFC8yGhJpVzq3lVppMAbiVz
 xQp5zXQSzKKU5BSp1huhyP7C0WMC3uj4UStwA1R/2pbgfnaFq5ya1QUMy2+MIhCjpH67
 w3UfCpkakNrENZOW4pt97Nftj589oKviVowO+2YzT56MPfi3prsQ6Hc3AiQ5+m0Bqe32
 6WUg==
X-Gm-Message-State: ACrzQf03MCTM4/XLHfCrmrDXXQ7fxDO030tUatL1JUg3OzXsG3ZPBZr/
 Kb1a3aW9LD4ymN3jyG2IYQP5XRrTBTlz1frhqNr9+Q==
X-Google-Smtp-Source: AMsMyM5NAg5hiskifyx3oX9myOocnRo/RptfziCPRzBCaHJ6BahdNB/5KwDbF6tiUfXXHlXm7RbnShfjm0f7OdjDxFY=
X-Received: by 2002:a05:6870:f110:b0:127:3735:8e19 with SMTP id
 k16-20020a056870f11000b0012737358e19mr4956469oac.273.1664362159288; Wed, 28
 Sep 2022 03:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
In-Reply-To: <YyyfJQo7N/iMPLNP@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 28 Sep 2022 13:48:43 +0300
Message-ID: <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
To: mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> What I worry about is that down the road we might want to add
> special meaning to currently unused values.
> If doing that just clears VIRTIO_BLK_F_SECURE_ERASE then
> we have forward compatibility. If it fails probe then we
> won't be able to do use these values.


They are not exactly unused, we are using them to calculate the
"discard sector alignment" and the "max discard sectors" values.
The values are even used directly if VIRTIO_BLK_F_DISCARD is not negotiated.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
