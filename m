Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51661C4727E
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 08:13:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCECF207C4
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqNxY34q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCECF207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 644FD86D01;
	Fri, 25 Sep 2020 08:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Se2rUxtKZ9w6; Fri, 25 Sep 2020 08:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70FD386CF9;
	Fri, 25 Sep 2020 08:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C88AC0859;
	Fri, 25 Sep 2020 08:13:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3AC6C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E296486D01
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Wqf5AcrIvtQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:13:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A951186CF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:13:04 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id t10so2591417wrv.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H+3WzdqdQFTD9YVJPe0cUi1421BcNuytEOcD1N3pbAA=;
 b=iqNxY34qj1j0Vv2BeallVZbgpm04aSXY4oypqhqgW0QDLuR8mqpJNA1B9Y9UnjdMrl
 zVFiBENE+bjpgYfDjjt2EamF+PHd0FtpAIHypBr4RHDbRo5BFaSpq0F83RDxs+f4HHo5
 68k9OZcMaOtaIDhr0gqewkiOmoFGvJGS1P5b1jz8vHWmvN1aXRfa+DeuVoIK65vvlHJY
 GE8o9OaXY+isCDJSd5Q1GxaXlL3866/Xh8fTBY80W+1hwhaL4rlF/754RIxVkj7JaVXL
 F1eOfIjmFVKkuUgOLFVSWSCoOQkvlur6VP1qVSfjZ+XAsxHVtMU59+vuFJVGFACTiOnK
 Y8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H+3WzdqdQFTD9YVJPe0cUi1421BcNuytEOcD1N3pbAA=;
 b=p2XfPAq4Q9GrkYjZCd9iFADj8ErqXz29B+sk2+8E9HlvtMaEf5+Ad4PvlG6zjnJSg3
 wHLOfyCerdnPP9lNz6rr+o1FjfbRP92MwP6DisgpG/cUHw1HF0DBimfrAE47WkmIt85D
 O+wHn1W4VN+ysyakrzGtGEpTx5DrD1E5CgyRkOnGnLhiCGCILv0zrwwRt1zq0WjZ3uyI
 FRCrvRZi599jhpB44YkF7+vy+tbDm3jRwaMero5BZOuyA191gAnXDskPavQEzCdzyWvW
 aE8yQBFlGrnGKVuu/rDDcEfrBMHvd2wC/38YgU7ehf1FWCpQJJ+6nlPfIfOsc8XhnxzL
 f3pQ==
X-Gm-Message-State: AOAM532eolC0+SayMCRLkhUJa0biokeYIjinLR7hSNVQdZ+ChgBRVfxr
 E8g892lNNKo2It1Cg89siGJi0g==
X-Google-Smtp-Source: ABdhPJzferA03aonshOz4wYiPb6ai1yoyCYdneu0wO9qrUHroSPM0f6AASiRX9eeyY81L6rbKyBxMQ==
X-Received: by 2002:adf:f382:: with SMTP id m2mr2925330wro.327.1601021582974; 
 Fri, 25 Sep 2020 01:13:02 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm1982212wrv.90.2020.09.25.01.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 01:13:02 -0700 (PDT)
Date: Fri, 25 Sep 2020 10:12:43 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200925081243.GA490533@myrica>
References: <20200821131540.2801801-6-jean-philippe@linaro.org>
 <20200924152203.GA2320481@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924152203.GA2320481@bjorn-Precision-5520>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com,
 linux-pci@vger.kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Thu, Sep 24, 2020 at 10:22:03AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:
> > Platforms without device-tree nor ACPI can provide a topology
> > description embedded into the virtio config space. Parse it.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> 
> > +struct viommu_cap_config {
> > +	u8 bar;
> > +	u32 length; /* structure size */
> > +	u32 offset; /* structure offset within the bar */
> 
> s/the bar/the BAR/ (to match comment below).
> 
> > +static void viommu_pci_parse_topology(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +	u32 features;
> > +	void __iomem *regs, *common_regs;
> > +	struct viommu_cap_config cap = {0};
> > +	struct virtio_pci_common_cfg __iomem *common_cfg;
> > +
> > +	/*
> > +	 * The virtio infrastructure might not be loaded at this point. We need
> > +	 * to access the BARs ourselves.
> > +	 */
> > +	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap);
> > +	if (!ret) {
> > +		pci_warn(dev, "common capability not found\n");
> 
> Is the lack of this capability really an error, i.e., is this
> pci_warn() or pci_info()?  The "device doesn't have topology
> description" below is only pci_dbg(), which suggests that we can live
> without this.

At this point we know that this is a (modern) virtio-pci device which,
according to the virtio 1.0 specification, must have this capability. So
this is definitely an error, but the topology description is an optional
feature.

> 
> Maybe a hint about what "common capability" means?

Yes, "virtio-pci common configuration capability" would be more
appropriate

> 
> > +		return;
> > +	}
> > +
> > +	if (pci_enable_device_mem(dev))
> > +		return;
> > +
> > +	common_regs = pci_iomap(dev, cap.bar, 0);
> > +	if (!common_regs)
> > +		return;
> > +
> > +	common_cfg = common_regs + cap.offset;
> > +
> > +	/* Perform the init sequence before we can read the config */
> > +	ret = viommu_pci_reset(common_cfg);
> 
> I guess this is some special device-specific reset, not any kind of
> standard PCI reset?

Yes it's the virtio reset - writing 0 to the status register in the BAR.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
