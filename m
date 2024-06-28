Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD212B75
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623513; cv=none; b=JC8iQTEil8Fhtq6dKyB8tAKg25jhvZleClr4pPzJMi13qpbuvNKp+DyrR8rRDBGHs+EwmYI4/p32a7GZo6A+0u2oXP7WeDbBL6inkiXpcYH867JYuiMIUCcv6Gs1VrjFDlT3Utm7OZbZgTENKpOnQhq122lg3KbsBN5uajtFS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623513; c=relaxed/simple;
	bh=7nlIwZaLCYxUa9fHgv2z1TOWXwJyMJVnO79vebcTU3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXOk4S6PiB/IAoaaIyNFSRMNFEf263ab1zfnraK+CyrH5M/Y0OD3dyralw7nWhgNOILF/gpOZ2MVc5Nk896fpqn41pwtxL+YJI4Bim8JXREMe6FWPIQe6Dy9h5COp4qogcXx4pbXyrb8RVgwH7X0RR5ImEkGrM1ewxB5jy7fiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XqRVDRom; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XqRVDRom"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E98454056D
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.508
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8dIiz2OnGV1 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9E165400E7
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E165400E7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XqRVDRom
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E165400E7
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:50 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3cabac56b38so682389b6e.3
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623509; x=1720228309; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=XqRVDRompsWKpuCeSKE8uWX9s65gPLHhqkl6XlVm+dwSst03q6U3fc06rWJDmVvUH9
         Myf7jtbuWyUW04ZCz0zMdIwtVH4mKMEpXJ1/RY86cuvgBc5eFEMgmVmyfh9tiPKN4XyY
         udboM2/pxb3cp0YuVZhMmd4kaeyY8XrSPyht2xZr5VSZcZ+TO0DXYFuohEAXsuiCX/qH
         Occ53yo1ttvQsqiTTnZFO211G05eG2nwCg211+mQedLXbhGhh9Vt2VzP0KgbzTl9XvLI
         V+FzIoUG0W8VvKcWnGS5laN9hIu7Bq0o/XqtmlSTUJLPgvXILvyewxMcTELY4PuKfioD
         qSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623509; x=1720228309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=MGH+xbsyvrzDY5HzV2JmTbMmu05rPrrf27LVH8XQ4w8gnUwJgLg6PBVs3tHLKC53YF
         VFT6LWuOUMbh88L7FB7PWxwh8nqtTzUIVqngbGfCdmqdReGCeKmBXQMDSbGMl8aZcPTH
         80lVZ2ZR4hEDLLp+wLBQHGRv/qWGeJOCAz4q/8CATsHbM0fzOQQ99u8orR9u/w0pHPDa
         b4ou3WQI9hB14Xdht1wNXM1M/BbPCv6AQNCLBHZ1ByrDsXhU3h8boUCVmGZtZjh198IR
         hmvMHIP5OzHyUCiw3RT2jJbyORrDr8qCoG7OR2qRtw8nKVP6XEFIcwOJun4bzuQ/ZSke
         IerQ==
X-Forwarded-Encrypted: i=1; AJvYcCUemFe5cJyq5gTA53ziC1y+9j3qfmXImB4j/pOxadD01ffTb9EByaWTbuQjlnqhIIuus9LqwVa9UbDPXjlmKIodgGwof8z/KOLvEXuIdp5oB+1DEouKZ2ognA==
X-Gm-Message-State: AOJu0YzCLVQRNvMyg0JigKIpWK1L4YuhQ+w9iN+3duDFccZl5Ps072vu
	LwXafnBRFUlplszX93o+wIi85eQHxwtt7PpcbSzG6dtrS6VT23CRbXdojuiwVD0=
X-Google-Smtp-Source: AGHT+IFOlesedZdEydbWFXLPLqGu9bC4AvxCTT6KmpZB2VDdZZsxo1EB4l2tZfq1zV6VCZyZuBGDNg==
X-Received: by 2002:a05:6808:21a9:b0:3d6:34d5:22c with SMTP id 5614622812f47-3d634d50632mr2347556b6e.39.1719623509555;
        Fri, 28 Jun 2024 18:11:49 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIUX-00049z-LI;
	Fri, 28 Jun 2024 17:46:45 -0300
Date: Fri, 28 Jun 2024 17:46:45 -0300
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
Subject: Re: [PATCH v7 01/10] iommu: Introduce domain attachment handle
Message-ID: <Zn8hNQDOvAJsQ5Fg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-2-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:46PM +0800, Lu Baolu wrote:
> Currently, when attaching a domain to a device or its PASID, domain is
> stored within the iommu group. It could be retrieved for use during the
> window between attachment and detachment.
> 
> With new features introduced, there's a need to store more information
> than just a domain pointer. This information essentially represents the
> association between a domain and a device. For example, the SVA code
> already has a custom struct iommu_sva which represents a bond between
> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
> a place to store the iommufd_device pointer in the core, so that the
> device object ID could be quickly retrieved in the critical fault handling
> path.
> 
> Introduce domain attachment handle that explicitly represents the
> attachment relationship between a domain and a device or its PASID.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 18 +++++++++++++++---
>  drivers/dma/idxd/init.c   |  2 +-
>  drivers/iommu/iommu-sva.c | 13 ++++++++-----
>  drivers/iommu/iommu.c     | 26 ++++++++++++++++----------
>  4 files changed, 40 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
