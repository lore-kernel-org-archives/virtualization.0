Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A791C27
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126699; cv=none; b=chfN6H8NWyM9vnrenG0rXwY+7Kzv79WEkU7+DlFM+oLar/3HrbZLV72cjfXVmBJ6SpqsDuuer68+pRPIBAa9CATWAKVrseZs/XI1RysPm/g4XxgByxN/yPCZkPg8eauQCqtxN4/gVifWnZorSQxsloTIUcX4DKT44JpXmKoULdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126699; c=relaxed/simple;
	bh=EJN6mlEQptyW+8QYnpWcKaJ9kN9jPZky98kePf90PeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9IIx2/fA2jgm9PsV/ivd6ARGDjSRyDFjRK1IUy8Oy26gs0VGMUCyQUCy0Z5cM4rxvxCNGfpKHiSOC/4C7XaXgPc5/GDbSJEJVj/cISi8ovyAVOCbFLsZymp7Tn2sizHzGVo7Q4zodyimeaagSlzE5ca62127vjBvbSLCaj5Y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z6C5OYUw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z6C5OYUw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BB6060B79
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ajCjr3aDsqO for <virtualization@lists.linux-foundation.org>;
 Wed,  8 May 2024 00:04:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CC13760823
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC13760823
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Z6C5OYUw
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC13760823
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:04:56 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-792940cc64cso334930685a.3
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126695; x=1715731495; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=Z6C5OYUw2fROszzmGSE0cwClE5rzCLqhYZdx4kzu7zx0IMfRBOMY5UNSPLF/l9x+lS
         QdjRXL0nsxkhjQqtl1t3/RnPoG66cvkW6dSVmvSyIBSXQNMb+tZ7SskEaVZCJaHGbUzA
         mymXHPR+Witx/tbGfBAbBhFt9KL71MZJjnjJZIbSSpS+rAhoVZGxk1FVUt2qxSv9ScaV
         8pA5uGx+OdIGio1H8VIPOJJ2mOrY/NuhioIGe/kEYC3WxeTGal+XCqmdCg+9BNrs5UG9
         KU58jVqbkyab7DBYptikzKGuQCICJQWta7QhTGeVKdRa8UkW/jkJFz2aNqA2vMXET0b0
         DL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126695; x=1715731495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=pS4dUgws7ERtL9Nt0U/vquo35ZPGr/z/9bc1G4xuL4baLmyJKZz+Ie8adYXnYqUI0A
         p3nNIo10rwP7im3XYUgXulBJyO2qMyj1eaqebaJeQaiL3h+UTmIPK2IkKXmZdcj/5QQJ
         Pr+I+k8AALzIkcToUwwKRlYqK7D2DszXtkslhCMH8TCpBKmaHkf7lxbXVItNgnK+DZx0
         3mxzxSKmqS8pPELoRrDkI3mKu/TXMp/xaJiRUOKtEZQRz7Z7ojQx+/wkvpTk1h6uyj8e
         4q3b+K/6YGcyS+6/x+mn4tA0kgDEfVg/IcR6/H8vHevUe8RF5lebfPYoJY9j2SiilBl0
         TnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb5a4IGYxvfli+NVZu43c1vx8e/vZDArCGS5gI5iuuRitJD6ugRY3bR4At/XZblnp91zzEVoq/+zODvkFp7tIYd/b1ide6DYehkRfbjgmw7YxdoUMcYbcOsA==
X-Gm-Message-State: AOJu0YwMlNH9idwGAxQ6QbprrcYUrKV3CrXs4X9okR7D4k/zCysuhqYT
	vc8Wcb5cqaoJcKj4/FlO+JfOBvAQsiE4YlbkC9P4VVidyUMtIAb22NiySVA21H8=
X-Google-Smtp-Source: AGHT+IHYYyzxl2qn3bcVXy98/9Q/oTYtmKwzIdmiSS76208dyr73dlmOHTUi+Oep8QKsaSqr7cfBKw==
X-Received: by 2002:a05:620a:c07:b0:792:9167:5982 with SMTP id af79cd13be357-792b26ae168mr130112085a.15.1715126695290;
        Tue, 07 May 2024 17:04:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n10-20020a05620a222a00b007929914d7cbsm2454612qkh.81.2024.05.07.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:04:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Unm-00040d-AR;
	Tue, 07 May 2024 21:04:54 -0300
Date: Tue, 7 May 2024 21:04:54 -0300
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240508000454.GM4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-4-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);

That seems a bit weird looking?

get_attach_handle_for_iopf(dev, 
   (fault->prm.flags &
   IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
   group);

Jason
