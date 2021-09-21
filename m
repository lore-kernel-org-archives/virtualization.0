Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC5C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 16:08:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1618361242
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 16:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1618361242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D328D400EF;
	Tue, 21 Sep 2021 16:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xlWjXfl50Qc; Tue, 21 Sep 2021 16:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22E914021E;
	Tue, 21 Sep 2021 16:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7DB5C0020;
	Tue, 21 Sep 2021 16:08:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 589C3C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EF4B81AD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhzVvuwthl7s
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:08:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC0148104B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:08:06 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id w29so40794321wra.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b9ayZN/31+YJCtPuFwl2kU4KlsDWXPcoXAZudGxGmkE=;
 b=DuTlqIELBcGgf37jsY8ukVZk5Fk1L8Yv7fME3/uVBv2BV0R5CE3HH+dF19Z6gGDqGD
 fYBEVlNicATgh6arOapOe1LFNbDsfic1cz7Fynn/pWt6XrvfcAg50tr/07zbEbwR1Fvi
 J/4hDrmHbboyPx2XYhwpZ54RNEuhu15dFtQafVYSW2EWCBWlk+KTCnGJc3QCQJN2rCQN
 gYRy4ijGnKm6mzxf/eQUoAzhvAEzcHlkQQaH+tifKMG8cVByB6fCEYRx+j2Tq0lvrnbT
 2N38zuj/FQMEeRmTjT1IMFxKjy3cBZ00aF01+UzXcA2bgo+erpC4ZXIXg4r7sAKdGALI
 UJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b9ayZN/31+YJCtPuFwl2kU4KlsDWXPcoXAZudGxGmkE=;
 b=Evtv45cTorqcO6BcAGU2ATSCk/8p0bObNF8wzeWOgdALJ53iElKlRkOIM8HoAdsLWV
 kJoUpDyM3bh84fTjYOOtHimLh0GFucTsA7svLtx/ljD6ksli63DxT1OAskg5uBMFnixT
 P9KOwtg9jcHW3GAvTmlHjXmPtxkI9X7N4TDhmiH8bHjXyDDvo1maeisTSIdpclSC8nsj
 eP6r1l6dzz5gj8VYlgaQsdVgnDlYCYoWQPWITr7yBXYGUMUlrU5b2UiI8OW5HAfx4UrZ
 Vm4slleu2ed16jk2My7kId8VlpgvNigmCkZK5S6XfqLQ8jf4G/uoVsqms8IDlPs03sSE
 K6zQ==
X-Gm-Message-State: AOAM530EcFT3NrEid+nDgXx1av9EWuaSSxrjIcHCi1bVPvSY7rWprKs4
 BlD4uMaUeMxfllQY7kHQ+EuwGA==
X-Google-Smtp-Source: ABdhPJw1Eh516Iqqx9GmwH6vXri7X153H2N0zgCSBKTK5AVeIfT+nPMR0g1LJE13anrDSDQ5KxfNCQ==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr35717468wrx.413.1632240484578; 
 Tue, 21 Sep 2021 09:08:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id d2sm19541616wrc.32.2021.09.21.09.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 09:08:04 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:07:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 08/11] iommu/arm-smmu-v3: Implement shared context
 alloc and free ops
Message-ID: <YUoDTv0bhbfcu4MS@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-9-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-9-vivek.gautam@arm.com>
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
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

On Fri, Apr 23, 2021 at 03:21:44PM +0530, Vivek Gautam wrote:
> Implementing the alloc_shared_cd and free_shared_cd in cd-lib, and
> start using them for arm-smmu-v3-sva implementation.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 71 ++++++++--------
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 83 ++++++++-----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ----
>  4 files changed, 73 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index 537b7c784d40..b87829796596 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -285,16 +285,14 @@ static bool arm_smmu_free_asid(struct xarray *xa, void *cookie_cd)
>   * descriptor is using it, try to replace it.
>   */
>  static struct arm_smmu_ctx_desc *
> -arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> +arm_smmu_share_asid(struct iommu_pasid_table *tbl, struct mm_struct *mm,
> +		    struct xarray *xa, u16 asid, u32 asid_bits)

xa and asid_bits could be stored in some arch-specific section of the
iommu_pasid_table struct. Other table drivers wouldn't need those
arguments.

More a comment for the parent series: it may be clearer to give a
different prefix to functions in this file (arm_smmu_cd_, pst_arm_?).
Reading this patch I'm a little confused by what belongs in the IOMMU
driver and what is done by this library. (I also keep reading 'tbl' as
'tlb'. Maybe we could make it 'table' since that doesn't take a lot more
space)

>  {
>  	int ret;
>  	u32 new_asid;
>  	struct arm_smmu_ctx_desc *cd;
> -	struct arm_smmu_device *smmu;
> -	struct arm_smmu_domain *smmu_domain;
> -	struct iommu_pasid_table *tbl;
>  
> -	cd = xa_load(&arm_smmu_asid_xa, asid);
> +	cd = xa_load(xa, asid);
>  	if (!cd)
>  		return NULL;
>  
> @@ -306,12 +304,8 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  		return cd;
>  	}
>  
> -	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
> -	smmu = smmu_domain->smmu;
> -	tbl = smmu_domain->tbl;
> -
> -	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
> -		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
> +	ret = xa_alloc(xa, &new_asid, cd, XA_LIMIT(1, (1 << asid_bits) - 1),
> +		       GFP_KERNEL);
>  	if (ret)
>  		return ERR_PTR(-ENOSPC);
>  	/*
> @@ -325,48 +319,52 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	 * be some overlap between use of both ASIDs, until we invalidate the
>  	 * TLB.
>  	 */
> -	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
> +	ret = arm_smmu_write_ctx_desc(&tbl->cfg, 0, cd);
>  	if (ret)
>  		return ERR_PTR(-ENOSYS);
>  
>  	/* Invalidate TLB entries previously associated with that context */
> -	iommu_psdtable_flush_tlb(tbl, smmu_domain, asid);
> +	iommu_psdtable_flush_tlb(tbl, tbl->cookie, asid);
>  
> -	xa_erase(&arm_smmu_asid_xa, asid);
> +	xa_erase(xa, asid);
>  	return NULL;
>  }
>  
> -struct arm_smmu_ctx_desc *
> -arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
> +static struct iommu_psdtable_mmu_notifier *
> +arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm,
> +			 struct xarray *xa, u32 asid_bits)
>  {
>  	u16 asid;
>  	int err = 0;
>  	u64 tcr, par, reg;
>  	struct arm_smmu_ctx_desc *cd;
>  	struct arm_smmu_ctx_desc *ret = NULL;
> +	struct iommu_psdtable_mmu_notifier *pst_mn;
>  
>  	asid = arm64_mm_context_get(mm);
>  	if (!asid)
>  		return ERR_PTR(-ESRCH);
>  
> +	pst_mn = kzalloc(sizeof(*pst_mn), GFP_KERNEL);
> +	if (!pst_mn) {
> +		err = -ENOMEM;
> +		goto out_put_context;
> +	}
> +
>  	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
>  	if (!cd) {
>  		err = -ENOMEM;
> -		goto out_put_context;
> +		goto out_free_mn;
>  	}
>  
>  	refcount_set(&cd->refs, 1);
>  
> -	mutex_lock(&arm_smmu_asid_lock);
> -	ret = arm_smmu_share_asid(mm, asid);
> +	ret = arm_smmu_share_asid(tbl, mm, xa, asid, asid_bits);
>  	if (ret) {
> -		mutex_unlock(&arm_smmu_asid_lock);
>  		goto out_free_cd;
>  	}
>  
> -	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
> -	mutex_unlock(&arm_smmu_asid_lock);
> -
> +	err = xa_insert(xa, asid, cd, GFP_KERNEL);
>  	if (err)
>  		goto out_free_asid;
>  
> @@ -406,21 +404,26 @@ arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
>  	cd->asid = asid;
>  	cd->mm = mm;
>  
> -	return cd;
> +	pst_mn->vendor.cd = cd;
> +	return pst_mn;
>  
>  out_free_asid:
> -	iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd);
> +	arm_smmu_free_asid(xa, cd);
>  out_free_cd:
>  	kfree(cd);
> +out_free_mn:
> +	kfree(pst_mn);
>  out_put_context:
>  	arm64_mm_context_put(mm);
>  	return err < 0 ? ERR_PTR(err) : ret;
>  }
>  
> -void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
> -			     struct arm_smmu_ctx_desc *cd)
> +static void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
> +				    struct xarray *xa, void *cookie)

Could we pass a struct iommu_psdtable_mmu_notifier, since that's what
alloc_shared() returns?

>  {
> -	if (iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd)) {
> +	struct arm_smmu_ctx_desc *cd = cookie;
> +
> +	if (iommu_psdtable_free_asid(tbl, xa, cd)) {
>  		/* Unpin ASID */
>  		arm64_mm_context_put(cd->mm);
>  		kfree(cd);
> @@ -428,11 +431,13 @@ void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
>  }
>  
>  struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
> -	.alloc	 = arm_smmu_alloc_cd_tables,
> -	.free	 = arm_smmu_free_cd_tables,
> -	.prepare = arm_smmu_prepare_cd,
> -	.write	 = arm_smmu_write_ctx_desc,
> -	.free_asid = arm_smmu_free_asid,
> +	.alloc		= arm_smmu_alloc_cd_tables,
> +	.free		= arm_smmu_free_cd_tables,
> +	.prepare	= arm_smmu_prepare_cd,
> +	.write		= arm_smmu_write_ctx_desc,
> +	.free_asid	= arm_smmu_free_asid,
> +	.alloc_shared	= arm_smmu_alloc_shared_cd,
> +	.free_shared	= arm_smmu_free_shared_cd,
>  };
>  
>  struct iommu_pasid_table *
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index da35d4cc0c1e..ef28d0c409da 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -13,23 +13,12 @@
>  #include "../../io-pgtable-arm.h"
>  #include "../../iommu-pasid-table.h"
>  
> -struct arm_smmu_mmu_notifier {
> -	struct mmu_notifier		mn;
> -	struct arm_smmu_ctx_desc	*cd;
> -	bool				cleared;
> -	refcount_t			refs;
> -	struct list_head		list;
> -	struct arm_smmu_domain		*domain;
> -};
> -
> -#define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
> -
>  struct arm_smmu_bond {
> -	struct iommu_sva		sva;
> -	struct mm_struct		*mm;
> -	struct arm_smmu_mmu_notifier	*smmu_mn;
> -	struct list_head		list;
> -	refcount_t			refs;
> +	struct iommu_sva			sva;
> +	struct mm_struct			*mm;
> +	struct iommu_psdtable_mmu_notifier	*smmu_mn;
> +	struct list_head			list;
> +	refcount_t				refs;
>  };
>  
>  #define sva_to_bond(handle) \
> @@ -41,20 +30,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  					 struct mm_struct *mm,
>  					 unsigned long start, unsigned long end)
>  {
> -	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> -	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> +	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
> +	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
> +	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
>  	size_t size = end - start + 1;
>  
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> -		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> +		arm_smmu_tlb_inv_range_asid(start, size, cd->asid,
>  					    PAGE_SIZE, false, smmu_domain);
>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>  }
>  
>  static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
> -	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> -	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> +	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
> +	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
> +	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
>  	struct iommu_pasid_table *tbl = smmu_domain->tbl;
>  
>  	mutex_lock(&sva_lock);
> @@ -69,7 +60,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	 */
>  	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, &quiet_cd);

Another comment for the parent series: I'd prefer making this a
"iommu_psdtable_quiesce()" call, instead of passing "quiet_cd" between
driver and library. Because that won't work if the SMMU driver is a module
or disabled - build of virtio-iommu will probably fail since quiet_cd will
be undefined. We could make the library built-in and move quiet_cd there,
but an explicit library call seems cleaner.

>  
> -	iommu_psdtable_flush_tlb(tbl, smmu_domain, smmu_mn->cd->asid);
> +	iommu_psdtable_flush_tlb(tbl, smmu_domain, cd->asid);

We can directly call arm_smmu_tlb_inv* here. iommu_psdtable_flush_tlb()
should only be called from the library. But with the previous comment,
this invalidation would move to the library.

>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>  
>  	smmu_mn->cleared = true;
> @@ -78,7 +69,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  
>  static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>  {
> -	kfree(mn_to_smmu(mn));
> +	kfree(mn_to_pstiommu(mn));
>  }
>  
>  static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
> @@ -88,63 +79,59 @@ static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>  };
>  
>  /* Allocate or get existing MMU notifier for this {domain, mm} pair */
> -static struct arm_smmu_mmu_notifier *
> +static struct iommu_psdtable_mmu_notifier *
>  arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>  			  struct mm_struct *mm)
>  {
>  	int ret;
> -	struct arm_smmu_ctx_desc *cd;
> -	struct arm_smmu_mmu_notifier *smmu_mn;
> +	struct iommu_psdtable_mmu_notifier *smmu_mn;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct iommu_pasid_table *tbl = smmu_domain->tbl;
>  
> -	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
> +	list_for_each_entry(smmu_mn, &tbl->mmu_notifiers, list) {
>  		if (smmu_mn->mn.mm == mm) {
>  			refcount_inc(&smmu_mn->refs);
>  			return smmu_mn;
>  		}
>  	}
>  
> -	cd = arm_smmu_alloc_shared_cd(tbl, mm);
> -	if (IS_ERR(cd))
> -		return ERR_CAST(cd);
> -
> -	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
> -	if (!smmu_mn) {
> -		ret = -ENOMEM;
> -		goto err_free_cd;
> -	}
> +	mutex_lock(&arm_smmu_asid_lock);
> +	smmu_mn = iommu_psdtable_alloc_shared(tbl, mm, &arm_smmu_asid_xa,
> +					      smmu->asid_bits);
> +	mutex_unlock(&arm_smmu_asid_lock);
> +	if (IS_ERR(smmu_mn))
> +		return ERR_CAST(smmu_mn);
>  
>  	refcount_set(&smmu_mn->refs, 1);
> -	smmu_mn->cd = cd;
> -	smmu_mn->domain = smmu_domain;
> +	smmu_mn->cookie = smmu_domain;
>  	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
>  
>  	ret = mmu_notifier_register(&smmu_mn->mn, mm);
> -	if (ret) {
> -		kfree(smmu_mn);
> +	if (ret)
>  		goto err_free_cd;
> -	}
>  
> -	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, cd);
> +	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
> +				   smmu_mn->vendor.cd);

Pass smmu_mn here, and let the library code get the cd (to allow for other
pasid table implementations)

>  	if (ret)
>  		goto err_put_notifier;
>  
> -	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
> +	list_add(&smmu_mn->list, &tbl->mmu_notifiers);

I'd keep the mmu_notifiers list in domain if the library doesn't use it
for anything.

That made me wonder whether the whole of arm_smmu_mmu_notifer_get/put()
could move to the library, since the virtio-iommu version seems to be the
same. They probably belong in iommu-sva-lib but we can revisit that when
there are more users.

Thanks,
Jean

>  	return smmu_mn;
>  
>  err_put_notifier:
>  	/* Frees smmu_mn */
>  	mmu_notifier_put(&smmu_mn->mn);
>  err_free_cd:
> -	arm_smmu_free_shared_cd(tbl, cd);
> +	iommu_psdtable_free_shared(tbl, &arm_smmu_asid_xa, smmu_mn->vendor.cd);
>  	return ERR_PTR(ret);
>  }
>  
> -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> +static void
> +arm_smmu_mmu_notifier_put(struct iommu_psdtable_mmu_notifier *smmu_mn)
>  {
>  	struct mm_struct *mm = smmu_mn->mn.mm;
> -	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
> -	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> +	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
> +	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
>  	struct iommu_pasid_table *tbl = smmu_domain->tbl;
>  
>  	if (!refcount_dec_and_test(&smmu_mn->refs))
> @@ -164,7 +151,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>  
>  	/* Frees smmu_mn */
>  	mmu_notifier_put(&smmu_mn->mn);
> -	arm_smmu_free_shared_cd(tbl, cd);
> +	iommu_psdtable_free_shared(tbl, &arm_smmu_asid_xa, cd);
>  }
>  
>  static struct iommu_sva *
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bbc4dc75de72..e55567b4d2f4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1987,7 +1987,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	mutex_init(&smmu_domain->init_mutex);
>  	INIT_LIST_HEAD(&smmu_domain->devices);
>  	spin_lock_init(&smmu_domain->devices_lock);
> -	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
>  
>  	return &smmu_domain->domain;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 13ff024ab0d5..8a689b4316ac 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -737,8 +737,6 @@ struct arm_smmu_domain {
>  
>  	struct list_head		devices;
>  	spinlock_t			devices_lock;
> -
> -	struct list_head		mmu_notifiers;
>  };
>  
>  static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -773,10 +771,6 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
>  void arm_smmu_sva_unbind(struct iommu_sva *handle);
>  u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
> -struct arm_smmu_ctx_desc *
> -arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm);
> -void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
> -			     struct arm_smmu_ctx_desc *cd);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
> @@ -832,13 +826,5 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>  }
>  
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
> -struct arm_smmu_ctx_desc *
> -arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
> -					   struct arm_smmu_ctx_desc *cd) {}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
