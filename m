Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7060C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 05:58:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61270611CC
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61270611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05A5F401BF;
	Thu, 21 Oct 2021 05:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMYzm_gIoTeW; Thu, 21 Oct 2021 05:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7996540141;
	Thu, 21 Oct 2021 05:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB4AC000F;
	Thu, 21 Oct 2021 05:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20815C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0817440141
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkCMUkLWYhHp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:58:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19DB1400C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:58:13 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id s1so15928529plg.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xCfmwNiGSIU1FWTiYV1xWdNfk6l/Oap6HAgg6fjLReU=;
 b=QfX1KxO1iDmoWlrWX4kmj/ikKGs91ceVH1DNPzMwDs35Nrv4ObEjsLoiF1FocVaOiz
 cRJnikiJTuE0K3RFq8D/NAvMy8x5vaAZOKy+0qkZ12XsRvRwmnLoX/wpKKHWEZWo/ry7
 ZyUlwxLJU2SAZGPAn8Flu3mVIq/B74FSWofr0QzUBxDOdslCuMt/NBHl5Z65Mk9LVvIe
 VvGjJTGawL7iDva1ii96MYLDca4A3W/lK+DL9Bwk6x2m43ztlCbLFputTSZ3IhJmXGOp
 1EEBYCodViTpG/MznXF+icHPMRvRJBv79dW+nvbccVVFOrDJwMbU3ougmVOAiLBfy0EW
 O/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xCfmwNiGSIU1FWTiYV1xWdNfk6l/Oap6HAgg6fjLReU=;
 b=ptWgfuCx3SUNPIGaTDcas+t4n8tmOgO0/RVAu9sSMmrCEpM+ZDIEnAF8JbAspG2xA1
 kpHa3x+o0Wz4uT0DOTgqNawhuFHX9gDmLfx2fEomvvKuj55W+URrX8a8NQREKpfJiget
 Vl8k5SGK1RGYiX0SpbGANWjJ/p1iWdJ/iiXt036jzA7uFGPHqXCDeAUS9ez3Y4u+RxmX
 I1fYgAEpuq+oU30/i1DUr466UFVXjvUJ1GFca9/Evy7NVDk2Ha0Z5U+rSQIAU+FDcE7V
 ijBdGzsdbO/b8hrrTbuhKegDt1t5Lgxd8/lg+4pzoLlvOhtq9OX9Iy5G63inHpo/FySq
 YiWQ==
X-Gm-Message-State: AOAM532QFa+Fu4x0ghbkHsw830YoHNIhxJpIpoSfsQyvshsyQjdnizM7
 L6TdEnLo4cLXbL+ttf/znAozWQ==
X-Google-Smtp-Source: ABdhPJysGXA45YfqU6m6F7iEIFsFMRwo+XnZ6TQLPxUKfVVZ4koslmjfwgQj434dEw6k0qDclNfxRA==
X-Received: by 2002:a17:90a:9b84:: with SMTP id
 g4mr4337506pjp.123.1634795892500; 
 Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id b8sm4305778pfi.103.2021.10.20.22.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
Date: Thu, 21 Oct 2021 11:28:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211021055810.4ivtscmg2rs5dtt4@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <a6cb9ae7-eee3-74aa-87de-a2be3fdc7a76@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6cb9ae7-eee3-74aa-87de-a2be3fdc7a76@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org
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

On 21-10-21, 13:55, Jie Deng wrote:
> Can the backend driver control the time point of interrupt injection ? I
> can't think of
> 
> why the backend has to send an early interrupt. This operation should be
> avoided
> 
> in the backend driver if possible. However, this change make sense if early
> interrupt
> 
> can't be avoid.

The backend driver probably won't send an event, but the notification
event, if it comes, shouldn't have side effects like what it currently
have (where we finish the ongoing transfer by calling complete()).

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
