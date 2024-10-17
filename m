Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054761DC1B0
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166730; cv=none; b=cmcQ9EqGPjzehQ8CF37/cc++cCDI3kgT0y8N9gJACr/pB3mSj7GwQzJbSzxPs+cU20ptCyChidV04mMzD3z20jYvc++Zfmdsxl4OQAomHalF1sA6iwfXJyAHPfyuQ4yBqC6X63Up+zotFqxU6H+EK3+yf8R5jznR2twJXlYD55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166730; c=relaxed/simple;
	bh=9Ou2IPV+fUYVUZFwDwpHsxjEEQ10P3Z4LAfWFwq7vtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBWTTVPnMfObJqHNfR924HlUV2VziIR23xxhWjjBPo1ddz8eYQE7CPvm/R4hkEdl2rN/7xNMgwu6/hg6BXgwJjmqfdi/x5PqB15ih8mZEURBpJgV2rfSgRohPxdCiHy4AqctVOIXDylkoPGKwoIZGf769NWT8hKeb9KZg0djA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PkOnDrUx; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PkOnDrUx"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB94402CC
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMq2QVFGciTx for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 12:05:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C429340114
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C429340114
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PkOnDrUx
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C429340114
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:05:20 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7b1343e8042so91248685a.0
        for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729166719; x=1729771519; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=PkOnDrUxLZjZjR8sPBswQuja2655hRTSa182uwGFkMMZ8dDllKhrjxpTgsxljeAAlU
         kYZk2mw/Itiq85eNq8XBwKza98SsISMcY2pT132Tw0B0pPzxTLKS5Hov2MSvZCIGyv7a
         DX55H2WYoW0wappKr0zBufxZtDOkekNYNB7agcaUjaGIjPE6Dm9mKCWHUtQI+XK25CyQ
         A+lfLFN9ECPuO8lE6djmZuNGSvL75Wh6DL/haQwR2RSN3mVQc+pju88DdB6vmlECMgJv
         E4NgyZ62aSjWnfVKXky6mujTiKE5puVs4sIwj7fRICQtdrtXm11Pqlb6cAIlayzqFcQS
         lzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166719; x=1729771519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=bFdlV/uaflB9+Hort5EcrYz0+Z/MV919KxM5c39rSgK17WyC4JkLQF0wkvWDUq9Uw2
         FvyWyZm/FVv7t+MGFUDJcHWJDS+DPKYKF+OTs43oMoqfqJkZuct9Kd8unWk/YeWSKFPn
         8AX2KW3bQHVd/Lx8Vuc2p9o2WurCI0JRxTTQmxCYKu3D7+U9O6BJR/l3/aRsiDjwbLx8
         1OYKh88WLx/fXnl+RzqNmxBvAknm4F1TIYrQq39oZxgHaPepy5BpXCn4k7ov9PwsaTc1
         OL7Fph9cJJT6PbEJjgABK1Mwwjz1Uqsp1jnVR1K3F1q88QZ3BKg2kpx9oGHJzyWJE1WK
         mqVg==
X-Forwarded-Encrypted: i=1; AJvYcCUv33vEuw7HyogkMDgZoKbccThI6VxFg0mmG+E0qEJTd6bL0i/qe2vRaGIvlvZjTKjMki5JqM26YpDxgNRhKg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyG/ObK4pc3wf+ILeBADbpwCO3koWmt5pMtwdzg8JNXK3wOdvf4
	RaWd/mZevSqY6ynEuYKeaCSGCNDTRJn6hFOCp6sgLekmYRRS+ugwiL1q68c3xe0=
X-Google-Smtp-Source: AGHT+IEPtt04l70kN6bicB55lZv2cm4Yf4rIE4G65war3hf5YJH+Qt48rYAG8z4yCn6t9Q2qUjjXgg==
X-Received: by 2002:a05:620a:44c5:b0:7a9:ab71:f820 with SMTP id af79cd13be357-7b1417a24ddmr959080985a.4.1729166719151;
        Thu, 17 Oct 2024 05:05:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1424ba332sm223436285a.81.2024.10.17.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:05:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1PFm-003iH2-4Y;
	Thu, 17 Oct 2024 09:05:18 -0300
Date: Thu, 17 Oct 2024 09:05:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241017120518.GI4020792@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > +{
> > > > > > +       struct device *dev = idev->dev;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > +        */
> > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > And now I am hacking to comment this check.
> > > > > Any suggestions?
> > > >
> > > > Are you using PCI SRIOV and stall together?
> > >
> > > Only use smmuv3 stall feature.
> >
> > Then isn't to_pci_dev(dev)->is_virtfn == false?
> >
> > That should only be true with SRIOV
> 
> Do you mean
> if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
>     return -EINVAL;
>
> This is fine

No, I mean on your test system you are not using SRIOV so all your PCI
devices will have is_virtfn == false and the above if shouldn't be a
problem. is_virtfn indicates the PCI device is a SRIOV VF.

Your explanation for your problem doesn't really make sense, or there
is something wrong someplace else to get a bogus is_virtfn..

If you are doing SRIOV with stall, then that is understandable.

Jason
