Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FA1E526
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623517; cv=none; b=h08b65o4hOspNhQ0XIJIB7gEb2OkLsqcoyO418pwy2LvyW3y63pSnEftm37Ycyzwj9ZRs0sO43wX0SjU1DNAbwW88DGGgnS9jdF2F34PPiHlbu5VlKEbw5s5wyAhn2XD2io307yv5939pWJYbgBNSwkZ9+0nrRxuS1eLNNw+Rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623517; c=relaxed/simple;
	bh=GNugPRiQq86y98AWq/VYhSjbxZhyTSYTdolFKkCRkP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX9kAbgzHNymFTcqNJyLrDUmmKay6vr4iN527VW/xT4cyBU3u31xjEJmR05czVby6JxGM66xf0OQDfybZOjK2XfVFF1ApVBLveMSPdQvHlwoXMt6TVtK7hQlrrVy8J1SAu94Ng57+7Jcmx6ynbzEk9IzeEaLn9LQsIngFGhf9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jeofAJJd; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jeofAJJd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 514008464A
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.508
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLJfsyOdS-zW for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8BE0A84647
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BE0A84647
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jeofAJJd
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BE0A84647
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5c40f0e679aso556178eaf.3
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623514; x=1720228314; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5mjPkWmG50LdKz2/yPWjPta2U3jK4ZpVUj00ksCRiY=;
        b=jeofAJJdoMO3/0jYJQN8SIZQnyKyOuAShQhY0l748imdDmxdRhpzFvH3NR5aMymVld
         luPIKfCRZxa2RqMjsYkAlG7XEg2V6LUhKJSjyE/XSWBPOJzq+NWCGJdK5OO0YfcWnmxY
         eqk1DfOT4YvudcBTRwh7iBUjZo2+a6ZhBuDe+cPtX2dus/FhivHhcCvcrLn21jqA/Myz
         dxwZ2/a49xUsdZTIynPLcdTjqkCtJjv+TFa7qbqt2QLG9Lq0fSHnKuvMnyxGigtMK+SW
         gpUNZDJcTAyrmSY9/VjBLpKdD/aUmsXWLOguQ+lXpioB0Fxbn0hib9NPXsUtPvh06dW/
         D4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623514; x=1720228314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5mjPkWmG50LdKz2/yPWjPta2U3jK4ZpVUj00ksCRiY=;
        b=OJnjaxVGf1Xy9b8TmIHdNkiAHRFEGkL4Y/SIKtEAqDRyQ+uUsq59q3YvSMYdx5ZsYp
         NDxJ4h3q/hweeCPIvYqs/iOlII1zCc/nQzXhJ64zFNeIL7XMEBOd3Jabbk4KigG8AuqW
         vfC+4+tCTrs/UqJGYgvMOy2ZzlBd5Q1nbH0BESDrHZ91IBlC0I/yZo7mMxgD06eX4kA2
         XAHmok7issvJenUJScLp/w/QswrnlujkJ2wIo8mrxP1lpOLL2K+7dq/FNTC/NSdtf1uw
         TYAF07JOYAfdoC9nAc98mh1YkRcBxBqUHCE6TvAj9otEU2kcTV+DJQHH6T+2PX8tXpoo
         vIZw==
X-Forwarded-Encrypted: i=1; AJvYcCXPfD6RWQ94c5qp46U+gMJECCM7lyIQkj/r36KGjnSH+bkGr4rp/zhz6+nfO2L+hAD8VSMAhyVRGKW+Kf2E0VhmLh/i3Tpel0MViM9mDZCTX41/mLUX/+TMHQ==
X-Gm-Message-State: AOJu0Yy8eIUjYIZScm4Nq4VTE7bJ/5OaM2ZxH4+1E/nEsjGX1pryoirb
	ViwFIPRkqKXKKfwJLHCQRINKEGmsylrtYoxOw35aF/dWRkqKyyqvbPhIX47zH84=
X-Google-Smtp-Source: AGHT+IGfnIitLwF85zOIc5aolWihTG9UNRr/tXG1jKGcZH+0/16zVksXuzB7Rp8rLXO3PNhWvv8y8g==
X-Received: by 2002:a05:6359:1a46:b0:1a2:58b6:9728 with SMTP id e5c5f4694b2df-1a258b69a79mr924344355d.18.1719623514328;
        Fri, 28 Jun 2024 18:11:54 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIWS-0004Ai-3J;
	Fri, 28 Jun 2024 17:48:44 -0300
Date: Fri, 28 Jun 2024 17:48:44 -0300
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
Subject: Re: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <Zn8hrOfw65PTvfYv@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-4-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:48PM +0800, Lu Baolu wrote:
> Previously, the domain that a page fault targets is stored in an
> iopf_group, which represents a minimal set of page faults. With the
> introduction of attach handle, replace the domain with the handle
> so that the fault handler can obtain more information as needed
> when handling the faults.
> 
> iommu_report_device_fault() is currently used for SVA page faults,
> which handles the page fault in an internal cycle. The domain is retrieved
> with iommu_get_domain_for_dev_pasid() if the pasid in the fault message
> is valid. This doesn't work in IOMMUFD case, where if the pasid table of
> a device is wholly managed by user space, there is no domain attached to
> the PASID of the device, and all page faults are forwarded through a
> NESTING domain attaching to RID.
> 
> Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
> indicates if the IOMMU driver supports user-managed PASID tables. In the
> iopf deliver path, if no attach handle found for the iopf PASID, roll
> back to RID domain when the IOMMU driver supports this capability.

This remark is out of date since it is now:

> @@ -547,6 +547,10 @@ static inline int __iommu_copy_struct_from_user_array(
>   * @default_domain: If not NULL this will always be set as the default domain.
>   *                  This should be an IDENTITY/BLOCKED/PLATFORM domain.
>   *                  Do not use in new drivers.
> + * @user_pasid_table: IOMMU driver supports user-managed PASID table. There is
> + *                    no user domain for each PASID and the I/O page faults are
> + *                    forwarded through the user domain attached to the device
> + *                    RID.
>   */
>  struct iommu_ops {
>  	bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -590,6 +594,7 @@ struct iommu_ops {
>  	struct iommu_domain *blocked_domain;
>  	struct iommu_domain *release_domain;
>  	struct iommu_domain *default_domain;
> +	u8 user_pasid_table:1;
>  };

Otherwise looks goot

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
