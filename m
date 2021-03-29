Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B85C433C1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4995361581
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4995361581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1343A40131;
	Mon, 29 Mar 2021 16:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kj1R5vRd3h_O; Mon, 29 Mar 2021 16:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB48140125;
	Mon, 29 Mar 2021 16:22:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57295C000A;
	Mon, 29 Mar 2021 16:22:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70655C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50FCE402DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qw4ULkPq43l8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:22:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2B56402AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:22:19 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id j7so13498514wrd.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jZbWweHIj/iw1Oz6DYxQVEIzp/1xsW8SliME+sloCtE=;
 b=v5BIfzssEyWHaeWvOMenXdg/ShP4omXLwwwTl5P9IiKBjEQEnFCvXfdlcTHvD3rKqt
 0QovNRCSLDyrotfiUA/HQPerYJTVXXZjIvB4l0p0RbOPBe7Grd+xLRumEu1CAAkJXJA7
 ApNJ3UKtdnvwVvy0YUiV8fgal7daW7pKYF3YVVmTSTlJ/kxHo/ZEzxneQUs9ED8GMdge
 lp3H0XDfAg/P+mq4iEoF7EEZfv7RBSpXJWp5miiHTYwnlxyYJm2GegL7TYmfTrUebA6L
 BYBxL7GmPjL1SdVurioHfx1F/Y6urULxFiWxeQYwNL3mBB88QDBDeAPP33rPLANH7b2G
 98Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jZbWweHIj/iw1Oz6DYxQVEIzp/1xsW8SliME+sloCtE=;
 b=EucZq2DjLwSRbs/B+FiI+qwpSVM/N8/+5IvMf1cpRTiyQ8voG576w9VTTTGcX3adWX
 hstOi/4maOsJZ31Ycv8uXbsc/shWYJvkaXj+V5LxvDD79LQXrseaFzTuykK8L6Zy0Y+P
 7P//+0shg+gGKf1Az+ch2suAcLUpH4LGHegcO7kihfr1d/WtqdV0mTcL9U6O8TT0zYQj
 YneRZIpXMMrfPnQip1mHQQPFMIgc5Jh2MHxZDM1A2ov/y/YEobkTUD2vSeq/zS1gTDnk
 yoyoDeF6ZmG98MCwC0p1m+wW5v7TCWgG9zX/0Ia0D31EABLuTtacidhrh1x2CgsttSJ3
 1H6g==
X-Gm-Message-State: AOAM533IR6w6QvGAwWmgLY2qbUIf0bho0+j6ghZa2HyswtJbX6Z00JPp
 0tGXXDXbuVztukruWvZ8sPpgoA==
X-Google-Smtp-Source: ABdhPJz7MvKPUQKWgDaNYw187loYoMGXwbMaxT87b8Cm4aAN69o65xT6zTUwjl1xl1XKHggGy5zNhw==
X-Received: by 2002:adf:e582:: with SMTP id l2mr29775270wrm.207.1617034938172; 
 Mon, 29 Mar 2021 09:22:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v18sm31545369wru.85.2021.03.29.09.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 09:22:17 -0700 (PDT)
Date: Mon, 29 Mar 2021 18:21:59 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 13/15] iommu/virtio: Attach Arm PASID tables when
 available
Message-ID: <YGH+pyO8bEKNhhGl@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-14-vivek.gautam@arm.com>
 <YD/GeIJA/ARevO7X@myrica>
 <ee88590b-513e-7821-ab52-18d496ad90dc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee88590b-513e-7821-ab52-18d496ad90dc@arm.com>
X-TUID: x5lqDTusQD9a
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

On Fri, Mar 12, 2021 at 06:59:17PM +0530, Vivek Kumar Gautam wrote:
> > > +	/* XXX HACK: set feature bit ARM_SMMU_FEAT_2_LVL_CDTAB */
> > > +	pst_cfg->vendor.cfg.feat_flag |= (1 << 1);
> > 
> > Oh right, this flag is missing. I'll add
> > 
> >    #define VIRTIO_IOMMU_PST_ARM_SMMU3_F_CD2L (1ULL << 1)
> > 
> > to the spec.
> 
> Regarding this Eric pointed out [1] in my other patch about the scalability
> of the approach where we keep adding flags in 'iommu_nesting_info'
> corresponding to the arm-smmu-v3 capabilities. I guess the same goes to
> these flags in virtio.
> May be the 'iommu_nesting_info' can have a bitmap with the caps for vendor
> specific features, and here we can add the related flags?

Something like that, but I'd keep separate arch-specific structs. Vt-d
reports the capability registers directly through iommu_nesting_info [2].
We could do the same for Arm, copy sanitized values of IDR0..5 into
struct iommu_nesting_info_arm_smmuv3.

I've avoided doing that for virtio-iommu because every field needs a
description in the spec. So where possible I used generic properties that
apply to any architecture, such as page, PASID and address size. What's
left is the minimum arch-specific information to get nested translation
going, leaving out a lot of properties such as big-endian and 32-bit,
which can be added later if needed. The Arm specific properties are split
into page table and pasid table information. Page table info should work
for both SMMUv2 and v3 (where they correspond to an SMMU_IDRx field that
constrains a context descriptor field.) I should move BTM in there since
it's supported by SMMUv2.

Thanks,
Jean

[2] https://lore.kernel.org/linux-iommu/20210302203545.436623-11-yi.l.liu@intel.com/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
