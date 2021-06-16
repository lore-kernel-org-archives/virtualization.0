Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F264C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:53:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C56660FF1
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C56660FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDDDE404AA;
	Wed, 16 Jun 2021 15:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCPrrDcdcJOr; Wed, 16 Jun 2021 15:53:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 869F0403B3;
	Wed, 16 Jun 2021 15:52:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60DA2C000D;
	Wed, 16 Jun 2021 15:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9E4FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BA55834C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eChSOSA267Qe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:52:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2A2482BF4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623858776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6r7FqEyIqGHuXZGRXFsW95199nXnF1UaOlSdhA4lIyc=;
 b=BvYKCIFARbyrRnAd0JzQU5HuFsck5HH3NlN80W0M7ILmEwDL/8Eo319ZFE2G9UbwN0S7q2
 00+4WnfNJR2Yz7WSOFh2mZf63Lq1/boNpL33RtxCjhgp8NW79K8C+hXuM7mWweG1T+T89x
 9drBKWVLPlfgofCTHcfZ5PLVsQ1ckmg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-FNmFiXDuPzeJirjmM9sbyQ-1; Wed, 16 Jun 2021 11:52:50 -0400
X-MC-Unique: FNmFiXDuPzeJirjmM9sbyQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 n2-20020adfb7420000b029010e47b59f31so1452481wre.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=6r7FqEyIqGHuXZGRXFsW95199nXnF1UaOlSdhA4lIyc=;
 b=hC9qMsLAYzrvYIKAG14v//VQSNQy11HbOCN8q0wsoz/84ue+50BUsWjklkCR2qyYPK
 tU3nBa5/SS6SWrW0wjIMomLBcujBJby6nCYYNWQ+pFsZWr5OrFuxrDzCr3/ZDjDMzbZ3
 j9ElsS7q/XV6uHoVEiyvzSnjnLUr1GSdEnrjMYaO5xJtyr0IfvZJqRBFBOQ9SHw3LOyE
 VGOONQr6f2ZPYk+UafmUzkMzXCPRlyQKXHN0eIM/5ZDkecqr4rpFoK213ydnayRY6Uj7
 iEw8WuLUguAgiVlAhHwiUWHbogqjOHNrIpWY8V9EXT3djh9zMQFf0MxHLwJ6ANpreHbn
 heAw==
X-Gm-Message-State: AOAM531hrA1Et+RnXLOkckmhbDg/P1dOO9I+oG1cpZKkF4K/Dcu8ieqA
 HuSl8O0toqDgDL/SIqI76bmZohD2ir6kwWjqi2YfOhEAukWOkNeE/NsQhHcbfWVufdvLxW+7sI0
 rWzQ0EVKocLfejJ106VuCDIPQk2rC8auFqk66UBLOQA==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr55250wri.291.1623858769531;
 Wed, 16 Jun 2021 08:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysyzQ5DAqgvGtPQdPC6k1RsxHctJlotRiVdhus3R8J8Yk+bdyOpT1kx5y2o1TBPyLSdtUNPA==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr55237wri.291.1623858769411;
 Wed, 16 Jun 2021 08:52:49 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id c13sm2703348wrb.5.2021.06.16.08.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 08:52:48 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] iommu/virtio: Enable x86 support
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-7-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <9149c79e-6f88-5df5-80e7-4da4cb13d6e1@redhat.com>
Date: Wed, 16 Jun 2021 17:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-7-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
>
> Because the other x86 IOMMU drivers aren't yet ready to use the
> acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
> moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
> probe_finalize().
>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/Kconfig        | 3 ++-
>  drivers/iommu/dma-iommu.c    | 1 +
>  drivers/iommu/virtio-iommu.c | 8 ++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index aff8a4830dd1..07b7c25cbed8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA
>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 175f8eaeb5b3..46ed43c400cf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1332,6 +1332,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
>  		 dev_name(dev));
>  }
> +EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
>  
>  static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  		phys_addr_t msi_addr, struct iommu_domain *domain)
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 218fe8560e8d..77aee1207ced 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1026,6 +1026,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  	return ERR_PTR(ret);
>  }
>  
> +static void viommu_probe_finalize(struct device *dev)
> +{
> +#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> +#endif
> +}
> +
>  static void viommu_release_device(struct device *dev)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> @@ -1062,6 +1069,7 @@ static struct iommu_ops viommu_ops = {
>  	.iova_to_phys		= viommu_iova_to_phys,
>  	.iotlb_sync		= viommu_iotlb_sync,
>  	.probe_device		= viommu_probe_device,
> +	.probe_finalize		= viommu_probe_finalize,
>  	.release_device		= viommu_release_device,
>  	.device_group		= viommu_device_group,
>  	.get_resv_regions	= viommu_get_resv_regions,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
