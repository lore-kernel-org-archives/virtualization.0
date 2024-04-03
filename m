Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086B14535B
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145559; cv=none; b=PIBcdLsFy56ygEmmOY5DDu8PhUwZmclCc8c/vziw+5fGknovjcP/p2xjHeocZ49HDMwi+83wksRFTixFKLxb3F3s00i4ydpANdTSJAquhCo2dRsFxxqx7IUh9Ahoprs37AhSdtO8kGSHleWr+oGTNDDZHYaYgCnEV56t9GwlKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145559; c=relaxed/simple;
	bh=XFcCHGaOu8ShUjCIksZfpjmaj4CJ7be6Fa9HhQO/fo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk9weq3u+LBvIFA5gp7KwPwodDTQT1Yb/XlZwkUnKErzRin19RY/MGWTw3+lySfYDAMkVPPdTY/QlSFncBixF7Pw0LTzcM1csk8dyeSeokgD6DR0VjvAtED4dfnKQUOXWLitwmYq/ytfnWAm5RWtXj2MNmfp3MsmrtvBJtosR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gK/QO6+V; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gK/QO6+V"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26AAA814A0
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 11:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDCd70H-cxML for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Apr 2024 11:59:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 951618146C
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 951618146C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gK/QO6+V
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 951618146C
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 11:59:15 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-22e8652090aso703682fac.2
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712145555; x=1712750355; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=gK/QO6+VoJy2oxjYQrQW+OErz/8yP7S5+9JoxRJHJFEVR/y9FYNd4qbTX+k3/BDlny
         rmtmGetpxj2Ita5fN5aYIYUqcBm6Ia3+UTQrTX15A8O/14fU1KRtLYcTbRU5pTyAaUOZ
         pujSRb8zWHZ47ZncXVTh14Y+sPf3SkZu9O+ckfh0fnCJmXKtky1d4reDfierqFGOYPjt
         rE+zdo98PLkGQ8udoPxobYHOrKn7Iqo92nfqwxIM4BJLOsSryOmFiDfLN42Ua3Hi5fte
         rbI3cJUu+4zgoTj7HCWIfTjZTp6JHK4zy/VnYU/lHr3L7SSEpJHX0wCXRMam8HuqgaDY
         rwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145555; x=1712750355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=wFVAuMrLciuEY1RxUtHD4Ynof5C0SW18Fi9wPWAN3wWh2gtYxfVIdy6rLdGsPeW+o5
         BNFXNi57LEXaV+PGLgmikTHjqTV4GqqexglTfJUK9+lGijDYKfiRszQNihuJddjpNMJt
         86jFECiKQwwpoyu1d5IOZSjTj9aIoje0bSMJmSYIxTlcWGFj08y0He/a4xrE4wTbqBPz
         BG03SGB0COccJ8EeWGrZzTh/HSEdiX4sy2F+qKfFMHrP82kI7EhNzYchhZgelbkfiKOb
         XKpMc4iMoR0/hqcQzUPwIXc2J3L0BfaKEPC+uuUOkmnNWKNVZH0Be25++gUFhJAn3z0r
         /fWw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQn6hXtXULeNxrM4w28SsA8FT5mEKJT33PAXNbpy/k5sLi9j/57hF+IqBcHO4AeEsdsLb9YdgUXR9N67R8fSKk/8VBkfTSpkCc98S55oVGrvgy624t7ma9w==
X-Gm-Message-State: AOJu0YwsfnSV6Cnse8eZ0r4x6OskrWnrVKw9GTLUhnai/4/GS3Rrs73j
	gbUGgQ8BK8OHzgFCrmiL6D+ubo6MuxrLmM2yTCIJXNNH+3q6tMqfdYeIvDYt3P0=
X-Google-Smtp-Source: AGHT+IEcrh3sfjtdruqsJXaJuUdnZAhAWtheqUdpYYQNj/BaEl7xqFHk1YKUrYVoGspTRvSJh+dkig==
X-Received: by 2002:a05:6870:414a:b0:222:8943:df2b with SMTP id r10-20020a056870414a00b002228943df2bmr16943300oad.16.1712145555075;
        Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lk8-20020a0568703e0800b0022e9af4f5a8sm199096oab.34.2024.04.03.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rrzGr-007GCe-4l;
	Wed, 03 Apr 2024 08:59:13 -0300
Date: Wed, 3 Apr 2024 08:59:13 -0300
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240403115913.GC1363414@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403011519.78512-3-baolu.lu@linux.intel.com>

On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> +	/* A bond already exists, just take a reference`. */
> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> +	if (handle) {
> +		mutex_unlock(&iommu_sva_lock);
> +		return handle;
>  	}

At least in this context this is not enough we need to ensure that the
domain on the PASID is actually an SVA domain and it was installed by
this mechanism, not an iommufd domain for instance.

ie you probably need a type field in the iommu_attach_handle to tell
what the priv is.

Otherwise this seems like a great idea!

> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> -	if (--domain->users == 0) {
> -		list_del(&domain->next);
> -		iommu_domain_free(domain);
> +	iommu_attach_handle_put(handle);
> +	if (refcount_read(&handle->users) == 1) {
> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> +		if (--domain->users == 0) {
> +			list_del(&domain->next);
> +			iommu_domain_free(domain);
> +		}
>  	}

Though I'm not convinced the refcount should be elevated into the core
structure. The prior patch I showed you where the caller can provide
the memory for the handle and we don't have a priv would make it easy
to put the refcount in a SVA dervied handle struct without more
allocation. Then we don't need this weirdness.

>  	mutex_unlock(&iommu_sva_lock);
> -	kfree(handle);

Also do we need iommu_sva_lock here anymore? I wonder if the group
mutex would be sufficient..

Jason
