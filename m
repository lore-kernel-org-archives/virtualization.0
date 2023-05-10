Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA45AC77B7D
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 08:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5799B61153;
	Wed, 10 May 2023 08:12:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5799B61153
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ls2RNsQd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_TCP1SqPg-Q; Wed, 10 May 2023 08:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE5EC60FBC;
	Wed, 10 May 2023 08:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE5EC60FBC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FAABC0037;
	Wed, 10 May 2023 08:12:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5154C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACC5F41C78
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACC5F41C78
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Ls2RNsQd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 91r5aOqaZfpF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:12:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D463841D55
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D463841D55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:12:07 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30771c68a9eso6127537f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683706326; x=1686298326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C6EsMAJBrwIXYtJEEeCQu1fc5qd/bCSpNSoDMMv2ltQ=;
 b=Ls2RNsQdi0se0zGx4zvVWlgD2WVc3rCLUuinUgHV/6vfIeJ1OM6ytIyBeJRabh/SYZ
 YzOK/VJ4uiRo/kBiMfSL9F4vyEuvLgJyOhgajHV44sNjBbEFee3D762xOcNKPQNzeIyb
 8Prsc+Z31foB6pA447gh5qnBQDIAmXbpxBxc1UZoSQKfSMsWt78BDae6r49A8qkxmKgV
 ILQbJEyGHTIPOhD5TcdQR3ikcyuxebE9z01Ob1RKoltxDk83yeKS0xBn4PS0NfI5/uZl
 4OnR8+dZfrkJj5trv6/KnwuMtJm6+lssOq9gXfPlKm9ElpRydSALejJ2k/pwRIWHiXyV
 dAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683706326; x=1686298326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6EsMAJBrwIXYtJEEeCQu1fc5qd/bCSpNSoDMMv2ltQ=;
 b=C13ubhCdKxPAquUio4ceSPZ5UMFBNefPof8Ns2VEYAa/7AB3N0OfiDgP0Q6sjQcdoZ
 +Mc4aqHFsEQhUB0jub9CgCVsj8k15yP3UwxL5ZxBrAOHA5fquGtW366ak5bgHsjTNm5N
 qyG66cyJKAjRbI6OcAFHRgiO/NKDUPRPzMlkP6xQBgeTCvk/O/ctt9vmMAEFfPPMB9C8
 dccUcv810tdWAOU5AMPXjw2WM6Fg6t5YFibW5f79vw4YHpmahKUsM0cKDrZLSvYZPV0r
 E9MINU2UYUiA6VzqR5JUa6U2s+d7ULqAl1V2GNU6r0Tr278Ou61Ql07lLY1dosxnjm6n
 12zg==
X-Gm-Message-State: AC+VfDwIMJT4y6ShHr2QB5farfVxdPuIxzJB88qnMHIhXYA76KBjblPN
 04kkx3gnpnx/4vYniUNqcVcixA==
X-Google-Smtp-Source: ACHHUZ7Oc/qKsllciWxkAsvKtMeLnUK4AO+mmgEQRyjg2ti6wAJ4Lx7DVWJCkn+PgfygTh/JU9SJRg==
X-Received: by 2002:adf:f749:0:b0:306:2de9:4c63 with SMTP id
 z9-20020adff749000000b003062de94c63mr11837824wrp.30.1683706325845; 
 Wed, 10 May 2023 01:12:05 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
 by smtp.gmail.com with ESMTPSA id
 x10-20020adfffca000000b002e61e002943sm16494160wrs.116.2023.05.10.01.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 May 2023 01:12:05 -0700 (PDT)
Date: Wed, 10 May 2023 09:11:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230510081157.GA3326511@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230414150744.562456-1-jean-philippe@linaro.org>
Cc: eric.auger@redhat.com, iommu@lists.linux.dev, robin.murphy@arm.com,
 akihiko.odaki@daynix.com, virtualization@lists.linux-foundation.org
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

Hi Joerg,

On Fri, Apr 14, 2023 at 04:07:45PM +0100, Jean-Philippe Brucker wrote:
> When an endpoint is released, for example a PCIe VF is disabled or a
> function hot-unplugged, it should be detached from its domain. Send a
> DETACH request.
> 
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This patch fixes device unregistration in the virtio-iommu driver, could
you please pick it up for the next batch of fixes?  It applies cleanly on
v6.4-rc1

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5b8fe9bfa9a5..3d3d4462359e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> +{
> +	int i;
> +	struct virtio_iommu_req_detach req;
> +	struct viommu_domain *vdomain = vdev->vdomain;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> +
> +	if (!vdomain)
> +		return;
> +
> +	req = (struct virtio_iommu_req_detach) {
> +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> +	}
> +	vdev->vdomain = NULL;
> +}
> +
>  static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
>  			    int prot, gfp_t gfp, size_t *mapped)
> @@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
>  {
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> +	viommu_detach_dev(vdev);
>  	iommu_put_resv_regions(dev, &vdev->resv_regions);
>  	kfree(vdev);
>  }
> -- 
> 2.40.0
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
