Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DCC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 15:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68EBF415E5;
	Wed,  7 Sep 2022 15:37:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68EBF415E5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmAVErYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGHVdwbfC_QF; Wed,  7 Sep 2022 15:37:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7F0A0410E5;
	Wed,  7 Sep 2022 15:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F0A0410E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0C8C0032;
	Wed,  7 Sep 2022 15:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0F48C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB74682884
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB74682884
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=fmAVErYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDgV9H0JIjKg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:37:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A93282881
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A93282881
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:37:43 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 n17-20020a05600c501100b003a84bf9b68bso9759166wmr.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=BHH6C0MUaJBB869uVqxXVXUx/Qb6hgtg09Hc0S0gRlE=;
 b=fmAVErYkQX071cLsx9F39Ti7u+NaH5nA5kS00lXR3MVqHtL3FNz2nmH5D2zNicV8hT
 aNhwWld4iVLs0KfgwZIcoU32p1cykSzWtx++QDNPPf0An7+3XSkHReXHGjVNLzA2FFmV
 YCKMsex/6UCYEjBoh4S9ib3j0aDc7XiZWTvBkDhyvsipuEGKZZxxAM4VnDuENETHESut
 3GvAnFflx9mRUa8RhybiY2oWRlBwHMAv2/1v/qerdDLYvNtlnU0JVIaf1QgSjpQfGnX/
 lFq8AGck95Jh5He4NNsC7zI9N8p2wW4XoFUPM8DxwGR1dT+q+sWczy50nNML1ydpZEz4
 RIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=BHH6C0MUaJBB869uVqxXVXUx/Qb6hgtg09Hc0S0gRlE=;
 b=zBUJqSVVUHb7QPiIvV2hzdHZKyTf8d4aVRi2Ar6Ql9L9dmjtwxvEvUhiQxwVS8DMDm
 mPB1k41eJlTIo+VpN0kCCSG0vkGKHJ4wI0mtUzFwEW6Kk32wNe9sLr0vYi4u1eQmMrrc
 Oxh13zEbiOCWu9Z/hL5vlejtAEtCQQafy/lbRwmhD1E5X6swNvinVmsO8/drrPeckcgZ
 YeGJgxZyGqOsSPvGa3fS7xKlLTbNkY41c1qXYjohVd0ZI+y+zii16oXnGwVdamUTKOt7
 40rCFql2NPwYLGanRHe1waHCC4IrTZsFQRLPMf0x8kRvJB6pW7Cml3JDw1B2pDIv4YVq
 1VxQ==
X-Gm-Message-State: ACgBeo2z3tvHXm66CCxTnJlrR0UhZpKAVYXPZccB5jryBb3QhCyVDr20
 51j6n1cbgdOUzzHHi/3n3qYVPQ==
X-Google-Smtp-Source: AA6agR4ofgU8cPouQN9kizhK4U/lWO9bgN6PyukytEIk8MDxkvAGlGOMwR9R7FY7qaZk1ueOehi9iw==
X-Received: by 2002:a05:600c:2f88:b0:3a5:4014:4b47 with SMTP id
 t8-20020a05600c2f8800b003a540144b47mr16977056wmn.96.1662565062164; 
 Wed, 07 Sep 2022 08:37:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 bp6-20020a5d5a86000000b00228692033dcsm13011401wrb.91.2022.09.07.08.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 08:37:41 -0700 (PDT)
Date: Wed, 7 Sep 2022 16:37:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Message-ID: <Yxi6wXDVU3h83Np2@myrica>
References: <20220907151154.21911-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220907151154.21911-1-joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Sep 07, 2022 at 05:11:54PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent fix introduced viommu_capable() but other changes
> from Robin change the function signature of the call-back it
> is used for.
> 
> When both changes are merged a compile error will happen
> because the function pointer types mismatch. Fix that by
> updating the viommu_capable() signature after the merge.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index da463db9f12a..1b12825e2df1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
> -static bool viommu_capable(enum iommu_cap cap)
> +static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  {
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
> -- 
> 2.36.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
