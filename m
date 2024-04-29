Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BC1420DD
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422305; cv=none; b=d5U6mU1xmlBe3ZFA+QlGBGY6+rS2gSo8TWq51XJ2YfBI1bbz+Po1bvejU9RvLngggHlFTAyGJprmgbK/z//HgdulI6yH01tDwSTkbZyqHU5AH6vKsnDOutBvRSYhOAdsuyewn2Z+a7q5Ll02gaZ3y9FPXVXf4hjnlASCQRJxPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422305; c=relaxed/simple;
	bh=hGkJQ2hEBOMlcZ1QQLXlHGuMxkhZEnRo9lDvpVvAHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyLTvVS4Y3aSPZYjRlGhvGg7tcP8nUFU8bGGbXMjzmR9SJMsJ1KdbbsuiaHXAmQ4fOXoJRprQdc39TFDOtPZ0fYpsmlcIfZmJk1WTDMPChYUvnZ587YxEg/7GrLgl5zq1ymplrIXi9IYvj0jHuvTtPp7Tk9tsapyUt23tUNRXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oAzrtyAy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oAzrtyAy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F52B4035D
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 20:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMNheYJ09jHD for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Apr 2024 20:25:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 826D540359
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 826D540359
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oAzrtyAy
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 826D540359
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 20:25:01 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-69b9365e584so48269976d6.1
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714422300; x=1715027100; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=oAzrtyAyaOyi0tjwcxQW30nBqDxZnMSA0w/sBJuv/7+06mKRDOMJXHtkDcanP0rBdS
         TilTadEaixrxiYfI8NA9I9A7AcP/px/3TTKqo8SD3ZvKpgBGVXqkDgL7GlPn5B8EqhIr
         pubpNbZAjdtQS01hR44RSWhhPnu2xcscY8ogYVgSNtAyD188MBcwJM8wDl2hwbhJndmI
         WI6j9s5DXqrXx//j1+1ZqpikB4OU3Q1sioN+F23jRu9zFSUuyqP+QGXE7dZpmb2lZGHM
         7+umQsZclpQU65lqLU4U/y9CVuDjG2rM8Or2M0r7N12vZXHPxtoaDe0xGXpDtgEgSdHp
         /WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422300; x=1715027100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=D94sSA7K0wwr86yoaJqPITYPdkRbCOGbO0LS21nNPK+gYfBsBy/l1eDOdvKxWgaFVW
         48Fuvjc2Va0YKw+37pshtmXOwUL86lvtNenTMXrF+BCV0tbuZyrbv5w8SUVWx4XGRxsD
         jAUpHCZQIQYHGYxoOt3LKKRJk3nxpEs8FhnUw7ZUX3TXc6yrqnBK94FDe6rjs3MQvjyT
         ejtjLzkFYKuwT4/182Tmtn4sZiC7qbjckSBlv2r/p6LWguTmsHuKOAlaOvXX8Gr+9EYP
         WX7z48nLwTRUXldFUytqAuNwinW1RB5CJ1YmLWRjoOHvR4RK7pl04pY2FCC5eDhpbq3s
         k0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcsnX/djaPYOXe70MqzrwYI0jdaY8vXD+UNq4c2o9M4d7syGDub7jOPTYHI72UbvffmCu+s/AGiqBqH6oKefayOwn0nmsbOBCpOu7I1Zmxt4JDfYkQdkSdFw==
X-Gm-Message-State: AOJu0Yw+p66Y9DTne9adferCsDVQh4TB7YBqbVlSVy25fwIzX43uZLIU
	amm+4r4LyNoH0wljuX6gGJW2pOj8aiyqqCfHSK9ST0mekvE0fl1rUJa7OAg/gAE=
X-Google-Smtp-Source: AGHT+IF06oYaGQ5jj9Iw6KSync38cZEI2xitY/lo/JDJPZex4PeINFt5C+ktEksqHFLkO2LXKXqFgA==
X-Received: by 2002:a05:6214:170c:b0:6a0:c155:a650 with SMTP id db12-20020a056214170c00b006a0c155a650mr1291314qvb.23.1714422300544;
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id x8-20020ad44588000000b0069b432df140sm3829579qvu.121.2024.04.29.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1XYY-002rmm-3g;
	Mon, 29 Apr 2024 17:24:58 -0300
Date: Mon, 29 Apr 2024 17:24:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240429202458.GR231144@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>

On Sun, Apr 28, 2024 at 06:22:28PM +0800, Baolu Lu wrote:

>         /* A bond already exists, just take a reference`. */
>         handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>         if (handle) {
>                 if (handle->domain->iopf_handler != iommu_sva_iopf_handler)
> {
>                         ret = -EBUSY;
>                         goto out_unlock;
>                 }
> 
>                 refcount_inc(&handle->users);
>                 mutex_unlock(&iommu_sva_lock);
>                 return handle;
>         }
> 
> But it appears that this code is not lock safe. If the domain on the
> PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
> iommu_sva_iopf_handler" could result in a use-after-free issue as the
> other thread might detach the domain in between the fetch and check
> lines.

For the above you just need to pass in the iommu_sva_iopf_handler as
an argument to attach_handle_get() and have it check it under the
xa_lock.

The whole thing is already protected under the ugly sva_lock.

Ideally it would be protected by the group mutex..

Jason
