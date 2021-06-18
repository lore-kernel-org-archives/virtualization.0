Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB48BC49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:50:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890B961351
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890B961351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD5882F37;
	Fri, 18 Jun 2021 10:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F6GXTDmYA8Fm; Fri, 18 Jun 2021 10:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B38C983770;
	Fri, 18 Jun 2021 10:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 990C3C000F;
	Fri, 18 Jun 2021 10:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31792C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1111D4020A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkjUMLUZ_J0J
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:50:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04CB5400F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:50:37 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id t3so8033928edc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gqS2coF+gzzhxK8JdJrBsn/rp6+MnCzkmwD0939wTww=;
 b=v3Z/or0+7TlFehwd12i21NCIgEp+gh++voW/VIymTVtCQXMzQPvX/oBn0X2zo1xPR3
 KYQgE7FqiiWtiTUV6UUy5IulrfCwlajDLxWmG0ZJiFENdHhgrCjrnuuzIxc+V8YXIvnY
 pCtstbRSLOP/Q8jiqnCqY5PpkaPFLIt1BUODWANOsfuZnhXS7OPVGux5kJgw1mQkUoDi
 QIXJFcMJInFoRgQ3rF0aQ6bRrB1o+zhbn4WWPITxYMutZ4hAYOn0OgEiuYyuYMsawbdT
 VSpigMs9jVQPRW+PksLyNwzH8mNxk1lDYzlF5KJAd51X/ZOLJZaP9AEh7l6Hj7hzCPDa
 umBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gqS2coF+gzzhxK8JdJrBsn/rp6+MnCzkmwD0939wTww=;
 b=INp1/LLWLmQjr+DC3cx8G34Yel5J+nBO9YOyMcungMK0d0xcZn4f+ttacLgNGXXzo+
 CL1zZoYTMriUrfYDweY/QQeqI1dj+JuhlGrhESsr99/NdDYfhIXeoWDUWdo6U5Gqb4Eu
 753moU3k4BOHOaZvpjmz1Wz+/c28G4d125Lb/nrNh5QqWyz8WOf7a3kOAI2y//vsYGz/
 mb9ZasoCTLkA9YZ7SXBUTPt8X4bPrqUAjxaS1MTpjhTISEzp4pbixIoy4HmP6fQ5AMHM
 k7iGJa4XzB7ECfRsQVbnR8xSo3cjQJ7s1v2Uegmd9LUzZlSA/wfCIdv/Dr2esuZyncW6
 hStw==
X-Gm-Message-State: AOAM533rByK3+reRAV3g0Ez/1WTD3oICQmgQwV3fSHW4WrajTH/tH0Mq
 xzRoPkMwaojzAq9LUFkyD8aS8A==
X-Google-Smtp-Source: ABdhPJwkwm0gLmvdkXKWZF4fjbq4g0GvgTenhMIDaNXRpOJoIOA8Ok+A/PIFx3v90WjMUVBRLplXvg==
X-Received: by 2002:a05:6402:42cb:: with SMTP id
 i11mr4009322edc.242.1624013436164; 
 Fri, 18 Jun 2021 03:50:36 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id m17sm863059ejg.96.2021.06.18.03.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 03:50:35 -0700 (PDT)
Date: Fri, 18 Jun 2021 12:50:15 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Message-ID: <YMx6Z8aWBOrFiEcV@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-6-jean-philippe@linaro.org>
 <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com>
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, catalin.marinas@arm.com,
 joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 eric.auger@redhat.com, guohanjun@huawei.com, baolu.lu@linux.intel.com,
 will@kernel.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Wed, Jun 16, 2021 at 06:02:39PM +0100, Robin Murphy wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index c62e19bed302..175f8eaeb5b3 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
> >   	if (domain->type == IOMMU_DOMAIN_DMA) {
> >   		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> >   			goto out_err;
> > -		dev->dma_ops = &iommu_dma_ops;
> > +		set_dma_ops(dev, &iommu_dma_ops);
> > +	} else {
> > +		set_dma_ops(dev, NULL);
> 
> I'm not keen on moving this here, since iommu-dma only knows that its own
> ops are right for devices it *is* managing; it can't assume any particular
> ops are appropriate for devices it isn't. The idea here is that
> arch_setup_dma_ops() may have already set the appropriate ops for the
> non-IOMMU case, so if the default domain type is passthrough then we leave
> those in place.
> 
> For example, I do still plan to revisit my conversion of arch/arm someday,
> at which point I'd have to undo this for that reason.

Makes sense, I'll remove this bit.

> Simplifying the base and size arguments is of course fine, but TBH I'd say
> rip the whole bloody lot out of the arch_setup_dma_ops() flow now. It's a
> considerable faff passing them around for nothing but a tenuous sanity check
> in iommu_dma_init_domain(), and now that dev->dma_range_map is a common
> thing we should expect that to give us any relevant limitations if we even
> still care.

So I started working on this but it gets too bulky for a preparatory
patch. Dropping the parameters from arch_setup_dma_ops() seems especially
complicated because arm32 does need the size parameter for IOMMU mappings
and that value falls back to the bus DMA mask or U32_MAX in the absence of
dma-ranges. I could try to dig into this for a separate series.

Even only dropping the parameters from iommu_setup_dma_ops() isn't
completely trivial (8 files changed, 55 insertions(+), 36 deletions(-)
because we still need the lower IOVA limit from dma_range_map), so I'd
rather send it separately and have it sit in -next for a while.

Thanks,
Jean

> 
> That said, those are all things which can be fixed up later if the series is
> otherwise ready to go and there's still a chance of landing it for 5.14. If
> you do have any other reason to respin, then I think the x86 probe_finalize
> functions simply want an unconditional set_dma_ops(dev, NULL) before the
> iommu_setup_dma_ops() call.
> 
> Cheers,
> Robin.
> 
> >   	}
> >   	return;
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 85f18342603c..8d866940692a 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
> >   static void intel_iommu_probe_finalize(struct device *dev)
> >   {
> > -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> > -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > -
> > -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> > -		iommu_setup_dma_ops(dev, base,
> > -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
> > -	else
> > -		set_dma_ops(dev, NULL);
> > +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> >   }
> >   static void intel_iommu_get_resv_regions(struct device *device,
> > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
