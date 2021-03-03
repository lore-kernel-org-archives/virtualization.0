Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271EC433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:40:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C32860202
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32860202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E8666F973;
	Wed,  3 Mar 2021 17:40:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rH6CAiO4DWVb; Wed,  3 Mar 2021 17:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF978605E5;
	Wed,  3 Mar 2021 17:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADF0BC000A;
	Wed,  3 Mar 2021 17:40:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7B3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2706584059
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rkQxrBenFJP3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:40:12 +0000 (UTC)
X-Greylist: delayed 00:11:55 by SQLgrey-1.8.0
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9B888376B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:40:12 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id w7so5844595wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=m0yEupP/L76P6gyISve2gAOojgj7J2+MhN1/3SbMwsE=;
 b=C6KCV2Ndp6CnJ973AOgZXdDV2ekUchmEJSgJwIBEmdHi354O2kCSutw5rxsuaetRS2
 6TWGzr8yJbWn4m3Gscu98rUzjS2Da4D50fqwZ+2nRW3QMP/1VIwc8h4YVEOlFw1OyElu
 xR9MPTccInyAI8SkqACUaRFoBJTIw+uwfVrORZaWtVapcLsDmBiWKh6hdddFwFXInOZh
 xJjh9otvchYhdcs8tvPO2rfa1cVCTzy81vjuAhs8lCNNERHj3NaDswXNENqNEwXgT/6q
 jez/V3484hDD5fJMt5nEduLgJm3Fs3iR+fK1ydpKCCATvHZ1rXTXxQ04lcxTcAOS0RKV
 bPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m0yEupP/L76P6gyISve2gAOojgj7J2+MhN1/3SbMwsE=;
 b=sGO6SNpsGt0Hy9DHY2CWO69lCGXHTvYx/WL62HwdOy32y2ZbixaN6eyAJ0mm6BtB+h
 ldcXqaQWhYIwGqBk76C8t5JoOOOZMnevxh/eGBh/XR68R0k1giFR7oJ2gjmKHAq2YA+N
 5gK3SPDZGdkvwne18QBzmNBvUtlB0jLPtOzbiDgRB/+AeyypGttQP5j704NQNA2yht+f
 Pmj3kdn4hhDv+Q314PcPcDeESIHOLemLBQWFxi7p1Qp1ihcG1sBh9UvDuCrEFzsMfgFe
 suPQKIdOuCGLxCjwjF/LQA9+Z48EPOunMq9uT70OY6WkKtqSFYrMW+kiOEvOrjuHdXFp
 PNqw==
X-Gm-Message-State: AOAM532i0uqAOFnwh7bgF+QVxblZuVu3dfMJNW+sR+Mmnpgv/CM4bcTc
 +5ddG3adDtQ0WSxmymlwwuZUljIw5PGRVQ==
X-Google-Smtp-Source: ABdhPJyTjnQxRH4h4WtoiKSNYqpA2AI+RhtLePJP1THwR+Upij+BED0FnmLt0W2lDduYTxT0WBRsbg==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr69805wmj.54.1614791690288;
 Wed, 03 Mar 2021 09:14:50 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v5sm6552574wmh.2.2021.03.03.09.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:14:49 -0800 (PST)
Date: Wed, 3 Mar 2021 18:14:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 04/15] iommu/arm-smmu-v3: Update CD base address
 info for user-space
Message-ID: <YD/D9HJxH9L503an@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-5-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-5-vivek.gautam@arm.com>
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

On Fri, Jan 15, 2021 at 05:43:31PM +0530, Vivek Gautam wrote:
> Update base address information in vendor pasid table info to pass that
> to user-space for stage1 table management.
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index 8a7187534706..ec37476c8d09 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -55,6 +55,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct iommu_vendor_psdtable_cfg *pst_cfg,
>  		if (arm_smmu_alloc_cd_leaf_table(dev, l1_desc))
>  			return NULL;
>  
> +		if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
> +			pst_cfg->base = l1_desc->l2ptr_dma;
> +

This isn't the right place, because this path allocates second-level
tables for two-level tables. I don't think we need pst_cfg->base at all,
because for both linear and two-level tables, the base pointer is in
cdcfg->cdtab_dma, which can be read directly.

Thanks,
Jean

>  		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
>  		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
>  		/* An invalid L1CD can be cached */
> @@ -211,6 +214,9 @@ static int arm_smmu_alloc_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
>  		goto err_free_l1;
>  	}
>  
> +	if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_64K_L2)
> +		pst_cfg->base = cdcfg->cdtab_dma;
> +
>  	return 0;
>  
>  err_free_l1:
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
