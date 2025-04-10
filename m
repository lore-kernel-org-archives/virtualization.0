Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8A21148F
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326013; cv=none; b=P6wd9mgJfn+6sr147ofLMcFoQ3us5fiv3pnFIoZ98eYeNmheWBvio5RS+8oAyUp67sJEmtWlgKJ1vdKFhpq5svUzs2nBwlvGQfe5K9l4IMbaSwyflw98Ki9Qy7HVDttQcqQk1ModCkhOv36KvE05f/8PrfIXSts9jIo1uJrgt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326013; c=relaxed/simple;
	bh=KJDeLRPNP4KR15v2b6aVw2383AZQQQwiuSEL1SwZOgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdwqXdyYZxDi7MdJ5ZYiaQitwNS5Ng+7Er5ojjh59gLdj60JbsgmKsw2M5KpsSDA1DPTNeZDtWEDoK4VIrAgLDLkvQidNUWveFsYSFHTcpU1cAoCdQC8/6KSR4SxfO2DxTXLJt00YE7AkN5oYZgooGHB8k+Bh7TtYyqHNw4fGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WnbtB+Wd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WnbtB+Wd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e39d1e0eso132066185a.1
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744326010; x=1744930810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpO2S4wctyk68CVyOkNnoYhQpTc8ULQAveyt4WbuIOg=;
        b=WnbtB+Wdyi9jHaaB9LPX2jwsCMHs+4q+9XCQ+OpRLZYucnGP6WDgROT3kKxuTzEeWi
         KXUjSIVmGWoNz/PBKaGOL6+yr8gV2MnQ8K8MMHO/v/NHaaHUXbKNS8Y8SSOBLEdcQtDT
         YCgPdnC/uusQps3rwyYhFbInqATGLjFwX5QrY4GNywF2MdoRZfvXUo4X1MurD00BtnFq
         +WTHt6a1HFRWiAyTu5sVP4TZBxfCne0yQ7onMSEfo6pUEDs/DMPUpu7u9edozq227Xhz
         xta22W+0WuDTvZCaljdx99q3Gi/On6bkqRbe7Dg+8OQMHNT/UHfGuVglClkIIVtzx5jg
         aBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744326010; x=1744930810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpO2S4wctyk68CVyOkNnoYhQpTc8ULQAveyt4WbuIOg=;
        b=p4KX2z4kAo91Or3y4nmxYn9CaHb78fW6fnWX3XQ4StHThxKIVYbpdNBWj+VsNROcnf
         c7gUQMI7Pl548tGq73NqRDON4Ms676LNDz2X18NkF9jGEgdGhTnWqvXOgD3zyMNdhJQJ
         qVhdLINQ57SuG82emitmOsrYj+QVaIq4KvJvHsx3KuLw9WPi1h1aNXNspZ9uq+Js50RK
         4Pue+CcltU64hYnhyLAFX86dLkrPYjL1j5etEgt8f1J88QqmxAs8swXHtJNayd4/LJDe
         riP8GAV82F4g8E9kgAzDjyRWJteUkp1hs3OGB7JdDbn073XujPOaZ7EQRSV2EbuAElSK
         iDRA==
X-Forwarded-Encrypted: i=1; AJvYcCX05/i5uGdOsJ7HHwDqTrOP9Aw9rTZStnUEADpMarX6YFpn7HSidGyGG5PuXnb+DG4KFgRVO2EQgrfg+Fr5IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMTMh4OJatsy9CmbCakbL09iPPMBf9Ep5L6ziJTyBYzQgUSGc8
	v7+S/XGZo4G+NF9/mFqoQOv/48PCPxSg2I4E4a7tNXQYUcjIt05oJVrI0Z3fFBA=
X-Gm-Gg: ASbGnctumtq6VsFRTPq3OyoIUAhdt3if4i2tsaQT1TD3nTOWxroPz/XG8uSj5xbeCfW
	FiJpP2oTSR51uDuE4OMauIwSWWy4ZR0tjrgdKETuX+KK/37VqnerijVIBjamdo+XX4cQJMlPUAU
	ClSOxIORBG7XnUEeTXC0OE1TcQ+u6ijTtZS3sOCQjtP1WXxCfx3ONjWVIflvqjYxxAa3LISnHN6
	cV43u2pUwwhmYXHt31kYLvYL2Hr7C2/7GxArYB5q5NufmRmcYe0GmrZ6uFPS4GcQ5wBRnb8Je+z
	mCdgirWrnCnkBoGjqid3bvrFpuPYPfbB4TbYpb+cKb/+MEhgrWImE1SjPjhEAFINrxviJTM6Mqp
	uqw6er0Q8DN5EsMeDkgQ=
X-Google-Smtp-Source: AGHT+IHr0/WY2Rqb4JC2JVZGgAH4AixNta9jAPZvPdjOUO1pv6CI6b5DlSO9IE1VF0/bDnrgXDRKew==
X-Received: by 2002:a05:620a:4306:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7c7af12e6ebmr102606285a.14.1744326010083;
        Thu, 10 Apr 2025 16:00:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89437a4sm164415585a.23.2025.04.10.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 16:00:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u30sS-00000000GRz-4851;
	Thu, 10 Apr 2025 20:00:08 -0300
Date: Thu, 10 Apr 2025 20:00:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250410230008.GA6905@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>

On Thu, Apr 10, 2025 at 03:50:27PM -0700, Shyam Saini wrote:
> 
> Hi,
> 
> Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> assuming that all platforms have this address available for MSI IOVA
> reservation. However, this is not always the case, as some platforms
> reserve this address for other purposes. Consequently, these platforms
> cannot reserve the MSI_IOVA_BASE address for MSI.
> 
> There was an [1] attempt to fix this problem by passing the MSI IOVA
> base as a kernel command line parameter.
> 
> This patch series aims to address the issue by introducing a new DTS
> property, "arm,smmu-faulty-msi-iova" which can be used to hold faulty
> MSI IOVA address. This property can be passed to ARM SMMU drivers
> via device tree so that the drivers can select appropriate MSI IOVA base
> address which doesn't intersect with the faulty MSI IOVA address.

I thought we already talked about this and you were not going to be
doing a DT proposal for a software knob?

And then you didn't even link to the recent discussion :(

https://lore.kernel.org/linux-iommu/20250403232619.GA681099@ziepe.ca/

It is easily solved in the smmuv3 driver without out any DT. Please
do that.

Jason
