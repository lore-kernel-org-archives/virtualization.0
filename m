Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6B5D752
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127178; cv=none; b=I3Z61Qab6hfY+owcMbvyXKUGhh4NYDYuZT0JzqvwlHpdiFeKU6EOYxbie+AVOS9Ybj4WRpflKZktiiFoGqzTd/gaH9XAEQWJl+nROq1+S6izkTvPSZo9cZ3stNGLVMOA+dAS1hTChsE5ZxusqmWdxvNQlbqHR95TtAZMB83x2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127178; c=relaxed/simple;
	bh=jT967HD0NkVb4sBMYdepySf5iZRznTV4xbYQBqhu4p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5VnodEGExqfU1bASYj46V7mPtxefBGgwXknLoUiGCdHH7DC47GzH3ivjkv3Lu1108q/VTrvSpLZwhjSgZ5z8icfq08Q1pmGYQ7ZtyrV0FeTFwvQlj8j2LeTDRR41YIhYp7ljxrVJM+d2hFGW9JQUwqLQ17zmWRyz9pwO3+QKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RB09PxFL; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RB09PxFL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98905606AF
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yTAb8NT-9Pq
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 17:06:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E6B360684
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E6B360684
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RB09PxFL
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E6B360684
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:06:15 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-789e6f7f748so139850185a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127174; x=1711731974; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=RB09PxFLJiMI8myhGP5k4oTMuftViGhhOlzZF4d1rx4fT3uiri+e5k7GxrFK6ig6kA
         15YVcQKJ0bWGaARsQoFZbjz11/k0U9+hLQWV/nke3G3gcGbEodO/Ma/74CFGMJI0/FRN
         UjbpIUIL2zmB8/QnxCuQsszRhyeICetYs/86LsAD70W9qstTsFFRvA0lZ7RDeZabcolX
         AXrRCD0u4cRnkTTB777upeLkxM6VBvbUzuuORlYEdDB+G0zwJJKSNHYKyhQBPDSX3j3e
         0sR7mzve+Se5GBABdMEvic81SyMuwFyd/sQNRv///P5bFZQwz3AfLvlmVYkaBrdsU3AC
         QMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127174; x=1711731974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=K69ec7JLnYSLM3w8Rac2vZG0vtAwu1NTue6AHnlU6KVerAMiK2FaU3tWRQ6ZqUHOq5
         Knf/sHB9O/OIbXthv1ibknna9YgwW+8GYDAqJv7TtAaxdOoK2FuwLhL0Hb7SN2qN9qqT
         pIWSPIHAK+extDvZSHmUmlo+44V0Nz3foTK/TWSBLHKoYi4ZFVlhbRoZHjCFR/1l6xUZ
         UT+UHMHtYzrW3KuX9BL6Q3Q3ZQVfx03OVNnvc3WSos8B6FPmzBEJH0K6x/+CBq026Am4
         2Pz7l55iDp10VSrms4ESnZO40SgA1uLbpn8shixf9u0khU5GrQHm8n5i+pYGscGZ8dPM
         RhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCS3hFLfyRaIPpeXQCWO2zXY1A8c9Ds2rdyHiiWs7U/j/088RR+L4LCYJa93dusa8L12Qu3JZ5bOams/DkIhHgbJtd89ZDmsFu7MgLB7In7Cnl4lYIK3bQ5w==
X-Gm-Message-State: AOJu0Yz4ZCy1El3v1H0ZAFtOtaiikeUF4m4FSqB64oQrHHR7WdSyg26O
	KdR/a9VaCf+19X7jjjf0NEJ1pvIILrVr1yfOrP6iJ+g18rH8wVbAcbGY4JUYgQI=
X-Google-Smtp-Source: AGHT+IEHFGKv/VWM3Yg4smu9N1G/2nFTpEK73dYxyEMKGfCzZHq73AEibapXcw3+Qlp7ej5p7M2doQ==
X-Received: by 2002:a05:620a:27c7:b0:789:f0ac:1b4b with SMTP id i7-20020a05620a27c700b00789f0ac1b4bmr34471qkp.58.1711127174318;
        Fri, 22 Mar 2024 10:06:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g12-20020a37e20c000000b007882fe32acasm926378qki.3.2024.03.22.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:06:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniLN-00CSJq-BV;
	Fri, 22 Mar 2024 14:06:13 -0300
Date: Fri, 22 Mar 2024 14:06:13 -0300
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240322170613.GI66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <20240308190539.GY9225@ziepe.ca>
 <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>

On Fri, Mar 15, 2024 at 09:16:43AM +0800, Baolu Lu wrote:
> On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
> > 
> > > @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
> > >    * @__reserved: Must be 0
> > >    * @data_type: One of enum iommu_hwpt_data_type
> > >    * @data_len: Length of the type specific data
> > > + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> > > + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> > >    * @data_uptr: User pointer to the type specific data
> > >    *
> > >    * Explicitly allocate a hardware page table object. This is the same object
> > > @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
> > >   	__u32 __reserved;
> > >   	__u32 data_type;
> > >   	__u32 data_len;
> > > +	__u32 fault_id;
> > >   	__aligned_u64 data_uptr;
> > >   };
> > 
> > ?? We can't add fault_id in the middle of the struct??
> 
> Yes. I should add the new field at the end.
> 
> By the way, with a __u32 added, this data structure is not 64-byte-
> aligned anymore. Do we need to add another unused u32 entry, or just let
> the compiler handle it?

Yes, add a reserved u32 to ensure the structs is always without
implicit padding.

> > 
> > > +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > > +		struct iommufd_fault *fault;
> > > +
> > > +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > > +		if (IS_ERR(fault)) {
> > > +			rc = PTR_ERR(fault);
> > > +			goto out_hwpt;
> > > +		}
> > > +		hwpt->fault = fault;
> > > +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > > +		hwpt->domain->fault_data = hwpt;
> > > +		hwpt->fault_capable = true;
> > 
> > I wonder if there should be an iommu API to make a domain fault
> > capable?
> 
> The iommu core identifies a fault-capable domain by checking its
> domain->iopf_handler. Anyway, what's the difference between a fault or
> non-fault capable domain from iommu core's point of view?

From the core? Nothing. I'm just wondering from an API perspective if
we should have a little inline to indicate it.

Jason
