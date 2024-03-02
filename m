Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B051364
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Mar 2024 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346994; cv=none; b=YT/uXSAQWL/+3GQjS7y1niWWPdx/YvkBUhpJ5+D927R13fqHUl4WwOsaAe4uHCUeQTqTlHigI6xQZNWQ/z4gtyjcH8Hcr01NMH/Se64xJJPCUIU/kw7Y82IlhyUqhLF09D0u2G3+X/mqGlcP7hpFobZ3de8JVp2ZLkOZERTyoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346994; c=relaxed/simple;
	bh=h85jpT5VMKAmcwx8xjty1pBSWn4rm7EQTJbenc1Kkn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fp0sEaUYhGHq4RAvpYFKMHcmc9Ldq2AgcyY7xdyKDR/NENCExKxNek9/BcMJQw6OPHerQ2HXJP0YwnvhtTNdNS+5bQvnn098Qqm5li13b48CHkqHZI+TIliIEgH80SeU0Uhv059Yvv3tqmkHZMjXbpcADUdJfNV7VezX+TB5zKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGs9Zda4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGs9Zda4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C034741EE4
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Mar 2024 02:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDNiCSejBDj2
	for <virtualization@lists.linux-foundation.org>;
	Sat,  2 Mar 2024 02:36:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6BC3741EE5
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BC3741EE5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QGs9Zda4
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6BC3741EE5
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Mar 2024 02:36:31 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-513298d6859so2420752e87.3
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Mar 2024 18:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709346989; x=1709951789; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5POyl/4677bPTPLA6iBYKpbwNy+pWBIIcesnixttt5A=;
        b=QGs9Zda4JV7J8zybVipXeKJRmtJ6zj4E1u7n20wMJ6x4EjJKMT/acuUO3GEgBwKRkJ
         vDYqPAa/536dcP6iT2CiquwpDT0H0CejJP14J4KDVpfoVCoANqPVLdQ3SdvrH7jBdcr4
         5jbV/Jx2YE88DqpTO+OsbF8s0G9VK5MHjdPx9mcgvwBP0aFLCmTo/KZiW8fc9ZEQ5tHq
         M0TN0gmsXu4KmYKl6u9ovUD8ko7mspEDOT8f5a3VyVhmbtNaaPMgNcjeVywo5ROXurcT
         ENNfzqBXtrLn4opQz/EuOzjMSXptjFkI5hYSsxmxpVRiArtUSHXJWTS1NG56m4SGdbAo
         Wufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709346989; x=1709951789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5POyl/4677bPTPLA6iBYKpbwNy+pWBIIcesnixttt5A=;
        b=t68SLEaWmSm5Kx9lEmQpueyJC8RxLvhixv9u64oU7OcCD3L9f/Eti82yz1QvbWcTjZ
         d7DIMXVZKjYrfcRiEkGbnBSZKzqMBWkeZmjjHMlpd8xXv40CzjluIDp8XlWTbAVzX/5A
         R1VVZ8OiHlvRcvTgQ4mdp7vZStxoZx2CAF3oW7p4X5m+ltQrFLDve8YBC6qGDzJF6SCT
         /0aQvhVdiPCGbfihyk3Y6tPq6IR9tVdKQqMNhZluZiv1XafgHcfGBgWYqj+zPPGS8gX8
         IQYkQlZXQLrWhQtEMTdrwqP+/SqWEw+K2CdSDtZ9Da5ZWQzM7H9Kd6xIXniKX3hay37S
         hbQw==
X-Forwarded-Encrypted: i=1; AJvYcCVNuJFKuUaJlx15pTlKwo91BKzksq2uwt6cLyzS3vReDhHkxLdjrk2Mj9UBLF1qyEGQCSgQhfNKdMQMzY/OoJ8FomGQMemZk77UI3TME1UWrzlySnPKdzvqrg==
X-Gm-Message-State: AOJu0Yywq23x3jpIZ0Jp+ByIov97tJJrTEKFJYfARARR226bbSnyo/d2
	nuLyzc4uF5PdyRi/hvo8UMtg8qqb/YTq2Ah5LV1svI4kkQFU+pt19KPxu8Uf19tvAECuet0GYxs
	2ApEtuX5TvuaEFsIrDLYZdtO5JviYLP+EFvCpTQ==
X-Google-Smtp-Source: AGHT+IHXwCc1btbgWjvxQYTUfULNjSSVQiId0NmekC+LhMs5EOmKYO9wVZMGd6O430V2MhOPIxRmQzaxlI79b0yDRl4=
X-Received: by 2002:a05:6512:78d:b0:512:d575:4745 with SMTP id
 x13-20020a056512078d00b00512d5754745mr2199873lfr.1.1709346988970; Fri, 01 Mar
 2024 18:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122073903.24406-1-baolu.lu@linux.intel.com> <20240122073903.24406-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 2 Mar 2024 10:36:17 +0800
Message-ID: <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with iommufd_hw_pgtable
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 15:46, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> When allocating a user iommufd_hw_pagetable, the user space is allowed to
> associate a fault object with the hw_pagetable by specifying the fault
> object ID in the page table allocation data and setting the
> IOMMU_HWPT_FAULT_ID_VALID flag bit.
>
> On a successful return of hwpt allocation, the user can retrieve and
> respond to page faults by reading and writing the file interface of the
> fault object.
>
> Once a fault object has been associated with a hwpt, the hwpt is
> iopf-capable, indicated by fault_capable set to true. Attaching,
> detaching, or replacing an iopf-capable hwpt to an RID or PASID will
> differ from those that are not iopf-capable. The implementation of these
> will be introduced in the next patch.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 11 ++++++++
>  include/uapi/linux/iommufd.h            |  6 +++++
>  drivers/iommu/iommufd/fault.c           | 14 ++++++++++
>  drivers/iommu/iommufd/hw_pagetable.c    | 36 +++++++++++++++++++------
>  4 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 52d83e888bd0..2780bed0c6b1 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -293,6 +293,8 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
>  struct iommufd_hw_pagetable {
>         struct iommufd_object obj;
>         struct iommu_domain *domain;
> +       struct iommufd_fault *fault;
> +       bool fault_capable : 1;
>  };
>
>  struct iommufd_hwpt_paging {
> @@ -446,8 +448,17 @@ struct iommufd_fault {
>         struct wait_queue_head wait_queue;
>  };
>
> +static inline struct iommufd_fault *
> +iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +       return container_of(iommufd_get_object(ucmd->ictx, id,
> +                                              IOMMUFD_OBJ_FAULT),
> +                           struct iommufd_fault, obj);
> +}
> +
>  int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
>  void iommufd_fault_destroy(struct iommufd_object *obj);
> +int iommufd_fault_iopf_handler(struct iopf_group *group);
>
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c32d62b02306..7481cdd57027 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
>   *                                the parent HWPT in a nesting configuration.
>   * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
>   *                                   enforced on device attachment
> + * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
> + *                             valid.
>   */
>  enum iommufd_hwpt_alloc_flags {
>         IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>         IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
> +       IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
>  };
>
>  /**
> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>   * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>         __u32 __reserved;
>         __u32 data_type;
>         __u32 data_len;
> +       __u32 fault_id;
>         __aligned_u64 data_uptr;
>  };
>  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 9844a85feeb2..e752d1c49dde 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -253,3 +253,17 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
>
>         return rc;
>  }
> +
> +int iommufd_fault_iopf_handler(struct iopf_group *group)
> +{
> +       struct iommufd_hw_pagetable *hwpt = group->cookie->domain->fault_data;
> +       struct iommufd_fault *fault = hwpt->fault;
> +
> +       mutex_lock(&fault->mutex);
> +       list_add_tail(&group->node, &fault->deliver);
> +       mutex_unlock(&fault->mutex);
> +
> +       wake_up_interruptible(&fault->wait_queue);
> +
> +       return 0;
> +}
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 3f3f1fa1a0a9..2703d5aea4f5 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,15 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>
> +static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
> +{
> +       if (hwpt->domain)
> +               iommu_domain_free(hwpt->domain);
> +
> +       if (hwpt->fault)
> +               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
> +}
> +
>  void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
>  {
>         struct iommufd_hwpt_paging *hwpt_paging =
> @@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
>                                          hwpt_paging->common.domain);
>         }
>
> -       if (hwpt_paging->common.domain)
> -               iommu_domain_free(hwpt_paging->common.domain);
> -
> +       __iommufd_hwpt_destroy(&hwpt_paging->common);
>         refcount_dec(&hwpt_paging->ioas->obj.users);
>  }
>
> @@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
>         struct iommufd_hwpt_nested *hwpt_nested =
>                 container_of(obj, struct iommufd_hwpt_nested, common.obj);
>
> -       if (hwpt_nested->common.domain)
> -               iommu_domain_free(hwpt_nested->common.domain);
> -
> +       __iommufd_hwpt_destroy(&hwpt_nested->common);
>         refcount_dec(&hwpt_nested->parent->common.obj.users);
>  }
>
> @@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>         struct iommufd_hw_pagetable *hwpt;
>         int rc;
>
> -       if (flags || !user_data->len || !ops->domain_alloc_user)
> +       if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
> +           !user_data->len || !ops->domain_alloc_user)
>                 return ERR_PTR(-EOPNOTSUPP);
>         if (parent->auto_domain || !parent->nest_parent)
>                 return ERR_PTR(-EINVAL);
> @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>         refcount_inc(&parent->common.obj.users);
>         hwpt_nested->parent = parent;
>
> -       hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
> +       hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
>                                               parent->common.domain, user_data);

Why remove flags? typo or any reason?
arm_smmu_domain_alloc_user  can not get flags from the user app.
User should set IOMMU_HWPT_FAULT_ID_VALID, right?

Thanks
