Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D8C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:32:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4EF60F56
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D4EF60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE12F60B97;
	Tue, 31 Aug 2021 06:32:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jb9uLgyW8_Et; Tue, 31 Aug 2021 06:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F695608D1;
	Tue, 31 Aug 2021 06:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD67C0010;
	Tue, 31 Aug 2021 06:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEA0DC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C358E81AF5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CsQSJ7iDlo3p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:31:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E854781AD7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:31:51 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 mw10-20020a17090b4d0a00b0017b59213831so1252096pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wx1FDrVHCRBqDvRaHXak7M9kfgXHCkU5zPaASGw2oLA=;
 b=aPJa2N2MY5Z7BKQF5gTAMAyTuN7gxdROFNru4ixmqR+6K6Eai7JK6GVv6IMqPYTQPm
 4woSXX6gnH0ZuFC+om9Bf8Or74CTSzg+74vMPY2T6kMxDYNIrKYjVocVCRo8e2qwiArE
 xWYvlUBy5P99Ix1QLLKagMn8X9VqOJ8f/JOlGz9poVdbWDKGvTHTiBtcPaKqLDvYCq6D
 HXI7K9qLNpnswBYh9p7MHorx65FTSxNO3oio2RIdYTG7XlPCcZJJDVUtkyENwTtpahCk
 TqUPv05fcWpSQ5y036aYs3PKvLN6+Z6oS5LGBCU8t+OT41qByaH40rSpslzEEMdN+KpE
 BkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wx1FDrVHCRBqDvRaHXak7M9kfgXHCkU5zPaASGw2oLA=;
 b=n6V2LFe5OWAckMwbQTHXw54ErPFdp7Uq4DCLaDuiNFZ+gDkBI8D1REqj8xi8vExdF2
 frUIYc++7H0DIifpRb3+QESuIkmYhOKSXaOTZT/qKr4x7mzwcmbTSCgR7gMNLt5YLDsB
 HxaiJDDR/KZdi7/EE6yPsW9ftwbk/mFYvxwga4o1HolHkf9roQ2pnr6FcmByyiHe4k/Z
 Za2JHy0yI3fbEDjaENkjWWI8Q2LK83jDnf/X+M7Y7N+ZX+5kf6tpq0oeoUcLLUj3VdWt
 tFKoyHL/+bwv3PYcFubWAUv1UpSo8YQt6S4OM+1bPfiscQLyfR5Uyd8U8qy6TuweVWq0
 M2sw==
X-Gm-Message-State: AOAM531ca4DBKzuUwllNG4PV1fmhvcVMOEDpYX5hIprP84eksSwMMAxE
 40OMKNFnP4RaSEnjguo8vkVUbw==
X-Google-Smtp-Source: ABdhPJzwbDvXXfhIxrp8QSQqB48TnUI6F5NGl+r7oFXzRWGJBYGkY92yx00/9g0/BBpLhMowfwv1hg==
X-Received: by 2002:a17:90a:6a01:: with SMTP id
 t1mr3496203pjj.31.1630391511361; 
 Mon, 30 Aug 2021 23:31:51 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id z67sm16827221pfb.169.2021.08.30.23.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 23:31:50 -0700 (PDT)
Date: Tue, 31 Aug 2021 12:01:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] gpio: virtio: Fix sparse warnings
Message-ID: <20210831063149.gcctzqtn635mn3wb@vireshk-i7>
References: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
 <20210831022224-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210831022224-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 kernel test robot <lkp@intel.com>, linux-gpio@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On 31-08-21, 02:25, Michael S. Tsirkin wrote:
> On Tue, Aug 31, 2021 at 10:59:25AM +0530, Viresh Kumar wrote:
> > Fix warnings reported by sparse, related to type mismatch between u16
> > and __le16.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I'm not sure which tree has the above commit - can this be squashed?

It has gone via the GPIO tree:

https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/log/?h=gpio/for-next

I believe it can be squashed, Bartosz can confirm the same though.

> Also, the driver lacks a MAINTAINERS entry - we want at least
> L:      virtualization@lists.linux-foundation.org
> on all virtio drivers.

Sure, I will send a patch for that.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
