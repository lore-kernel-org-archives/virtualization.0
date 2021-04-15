Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB8FC43461
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:32:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C8461139
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25D6660655;
	Thu, 15 Apr 2021 14:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqc8FBA8zhP7; Thu, 15 Apr 2021 14:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 901F4605D3;
	Thu, 15 Apr 2021 14:32:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28C24C0014;
	Thu, 15 Apr 2021 14:32:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97BE7C000C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 743CC605EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2C4wKJaA0MJK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:32:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CB75605D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:32:21 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id u17so37214584ejk.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=L82sLuZY0ugbSU18HFCt4zSNof75oOUHwMqo8db7PQo=;
 b=XC47iwRnhn5XxvNoHrSMRTYvMmyylMQea6n3cWehQolID7mQODwsyWFXqzyKtpD4cs
 y8lOrmekf/VJB7hm75G9IUitAhmx4d+XZd+tjHGu3aWmW+aDmt4abDn+Ynv/ewsMjD7A
 tB0toxYzfUjG+MkdueLYPSPI/1KP93N1NvBZrUlvpN5zAT23UL15VsLC7gUs3VSdkeGC
 ytoBapMgadlW/VJrxUHk3dQInzWu4OnHiXIZR9z98djB2162qBKMTn2JtUAfdO+7x8wF
 DNzNM51J/DAqBEYV3l6a7zY+vpSzDa8a1ysLpVwehMew50NF6/0lqnr/LH1SzT/P5/2l
 AkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L82sLuZY0ugbSU18HFCt4zSNof75oOUHwMqo8db7PQo=;
 b=lwRuicxIL0ikIr+GW10gELKBfYMmxb90wW4ds3tZqVnJwzT0Kfd5wb5bpiZiB4f859
 qvu/Gl9BQNlMo7sPZZCctb+nLUJTcIByjgSR5zPkmHDr0KRL3NLvXBoHqM8DMI9kJCDz
 6SrpK5d61pNBrlImP6kP6VjRTHf8qBeb7KcwN+jSKQj9n+ktKP8joDr7x19icIp2df19
 nKUd3QGthOiojViLik3tNCCH/xeMN7YRebMZoVhRqE3WnAQS/300B0QNYKHRj0WJd3U0
 fAd8U7x17jpTqm+Z6Q1+yQTJZLUo0MU/FyY0YZ7BVfhZ5hm2UVnlYpwwg6E1sY2CL8xG
 mxxg==
X-Gm-Message-State: AOAM5325wfL4cDzFWLLaR+CmNI1IOpJ/lHJ+SG/mbxKjIrQ8q+9u5FYE
 O8ABs3lrjHn6/X2zME36RjniAg==
X-Google-Smtp-Source: ABdhPJz9xJvjMDtMrGsFu9juT6y5sozB8e2gd0vOrar2nkBQBIR6iW9LlDQfSnkGDtNTNQcx16PR0g==
X-Received: by 2002:a17:906:32d1:: with SMTP id
 k17mr3752201ejk.94.1618497139334; 
 Thu, 15 Apr 2021 07:32:19 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o17sm1975482edt.92.2021.04.15.07.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 07:32:18 -0700 (PDT)
Date: Thu, 15 Apr 2021 16:31:59 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
Message-ID: <YHhOX6yZi1bxifDp@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
 <2f081b8f-98e2-2ce1-6be6-bb81aab8e153@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f081b8f-98e2-2ce1-6be6-bb81aab8e153@arm.com>
Cc: mst@redhat.com, joro@8bytes.org, rjw@rjwysocki.net,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org,
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

On Thu, Mar 18, 2021 at 07:36:50PM +0000, Robin Murphy wrote:
> On 2021-03-16 19:16, Jean-Philippe Brucker wrote:
> > The ACPI Virtual I/O Translation Table describes topology of
> > para-virtual platforms. For now it describes the relation between
> > virtio-iommu and the endpoints it manages. Supporting that requires
> > three steps:
> > 
> > (1) acpi_viot_init(): parse the VIOT table, build a list of endpoints
> >      and vIOMMUs.
> > 
> > (2) acpi_viot_set_iommu_ops(): when the vIOMMU driver is loaded and the
> >      device probed, register it to the VIOT driver. This step is required
> >      because unlike similar drivers, VIOT doesn't create the vIOMMU
> >      device.
> 
> Note that you're basically the same as the DT case in this regard, so I'd
> expect things to be closer to that pattern than to that of IORT.
> 
> [...]
> > @@ -1506,12 +1507,17 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >   {
> >   	const struct iommu_ops *iommu;
> >   	u64 dma_addr = 0, size = 0;
> > +	int ret;
> >   	if (attr == DEV_DMA_NOT_SUPPORTED) {
> >   		set_dma_ops(dev, &dma_dummy_ops);
> >   		return 0;
> >   	}
> > +	ret = acpi_viot_dma_setup(dev, attr);
> > +	if (ret)
> > +		return ret > 0 ? 0 : ret;
> 
> I think things could do with a fair bit of refactoring here. Ideally we want
> to process a possible _DMA method (acpi_dma_get_range()) regardless of which
> flavour of IOMMU table might be present, and the amount of duplication we
> fork into at this point is unfortunate.
> 
> > +
> >   	iort_dma_setup(dev, &dma_addr, &size);
> 
> For starters I think most of that should be dragged out to this level here -
> it's really only the {rc,nc}_dma_get_range() bit that deserves to be the
> IORT-specific call.

Makes sense, though I'll move it to drivers/acpi/arm64/dma.c instead of
here, because it has only ever run on CONFIG_ARM64. I don't want to
accidentally break some x86 platform with an invalid _DMA method (same
reason 7ad426398082 and 18b709beb503 kept this code in IORT)

> 
> >   	iommu = iort_iommu_configure_id(dev, input_id);
> 
> Similarly, it feels like it's only the table scan part in the middle of that
> that needs dispatching between IORT/VIOT, and its head and tail pulled out
> into a common path.

Agreed

> 
> [...]
> > +static const struct iommu_ops *viot_iommu_setup(struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct viot_iommu *viommu = NULL;
> > +	struct viot_endpoint *ep;
> > +	u32 epid;
> > +	int ret;
> > +
> > +	/* Already translated? */
> > +	if (fwspec && fwspec->ops)
> > +		return NULL;
> > +
> > +	mutex_lock(&viommus_lock);
> > +	list_for_each_entry(ep, &viot_endpoints, list) {
> > +		if (viot_device_match(dev, &ep->dev_id, &epid)) {
> > +			epid += ep->endpoint_id;
> > +			viommu = ep->viommu;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&viommus_lock);
> > +	if (!viommu)
> > +		return NULL;
> > +
> > +	/* We're not translating ourself */
> > +	if (viot_device_match(dev, &viommu->dev_id, &epid))
> > +		return NULL;
> > +
> > +	/*
> > +	 * If we found a PCI range managed by the viommu, we're the one that has
> > +	 * to request ACS.
> > +	 */
> > +	if (dev_is_pci(dev))
> > +		pci_request_acs();
> > +
> > +	if (!viommu->ops || WARN_ON(!viommu->dev))
> > +		return ERR_PTR(-EPROBE_DEFER);
> 
> Can you create (or look up) a viommu->fwnode when initially parsing the VIOT
> to represent the IOMMU devices to wait for, such that the
> viot_device_match() lookup can resolve to that and let you fall into the
> standard iommu_ops_from_fwnode() path? That's what I mean about following
> the DT pattern - I guess it might need a bit of trickery to rewrite things
> if iommu_device_register() eventually turns up with a new fwnode, so I doubt
> we can get away without *some* kind of private interface between
> virtio-iommu and VIOT, but it would be nice for the common(ish) DMA paths to
> stay as unaware of the specifics as possible.

Yes I can reuse iommu_ops_from_fwnode(). Turns out it's really easy: if we
move the VIOT initialization after acpi_scan_init(), we can use
pci_get_domain_bus_and_slot() directly and create missing fwnodes. That
gets rid of any need for a private interface between virtio-iommu and
VIOT.

> 
> > +
> > +	ret = iommu_fwspec_init(dev, viommu->dev->fwnode, viommu->ops);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	iommu_fwspec_add_ids(dev, &epid, 1);
> > +
> > +	/*
> > +	 * If we have reason to believe the IOMMU driver missed the initial
> > +	 * add_device callback for dev, replay it to get things in order.
> > +	 */
> > +	if (dev->bus && !device_iommu_mapped(dev))
> > +		iommu_probe_device(dev);
> > +
> > +	return viommu->ops;
> > +}
> > +
> > +/**
> > + * acpi_viot_dma_setup - Configure DMA for an endpoint described in VIOT
> > + * @dev: the endpoint
> > + * @attr: coherency property of the endpoint
> > + *
> > + * Setup the DMA and IOMMU ops for an endpoint described by the VIOT table.
> > + *
> > + * Return:
> > + * * 0 - @dev doesn't match any VIOT node
> > + * * 1 - ops for @dev were successfully installed
> > + * * -EPROBE_DEFER - ops for @dev aren't yet available
> > + */
> > +int acpi_viot_dma_setup(struct device *dev, enum dev_dma_attr attr)
> > +{
> > +	const struct iommu_ops *iommu_ops = viot_iommu_setup(dev);
> > +
> > +	if (IS_ERR_OR_NULL(iommu_ops)) {
> > +		int ret = PTR_ERR(iommu_ops);
> > +
> > +		if (ret == -EPROBE_DEFER || ret == 0)
> > +			return ret;
> > +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> > +		return 0;
> > +	}
> > +
> > +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> > +	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, attr == DEV_DMA_COHERENT);
> > +#else
> > +	iommu_setup_dma_ops(dev, 0, ~0ULL);
> > +#endif
> 
> Duplicating all of this feels particularly wrong... :(

Right, I still don't have a good solution for this last part. Ideally I'd
implement arch_setup_dma_ops() on x86 but virtio-iommu alone isn't enough
justification and changing DMAR and IVRS to use it is too much work. For
the next version I added a probe_finalize() method in virtio-iommu that
does the same as Vt-d and AMD IOMMU on x86. Hopefully the only wart in the
series.

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
