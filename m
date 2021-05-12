Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82437C43460
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 15:31:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD2D61CB3
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 15:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD2D61CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7198C404A3;
	Wed, 12 May 2021 15:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVeKIS4GP_kB; Wed, 12 May 2021 15:31:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D551F404A8;
	Wed, 12 May 2021 15:31:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEF44C000E;
	Wed, 12 May 2021 15:31:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE1E3C0024
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5BA56071D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYCE5JaPQu8P
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:31:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 995F7608E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:31:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id f1so5349674edt.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=foMbcJ9t/jw1PCF1w8ZLUJQPw4LhtMPOdZ9n9vc+2JY=;
 b=OSx+Ho0M1jKEBkXetkktVDTXudOBNAtPrBVu1YzuVKuTEL1/sS15FPlFFafNV89tco
 NJmlEchhll3j8ZSNq0vnDjLSrR6IeXopJ2aWzzibU3P5McgiEBSg5oZxObnFBtfCd5Q5
 MUSFdOM78SjxcxNUdfhiDx2preN2CamXZg+uo8TvF38qyhemUE1xaDY9JJhz31VE0hBq
 K1KZmg8t3QdmgxzE860qpEhIS/YHtJ8T9mMzATy5C+kQxhq8AwfncXGJMrwPI8/zAtdk
 vL28ba67Her9n6wZeYU5P+AljnG59cHjN91Wp36UCB8Yy//g85zmJIMFF4CgTUdtadqX
 dP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=foMbcJ9t/jw1PCF1w8ZLUJQPw4LhtMPOdZ9n9vc+2JY=;
 b=i/YHNGdjsa/RNpKoQqX130BF7hCooMwW6BpQ4bWgv1B0vbH4EI/hoGijb0jlcvuTss
 OYQ6lxn09sc7uMwfPDPwWmOTyPiK0rit9rz3Z8yf9aPJsL7pIvnQi0YNy1xqd3JUQuAR
 s7wJLh88bRzTTMTb1zFSnhQx3kApM72FTZw5KM6lG0kiU9FYVLh7jxS0wMU8+D/IGjyS
 pBLSgXMF6BgsioNP7++/XnY7pIkYwvoiWj1aHBg6BNCKXBe9ajiYxodpJLHTQ5887vXI
 2Iqnl/c/QDW+ZCObVTIPfJA9A/b6/rdIyTSpEa7ZaMWc7K1CRBfHyXMpd+bPYOpWj7kU
 wHFg==
X-Gm-Message-State: AOAM533hU0i4PaORigHuraXVhbxe5+WwnC3pYtdW//8YHvV4nn4Bmi9e
 qBRBRwZoDXPbK/pkarqDvlbRZA==
X-Google-Smtp-Source: ABdhPJz7r5xZBOfByReNbNmN+wJFbb276iWLe5bA39oV+ikWetjEf06uCnPbDSA7ak1z9EzB+Nvgyw==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr44159494edr.111.1620833460097; 
 Wed, 12 May 2021 08:31:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id di7sm68216edb.34.2021.05.12.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 08:30:59 -0700 (PDT)
Date: Wed, 12 May 2021 17:30:42 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bixuan Cui <cuibixuan@huawei.com>
Subject: Re: [PATCH -next] iommu/virtio: Add missing MODULE_DEVICE_TABLE
Message-ID: <YJv0osddxKqlFUyT@myrica>
References: <20210508031451.53493-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210508031451.53493-1-cuibixuan@huawei.com>
Cc: Joerg Roedel <joro@8bytes.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Sat, May 08, 2021 at 11:14:51AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>

Fixes: fa4afd78ea12 ("iommu/virtio: Build virtio-iommu as module")
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 7c02481a81b4..c6e5ee4d9cef 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1136,6 +1136,7 @@ static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_IOMMU, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, id_table);
>  
>  static struct virtio_driver virtio_iommu_drv = {
>  	.driver.name		= KBUILD_MODNAME,
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
