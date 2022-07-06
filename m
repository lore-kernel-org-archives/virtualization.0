Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C481FC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 17:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FFBE417D9;
	Wed,  6 Jul 2022 17:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FFBE417D9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VS/bX/+V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ttCsFuBuqK2; Wed,  6 Jul 2022 17:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36FF2417DA;
	Wed,  6 Jul 2022 17:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36FF2417DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9B9C0035;
	Wed,  6 Jul 2022 17:42:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97589C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 17:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F12381310
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 17:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F12381310
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VS/bX/+V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JsZZG6ckRoNA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 17:42:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 470088129B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 470088129B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657129347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bm6ni0e0Z3ZqDaHM6VmzfCaa2VxT43x1YW4zQJliK1o=;
 b=VS/bX/+Vu38g2mUxNvCNUsYi17HjwgN8SRmc+JnmdM7re6LxWiqGk7rhSleVvXi/+l5hN6
 uNoqlbyiFY+o+RAEQ3Ms6M4vImPHhoDeAWCLsLTo2TVNt8iM5zW09HflITezqzBsQDOVZE
 xouIWArAtAVjSpROPLGEbHU3UQKGZyU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-JIoS-3CMNK2O9Rqs_sOxkA-1; Wed, 06 Jul 2022 13:42:21 -0400
X-MC-Unique: JIoS-3CMNK2O9Rqs_sOxkA-1
Received: by mail-il1-f197.google.com with SMTP id
 o9-20020a056e0214c900b002dc29c288bfso2728367ilk.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 10:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=Bm6ni0e0Z3ZqDaHM6VmzfCaa2VxT43x1YW4zQJliK1o=;
 b=cJ6Wb0PL1fnpjwfGqvO1P3zU3X73RDjqQ7i1Ei4xQ7FZT0hkHiBvyfj1F9f8N/+Kx5
 oe9LlPF1NTxv8+p4IlxBCgVtXJRmMG/qReWG2In32I+mVLPPusEesFf5NyLK5Dw9XBiD
 Ixl9doZjwUmudXonBO8PFOTnleHvYcR0QhKQIB692J+F0XcUx280BX4kJCoyIHGRCxdn
 NIbof/2Q0U5vSu1T+yQSynnctXNYTqLXjhIwn51ZRqTgodmTxr2LWJh1eL27WVVCueiU
 0516XxE4HxPMTEJIQ+F+Kk+yWX6jndSET1CoVpwafE7Mq4er6H9G4fjmyI5awc3MS01y
 /KLw==
X-Gm-Message-State: AJIora/Snb+nMjkzDB1yjxqvay8VMoVqGDT1RmcfwBZ+IjbuJbJrTeZP
 W1Fjz3KKnXIKm3IhLOLbDNZcDwwsMnXDjHnNITC0WweD61bp1gd7hcmub3nkVgWBG7JXwxIYzQs
 jKdwjXxoMe6mxvYLRxu29ibo10B6wXuPowPTL4MolCA==
X-Received: by 2002:a05:6e02:1be6:b0:2db:ea7f:10c4 with SMTP id
 y6-20020a056e021be600b002dbea7f10c4mr17220913ilv.248.1657129340275; 
 Wed, 06 Jul 2022 10:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tKW5hHrIbN8D8MKAPlov0FsaTgJJCZrivyPi82ikNP5NQmibHb26OWtdHiMispm5nOi3tbJA==
X-Received: by 2002:a05:6e02:1be6:b0:2db:ea7f:10c4 with SMTP id
 y6-20020a056e021be600b002dbea7f10c4mr17220872ilv.248.1657129339926; 
 Wed, 06 Jul 2022 10:42:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 i83-20020a6bb856000000b0065a47e16f53sm17005663iof.37.2022.07.06.10.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 10:42:19 -0700 (PDT)
Date: Wed, 6 Jul 2022 11:42:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 0/5] cover-letter: Simplify vfio_iommu_type1
 attach/detach routine
Message-ID: <20220706114217.105f4f61.alex.williamson@redhat.com>
In-Reply-To: <20220701214455.14992-1-nicolinc@nvidia.com>
References: <20220701214455.14992-1-nicolinc@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, marcan@marcan.st, mjrosato@linux.ibm.com,
 virtualization@lists.linux-foundation.org, thierry.reding@gmail.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 kvm@vger.kernel.org, zhang.lyra@gmail.com, joro@8bytes.org,
 jonathanh@nvidia.com, iommu@lists.linux.dev, jgg@nvidia.com,
 yangyingliang@huawei.com, orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com,
 sven@svenpeter.dev, linux-arm-msm@vger.kernel.org, john.garry@huawei.com,
 vdumpa@nvidia.com, christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 chenxiang66@hisilicon.com, dwmw2@infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, baolin.wang7@gmail.com, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, 1 Jul 2022 14:44:50 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> This is a preparatory series for IOMMUFD v2 patches. It enforces error
> code -EMEDIUMTYPE in iommu_attach_device() and iommu_attach_group() when
> an IOMMU domain and a device/group are incompatible. It also drops the
> useless domain->ops check since it won't fail in current environment.
> 
> These allow VFIO iommu code to simplify its group attachment routine, by
> avoiding the extra IOMMU domain allocations and attach/detach sequences
> of the old code.
> 
> Worths mentioning the exact match for enforce_cache_coherency is removed
> with this series, since there's very less value in doing that as KVM will
> not be able to take advantage of it -- this just wastes domain memory.
> Instead, we rely on Intel IOMMU driver taking care of that internally.
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/vfio_iommu_attach

How do you foresee this going in, I'm imagining Joerg would merge the
first patch via the IOMMU tree and provide a topic branch that I'd
merge into the vfio tree along with the remaining patches.  Sound
right?  Thanks,

Alex

 
> Changelog
> v5:
>  * Rebased on top of Robin's "Simplify bus_type determination".
>  * Fixed a wrong change returning -EMEDIUMTYPE in arm-smmu driver.
>  * Added Baolu's "Reviewed-by".
> v4:
>  * Dropped -EMEDIUMTYPE change in mtk_v1 driver per Robin's input
>  * Added Baolu's and Kevin's Reviewed-by lines
> v3: https://lore.kernel.org/kvm/20220623200029.26007-1-nicolinc@nvidia.com/
>  * Dropped all dev_err since -EMEDIUMTYPE clearly indicates what error.
>  * Updated commit message of enforce_cache_coherency removing patch.
>  * Updated commit message of domain->ops removing patch.
>  * Replaced "goto out_unlock" with simply mutex_unlock() and return.
>  * Added a line of comments for -EMEDIUMTYPE return check.
>  * Moved iommu_get_msi_cookie() into alloc_attach_domain() as a cookie
>    should be logically tied to the lifetime of a domain itself.
>  * Added Kevin's "Reviewed-by".
> v2: https://lore.kernel.org/kvm/20220616000304.23890-1-nicolinc@nvidia.com/
>  * Added -EMEDIUMTYPE to more IOMMU drivers that fit the category.
>  * Changed dev_err to dev_dbg for -EMEDIUMTYPE to avoid kernel log spam.
>  * Dropped iommu_ops patch, and removed domain->ops in VFIO directly,
>    since there's no mixed-driver use case that would fail the sanity.
>  * Updated commit log of the patch removing enforce_cache_coherency.
>  * Fixed a misplace of "num_non_pinned_groups--" in detach_group patch.
>  * Moved "num_non_pinned_groups++" in PATCH-5 to the common path between
>    domain-reusing and new-domain pathways, like the code previously did.
>  * Fixed a typo in EMEDIUMTYPE patch.
> v1: https://lore.kernel.org/kvm/20220606061927.26049-1-nicolinc@nvidia.com/
> 
> Jason Gunthorpe (1):
>   vfio/iommu_type1: Prefer to reuse domains vs match enforced cache
>     coherency
> 
> Nicolin Chen (4):
>   iommu: Return -EMEDIUMTYPE for incompatible domain and device/group
>   vfio/iommu_type1: Remove the domain->ops comparison
>   vfio/iommu_type1: Clean up update_dirty_scope in detach_group()
>   vfio/iommu_type1: Simplify group attachment
> 
>  drivers/iommu/amd/iommu.c                   |   2 +-
>  drivers/iommu/apple-dart.c                  |   4 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  15 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |   5 +-
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   9 +-
>  drivers/iommu/intel/iommu.c                 |  10 +-
>  drivers/iommu/iommu.c                       |  28 ++
>  drivers/iommu/ipmmu-vmsa.c                  |   4 +-
>  drivers/iommu/omap-iommu.c                  |   3 +-
>  drivers/iommu/s390-iommu.c                  |   2 +-
>  drivers/iommu/sprd-iommu.c                  |   6 +-
>  drivers/iommu/tegra-gart.c                  |   2 +-
>  drivers/iommu/virtio-iommu.c                |   3 +-
>  drivers/vfio/vfio_iommu_type1.c             | 352 ++++++++++----------
>  14 files changed, 229 insertions(+), 216 deletions(-)
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
