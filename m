Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6119BC4332F
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 15:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C59058149D;
	Mon,  7 Nov 2022 15:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C59058149D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CtQqMj5p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFCrLMr-w8Eb; Mon,  7 Nov 2022 15:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3836681467;
	Mon,  7 Nov 2022 15:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3836681467
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC3CC0032;
	Mon,  7 Nov 2022 15:27:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95F7DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 15:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63A9981499
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 15:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63A9981499
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wqlm1WCDGpC1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 15:26:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0B1B81467
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0B1B81467
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 15:26:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 189FAB8121D;
 Mon,  7 Nov 2022 15:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45829C433C1;
 Mon,  7 Nov 2022 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667834814;
 bh=W675gqNAfxBDemkU93uk7keZsNkIbPSTt12Mk3qnGOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CtQqMj5pvofsT6RL6c73nOHyJPNzYHtWR26lgwhR5lL+mFr3DLmnfXNOyM2ctk2EB
 DXSnyVmwBDVWCuh6t/jOYy4sGDpVuaah8fWod0gReT/fuEvZjRhpL+WKjRyfD3KxA5
 StyJ8iTVWr2AYevyJncv9jcjUdKTGN08CG+c4sb5sthZwvKGwtnyE5ke3jg/Iw5YSO
 IG58eDQv1Bu1n7fbiBR5ddQtysHqTwy/hn4mRBxbfYaLnb08KeHt4dh1qmmSMB2QnU
 Rbls6y5O+krcPIpTHylZ9sv6MHtZf+7JOJAm12EOSyHvBewer8sDqrAkrqaWflTupW
 qNvv+jC8xzkbQ==
Date: Mon, 7 Nov 2022 15:26:45 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <20221107152645.GD21002@willie-the-truck>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: quic_saipraka@quicinc.com, yangyicong@hisilicon.com,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 jean-philippe@linaro.org, zhang.lyra@gmail.com, joro@8bytes.org,
 jon@solid-run.com, jonathanh@nvidia.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, dwmw2@infradead.org, linux-arm-msm@vger.kernel.org,
 vdumpa@nvidia.com, christophe.jaillet@wanadoo.fr,
 baolin.wang@linux.alibaba.com, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 quic_jjohnson@quicinc.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 robin.murphy@arm.com, baolu.lu@linux.intel.com
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

On Mon, Oct 17, 2022 at 04:02:21PM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return EINVAL in the failure paths that
> are related to domain incompatibility.
> 
> Also, drop adjacent error prints to prevent a kernel log spam.
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
>  drivers/iommu/intel/iommu.c                 | 10 +++-------
>  drivers/iommu/ipmmu-vmsa.c                  |  2 --
>  drivers/iommu/omap-iommu.c                  |  2 +-
>  drivers/iommu/sprd-iommu.c                  |  4 +---
>  drivers/iommu/tegra-gart.c                  |  2 +-
>  drivers/iommu/virtio-iommu.c                |  3 +--
>  9 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ba47c73f5b8c..01fd7df16cb9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			goto out_unlock;
>  		}
>  	} else if (smmu_domain->smmu != smmu) {
> -		dev_err(dev,
> -			"cannot attach to SMMU %s (upstream of %s)\n",
> -			dev_name(smmu_domain->smmu->dev),
> -			dev_name(smmu->dev));
> -		ret = -ENXIO;
> +		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> -		dev_err(dev,
> -			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> -			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   smmu_domain->stall_enabled != master->stall_enabled) {
> -		dev_err(dev, "cannot attach to stall-%s domain\n",
> -			smmu_domain->stall_enabled ? "enabled" : "disabled");
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}

I think it would be helpful to preserve these messages using
dev_err_ratelimited() so that attach failure can be diagnosed without
having to hack the messages back into the driver.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
