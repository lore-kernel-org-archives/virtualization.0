Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C4AC433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 08:40:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6C8207DA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRYysz8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6C8207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B23688524;
	Fri, 21 Aug 2020 08:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxHhTZkxw4aU; Fri, 21 Aug 2020 08:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4419F8846E;
	Fri, 21 Aug 2020 08:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C7EAC07FF;
	Fri, 21 Aug 2020 08:40:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28505C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 170B18869D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1MawhYFsfQ-N
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0F2C588699
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:40:00 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id qc22so1388819ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XadaanCr4lDO+zLVqWWUMPb1BVlfqUxXq/ClehyNMJE=;
 b=HRYysz8OrEROQJ+s0ZlS9JhcEJ84ZPeORKAXDPtjU4NIM31gA5GvMBD9MxnqNLhaIC
 lsGVes1QCLYuP78wbfFbNycx8Surhm2k/xSV85puFaZr8NxnFmO4RGcldl5WYiC5Scag
 9W3SPqSl1jYgL8OPg7yAk6327TcJU2/TieHHNnlbPYrJz/khiVdz40lijkIySn/ow5cr
 itMajhJhz7RByWWbXnBD9kyWlfliVib5gPhn0DgtLQBQaxvaaQ4OQmNuLTWmn0Le7/+f
 0n8RNP6S5LCsVs4kjPremaLB3J9atTJk/9q03GFvHSfidPEAiKEMTqwHh2+qnyj4dCYw
 My5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XadaanCr4lDO+zLVqWWUMPb1BVlfqUxXq/ClehyNMJE=;
 b=Bts9bMKmlJU/PIgfyCGwYhd8YL+MBWxzh3jrXywIIfyDFWLypgHlWUL2p7c92NK9L5
 QO+PfebjU1eVF/XDxhPRy/9iQ+McrP4yEulwxJx9jxxhqHKdXB19OGZdLFekDI+v5DjQ
 EX+iHRDXU3Jcf4eembaLNX+gE3pw8+h55mInNuE1+LzbNOtDc4Ta6ndHgn4oc+uv4Byt
 1wtc57LTza54pHB27oMDaysyu0vc2KEQXehep38kJxZE/8/bkq0vUgKURSLQa22BkpOx
 dOA05Aidsxhgd26NrgweFcfNhiV5BDgD4uX1ouPXDgxVG7JcKIG7MRCeBdMCNE+kaQME
 4YyQ==
X-Gm-Message-State: AOAM530jYMUT7yCZXj4a/P406BoFoJ+vud+IttNJ2AYC3eWbbkT+/0mO
 T84AcuCctxjwHh9LK6kGSd9TSQ==
X-Google-Smtp-Source: ABdhPJzOu67KhPib/7zfI7mgHnrftLzWEt8v5fYXk10FlxSsjIV57STeY43DqysK8UOWTKLL9Quh9g==
X-Received: by 2002:a17:906:c1c3:: with SMTP id
 bw3mr1966407ejb.8.1597999198248; 
 Fri, 21 Aug 2020 01:39:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j11sm888155ejx.0.2020.08.21.01.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 01:39:57 -0700 (PDT)
Date: Fri, 21 Aug 2020 10:39:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200821083941.GA2312546@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D86D9C9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D86D9C9@SHSMSX104.ccr.corp.intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi,

While preparing the next version I noticed I forgot to send this reply.
Better late than never I suppose...

On Tue, Apr 21, 2020 at 07:31:12AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker
> > Sent: Saturday, February 29, 2020 1:26 AM
> > 
> > Platforms without device-tree do not currently have a method for
> > describing the vIOMMU topology. Provide a topology description embedded
> > into the virtio device.
[...]
> > diff --git a/drivers/iommu/virtio-iommu-topology.c b/drivers/iommu/virtio-
> > iommu-topology.c
> > new file mode 100644
> > index 000000000000..2188624ef216
> > --- /dev/null
> > +++ b/drivers/iommu/virtio-iommu-topology.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/dma-iommu.h>
> > +#include <linux/list.h>
> > +#include <linux/pci.h>
> > +#include <linux/virt_iommu.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_pci.h>
> > +#include <uapi/linux/virtio_iommu.h>
> > +
> > +struct viommu_cap_config {
> > +	u8 bar;
> > +	u32 length; /* structure size */
> > +	u32 offset; /* structure offset within the bar */
> > +};
> > +
> > +union viommu_topo_cfg {
> > +	__le16					type;
> > +	struct virtio_iommu_topo_pci_range	pci;
> > +	struct virtio_iommu_topo_endpoint	ep;
> > +};
> > +
> > +struct viommu_spec {
> > +	struct device				*dev; /* transport device */
> > +	struct fwnode_handle			*fwnode;
> > +	struct iommu_ops			*ops;
> > +	struct list_head			list;
> > +	size_t					num_items;
> 
> Intel DMAR allows an IOMMU to claim INCLUDE_ALL thus avoid listing
> every endpoint one-by-one. It is especially useful when there is only
> one IOMMU device in the system. Do you think whether making sense
> to allow such optimization in this spec?

The DMAR INCLUDE_PCI_ALL is for a single PCI domain, so I think is
equivalent to having a single virtio_iommu_topo_pci_range structure with
start=0 and end=0xffff. That only takes 16 bytes of config space and is
pretty easy to parse, so a special case doesn't seem necessary to me.

If more than one PCI domain is managed by the IOMMU, then INCLUDE_ALL
isn't sufficient since we need to describe how endpoint IDs are associated
to domain:RID (one of the domains would have its endpoint IDs = RID +
0x10000 for example). Furthermore non-PCI devices don't have an implicit
endpoint ID like the RID.

Thanks,
Jean

> It doesn't work for ARM since
> you need ID mapping to find the MSI doorbell. But for architectures
> where only topology info is required, it makes the enumeration process
> much simpler.
> 
> Thanks
> Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
