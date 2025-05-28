Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E8A41
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390669; cv=none; b=ZvM2ek59GftCmtjh1fJsvF64Sh1ZLwj8dcyQJs3Qag2FjbMcHqNQKcEtCEKxXq7mvnZBGi4fTIH32TQw40zTKzDO7YjGMNP66H1RhRHRDKFpSo5U3cZPIohxZysB1gx6xFfIrrC5ab/Op5JqyIy0wF4IPPcGCrN8sEdjYgiMICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390669; c=relaxed/simple;
	bh=U504ZGWiMUGIevk6ic8kx386W5qtbTlb40apuZeZfFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boRVqxfH1eOXXC7E9i1iPS60maVBLE/ApY+YOuFtUewWIHN7mXeSXLXd6gqQM6XY9lFmYNttMq5mBL2bAo9xtHZRqiN6hjrdsThfESnBa1oVkJJkP8ZmgnApsm7V0MmF2ZrvOfgsTNitbnbC/yf23Iprn6GRW1ynU4MSmtPtl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pO8JMrkG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pO8JMrkG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fab5dfe095so10365226d6.1
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748390666; x=1748995466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr8j2ABRcVMveLyV9vmAho6qlH2nVGxwxz0sFNAeQYk=;
        b=pO8JMrkG/PY49RMOA/A4Sw54pGXDtTQ1rL8eCljZl1uwkaQGhpX78+3JXLdLbHlEv9
         F5IK1g35wijJ1LXglzHmrOi7iVi8iFcrg3lexJN7Y88IOCBNUcTupMGvtqDDkFyULxEd
         x1NJR7XczPpTCGbtjMUDjMOz0HkQHeQ/4Rz3tNHDaOD3rERdUKyoTJmcOAdjo896zdC+
         DXdiy0X5CRJeuD5PXqHqqn7gCn+uKjg1BwWb040JIIBPfy+EnLccKpyADlrQR8QBAqp7
         qTT2k5wEhA4fy++YXl+cnxltY0hRQ2HMykJ9u0fCYWRVpFkd4HS109iTJSdtVueUTvHa
         rfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390666; x=1748995466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr8j2ABRcVMveLyV9vmAho6qlH2nVGxwxz0sFNAeQYk=;
        b=tyx6EfpvRBW1zZoHhkE8RMzK5R7VTgTaJJttWIp/dYM/WLTqdaH316UD2Y3Zn41nsd
         4FPHj9Fl4LGFEPL8zqKfqECfAQe5IQBXAgGLzAjWnXZohpLGaA9XZQA/mtEP5yyBltmZ
         ReZBbXxaE1d/3+CpEbOrhAsPuTOGuV+Ne2OtcZkUNkSwVQmRw2DQUoR0A7YLIG22xBVV
         vMikcU6dxX2NObCFHsVLD7NYifPtBWQx8ScZju2zLATb47CIUpYk69QTVCt2gVx0UUjv
         qlZek8TaNAlKO2Xxctnf6epvU/DROfQJHKrv/GvHcMa+OkU2s3FNdX3JjoMEGab/v0EY
         6poQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgW+jkHmSIZH2GHQ37uyWcCRTx89AORJ+V69DemdieznQ51dgyIjxigHTW0BXaGAAgnH9gApXj23UsVAUUFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzim0L5Fd0sfH/iPaC9expMYyE84fxeixZ+dVGabyAByuCbr8zw
	0LH4MQSqYSLfX8QeqkZrQVHJs8QgeDZQqB7F67d/YiGYjM9CNnEhcdlXyfE7wfNV1Xc=
X-Gm-Gg: ASbGncviuVk/bVjEeW2T4nxYrdMakA4lJ+3vd7NNJ8h+JAksFIICO3Ypab53YaACS0A
	H32YMOVlnkxgfwEpfccqOk++j30QbPX0k+8mRzyob0HPmzejUMt8BG8QlgjRymm7ZwHzNd8RENx
	RWgtu3LmNogXMGel5ZMgXh/eijIUArP/UEb6B7Fmxxo0lZqu2JJBctLb0Ha2TlgAJ+BALMHsMkC
	aDZ58RTku83gglB/5bvP0ZuPo9LHwAaozWByn3EJxxb611d7GPq4j3VJLumWAazhrVe4zB9izGn
	qxEBa2uNbLYXpXIGgi50dqEYk/alSQSupj5UTa7xq+6X5BE6GCaNpwW2qbWrCrnjHsac0oi2TJ7
	m2wRYVNMxeuzu+lxtBPslxBpSOUY=
X-Google-Smtp-Source: AGHT+IErBe5nbyKYqWU9JIckHMVhK4xaI7/PP/tH903bB+DJeuC8MK2VCogNXSDRYdW98d3MojQWPw==
X-Received: by 2002:a05:6214:2b0d:b0:6f8:8fdf:f460 with SMTP id 6a1803df08f44-6fa9cfea4fbmr223186366d6.9.1748390666533;
        Tue, 27 May 2025 17:04:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bb9799sm12096d6.83.2025.05.27.17.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:04:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uK4HR-00000000fET-1oRi;
	Tue, 27 May 2025 21:04:25 -0300
Date: Tue, 27 May 2025 21:04:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250528000425.GC146260@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, May 27, 2025 at 01:54:28PM -0700, Shyam Saini wrote:
> > The above is the only place that creates a IOMMU_RESV_SW_MSI so it is
> > definately called and used, right? If not where does your
> > IOMMU_RESV_SW_MSI come from?
> 
> code tracing and printks in that code path suggests iommu_dma_get_resv_regions()
> called by vfio-pci driver, 

Yes, I know it is, that is how it setups the SW_MSI.

> > As above, I've asked a few times now if your resv_regions() is
> > correct, meaning there is a reserved range covering the address space
> > that doesn't have working translation. That means
> > iommu_get_resv_regions() returns such a range.
> 
> sorry about missing that, i see msi iova being reserved:
> 
> cat /sys/kernel/iommu_groups/*/reserved_regions
> 0x0000000008000000 0x00000000080fffff msi
> 0x0000000008000000 0x00000000080fffff msi
> 0x0000000008000000 0x00000000080fffff msi
> 0x0000000008000000 0x00000000080fffff msi
> [output trimmed]

But this does not seem correct, you should have a "reserved" region
covering 0x8000000 as well because you say your platform cannot do DMA
to 0x8000000 and this is why you are doing all this.

All IOVA that the platform cannot DMA from should be reported in the
reserved_regions file as "reserved". You must make your platform
achieve this.

> Yes, i tried that,
> 
> This is how my dts node looked like
> reserved-memory {
>                faulty_iova: resv_faulty {
>                        iommu-addresses = <&pcieX 0x8000000 0x100000>;
>                };
>                ..
>                ..
> }
> 
> &pcieX {
>     memory-region = <&faulty_iova>;
> };
> 
> I see it working for the devices which are calling
> iommu_get_resv_regions(), eg if I specify faulty_iova for dma
> controller dts node then i see an additional entry in the related
> group

Exactly, it has to flow from the DT into the reserved_regions, that is
essential.

So what is the problem if you have figured out how to fix up
/sys/kernel/iommu_groups/Y/reserved_regions?

If you found some cases where you can't get /sys/../reserved_regions
to report the right things from the DT then that needs to be addressed
first before you think about fixing SW_MSI.

I very vaguely recall we have some gaps on OF where the DMA-API code
is understanding parts of the DT that don't get mapped into
reserved_regions and nobody has cared to fix it because it only
effects VFIO. You may have landed in the seat that has to fix it :)

But I still don't have a clear sense of what your actual problem is as
you are show DT that seems reasonable and saying that
/sys/../reserved_regions is working..

Jason

