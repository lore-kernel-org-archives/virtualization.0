Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD17C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 16:09:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D87760E76
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 16:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D87760E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3808D403F2;
	Tue, 21 Sep 2021 16:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZxrNkDsYvI1W; Tue, 21 Sep 2021 16:09:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 421B2403F0;
	Tue, 21 Sep 2021 16:09:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2245AC000F;
	Tue, 21 Sep 2021 16:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9424DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82D54402FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u_4lPleQykiR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:09:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 611B2402E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:09:52 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id t8so40826892wrq.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=n/dUevHsiLdE2irKaS1K4eioH3NiOV8sQVgnvAoo5Ko=;
 b=mfU91cRuSYxoetgBDYjcRxoyjxzZNOhzDWtY9d0TYAAmHG0KE/ijeHoF7573yNouyH
 RkVW0cPEEr6cTRAn0+3XYADRMFj0hG7QpVeZQyPRKy6yWxP9rSdhTwYK6A7qjsqioj0I
 DL1dMhbzXj1kHxEulMNRKhALT3iaSxiJg3zSBt4NGDbGRSztkRW2NwzVHKOh6C1+ir2q
 lOKAenY5YLo+A5ur2WYBK95yVMjqo+DZLGY3onk8smssehg0eg9KB0dEl6TSvukBb1eG
 Nu+77/ytnWeV1lqlaLwQeSvXNbJHVE1MDxw0OvymIuiRf4Kej3stGYgUA/TxbY4KENe8
 Gl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n/dUevHsiLdE2irKaS1K4eioH3NiOV8sQVgnvAoo5Ko=;
 b=hKEtCp1KYeAzFe9klncLSQe9Fx0wtgL3+2iV1UnRk1vCNhc2s6sDhKuelRlsz34313
 I2tC/j7SXkprVYEScy1VH9DZaHYntlkrTz+GIw1/y3IEsVtOlC+Uhf5cdEvPksJzR/8W
 6ea/t2GAvtkdNzG104AFh52TrfVjRThC55QGfWoVV132dBKIWDjpJjam0xycNfGinIPA
 o3u24bMxqQ7kLZTUBrOBiKUAGsQmcUMj5y/MEMx/D97AtZR9xlLiD2f4L9cE3OP2ir6l
 hRcmU5FClZXo6v5AtQfuLmJ8qoWgkI3LGtduaA4XyrFMJR/jjiW0y07oa4hGHdJA71Jl
 9qyQ==
X-Gm-Message-State: AOAM531bs/LxUjXfXM3bUZguChsRxyY5+y7A8xGWOt8yJDRMehkR/HPU
 ksOd0sXmxVsG4BwRMd3tpMm/PQ==
X-Google-Smtp-Source: ABdhPJxBu+3YJh8avIZrTawiYkjU/W2b+1aQMbVujqjUbPyuv6hyDWne+bNnYKVD0hbLSVljVhUkuA==
X-Received: by 2002:a05:600c:1c26:: with SMTP id
 j38mr5732706wms.12.1632240590526; 
 Tue, 21 Sep 2021 09:09:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id c4sm13205218wrt.23.2021.09.21.09.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 09:09:50 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:09:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 09/11] iommu/virtio: Implement sva bind/unbind calls
Message-ID: <YUoDuOg0pVw8GGOl@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-10-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-10-vivek.gautam@arm.com>
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

On Fri, Apr 23, 2021 at 03:21:45PM +0530, Vivek Gautam wrote:
> SVA bind and unbind implementations will allow to prepare translation
> context with CPU page tables that can be programmed into host iommu
> hardware to realize shared address space utilization between the CPU
> and virtualized devices using virtio-iommu.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c      | 199 +++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_iommu.h |   2 +
>  2 files changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 250c137a211b..08f1294baeab 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -14,6 +14,9 @@
>  #include <linux/interval_tree.h>
>  #include <linux/iommu.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/mm.h>
> +#include <linux/mmu_context.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/module.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
> @@ -28,6 +31,7 @@
>  #include <uapi/linux/virtio_iommu.h>
>  #include "iommu-pasid-table.h"
>  #include "iommu-sva-lib.h"
> +#include "io-pgtable-arm.h"

Is this used here?

>  
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> @@ -41,6 +45,7 @@ DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
>  
>  static DEFINE_MUTEX(sva_lock);
>  static DEFINE_MUTEX(iopf_lock);
> +static DEFINE_MUTEX(viommu_asid_lock);
>  
>  struct viommu_dev_pri_work {
>  	struct work_struct		work;
> @@ -88,10 +93,22 @@ struct viommu_mapping {
>  struct viommu_mm {
>  	int				pasid;
>  	u64				archid;
> +	struct viommu_sva_bond		*bond;
>  	struct io_pgtable_ops		*ops;
>  	struct viommu_domain		*domain;
>  };
>  
> +struct viommu_sva_bond {
> +	struct iommu_sva		sva;
> +	struct mm_struct		*mm;
> +	struct iommu_psdtable_mmu_notifier	*viommu_mn;
> +	struct list_head		list;
> +	refcount_t			refs;
> +};
> +
> +#define sva_to_viommu_bond(handle) \
> +	container_of(handle, struct viommu_sva_bond, sva)
> +
>  struct viommu_domain {
>  	struct iommu_domain		domain;
>  	struct viommu_dev		*viommu;
> @@ -136,6 +153,7 @@ struct viommu_endpoint {
>  	bool				pri_supported;
>  	bool				sva_enabled;
>  	bool				iopf_enabled;
> +	struct list_head		bonds;
>  };
>  
>  struct viommu_ep_entry {
> @@ -1423,14 +1441,15 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  
>  		pst_cfg->iommu_dev = viommu->dev->parent;
>  
> +		mutex_lock(&viommu_asid_lock);
>  		/* Prepare PASID tables info to allocate a new table */
>  		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
>  		if (ret)
> -			return ret;
> +			goto err_out_unlock;
>  
>  		ret = iommu_psdtable_alloc(tbl, pst_cfg);
>  		if (ret)
> -			return ret;
> +			goto err_out_unlock;
>  
>  		pst_cfg->iommu_dev = viommu->dev->parent;
>  		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
> @@ -1452,6 +1471,7 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  			if (ret)
>  				goto err_free_ops;
>  		}
> +		mutex_unlock(&viommu_asid_lock);
>  	} else {
>  		/* TODO: otherwise, check for compatibility with vdev. */
>  		return -ENOSYS;
> @@ -1467,6 +1487,8 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  err_free_psdtable:
>  	iommu_psdtable_free(tbl, &tbl->cfg);
>  
> +err_out_unlock:
> +	mutex_unlock(&viommu_asid_lock);
>  	return ret;
>  }
>  
> @@ -1706,6 +1728,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  	vdev->dev = dev;
>  	vdev->viommu = viommu;
>  	INIT_LIST_HEAD(&vdev->resv_regions);
> +	INIT_LIST_HEAD(&vdev->bonds);
>  	dev_iommu_priv_set(dev, vdev);
>  
>  	if (viommu->probe_size) {
> @@ -1755,6 +1778,175 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
> +static u32 viommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
> +
> +	return bond->mm->pasid;
> +}
> +
> +static void viommu_mmu_notifier_free(struct mmu_notifier *mn)
> +{
> +	kfree(mn_to_pstiommu(mn));
> +}
> +
> +static struct mmu_notifier_ops viommu_mmu_notifier_ops = {
> +	.free_notifier		= viommu_mmu_notifier_free,

.invalidate_range and .release will be needed as well, to keep up to date
with changes to the address space

> +};
> +
> +/* Allocate or get existing MMU notifier for this {domain, mm} pair */
> +static struct iommu_psdtable_mmu_notifier *
> +viommu_mmu_notifier_get(struct viommu_domain *vdomain, struct mm_struct *mm,
> +			u32 asid_bits)
> +{
> +	int ret;
> +	struct iommu_psdtable_mmu_notifier *viommu_mn;
> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
> +
> +	list_for_each_entry(viommu_mn, &tbl->mmu_notifiers, list) {
> +		if (viommu_mn->mn.mm == mm) {
> +			refcount_inc(&viommu_mn->refs);
> +			return viommu_mn;
> +		}
> +	}
> +
> +	mutex_lock(&viommu_asid_lock);
> +	viommu_mn = iommu_psdtable_alloc_shared(tbl, mm, &viommu_asid_xa,
> +						asid_bits);
> +	mutex_unlock(&viommu_asid_lock);
> +	if (IS_ERR(viommu_mn))
> +		return ERR_CAST(viommu_mn);
> +
> +	refcount_set(&viommu_mn->refs, 1);
> +	viommu_mn->cookie = vdomain;
> +	viommu_mn->mn.ops = &viommu_mmu_notifier_ops;
> +
> +	ret = mmu_notifier_register(&viommu_mn->mn, mm);
> +	if (ret)
> +		goto err_free_cd;
> +
> +	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
> +				   viommu_mn->vendor.cd);
> +	if (ret)
> +		goto err_put_notifier;
> +
> +	list_add(&viommu_mn->list, &tbl->mmu_notifiers);
> +	return viommu_mn;
> +
> +err_put_notifier:
> +	/* Frees viommu_mn */
> +	mmu_notifier_put(&viommu_mn->mn);
> +err_free_cd:
> +	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
> +	return ERR_PTR(ret);
> +}
> +
> +static void
> +viommu_mmu_notifier_put(struct iommu_psdtable_mmu_notifier *viommu_mn)
> +{
> +	struct mm_struct *mm = viommu_mn->mn.mm;
> +	struct viommu_domain *vdomain = viommu_mn->cookie;
> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
> +	u16 asid = viommu_mn->vendor.cd->asid;
> +
> +	if (!refcount_dec_and_test(&viommu_mn->refs))
> +		return;
> +
> +	list_del(&viommu_mn->list);
> +	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, NULL);
> +
> +	/*
> +	 * If we went through clear(), we've already invalidated, and no
> +	 * new TLB entry can have been formed.
> +	 */
> +	if (!viommu_mn->cleared)
> +		iommu_psdtable_flush_tlb(tbl, vdomain, asid);
> +
> +	/* Frees smmu_mn */
> +	mmu_notifier_put(&viommu_mn->mn);
> +	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
> +}
> +
> +static struct iommu_sva *
> +__viommu_sva_bind(struct device *dev, struct mm_struct *mm)
> +{
> +	int ret;
> +	struct viommu_sva_bond *bond;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
> +
> +	if (!vdev || !vdev->sva_enabled)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* If bind() was already called for this {dev, mm} pair, reuse it. */
> +	list_for_each_entry(bond, &vdev->bonds, list) {
> +		if (bond->mm == mm) {
> +			refcount_inc(&bond->refs);
> +			return &bond->sva;
> +		}
> +	}
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Allocate a PASID for this mm if necessary */
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << vdev->pasid_bits) - 1);
> +	if (ret)
> +		goto err_free_bond;
> +
> +	bond->mm = mm;
> +	bond->sva.dev = dev;
> +	refcount_set(&bond->refs, 1);
> +
> +	bond->viommu_mn = viommu_mmu_notifier_get(vdomain, mm, desc->asid_bits);
> +	if (IS_ERR(bond->viommu_mn)) {
> +		ret = PTR_ERR(bond->viommu_mn);
> +		goto err_free_pasid;
> +	}
> +
> +	list_add(&bond->list, &vdev->bonds);
> +	return &bond->sva;
> +
> +err_free_pasid:
> +	iommu_sva_free_pasid(mm);
> +err_free_bond:
> +	kfree(bond);
> +	return ERR_PTR(ret);
> +}
> +
> +/* closely follows arm_smmu_sva_bind() */
> +static struct iommu_sva *viommu_sva_bind(struct device *dev,
> +					 struct mm_struct *mm, void *drvdata)
> +{
> +	struct iommu_sva *handle;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __viommu_sva_bind(dev, mm);
> +	mutex_unlock(&sva_lock);
> +	return handle;
> +}
> +
> +void viommu_sva_unbind(struct iommu_sva *handle)
> +{
> +	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(handle->dev);
> +
> +	if (vdev->pri_supported)
> +		iopf_queue_flush_dev(handle->dev);
> +
> +	mutex_lock(&sva_lock);
> +	if (refcount_dec_and_test(&bond->refs)) {
> +		list_del(&bond->list);
> +		viommu_mmu_notifier_put(bond->viommu_mn);
> +		iommu_sva_free_pasid(bond->mm);
> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> +
>  static bool viommu_endpoint_iopf_supported(struct viommu_endpoint *vdev)
>  {
>  	/* TODO: support Stall model later */
> @@ -1960,6 +2152,9 @@ static struct iommu_ops viommu_ops = {
>  	.dev_feat_enabled	= viommu_dev_feature_enabled,
>  	.dev_enable_feat	= viommu_dev_enable_feature,
>  	.dev_disable_feat	= viommu_dev_disable_feature,
> +	.sva_bind		= viommu_sva_bind,
> +	.sva_unbind		= viommu_sva_unbind,
> +	.sva_get_pasid		= viommu_sva_get_pasid,
>  };
>  
>  static int viommu_init_vqs(struct viommu_dev *viommu)
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 88a3db493108..c12d9b6a7243 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -122,6 +122,8 @@ struct virtio_iommu_req_attach_pst_arm {
>  #define VIRTIO_IOMMU_PGTF_ARM_HPD0		(1ULL << 41)
>  #define VIRTIO_IOMMU_PGTF_ARM_EPD1		(1 << 23)
>  
> +#define VIRTIO_IOMMU_PGTF_ARM_IPS_SHIFT		32
> +#define VIRTIO_IOMMU_PGTF_ARM_IPS_MASK		0x7

Probably not the right place for this change

Thanks,
Jean

>  #define VIRTIO_IOMMU_PGTF_ARM_TG0_SHIFT		14
>  #define VIRTIO_IOMMU_PGTF_ARM_TG0_MASK		0x3
>  #define VIRTIO_IOMMU_PGTF_ARM_SH0_SHIFT		12
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
