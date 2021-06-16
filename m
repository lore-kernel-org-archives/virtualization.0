Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A5C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:51:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6336260FF1
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 15:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6336260FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EC5B60AAB;
	Wed, 16 Jun 2021 15:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxKMcdoMyO-H; Wed, 16 Jun 2021 15:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4A3260AA8;
	Wed, 16 Jun 2021 15:51:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD471C000D;
	Wed, 16 Jun 2021 15:51:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDCC3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACE5B836CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sQMcGjvodfv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:51:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1276983506
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623858688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlBpjk0p11BKeTclm4FcvP2+RtXdSrKcaNlna0enzx0=;
 b=Dm2PRK5dTxFFvCC4PEGscZMwjZZUNZPANy9E4/4AigHdDQl04PdU+jYkb/ET9nXtP+8L+g
 NSz6yXJecMFTuoQM49jP+MNvOHQGo1eN4TONnWObrWkunLQlcVoGRgI0fc1HIOPfj1EzFC
 11ewHCtobfKF5VYWxp/0sEwdNPOkI8c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-HyjAESKtPbaLwszuakx9rA-1; Wed, 16 Jun 2021 11:50:54 -0400
X-MC-Unique: HyjAESKtPbaLwszuakx9rA-1
Received: by mail-wr1-f69.google.com with SMTP id
 k3-20020a5d62830000b029011a69a4d069so1234237wru.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xlBpjk0p11BKeTclm4FcvP2+RtXdSrKcaNlna0enzx0=;
 b=aSq9B1nzqfiYkusNQ4CiV+AsVbowBaJ4NfukTDsgTOHDlok5gBboiv+LTZO5GcjxY9
 ulW49uF/bNw1ifI7z0y5v3PgyzcTTv3dCmr5fo7qN+3KWcfGpfKm3WICTOOlTBnFiW0z
 fI2RQC6IcsH45E9j0zt8HkIqcl1JtSBgNzQub4rva2FNQUyKx+8MKoac/97JcKnGTHJM
 WcMJJAhM0fDwy1kq2XM8QqZbfyz/X5+JGXqlhIDI8nBa/e+z38QwhkLE5vsveEmdi9+T
 0cayCVGRiUdTlGkgnC495UUIePyWK4rOqWV/kKZhpNbcmecKGZeASvt77Qj5ECjTny0L
 Lv2Q==
X-Gm-Message-State: AOAM533cVrwoKtRXD7N6IKSIdrONrrKdO2Lqn6SKPDWG6CLyxBNLSUJd
 wiBeJZwcvqv28eLq0ECa4BsLSycC9X2yok2DJcTbx6xWcYnf1SnGnSmdWG/Iq/+bv8RWy9u4BxV
 /7g147wbChLf3QYEceTawOsSKpJovNndNrLVyVecIPQ==
X-Received: by 2002:a1c:193:: with SMTP id 141mr12231121wmb.106.1623858653041; 
 Wed, 16 Jun 2021 08:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9OI2IVADygttdOre09Sy1S+JFXZdlBRd88z8bREst0fh3MJQ4Chz/ONg8Ap86S3zsy0+c3w==
X-Received: by 2002:a1c:193:: with SMTP id 141mr12231096wmb.106.1623858652836; 
 Wed, 16 Jun 2021 08:50:52 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id g17sm3403307wrh.72.2021.06.16.08.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 08:50:52 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-6-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <210dbd62-cd04-209c-eec9-f0a4e706264d@redhat.com>
Date: Wed, 16 Jun 2021 17:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-6-jean-philippe@linaro.org>
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

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> dma-iommu uses the address bounds described in domain->geometry during
> IOVA allocation. The address size parameters of iommu_setup_dma_ops()
> are useful for describing additional limits set by the platform
> firmware, but aren't needed for drivers that call this function from
> probe_finalize(). The base parameter can be zero because dma-iommu
> already removes the first IOVA page, and the limit parameter can be
> U64_MAX because it's only checked against the domain geometry. Simplify
> calls to iommu_setup_dma_ops().
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/amd/iommu.c   |  9 +--------
>  drivers/iommu/dma-iommu.c   |  4 +++-
>  drivers/iommu/intel/iommu.c | 10 +---------
>  3 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 94b96d81fcfd..d3123bc05c08 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1708,14 +1708,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  
>  static void amd_iommu_probe_finalize(struct device *dev)
>  {
> -	struct iommu_domain *domain;
> -
> -	/* Domains are initialized for this device - have a look what we ended up with */
> -	domain = iommu_get_domain_for_dev(dev);
> -	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>  }
>  
>  static void amd_iommu_release_device(struct device *dev)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c62e19bed302..175f8eaeb5b3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	if (domain->type == IOMMU_DOMAIN_DMA) {
>  		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>  			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> +		set_dma_ops(dev, &iommu_dma_ops);
> +	} else {
> +		set_dma_ops(dev, NULL);
>  	}
>  
>  	return;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 85f18342603c..8d866940692a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
>  
>  static void intel_iommu_probe_finalize(struct device *dev)
>  {
> -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> -
> -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, base,
> -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>  }
>  
>  static void intel_iommu_get_resv_regions(struct device *device,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
