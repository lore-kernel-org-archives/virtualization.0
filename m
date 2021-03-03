Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65842C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 18:20:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB9564EE4
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 18:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB9564EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90E6940181;
	Wed,  3 Mar 2021 18:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnu4hR_Ug2Ok; Wed,  3 Mar 2021 18:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23F1C4013C;
	Wed,  3 Mar 2021 18:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0864C000B;
	Wed,  3 Mar 2021 18:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C318C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 18:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B8BC6F99D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 18:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4p3tkvt6uwj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 18:20:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EBF16F98C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 18:20:01 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id u187so5941910wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
 b=VwJ+VHKJcT2Nf/kj3+7hqNO+M8Jub4xI+zPtfFYoQaqgHTl43E/lHcDJW8zwY4eHUq
 PiLw+a7S0TTjtZt0wIdcfocKW4sdtFAs+BSeXQZ7Un71ucylyW/orAbwxZOd7ajhi3GX
 BrLrJ0idIv26+gJboNFBabl6If2U02DArAp2HxxleK+xXxnRqmRLke66PLBm06i/jUHb
 /08oxS3l20Pa7g0INWbcIVqHiKWSiGijLLQ2QZcfFHHpI5KTNRRHdE3+U6JeNHXDdKBq
 A43uJFcfy0NniInhBbUpqMWuHe8aZYtoy4MIMq65vyW2fo9cxrlohPDpfXYdJndR4OVD
 4CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
 b=Gjd4FjnuhgYMUBuXBOy4yqCj2GfBCfhWlqPjDcGkMGttMdZdVYOQKRybnKITRyn769
 nKUfY7XJGsvRvE0+uIRLt5LbxvYQ7ZoLxPHyIGMhCQSsgJG/1BF7aeIh7M+H6AD/ksj2
 pe470R2VIvY2RUgx43w6Pr9mH0goYf6miSr3AOa8hbW2bNCpzNXZFEOLCtOQrSx1+mhi
 5zR1O/+6BP4jh2nGamWOGcl6m3neQeOqoEqx3aHrFKOq6I0B4J8YBTv60eLmmc9c3Uqf
 ZAM4EHO2B4/h7ed2wdz56fb0q0GrcqQ2geRmYdNBMRtq6bsGbIpsqCYVlBEEi98chhIn
 e3Ng==
X-Gm-Message-State: AOAM531pDEeDmU+QD+QWymSSKRhrwuaXRnH8UdHdEyeSBUO1Lnvx5jIa
 53dnj9dwZ01cThUhZ0hMnIxuxE5/VtLq+A==
X-Google-Smtp-Source: ABdhPJxEGFLtLtT2CVJqW85OgSqITesZWdYSO96CmRmaHjOUEzXMjLr6QhIIoiQz8us9HKvesrIHzQ==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr62026wma.92.1614791779611;
 Wed, 03 Mar 2021 09:16:19 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o2sm6209999wme.16.2021.03.03.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:16:18 -0800 (PST)
Date: Wed, 3 Mar 2021 18:15:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 05/15] iommu/arm-smmu-v3: Set sync op from
 consumer driver of cd-lib
Message-ID: <YD/ETcVwWATG4M6e@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-6-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-6-vivek.gautam@arm.com>
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 15, 2021 at 05:43:32PM +0530, Vivek Gautam wrote:
> Te change allows different consumers of arm-smmu-v3-cd-lib to set
> their respective sync op for pasid entries.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index ec37476c8d09..acaa09acecdd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -265,7 +265,6 @@ struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
>  	.free	 = arm_smmu_free_cd_tables,
>  	.prepare = arm_smmu_prepare_cd,
>  	.write	 = arm_smmu_write_ctx_desc,
> -	.sync	 = arm_smmu_sync_cd,
>  };
>  
>  struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f86c6ac42b6..0c644be22b4b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1869,6 +1869,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> +	/*
> +	 * Strange to setup an op here?
> +	 * cd-lib is the actual user of sync op, and therefore the platform
> +	 * drivers should assign this sync/maintenance ops as per need.
> +	 */
> +	tbl->ops->sync = arm_smmu_sync_cd;
> +

Modifying a static struct from here doesn't feel right. I think the
interface should be roughly similar to io-pgtable since the principle is
the same. So the sync() op should be separate from arm_cd_table_ops since
it's a callback into the driver. Maybe pass it to
iommu_register_pasid_table().

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
