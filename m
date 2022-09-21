Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F90C32771
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 08:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AABE40CE1;
	Wed, 21 Sep 2022 08:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AABE40CE1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cs5Dvxfm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q7wdswz2pz0Z; Wed, 21 Sep 2022 08:55:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7FFCF402E7;
	Wed, 21 Sep 2022 08:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FFCF402E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5305EC0033;
	Wed, 21 Sep 2022 08:55:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8B69C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C1D240908
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C1D240908
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cs5Dvxfm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oQQoOKPsl241
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:55:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1FAC40907
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1FAC40907
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:55:08 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id ay36so3968239wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=NMm6vbupuNg3e8G1erinu7XgiIOmdNdtykV6wWBx/V8=;
 b=cs5Dvxfm7fd7aaUwKHNDAnKWcNrqMyWvSpCFhYmNjRwKQjf697cP12ef2JVhzS+nTr
 rBiEPfFCAvK18V0b4TPU93sWl3nBICTtuO2MuXRVpLAsvrnPMrSMT8utfj6qRBivTxti
 BXRo7n7yiwy1VFEU65sNSMFb9wbJX0Y01wSWLKT5xxq4/13Ub6Q0C+MSyK+vNliqzKv7
 7DJIhCBeCbjUg+pZttjuEgYoPhQn5piUM0+uqu6ez9uuEzMnz+dnjzErRDjuyGOk/BYS
 UkhbQnQFMY8EjTuZOsOAEbzscpTOQfKIqXeSfDZd9sFya7VbVqAP+h8BvB+DFZ+Idka/
 wnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=NMm6vbupuNg3e8G1erinu7XgiIOmdNdtykV6wWBx/V8=;
 b=liP1uWXPzcr4NHN4VEvyOdEpWiLuH1ZKXdE/aTa86+PF3Suz1dbSAvD1QiGRTtWGtR
 FE9eHpGpoviod8bpJPXRDM861MGTCaVKevdDZ3NZAEVTQOd7q8WkjxBYJqXnBdeiXiLM
 yDp2p5gv4UovlwlFCraePlN+qRp+9tM+k6yatXG1YOtDvea+YcmYJGlkN5jM/KARvgoO
 RFxXGhjXNsLTJJHlcaddnJ6TNWPKamsa3iisiAQVm5oZa+TKqtVu336So3U+JPKRxnnc
 mFhPzPw4b1BWTFc33xge6Rpqn2EQdiMNgv5El+QGvqLlf2ndACQXOeWkqxfZ12LDKJWp
 VlvA==
X-Gm-Message-State: ACrzQf20kQjugPMkTUXFyqg6zWBPpBvfcUhH+G+/yzoLBJfRrLWO5ulU
 1tdYSZ6WnBWmGQ0mr9SAwiOWZw==
X-Google-Smtp-Source: AMsMyM5v4ccQB/sVn2S/zJDFsH4keJ/VCqNp428gK8IV32RalM87u6d3xbyo/Rp+qs75y4SGFW5eBA==
X-Received: by 2002:a1c:202:0:b0:3a8:4197:eec0 with SMTP id
 2-20020a1c0202000000b003a84197eec0mr5125375wmc.83.1663750506995; 
 Wed, 21 Sep 2022 01:55:06 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 p14-20020a5d48ce000000b0022afbd02c69sm1949060wrs.56.2022.09.21.01.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Sep 2022 01:55:06 -0700 (PDT)
Date: Wed, 21 Sep 2022 09:55:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 0/6] Define EINVAL as device/domain incompatibility
Message-ID: <YyrRZXVWWxBhW3ST@myrica>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
Cc: quic_saipraka@quicinc.com, konrad.dybcio@somainline.org,
 bjorn.andersson@linaro.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, will@kernel.org, zhang.lyra@gmail.com,
 joro@8bytes.org, jon@solid-run.com, jonathanh@nvidia.com,
 iommu@lists.linux.dev, agross@kernel.org, linux-arm-kernel@lists.infradead.org,
 jgg@nvidia.com, yangyingliang@huawei.com, orsonzhai@gmail.com,
 linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 thunder.leizhen@huawei.com, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 dwmw2@infradead.org, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 sricharan@codeaurora.org, baolu.lu@linux.intel.com
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

On Wed, Sep 21, 2022 at 01:22:31AM -0700, Nicolin Chen wrote:
> This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
> https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/
> 
> The purpose is to regulate all existing ->attach_dev callback functions to
> use EINVAL exclusively for an incompatibility error between a device and a
> domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
> try a different domain with the same device.
[...]
>  drivers/iommu/amd/iommu.c                   | 12 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 --
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +--
>  drivers/iommu/fsl_pamu.c                    |  2 +-
>  drivers/iommu/fsl_pamu_domain.c             |  4 +-
>  drivers/iommu/intel/iommu.c                 | 10 ++--
>  drivers/iommu/intel/pasid.c                 |  6 ++-
>  drivers/iommu/iommu.c                       | 22 ++++++++
>  drivers/iommu/ipmmu-vmsa.c                  |  2 -
>  drivers/iommu/msm_iommu.c                   | 59 +++++++++++----------
>  drivers/iommu/mtk_iommu.c                   |  4 +-
>  drivers/iommu/omap-iommu.c                  |  6 +--
>  drivers/iommu/sprd-iommu.c                  |  4 +-
>  drivers/iommu/tegra-gart.c                  |  2 +-
>  drivers/iommu/virtio-iommu.c                |  7 ++-

For virtio-iommu:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  include/linux/iommu.h                       | 12 +++++
>  17 files changed, 90 insertions(+), 83 deletions(-)
> 
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
