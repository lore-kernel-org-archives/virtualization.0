Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF0CC6FA82
	for <virtualization@archiver.kernel.org>; Tue, 13 Sep 2022 12:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D9FC4047C;
	Tue, 13 Sep 2022 12:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D9FC4047C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=miJorPWG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DbEYuCX9ZiHU; Tue, 13 Sep 2022 12:27:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7EC4400F2;
	Tue, 13 Sep 2022 12:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7EC4400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A89D4C0033;
	Tue, 13 Sep 2022 12:27:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F122C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 12:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56E0F60AEC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 12:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56E0F60AEC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=miJorPWG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r_WQHMUVSKcB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 12:27:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5272860BE7
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5272860BE7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 12:27:14 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id n8so1807186wmr.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=VTC8+roq761rPO1lbs0pNCCJS3R+FuNtWSS5Z+GCYq0=;
 b=miJorPWGXKjdCvQfUrlK5b1TBnftK3ihkKzT7xqaUavMG7CeLtoJKGsTDgIrHxw1I3
 2o8xQkGSzosqM7uGO5cLcDrsoGHQ8twTWgHZ2vDCp7Moq8rQyncPJPf9AH7M4U8xaxAM
 YggevJiZ/hK+JQccvTf9e0cZGg7o7aOJH35ps/x9/3ARbo/2W107ZSA8CUuSjnPY3N3y
 soct36MtuIzorK4dk2RWaf9fYqjmfgyJjBzvbG5Q6v2vAtcjNhQLt/2tXAKSrGGFkQfM
 wrSlwNuWKXmVGgcul7JnWyX4aFqYYq/VYsG9T/I1xdpyUdb4FKPcIL7ldqP87qC+7eEg
 /5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=VTC8+roq761rPO1lbs0pNCCJS3R+FuNtWSS5Z+GCYq0=;
 b=bIyd9WwntP/53S/z7xbu3ooEm9NKuhiTrKyvK1N7a41nzCdgo6ZS3A3Bbz6cDpEb17
 S21hAe6Vt558vqYDOQ+8FXDI39upxsI/KQ9eNDsfDjLC6ynd+tZdIQ8zIYM89ODOnLJO
 Bmq18+xfs+EPxSS4iL3ZxI2P3mLn7AYOTlY+gU+M4SWxSQRUTREE9DN3CCSY7ZpCu0Ij
 WNrUtDt3giOMlJpRtL5h2ZsV07u5AHxjiZyAnoRYmhOaGpe9u+1jJ0N365Io98Kn1rO3
 iwgPWdRG+ARfuQuDZJpjr3EBpxxucFNGSIybemKZqUEW1HzaFNY5haq+EsD95uUQ/Wdr
 xfKg==
X-Gm-Message-State: ACgBeo06sp65tnS7xsBUQFRSh1Djota4g+5wSdYHZl4KTlrG7HpKFR5D
 sSRo6TeXP3U1vy29In8zgOG4/A==
X-Google-Smtp-Source: AA6agR6T+QLT8jB5Xi/vSWb9EBDtxlHd1ocjnlnMMf5JCbG+ys2vKBcb/2DyNzFGWO0wDCo6sPf6Iw==
X-Received: by 2002:a05:600c:6026:b0:3b4:94ff:c019 with SMTP id
 az38-20020a05600c602600b003b494ffc019mr2218246wmb.101.1663072028280; 
 Tue, 13 Sep 2022 05:27:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b003b47b913901sm2496769wmq.1.2022.09.13.05.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Sep 2022 05:27:07 -0700 (PDT)
Date: Tue, 13 Sep 2022 13:27:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyB3F/o3RfymqiFW@myrica>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913082448.31120-5-nicolinc@nvidia.com>
Cc: heiko@sntech.de, konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 zhang.lyra@gmail.com, joro@8bytes.org, jon@solid-run.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com,
 vdumpa@nvidia.com, christophe.jaillet@wanadoo.fr,
 baolin.wang@linux.alibaba.com, thunder.leizhen@huawei.com,
 matthias.bgg@gmail.com, tglx@linutronix.de,
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

Hi Nicolin,

On Tue, Sep 13, 2022 at 01:24:47AM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return ENODEV error code for all device
> specific errors. It particularly excludes EINVAL from being used for such
> error cases. For the same purpose, also replace one EINVAL with ENOMEM in
> mtk_iommu driver.
> 
> Note that the virtio-iommu does a viommu_domain_map_identity() call, which
> returns either 0 or ENOMEM at this moment. Change to "return ret" directly
> to allow it to pass an EINVAL in the future.
[...]
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80151176ba12..874c01634d2b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  		if (ret) {
>  			ida_free(&viommu->domain_ids, vdomain->id);
>  			vdomain->viommu = NULL;
> -			return -EOPNOTSUPP;
> +			return ret;

I think in the future it will be too easy to forget about the constrained
return value of attach() while modifying some other part of the driver,
and let an external helper return EINVAL. So I'd rather not propagate ret
from outside of viommu_domain_attach() and finalise().

For the same reason I do prefer this solution over EMEDIUMTYPE, because
it's too tempting to use exotic errno when they seem appropriate instead
of boring ENODEV and EINVAL. The alternative would be adding a special
purpose code to linux/errno.h, similarly to EPROBE_DEFER, but that might
be excessive.

Since we can't guarantee that APIs like virtio or ida won't ever return
EINVAL, we should set all return values:

--- 8< ---
From 7b16796cb78d11971236f98fd2d3cd73ca769827 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Tue, 13 Sep 2022 12:53:02 +0100
Subject: [PATCH] iommu/virtio: Constrain return value of viommu_attach_dev()

Ensure viommu_attach_dev() only return errno values expected from the
attach_dev() op. In particular, only return EINVAL when we're sure that
the device is incompatible with the domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..582ff5a33b52 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -669,13 +669,13 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
 			viommu_page_size, PAGE_SIZE);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
 			      viommu->last_domain, GFP_KERNEL);
 	if (ret < 0)
-		return ret;
+		return -ENOMEM;
 
 	vdomain->id		= (unsigned int)ret;
 
@@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return -ENODEV;
 		}
 	}
 
@@ -734,7 +734,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
@@ -769,7 +769,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	if (!vdomain->nr_endpoints) {
@@ -779,7 +779,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_replay_mappings(vdomain);
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	vdomain->nr_endpoints++;
-- 
2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
