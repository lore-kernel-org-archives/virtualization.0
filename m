Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28930C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A09B441153;
	Fri,  3 Feb 2023 10:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A09B441153
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMOGITgs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTMUc8Lyp2iz; Fri,  3 Feb 2023 10:20:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C8BD4038B;
	Fri,  3 Feb 2023 10:20:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C8BD4038B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D69FAC0032;
	Fri,  3 Feb 2023 10:20:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB52CC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D08C40C90
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D08C40C90
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiG9NNZmXyUG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:20:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33FAD4038B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33FAD4038B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675419644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iam6TVlC4BdFHMqUPWEg8zp328c+mS6UwmH3KvCTdM=;
 b=WMOGITgsdNRcWsXhyukXngYiLQqizB7ok/ghUTN0LO3PwEpwm6E2tgQpSKnNo3pvih8Jp8
 KZvNc5lUIUhHRvNQ3mbkfSaLy9iedeaKk3YPisT/fgc4XWSSns28obVTxVElUCkD5kra44
 tFsBO3pxXDN9denjz7imT1yiDUny210=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-8myMhvSTNByTAy6wIFGNfQ-1; Fri, 03 Feb 2023 05:20:42 -0500
X-MC-Unique: 8myMhvSTNByTAy6wIFGNfQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 g19-20020a056402115300b004a26cc7f6cbso3307076edw.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iam6TVlC4BdFHMqUPWEg8zp328c+mS6UwmH3KvCTdM=;
 b=rSEoQYloO2EomBWz/7baIAxCSMakIqrlBO9Fj8JocfZE3ozIQhSZOELetLh4UoinNA
 zVtcWapJsz8esQXWOAJRm8GMUiJOmqfRDcH4Vy5VoHRky2KXZMNUB14No+GYurS34oLS
 5VnByr+i8RC1MqoAIxQlMzc5bxIr2b0jCbTV7ITCay3ynWLOSLJ+/Yy5KS4VG5I85rbE
 o5sqHH1UY/jmre9F3LVIortfgLGsiVPRb1inrfT2xohIXP1RGW17y1XbU4V7Yd1Xvp8x
 FUnS1vMW/oVDaBmXsAS8vMpBb5KiGIgmm0GohPgaBaWl1kmOZv33VjSAdHJBC2v65/1G
 7WCQ==
X-Gm-Message-State: AO0yUKUoOHaoxeK/6RbqDpR+z9uaN6UwNfCbeKF0RzPGPZ00DTNKOKBv
 OFilxYIrwLuE9BN4zwb+P/5pvBVJVnl9q3WKXy/vP9nArZig+iWEK7T5K+w47C4AiixNijSzQcd
 5nE2P6ZzMeU4B8ttBLcGuuBVSEWD/xAgeyi2FdB8mWQ==
X-Received: by 2002:a17:906:8281:b0:878:5c36:a14a with SMTP id
 h1-20020a170906828100b008785c36a14amr9683909ejx.23.1675419640986; 
 Fri, 03 Feb 2023 02:20:40 -0800 (PST)
X-Google-Smtp-Source: AK7set8eTbc7ppNll0/cXWNgC6aCFc9ulp9OBgT55PnP3sg0K3wCpW48yQtNB4dx/Td2VT4I1Cc69A==
X-Received: by 2002:a17:906:8281:b0:878:5c36:a14a with SMTP id
 h1-20020a170906828100b008785c36a14amr9683888ejx.23.1675419640712; 
 Fri, 03 Feb 2023 02:20:40 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 z20-20020a1709060f1400b0084c6ec69a9dsm1145376eji.124.2023.02.03.02.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:20:40 -0800 (PST)
Date: Fri, 3 Feb 2023 05:20:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 3/4] PCI: endpoint: Introduce virtio library for EP
 functions
Message-ID: <20230203051844-mutt-send-email-mst@kernel.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-4-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230203100418.2981144-4-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

On Fri, Feb 03, 2023 at 07:04:17PM +0900, Shunsuke Mie wrote:
> Add a new library to access a virtio ring located on PCIe host memory. The
> library generates struct pci_epf_vringh that is introduced in this patch.
> The struct has a vringh member, so vringh APIs can be used to access the
> virtio ring.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> ---
>  drivers/pci/endpoint/Kconfig          |   7 ++
>  drivers/pci/endpoint/Makefile         |   1 +
>  drivers/pci/endpoint/pci-epf-virtio.c | 113 ++++++++++++++++++++++++++
>  include/linux/pci-epf-virtio.h        |  25 ++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>  create mode 100644 include/linux/pci-epf-virtio.h
> 
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index 17bbdc9bbde0..07276dcc43c8 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -28,6 +28,13 @@ config PCI_ENDPOINT_CONFIGFS
>  	   configure the endpoint function and used to bind the
>  	   function with a endpoint controller.
>  
> +config PCI_ENDPOINT_VIRTIO
> +	tristate
> +	depends on PCI_ENDPOINT
> +	select VHOST_IOMEM
> +	help
> +	  TODO update this comment
> +
>  source "drivers/pci/endpoint/functions/Kconfig"
>  
>  endmenu
> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> index 95b2fe47e3b0..95712f0a13d1 100644
> --- a/drivers/pci/endpoint/Makefile
> +++ b/drivers/pci/endpoint/Makefile
> @@ -4,5 +4,6 @@
>  #
>  
>  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> +obj-$(CONFIG_PCI_ENDPOINT_VIRTIO)	+= pci-epf-virtio.o
>  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
>  					   pci-epc-mem.o functions/
> diff --git a/drivers/pci/endpoint/pci-epf-virtio.c b/drivers/pci/endpoint/pci-epf-virtio.c
> new file mode 100644
> index 000000000000..7134ca407a03
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-epf-virtio.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtio library for PCI Endpoint function
> + */
> +#include <linux/kernel.h>
> +#include <linux/pci-epf-virtio.h>
> +#include <linux/pci-epc.h>
> +#include <linux/virtio_pci.h>
> +
> +static void __iomem *epf_virtio_map_vq(struct pci_epf *epf, u32 pfn,
> +				       size_t size, phys_addr_t *vq_phys)
> +{
> +	int err;
> +	phys_addr_t vq_addr;
> +	size_t vq_size;
> +	void __iomem *vq_virt;
> +
> +	vq_addr = (phys_addr_t)pfn << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> +
> +	vq_size = vring_size(size, VIRTIO_PCI_VRING_ALIGN) + 100;

100?

Also ugh, this uses the legacy vring_size.
Did not look closely but is all this limited to legacy virtio then?
Pls make sure you code builds with #define VIRTIO_RING_NO_LEGACY.

> +
> +	vq_virt = pci_epc_mem_alloc_addr(epf->epc, vq_phys, vq_size);
> +	if (!vq_virt) {
> +		pr_err("Failed to allocate epc memory\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	err = pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no, *vq_phys,
> +			       vq_addr, vq_size);
> +	if (err) {
> +		pr_err("Failed to map virtuqueue to local");
> +		goto err_free;
> +	}
> +
> +	return vq_virt;
> +
> +err_free:
> +	pci_epc_mem_free_addr(epf->epc, *vq_phys, vq_virt, vq_size);
> +
> +	return ERR_PTR(err);
> +}
> +
> +static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_virt,
> +				phys_addr_t vq_phys, size_t size)
> +{
> +	pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys);
> +	pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt,
> +			      vring_size(size, VIRTIO_PCI_VRING_ALIGN));
> +}
> +
> +/**
> + * pci_epf_virtio_alloc_vringh() - allocate epf vringh from @pfn
> + * @epf: the EPF device that communicates to host virtio dirver
> + * @features: the virtio features of device
> + * @pfn: page frame number of virtqueue located on host memory. It is
> + *		passed during virtqueue negotiation.
> + * @size: a length of virtqueue
> + */
> +struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
> +						   u64 features, u32 pfn,
> +						   size_t size)
> +{
> +	int err;
> +	struct vring vring;
> +	struct pci_epf_vringh *evrh;
> +
> +	evrh = kmalloc(sizeof(*evrh), GFP_KERNEL);
> +	if (!evrh) {
> +		err = -ENOMEM;
> +		goto err_unmap_vq;
> +	}
> +
> +	evrh->size = size;
> +
> +	evrh->virt = epf_virtio_map_vq(epf, pfn, size, &evrh->phys);
> +	if (IS_ERR(evrh->virt))
> +		return evrh->virt;
> +
> +	vring_init(&vring, size, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
> +
> +	err = vringh_init_iomem(&evrh->vrh, features, size, false, GFP_KERNEL,
> +				vring.desc, vring.avail, vring.used);
> +	if (err)
> +		goto err_free_epf_vq;
> +
> +	return evrh;
> +
> +err_free_epf_vq:
> +	kfree(evrh);
> +
> +err_unmap_vq:
> +	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_virtio_alloc_vringh);
> +
> +/**
> + * pci_epf_virtio_free_vringh() - release allocated epf vring
> + * @epf: the EPF device that communicates to host virtio dirver
> + * @evrh: epf vringh to free
> + */
> +void pci_epf_virtio_free_vringh(struct pci_epf *epf,
> +				struct pci_epf_vringh *evrh)
> +{
> +	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
> +	kfree(evrh);
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_virtio_free_vringh);
> +
> +MODULE_DESCRIPTION("PCI EP Virtio Library");
> +MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pci-epf-virtio.h b/include/linux/pci-epf-virtio.h
> new file mode 100644
> index 000000000000..ae09087919a9
> --- /dev/null
> +++ b/include/linux/pci-epf-virtio.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Endpoint Function (EPF) for virtio definitions
> + */
> +#ifndef __LINUX_PCI_EPF_VIRTIO_H
> +#define __LINUX_PCI_EPF_VIRTIO_H
> +
> +#include <linux/types.h>
> +#include <linux/vringh.h>
> +#include <linux/pci-epf.h>
> +
> +struct pci_epf_vringh {
> +	struct vringh vrh;
> +	void __iomem *virt;
> +	phys_addr_t phys;
> +	size_t size;
> +};
> +
> +struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
> +						   u64 features, u32 pfn,
> +						   size_t size);
> +void pci_epf_virtio_free_vringh(struct pci_epf *epf,
> +				struct pci_epf_vringh *evrh);
> +
> +#endif // __LINUX_PCI_EPF_VIRTIO_H
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
