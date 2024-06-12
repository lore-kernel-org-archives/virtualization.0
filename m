Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274717A931
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199458; cv=none; b=UnGT+69R8K4jgfo0wQ4wJjoNLBp8ps1m33bNCEMzgLaF+tu3v4i50uld7h3Q7fcz9JfYwWSUFTvQ2ynfP0/7EwSrc0Kvm5YXQPuqlGnvv8Invk4yZuSgOL66Oz/+nsoTBXCCD7lWwaDaFsoyrhEDILVNto+2T61cKuJGOXEGUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199458; c=relaxed/simple;
	bh=fe0VWMI+8IbOduW8IuBosS5lQngZX3belBNixyoqkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCEKyFg4j6j/X0Suev4WXT0J3jK0tJVXDDZKe1ftbAiFPq5kNHVT3ivuRKZ0nYYf32FbttwHR1/fT3R9fLavRL2IJNvVyFvkwDU9qaBV4nTF+yi9/fU21WRblrTH5ge9O73Qdblhm/BlFvU11NXEINVd0N5xtRfU8CczNU/bm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ghjYUfLf; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ghjYUfLf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2499840C26
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Am7HTbA3eiYX for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:37:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 065B140026
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 065B140026
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ghjYUfLf
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 065B140026
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:37:35 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6b06f1f9a06so21209796d6.3
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199455; x=1718804255; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=ghjYUfLftMx3qpY0dFU3wVBnXSFJoy3+kB6sSb0T6j6eV2JlHcu+sSV1X32uJ0YoG6
         Blc9gFvCXWkQrcIyAECPcPoyHj3Ft8hHxJuqz1PpF2377d06ztGy6BDDtCKIpd+B8z5x
         QKXWyUSPa29Z1XbaTAkxYWukCzbHb9ijnwk+g0cfi/6MToKCdN1A8F5a8LzY/51vif+C
         OWw6pONMerCuhS73hFcYIG1RvbHQ6UWr0MUHQUiibGVUg+JSP+Oi5H7s6aFw7ChMRNfl
         e8MOJDlcdqmIXzxqPzAv21CXZ4HucmZZuVDFvN609PqaKmhuhxCrmvo8CtHlLAigoHm2
         55xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199455; x=1718804255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=Cv0StkqRwbWDjuqKefiakUlP8bH+0Ea1z3A6WL0esKoHTjs0ZC8n0TmuRnNXAZ5CLq
         rzGNNR8j5p92HrMlOVNfYSjhQEK+/REG64tLfPXuamlWd0sMZ+THbC27BAF4OFYLJDFf
         QowBmbeZZd7p3XA+eNo0C1bV4vAfBWX6c24HX/Tl7bXiPwoRSw1efdd7hBg+IxQKVFpe
         UVjHBULdWtxbfHu/3J/+al474W1+VD7tpjjBMBgWMiyzzIjjD6oYv+uw8XtlbVW7dSD5
         rJjUYQe8lvBEaNoeLfL1nW9ujuLMY/L98TN3jOGVNMumePS4YcEyazA4xd4MaIr7LzYi
         FqOA==
X-Forwarded-Encrypted: i=1; AJvYcCWSKJbAJdgdJrgpPXrLEGZdsJ7qlBWajphpLvdRhXRjylcrXHotL3RKXeTLLLXgQa4BuPcQ3J2fA3CgEx1H5XeKkAwF2nlGdJJ3lkrOJcfgU8X24GtGjTohvw==
X-Gm-Message-State: AOJu0YwTVt3pikszsIIBRQbvVCrpg2CE+tetDynm/E5hC6ipdWYidXKS
	sOGl3nA3uzu9K5RNsF4NC0u34d9vB7s4e13PFcVWql+eO53rGevTIhfQ+vOtnb0=
X-Google-Smtp-Source: AGHT+IHSfEYGwDvsij2R0661tz6O7lYNLUUlm/+RnRLZK7C4edHuNG4iu5XV2Em15wUQSAV1AhEuuw==
X-Received: by 2002:a05:6214:5889:b0:6b0:6671:86a with SMTP id 6a1803df08f44-6b1a7ad4be4mr16867256d6.48.1718199454661;
        Wed, 12 Jun 2024 06:37:34 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11949346d6.87.2024.06.12.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOAO-008wzF-E8;
	Wed, 12 Jun 2024 10:37:32 -0300
Date: Wed, 12 Jun 2024 10:37:32 -0300
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240612133732.GW791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-4-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:10PM +0800, Lu Baolu wrote:
> @@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> +		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +							       fault->prm.pasid,
> +							       0);
> +		if (IS_ERR(group->attach_handle)) {
> +			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
> +				goto err_abort;

I'm not excited about calling a function pointer on every fault. Let's
just add a constant flag to iommu_ops?

Jason
