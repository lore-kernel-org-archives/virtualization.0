Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34969C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 13:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B83936079E;
	Tue,  8 Nov 2022 13:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B83936079E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LZaBgX2V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kvDyt1OfhUc; Tue,  8 Nov 2022 13:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 396486076A;
	Tue,  8 Nov 2022 13:20:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 396486076A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 191E1C0033;
	Tue,  8 Nov 2022 13:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 608F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 13:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 347354028C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 13:20:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 347354028C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LZaBgX2V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y2jCB5g07aVM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 13:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38CCA401B7
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38CCA401B7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 13:20:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0BDC86148D;
 Tue,  8 Nov 2022 13:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7360C433D6;
 Tue,  8 Nov 2022 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667913651;
 bh=F1MrMjvh/L1F4zxWBX7r8xXYoMUO4ZXMTGWde/+UFd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LZaBgX2VaqGZgOh/2C0l++qPRlM8ueDrM9SLeSVBvUQEQ0+CNdo356p2qirP1dEgJ
 p/H4iy/1oAwn0ait0PvZKuBfPMAnQDFDkXJtKbJiot6gOdqiqVGf0/w7jk8vpPsbFI
 n39iYmDpzjVLSA1MXWr/cDCfrGf3A/+OHru3RiE4kPX3W97ALdEM6/h3yPQ0zjGCJZ
 q1ivEC4oeiOD9WI4AegBBhj03IgPbMrHzOGR+4pXQwzPuGiX7waZ0und1RxcXF1J+j
 MXeA9iQvAXVNy8WS4w2xu8rFWvjxhzh0obhV1OFgD6jSVycIiG4hb8lh5dBxyqba2D
 JHeBEQ2z21fvg==
Date: Tue, 8 Nov 2022 13:20:42 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <20221108132041.GB22816@willie-the-truck>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
 <20221107152645.GD21002@willie-the-truck>
 <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
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

On Mon, Nov 07, 2022 at 04:14:32PM -0800, Nicolin Chen wrote:
> On Mon, Nov 07, 2022 at 03:26:45PM +0000, Will Deacon wrote:
> 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index ba47c73f5b8c..01fd7df16cb9 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >                       goto out_unlock;
> > >               }
> > >       } else if (smmu_domain->smmu != smmu) {
> > > -             dev_err(dev,
> > > -                     "cannot attach to SMMU %s (upstream of %s)\n",
> > > -                     dev_name(smmu_domain->smmu->dev),
> > > -                     dev_name(smmu->dev));
> > > -             ret = -ENXIO;
> > > +             ret = -EINVAL;
> > >               goto out_unlock;
> > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > >                  master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> > > -             dev_err(dev,
> > > -                     "cannot attach to incompatible domain (%u SSID bits != %u)\n",
> > > -                     smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> > >               ret = -EINVAL;
> > >               goto out_unlock;
> > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > >                  smmu_domain->stall_enabled != master->stall_enabled) {
> > > -             dev_err(dev, "cannot attach to stall-%s domain\n",
> > > -                     smmu_domain->stall_enabled ? "enabled" : "disabled");
> > >               ret = -EINVAL;
> > >               goto out_unlock;
> > >       }
> 
> > I think it would be helpful to preserve these messages using
> > dev_err_ratelimited() so that attach failure can be diagnosed without
> > having to hack the messages back into the driver.
> 
> Thank you for the review.
> 
> The change is already picked up last week. Yet, I can add prints
> back with a followup patch, if no one has a problem with that.

Sorry, I fell behind with upstream so I got to this late. A patch on top
would be fantastic!

> Also, I am not quite sure what the use case would be to have an
> error print. Perhaps dev_dbg() would be more fitting if it is
> just for diagnosis?

Sure, that works for me. I think the messages are useful for folks
triggering this path e.g. via sysfs but if they're limited to debug I think
that's better than removing them altogether.

Cheers,

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
