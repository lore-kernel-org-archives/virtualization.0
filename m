Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0BC636CC
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 11:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2BB60E5B;
	Wed, 15 Feb 2023 11:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF2BB60E5B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PD7A+gW7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPi5DC4sGS_D; Wed, 15 Feb 2023 11:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41BA760AEE;
	Wed, 15 Feb 2023 11:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41BA760AEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C835C0033;
	Wed, 15 Feb 2023 11:48:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD39C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78F8C400EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78F8C400EF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PD7A+gW7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zE7gcQY2BYg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98042400B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98042400B8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676461711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/H0rotavd9oyHOO+0LmtN00go4zSs58DTjk4UZUpfA=;
 b=PD7A+gW7kIOwBc8wPhgOY0WwU7gNMFO2xakKhGZw9RqeNYmu74ZoyAjny7JJSYN/mJQZ/d
 Qq6nVLr/iP35dx6idum9sklBRtDyWTsSvDM1i8CDn4gYi1Wj4Qvkf5fPnVYESSJl1Kk8yG
 OZdLr67Gxs4XyIEPjHVyTjW56nsrbbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-28-WzoRTf26NwOrXtLUOPrDbg-1; Wed, 15 Feb 2023 06:48:30 -0500
X-MC-Unique: WzoRTf26NwOrXtLUOPrDbg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r14-20020a05600c35ce00b003e10bfcd160so1003502wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 03:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/H0rotavd9oyHOO+0LmtN00go4zSs58DTjk4UZUpfA=;
 b=REQcGnY+fzzMS/VuTkoHo9NEIaTzEtW0ec5QOFj/81JpmFOf3mDRVBzIIvt5olS8m9
 RvOEyJZH9LL3Dm8mj0yboQiON6tLDpidN5/sWTwW0KBB2ZIbSyQVeAnkXf6KXwcIihDc
 pRoWIBRrEV3rOPzodi80on5UvmnCWj4fC0LIfof3AqrV/23v/AmB5i5U2OSOS3b3A90a
 9qikZ13S8GqBSPSMfwJ6qidiVelDHB89+qoXUQRvKNQFa6ztDZGPtJWaXpb/gReoLGKz
 QYu+I5pZkGHHTr8oHh2kO+rNr3uDZlkMghR94Kzz6Z9uvdWJ2rQ8kbjannvNCB7vO/Cx
 Vxpg==
X-Gm-Message-State: AO0yUKUGgEkQUmkrOygpP72g+BMfQBHmdTQ507cYNMbhk6F7IysDqmuI
 ygtInFx+D8I8rMScvUQhY4o1gw89CHpcFZ4R2fz2kaW9S7/xDIYF+Zy/jiVGLxO2flLqJscobnc
 sTYN65blvxh2HOfrvjdQ9D9q7dpurK6Sj+4dZofTOag==
X-Received: by 2002:a05:600c:318f:b0:3e1:f8af:8772 with SMTP id
 s15-20020a05600c318f00b003e1f8af8772mr2325072wmp.9.1676461706063; 
 Wed, 15 Feb 2023 03:48:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8OYAXBJzFVluU8HCwAVQMa/cFq9Nf1S2p+oFvhdxz8zS5w1AxVlAWS//WkraJpLlX5F/zY9Q==
X-Received: by 2002:a05:600c:318f:b0:3e1:f8af:8772 with SMTP id
 s15-20020a05600c318f00b003e1f8af8772mr2325057wmp.9.1676461705784; 
 Wed, 15 Feb 2023 03:48:25 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 c3-20020a1c3503000000b003dc522dd25esm1920544wma.30.2023.02.15.03.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Feb 2023 03:48:25 -0800 (PST)
Date: Wed, 15 Feb 2023 06:48:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nanyong Sun <sunnanyong@huawei.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230215064759-mutt-send-email-mst@kernel.org>
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
> 
> Change log
> ----------
> 
> v1->v2:
> - add resv iotlb to avoid overlap mapping.

put changelog after --- pls

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
