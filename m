Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91812C6377D
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 10:32:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D626128A
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 10:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D626128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA72B82A0E;
	Thu, 22 Jul 2021 10:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cnls5bLSqBbs; Thu, 22 Jul 2021 10:32:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 97307828F7;
	Thu, 22 Jul 2021 10:32:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CD9C001A;
	Thu, 22 Jul 2021 10:32:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49EA4C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 10:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4217682A0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 10:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Euf1hyoHDHMs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 10:32:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AA11828F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 10:32:17 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id my10so5535945pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nQ1eEZRSLoztR9oGZiRIl6wZybSjsReiwmSu0q04ypY=;
 b=Tzy7i8uBqDU5WkjECLstHTLuMa2ll1zWDSUtwXWnN97OOuCMXw+wdLllSBaRx9D84I
 Adzlr7jk7Iynjp7Xn00A/jm6WyHNCkPJvEg16R3ciXOQX6IF3BRgs2ni0zTdH+PzdZu2
 +W0Hrrb8qZeDnRcMAworXLZhjLfxSpWmhyBEmxAK7/f5XsQv5EF7fSjEsBvMU3MX/9qq
 wjVLPyiszIUBf/bu8s1blJHgIzi66lCZCsPBS3gI7DIaFjv4JYXTADz2y0/4lzO1/VAd
 1W7q2Ruc5bI7k5VtykqM04f6qsLu+8lIE6MrJ66LSqBSzP/HNYEZkFK+r0TIrVBqslr5
 +alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nQ1eEZRSLoztR9oGZiRIl6wZybSjsReiwmSu0q04ypY=;
 b=H870TVdeAqiCixTPN2g0dfnyxXXjKt+1Og1kHGL+OquxN76yfnX2DheAabrwdViIpd
 j8mSSjiEEtajxvl0EXdl6aznqyVEQJdp+qSa4oXbSdOPmO/uXG6t556323pbYp2Z3SNI
 a8WgY7zQ3vX/7BZnSVMOAqHa8XUhEbD44mkhKwR4+8BVUNe18/f5WFSPs2HqQDEfIv5A
 tfF6uL8eHM7nUzoIwupUMrNHpnpUWRd7F/ZMCDQNYP32iqFokO0NTeIkW/NoqGZ9fSfD
 fI41aEH+8RI7jxK/fckupvvUC28Nq1F1+6TADO/EJC4KYCe0+TBmoF5fw6Mqhr8A5uvJ
 4luQ==
X-Gm-Message-State: AOAM532srsT6tOu5MJjFQjYkV3C495ohkIm+FVCS5p8qTekanuqnvkEH
 aGodJXGEdI3eiHy0Jye032+PHw==
X-Google-Smtp-Source: ABdhPJyUM0Nh/ZZU8PlUBD7bVExz4En72F/n5jCdD9fyns8C1FqeX/qL28P0ibWHtUrOdOvk8BwMIQ==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr40288329pgv.398.1626949936590; 
 Thu, 22 Jul 2021 03:32:16 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id r128sm1625271pfc.155.2021.07.22.03.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 03:32:16 -0700 (PDT)
Date: Thu, 22 Jul 2021 16:02:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V2 1/5] dt-bindings: virtio: Add binding for virtio devices
Message-ID: <20210722103214.vwdsaj6577pi4bdz@vireshk-i7>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
 <fced2f2b9dcf3f32f16866d7d104f46171316396.1626947324.git.viresh.kumar@linaro.org>
 <CAK8P3a1jqtu1BJmnfFLEgNXsPCfiTzd0sxwJBxdgNySmETBQSg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1jqtu1BJmnfFLEgNXsPCfiTzd0sxwJBxdgNySmETBQSg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, DTML <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On 22-07-21, 12:28, Arnd Bergmann wrote:
> On Thu, Jul 22, 2021 at 11:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Allow virtio device sub-nodes to be added to the virtio mmio or pci
> > nodes. The compatible property for virtio device must be of format
> > "virtio,<DID>", where DID is virtio device ID in hexadecimal format.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Looks good to me overall. One question would be for the exact format of
> the 'compatible' string. After seeing this version, I would slightly prefer
> "virtio,device22" over "virtio,22". I think in the previous version
> we had mentioned both, but not actually decided on which one to use.

Right, so there were few doubts I had.
- Should I use "device" as well or not.
- Should I use hex value or decimal.

I went with what's already done with USB/PCI, and so dropped device
and used hex values.

I don't have any strong opinions about using or dropping "device", I
am fine with whatever You/Rob suggest.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
