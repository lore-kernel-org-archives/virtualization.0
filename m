Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E333372
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127526; cv=none; b=rcaqnSGzZzvZjGrFm3KSQtqNW0CWWgCnkN7h4apapFOoGankleJ6iKeM8NVP+Mpgp978HqZ96qe9rK1pRTYhjRjBJZqICEGyzQeZsuZR+TDF8Bve5a+ArinMUW0ci0lcum/CsECHpA8ugzFlGTJVWXd0iGNAjfsMvwM6JuykMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127526; c=relaxed/simple;
	bh=yYyTvuGPY9Yh5W/zUy0ZLLfIboxNn47n/XUpWdPEdkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnRwVulVsw/xAvHiqcsEAzqUrz8fZlSQFDMK049OYKabbqQ99zArS0GSQFf9Zc47/cfGQJbMIezn/7ew1qnRwep/SIYwypXolCloyucQ1eNnfIFf+qCiAUNa+FC3t0IGD8rOuAUAIvdzs0900YBcf5hMEpJWkyWQbvO+8Lmh/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VaL7umq/; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VaL7umq/"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D23DE605E8
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BE5RKTnQnPCq for <virtualization@lists.linux-foundation.org>;
 Wed,  8 May 2024 00:18:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 56EC2605D0
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56EC2605D0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VaL7umq/
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56EC2605D0
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:18:43 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7928ec5308cso28743985a.1
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127522; x=1715732322; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=VaL7umq/YRqLYop8ltVRcMKKwpnVBlwHYaaBTFig1z+8bF5xN8k7TjF1aHEWJR2FPH
         XCGdteaJhTyNGXfBsSJkpU/yE8bj9wYHA9YvmQJL18dMwESVnAECbF6+WY3ueqBOCzmP
         lrZmQHHSPTQnLDsLiTrI2/H2jmk5qTqqeCySfZ+/MHep9SJl1tNHKZ0SDZGEzXoSvgy/
         2Nn+miPq33IM2x5maapALWZ34yUC4gCwUoLnHLgn4+dkBDp78hjRh59LwgkhpAzQuyYM
         gIAaTjqCg2VKVr9Rm818SM33nuoQ9gUpXDqOIvsLV6WYN5mLot34hMm5wJtDaYxXBr3m
         m1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127522; x=1715732322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=Y46jYM6iLhDnIkhGpjrQvSNH8b9LXNvJk8mGx2/zKPOLPYMoOQfvTkt3tmnzB9xw7m
         OVAWiUlCyncFsrmnPwLTQFI/Let6qShBRvtEeZ2KMrtHotBPPV+eOxfzUi5Pa78TmJym
         4Ojx0ESRkySU+gV/SuKUb/xTBDJcO0vSzplYk7Vt+pPa7Zn9ILVTAzoGBgbO0/OWGD0k
         P1e/MoGp6Ckpsjvd1gF0pBreBm0j0w0O2Z2ffW1FTeH1yKj5CtEZA/nUXLeoEKm5MdGb
         tFIyzr1wbaCvkBhy6hLavlnujLNhgaB55vrTD42m6JkX9KUle2ks79XzMD6ow1MOupxf
         H93g==
X-Forwarded-Encrypted: i=1; AJvYcCVem8zejumO132KoBleLiufpbpZ6xGpUDQ3dBEbI6JAgJwor0+jejm2u4UpfDCSJjXLnmVTrbGGeUiy/AEBuVUwWEKCEqR9dLbz6XSaisVm7d9gKMdydUO5Tw==
X-Gm-Message-State: AOJu0YwdGZzsxxEH+i61bHpWo2gL4N654r15rJmzGm0Vm+AHsYnNxUbe
	4HL3WT8b/cZ7gfVLrej0Mu/Opowgb2rM/j7XmHn3dYJPewdPoKBZzUMH8Ac3ouw=
X-Google-Smtp-Source: AGHT+IH/oKAJDpiDkQ/SfwUCo/HBUUtNt6FLW2j+wSJ+9VeCJKucyFKqJPPS4SU5qDn89BCTBGrk9w==
X-Received: by 2002:a05:620a:1901:b0:790:ec77:4c1a with SMTP id af79cd13be357-792a64cdb96mr636436685a.39.1715127522026;
        Tue, 07 May 2024 17:18:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a44c700b007929ca64e0fsm2160454qkp.5.2024.05.07.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:18:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V16-0004sp-PU;
	Tue, 07 May 2024 21:18:40 -0300
Date: Tue, 7 May 2024 21:18:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240508001840.GO4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-7-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 13125c0feecb..6357229bf3b4 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -15,6 +15,124 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>  
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	int ret;
> +
> +	if (idev->iopf_enabled)
> +		return 0;
> +
> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	idev->iopf_enabled = true;
> +
> +	return 0;
> +}

I would greatly prefer we remove this from the drivers :\ I guess it
is Ok for now

Doesn't this need a counter? We can have many fault capable PASIDs?
That will get changed in the PASID series?

Jason

