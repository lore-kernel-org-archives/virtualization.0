Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170B146010
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279394; cv=none; b=Ao+oM/tZq4M3qGXDlmCVgTebxHTFtVK4GkwFjH1ZqO6jxdATR1BtpUFs2LKbmWTAloQzcz68gbqRjHZkjJOKBNM4v/owxM0yp+bOzWDtqDEitO38p2TU5XBqXKQJUJPzTzvoWYq7NlLExKUGaZiNrF46ybw+apynnj0q6mHs9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279394; c=relaxed/simple;
	bh=JMH7aegv+MnUlyAhiAM0CDdTw+aBY3IivqXYt0vaVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M39a7mm/yIOsgNwd7OB15bbUtmCUW5xF6wGZSvRGUkTAPOYSULWLGD4qMsKkbfnwYggcEwTNg+Zz2w7Qf+ErKXxYjbrntwifkmTkgPbUSu9eDJFwCU+unY9x5fkgU55pfYT2n7jfpfYDDP2M3Aoq1ZkI9xPsOBetSV0q/x1WmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CvjpoS2z; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CvjpoS2z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54EFA81947
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 11:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6KlJ5fMoI7F for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 11:49:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DE95818D7
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DE95818D7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CvjpoS2z
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DE95818D7
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 11:49:52 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7955ddc6516so57641585a.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718279391; x=1718884191; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=CvjpoS2z2XH3QGgB4gTuk74vdAzGpaF+2TiCITpm7qVw0rR0vq9/sbh7w9IQMsQHbJ
         Y8zALKOtO1+cRse5GpFpdMbW96gxkvvxvmMGYBrCmxUwmeW2yVNIYBvO3rZuPntdUHD/
         iSNt+z+ua8I2TUAmlg0C+hWfmQe6PmcSNiR59orIqQIcM/g9sxRin1aZ29GwXBMkr2f0
         brq67didszhM6N0HzyVaSC15udVgF4cjPo7TDLxQ5Yaiq3zzLfAOif73HR01PSngzxVz
         SUJmV9F4xhXOyuOQtNYp4RHAlC1Nt60K5fZXUw6H0rQv5/rP4Sz6Zu5EiNuTVeBoYE83
         SW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279391; x=1718884191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=il7AnVyrSxO5ebdb2RmdNtXhUE5xRZQcCeO/qRa9VVqFCRIXYtcXWBQ2NSccgVM0gG
         cWFpRWBCKoXUd2f01kiSD0TgMasgPZevabS0ck3jpwty1R/tvj8dLB5EL4l1hUGraXDM
         z0nUaAoA3kSku2cInpashluiEAOgXrdXNZiAesre0QEqcbpc68ndjkgs5hhhTCTN6VPt
         hQ8bdenY/h5rpPKnVFR48Z5VvrHKoW4ofeoIsrbEnJE4lJUugXhW0MN0t9d0rINx63Ud
         jjNRfciMGcYNcKdxgHCW7bBHeZbJ9BzvKuUmVGB4VzqtTRnW4PUjRVsUOqJPkSkIqz32
         l7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfcu/Sd6Vp5FvFgMGKF+IGklTzG7Og+QH9LmZE7vrp5yrT8iMLiXRy4wsnh14NFyuIpg8FGuHbg9aZeKB82100gWnytU14kbHH5XXxN9d3FgPwTMPbN5Iaug==
X-Gm-Message-State: AOJu0YyxlL3dIEALjTWYGqFSKQbln3vui8lxNtBexBM59hd5/zQRvuNe
	4FsMv44/QCPaJBn4Za8jMGEsp8k4Ycldy/lj40A7kVXdlT63ukPJLiodH7DOpSg=
X-Google-Smtp-Source: AGHT+IFWK9h3YEybm6BIGLMJNixPvA73NV4oZYSszQRCqVG7+H7HxqTpkqRohcPjaEg2JALqIvr1Ug==
X-Received: by 2002:a05:620a:4482:b0:794:d988:521a with SMTP id af79cd13be357-797f6006419mr521195085a.7.1718279390820;
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b73fb4dcsm40891385a.100.2024.06.13.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHixg-00FW6s-Sj;
	Thu, 13 Jun 2024 08:49:48 -0300
Date: Thu, 13 Jun 2024 08:49:48 -0300
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240613114948.GA791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
 <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>

On Thu, Jun 13, 2024 at 12:23:17PM +0800, Baolu Lu wrote:

>  struct iommu_ops {
>         bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -600,6 +598,7 @@ struct iommu_ops {
>         struct iommu_domain *blocked_domain;
>         struct iommu_domain *release_domain;
>         struct iommu_domain *default_domain;
> +       bool user_pasid_table;
>  };

Yeah, maybe spell it 

  u8 user_pasid_table : 1;

Jason
