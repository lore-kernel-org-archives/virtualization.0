Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480117BA2
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505168; cv=none; b=XIrLm7MLrNB0xY3Wgv+CUE2RNKVaNGWTeW9TcIB7R92HP7H31spqiyicpGRhrxUcnHKSGt3I276m8WqsO18+0OHUkiMI3PlQ6Lw37hBW5IdWcmU9K8FZG4iep59NEXK5h6LYbXxztpMg80U2hwfL3WnaxzuVbEOSRvoRrx1gvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505168; c=relaxed/simple;
	bh=ruX+n2T+6DZMna4jhh1LLuxJ/3MDS9cVn5e1zJuBUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAVI+q8bGL6QrFwrbgA6J6F0GLbYF36qMpGSEu7CjmPqP6q//sxTqWeIkdchMbrGMevkoyM99gZiG0tzSTvEI+WROLvi59yqICJxz13t1xBcdOw6T+lDBeRTD/HglGJwn8YNKsk0Qu2S6sqMprkI/pJHn79F6rgZjLoOdPIxESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l1bpZzTL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l1bpZzTL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be49f6b331so581453885a.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737505166; x=1738109966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXghlfhRrFCx/sGoC3oMAY0O6HNgyaJ/L03L6lreXxo=;
        b=l1bpZzTLrGTLKy1hUdbq+pfu2XsacEDuCbKmM0xyOdmpMBQe767EALQqGWyLsp7msd
         g9IRkjUROgTFJFc5UlXfjRRn7+nLgF9//GyzlukIBX0slT2xsyweHk50NpN4mIzgREnm
         v7zq97ba+OqaoNmwqADhq/62/Eb5Rcn9wY7D2Vn0nOskGcElOWNDCwxp5kmBBgkMJqxr
         6kx6/aJfkDi4rzNs1v8E2EDYQNQvbnL0Mt4BtRdA8K454CG4D6JGBi3VfGbvuvio8OjW
         sOZVLJKVbo0/B/DvhJgOfFCSVuvurRvNWdnAFDIAGfwFwCYC4Q1+esaq6edZIUnLqtLF
         FKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737505166; x=1738109966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXghlfhRrFCx/sGoC3oMAY0O6HNgyaJ/L03L6lreXxo=;
        b=GUmDrual916s5bO0XK+b4oy58+qvMmF5dojYCizUGzKb47lu2Wl9MTsbbv+seJXoly
         ygpVs5eUvMOvI6c7/dKWMxQAayWdyRgTY7Bf7w4xHYqub+h9z34Ble1yMwTwxCCVQUj8
         w+xKPk3O2qR1J8yo1MXxsZgzMNAmmZRHhJlkJDliVEM3VKwtGyfYNcB5NqUw/NDmsPc+
         Fh2Poeem2q61M/LdXQiRK4CIjbuLT7e7w+8msohw+ay3AN0NUsp8bbCEQyZNsLh11i33
         SLhvCdF0k9LwNmKAy2gvretjYqLnSL5wSNSl29cSpp18aB4zZnOtePqbosI88JABbJmh
         MTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkzR/I3t4bqGxz+1Zc36a7fLW3Dsa06xTRBqpqDr7cJoXgdiZ5NBD6jLoXsH3VLy+/CtbLBdDaz3j3nv5EzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyon7UZtRmNeZ9cVYfZzq5xss9quWJM8Kv0XTwgYdsPFMlD001t
	ULRXk0wE6PN0PjQ9QPyPuRpTHjKZ9mxO2wQUvk3lRIu9FkuJWFKPUdK3Da7R6SU=
X-Gm-Gg: ASbGncvsTrlDLuPzxzbYsUZBl+oyQ2oUFwFDDvKDxNlcwv+cUbTPjZzLVMYXISFdcx9
	o3waRopZ0R9gIBlO3eyPG/P49O+VylGtBdoxfoZIqwwI7vqlLCm/WT1PKlHz/PElep4LJH1OchT
	8QvIq8oKwpnC6JPdxuMq6pHjlU11diA4r3YfZSzYHNxR2MkHDPd2GT8spXkyvmULAbbUV+gSBy4
	Rq1B19Z3YGw2lUV2vBNKzvv5kjbhD+hNieKApwJczZN
X-Google-Smtp-Source: AGHT+IHoWfQLXBi4VVc2RH/uW0uLrxtbCGBc+6ctACTGWHOSsmF0DObwhxass5GjF3fYnabLc9/BJg==
X-Received: by 2002:a05:620a:440b:b0:7b6:cf60:3973 with SMTP id af79cd13be357-7be6321c80fmr3167063785a.23.1737505165882;
        Tue, 21 Jan 2025 16:19:25 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61473bc5sm605450085a.20.2025.01.21.16.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 16:19:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1taOSq-00000003lzE-0J9M;
	Tue, 21 Jan 2025 20:19:24 -0400
Date: Tue, 21 Jan 2025 20:19:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250122001924.GT674319@ziepe.ca>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
 <20250120142643.GM674319@ziepe.ca>
 <67901659.170a0220.20b206.f1f5SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67901659.170a0220.20b206.f1f5SMTPIN_ADDED_BROKEN@mx.google.com>

On Tue, Jan 21, 2025 at 01:49:10PM -0800, Jacob Pan wrote:

> > On Thu, Jan 16, 2025 at 03:23:04PM -0800, Shyam Saini wrote:
> > > Hi,
> > > 
> > > Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> > > assuming that all platforms have this address available for MSI IOVA
> > > reservation. However, this is not always the case, as some platforms
> > > reserve this address for other purposes.  
> > 
> > Can you explain this some more? This address is in the kernel
> > controlled IOVA space, there are few ways a platform can impact this.
> > 
> > How is the platform impacting it? Is the non-functional IOVA always
> > reflected in the iommu_get_resv_regions()?
> 
> I don't know the platform impact but just to clarify, are you asking
> whether this non-functional IOVA is also under IORT RMR or other FW
> tables? I don't think it is.

No, I'm asking how can you possibly have a HW platform where
MSI_IOVA_BASE is unable to be used for DMA?

MSI_IOVA_BASE is 128M, and most ARM platforms put DRAM starting at
0. Most ARM VMMs put DRAM starting at 0 too.

So a platform saying that DMA to 128M doesn't work is pretty broken,
to the point it is hard to believe there is a HW issue at work here?

> But this special IOVA is reflected in iommu_get_resv_regions() the same
> way as the hardcoded MSI_IOVA_BASE. So each iommu group's
> reserved_regions should show.

That's great

> > Why not avoid this conflict in your platform software?
> I had the same question but it seems there is not enough difference
> (than the standard smmu) to justify a platform code. i.e. platform
> specific iommu_get_resv_regions(), is that what you are suggesting?

And here I mean, why not stop marking it reserved in the ACPI/DT
inside your firwmare or hypervisor?

This smells like some SW component using the same address Linux uses
for some odd purpose. Just change it and let Linux keep using the
address it wants?

Jason
