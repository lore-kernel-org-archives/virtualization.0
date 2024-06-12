Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031917BB37
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199686; cv=none; b=mPbAcn5RoXOqBrJHFvUD6PDuRNUV8sK5T/PeafkrM5qe9RgqhCz6JUCNVrYqZ35m6v1XameLtwL22vAURNOx4uF0EoSUztEnoXdUqPQ7HTODEOSlByOO23puYfCswzD9dOM2BBAGSJrsmuL+u05AadxBd7ohfkoS6t+qHINixnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199686; c=relaxed/simple;
	bh=uBT7vUYzRxnNkNdZfK9+gVAa0bI6bEGIF3WRyxtN3+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIBOQ05CZjGpE6i6SJ+qA9EY19NhNCirSfswCRv6EdHW2mhrx7JuwGlvLRYzgnBSjyVho5wxl7FAto5RYg8Aim/1enjLGXurDHE2SyRGxr94XCVKwBWCNtcqySY3zgIm/NFDJ6Jp1OjcPoZWaLQ5pz9xZJwWHFizIy81TMb/gH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mQHwUQ71; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mQHwUQ71"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DA9981F96
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4KDMjaSwwWp for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:41:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B28F081F68
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B28F081F68
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mQHwUQ71
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B28F081F68
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:41:23 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6b065d12e81so12599146d6.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199682; x=1718804482; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=mQHwUQ71GMPsPeNIs+DmXkUECU+gKJge7Aer+iGUuL1Dv9dNt/qf4smqLfVAstRrtA
         6J7qgxtvgSDMxB6onCXNXkucYtBO9NcIfkv7wVywd14CLVNnGFDl9PZfUp5sCrx95K5x
         y2M5HuHCcucAeSUYyvUQIXPwKLFk9dzR3Uyi7Qw6d/FC4ZZ3vPgMQVDSkf2BE+HQx8X4
         GL19HVlNBPFoBi7h2OI17ReIENGf3okdlASe0zzfNVxf0WUDjbm3UnQ9xQqjoKWRaaTw
         BtQK9hit35S401dkB90K49lRa8EXPIEqQjP95pDp+mneLRv+d/hDjhIgM08XQAKBpuZh
         EgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199682; x=1718804482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=YWdv5MO0LsPPnOq/CaQi6RCtUYqWy6T08BOnXmid8KZAtvg9+wKc9zLGYMvq4jOw+i
         n/lsFFjtqdP2XZLu74q47TCT8ewec7DtHyZYamieIYN/EcJPUh3tYRS2dOhsPxQs5Kf7
         F30n3sK4aK69uHAIKx8Qab4tJijya6AboAzUHOUU0Z1Wd1npsvbgoM7KTWXkhtoJQ0kq
         IYN76VrpBHTvjMkKUP+vpaeHw2h+f/j1t7PvwLKxe+2gfALgybDhSxxi7hn7xXzPpv/L
         lrpcODbftwog4MVz5o1wpIrNQ7K8XR+DplXbOPENnFaMLjGcOlJmmQ2XjFbXqryKpvrA
         5uag==
X-Forwarded-Encrypted: i=1; AJvYcCWNBUtfKRmOnULqlXnQnSzDpRruh3Cri47jyQ5YJ3A0TReVkYVuwcqOsU/yNwdO5j+vRRbW6+DOZvnEiLjHYRddm6b+xtyocSEjAaYTZiZCxuytdfruYP7OFA==
X-Gm-Message-State: AOJu0YzhAXAEWdy5UQi2mVVBmIu4mxiZwMDiHqO7AGtTefCe9IE8bs1v
	0NP51UjOJaYjzbPPIiZsECEWyVQKRKAX9osUI/bxrW3uWVLv5mRJyx264SdCNHY=
X-Google-Smtp-Source: AGHT+IGj3bA+oXPOoBvMCn6FAi2vMePmynyM2+Wxv1k8TreF0ZOFdKJAdWV4ii1y8EtkVeqRq9O4sQ==
X-Received: by 2002:a05:6214:5d11:b0:6b0:7270:104d with SMTP id 6a1803df08f44-6b19fb9fc09mr13439486d6.29.1718199682399;
        Wed, 12 Jun 2024 06:41:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11975046d6.87.2024.06.12.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:41:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOE4-008y6B-6Z;
	Wed, 12 Jun 2024 10:41:20 -0300
Date: Wed, 12 Jun 2024 10:41:20 -0300
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
Subject: Re: [PATCH v6 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <20240612134120.GX791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-5-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:11PM +0800, Lu Baolu wrote:
> Unlike the SVA case where each PASID of a device has an SVA domain
> attached to it, the I/O page faults are handled by the fault handler
> of the SVA domain. The I/O page faults for a user page table might
> be handled by the domain attached to RID or the domain attached to
> the PASID, depending on whether the PASID table is managed by user
> space or kernel. As a result, there is a need for the domain attach
> group interfaces to have attach handle support. The attach handle
> will be forwarded to the fault handler of the user domain.
> 
> Add some variants of the domain attaching group interfaces so that they
> could support the attach handle and export them for use in IOMMUFD.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-priv.h |  8 +++
>  drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

I don't have an objection to it like this, but I wonder if we could be
smaller to teach iommu_attach_device_pasid to use IOMMU_NO_PASID to
attach the handle to the rid?

It would have an if there to call the  __iommu_attach_group() instead
of the pasid attach ?

Jason
