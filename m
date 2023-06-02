Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64774C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 12:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D132F40A55;
	Fri,  2 Jun 2023 12:11:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D132F40A55
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cnm5jO+Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AR5fPkowH82s; Fri,  2 Jun 2023 12:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4642241795;
	Fri,  2 Jun 2023 12:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4642241795
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 294DBC0037;
	Fri,  2 Jun 2023 12:11:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA423C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A518842716
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A518842716
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cnm5jO+Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HAzXndcUn4cK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72650426DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72650426DC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685707906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBqXisssxSy08laXqA4j2X5BRqq3rkPi2c6BRIFiiB0=;
 b=Cnm5jO+YdZTL8QENmYVdC9r0T1lV9bNizMJyu/X+tlegKs3aB21tGmoJaurP9icvBfHMhi
 +BVaoZe7D3onLHhL5WCgOHY+qdGBftkggQt/b/X0fgm7iWFb4s8Rq83YG4s+48y7f9TP/R
 GodlWRLyjCmiwjFb59Lr4IUp6Id1MDc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-o1kKjfvSN0u5aamUZjow2A-1; Fri, 02 Jun 2023 08:11:42 -0400
X-MC-Unique: o1kKjfvSN0u5aamUZjow2A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso1485664e87.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 05:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685707901; x=1688299901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBqXisssxSy08laXqA4j2X5BRqq3rkPi2c6BRIFiiB0=;
 b=UI6WGLxZm4JUYCWKKA94AICvhwVbl/wvsZm0WG6E18vlLeCuuZUkSbi2IgGjwEuuto
 U8xjPtQibJ/VF6PWTfec3TA8h0e1wSYI2OopHYhJukSmYNo/QzbEUReDFT96oszAz7mj
 BhCcfEZVkGHFj5/38xeGqv+sTpAkGJ9fOvEXocxNyHdcxLYc8wY/30ZBR8TeQHiAqJsY
 Tzzl0t6tA/0u9jba2VBv3SWkJry40kBcrxKyUwZaIFtsmZQa3V3UoryM9vPsulM4Nnkx
 M5nuEtMeMh+HcEimiAcOa5R1+Qe7dWhMcjoZvsfcW+ix2MXi060JnLoPLrUg0/3V8FJi
 iOKw==
X-Gm-Message-State: AC+VfDz3c/qSfnUuDy12yzToNG6q2xx+6Pmhk84N6fbxQAErYhGsrre2
 ESUf5ZwGi8dhfLsrNjKA9zKxPGPSBiYFz8ZMaG+FMqRRLQaR9vQvWED6pVgpTXjLLA67qc+rc0B
 9dcKOEoCALC5ZFJNJ7yhRXg6iW+260Ey5wh9yqDdQCQ==
X-Received: by 2002:ac2:5d49:0:b0:4f3:b242:aa90 with SMTP id
 w9-20020ac25d49000000b004f3b242aa90mr1515715lfd.35.1685707901331; 
 Fri, 02 Jun 2023 05:11:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IVeiUNG0peGHBMQ2vc4eUrkOSQnaTk3Irclc1ESd8zyAftY8Hs9kbez88ioB4Hh+4W4z+RQ==
X-Received: by 2002:ac2:5d49:0:b0:4f3:b242:aa90 with SMTP id
 w9-20020ac25d49000000b004f3b242aa90mr1515704lfd.35.1685707900929; 
 Fri, 02 Jun 2023 05:11:40 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4c42000000b00306415ac69asm1519978wrt.15.2023.06.02.05.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:11:40 -0700 (PDT)
Date: Fri, 2 Jun 2023 08:11:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nanyong Sun <sunnanyong@huawei.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230602081114-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230207120843.1580403-1-sunnanyong@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wangrong68@huawei.com, kvm@vger.kernel.org, will@kernel.org,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, robin.murphy@arm.com
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

On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> From: Rong Wang <wangrong68@huawei.com>
> 
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.


OK this one seems to be going nowhere I untagged it.

> Change log
> ----------
> 
> v1->v2:
> - add resv iotlb to avoid overlap mapping.
> 
> Signed-off-by: Rong Wang <wangrong68@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  drivers/iommu/iommu.c |  1 +
>  drivers/vhost/vdpa.c  | 59 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5f6a85aea501..af9c064ad8b2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2623,6 +2623,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  	if (ops->get_resv_regions)
>  		ops->get_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL(iommu_get_resv_regions);
>  
>  /**
>   * iommu_put_resv_regions - release resered regions
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f785dfde..a58979da8acd 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -49,6 +49,7 @@ struct vhost_vdpa {
>  	struct completion completion;
>  	struct vdpa_device *vdpa;
>  	struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> +	struct vhost_iotlb resv_iotlb;
>  	struct device dev;
>  	struct cdev cdev;
>  	atomic_t opened;
> @@ -216,6 +217,8 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
>  
>  	v->in_batch = 0;
>  
> +	vhost_iotlb_reset(&v->resv_iotlb);
> +
>  	return vdpa_reset(vdpa);
>  }
>  
> @@ -1013,6 +1016,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	    msg->iova + msg->size - 1 > v->range.last)
>  		return -EINVAL;
>  
> +	if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> +					msg->iova + msg->size - 1))
> +		return -EINVAL;
> +
>  	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>  				    msg->iova + msg->size - 1))
>  		return -EEXIST;
> @@ -1103,6 +1110,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
>  	return vhost_chr_write_iter(dev, from);
>  }
>  
> +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
> +	struct vhost_iotlb *resv_iotlb)
> +{
> +	struct list_head dev_resv_regions;
> +	phys_addr_t resv_msi_base = 0;
> +	struct iommu_resv_region *region;
> +	int ret = 0;
> +	bool with_sw_msi = false;
> +	bool with_hw_msi = false;
> +
> +	INIT_LIST_HEAD(&dev_resv_regions);
> +	iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +	list_for_each_entry(region, &dev_resv_regions, list) {
> +		ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
> +				region->start + region->length - 1,
> +				0, 0, NULL);
> +		if (ret) {
> +			vhost_iotlb_reset(resv_iotlb);
> +			break;
> +		}
> +
> +		if (region->type == IOMMU_RESV_MSI)
> +			with_hw_msi = true;
> +
> +		if (region->type == IOMMU_RESV_SW_MSI) {
> +			resv_msi_base = region->start;
> +			with_sw_msi = true;
> +		}
> +	}
> +
> +	if (!ret && !with_hw_msi && with_sw_msi)
> +		ret = iommu_get_msi_cookie(domain, resv_msi_base);
> +
> +	iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> +
> +	return ret;
> +}
> +
>  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
> @@ -1128,11 +1174,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  
>  	ret = iommu_attach_device(v->domain, dma_dev);
>  	if (ret)
> -		goto err_attach;
> +		goto err_alloc_domain;
>  
> -	return 0;
> +	ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
> +	if (ret)
> +		goto err_attach_device;
>  
> -err_attach:
> +	return 0;
> +err_attach_device:
> +	iommu_detach_device(v->domain, dma_dev);
> +err_alloc_domain:
>  	iommu_domain_free(v->domain);
>  	return ret;
>  }
> @@ -1385,6 +1436,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  		goto err;
>  	}
>  
> +	vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> +
>  	r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
>  	if (r)
>  		goto err;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
