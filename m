Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7E61670
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WkkQG06E"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 982B76150A
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 14:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 982B76150A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WkkQG06E
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuiaCtdS0bW1
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 14:12:12 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC0EA60BD0
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 14:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC0EA60BD0
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f59fcb204so207927885a.3
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702390330; x=1702995130; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=WkkQG06Ei9a+FjJgGZHKVVt/hBYNnA8t6mnfpxzFpLatslKKH0Hm+4gHxo56BTk9AF
         aDa+4hGD/lqvgpDQaIcZ4oAhc2kabwEj3X14yImiMcAIwrkES2ePxgUZksd8QJCoHzgg
         Tcu3Na/EezQhhgh66GTk3G2XEqIIrzqhxjv/tHEcz6Xk4YVzJ2j4VW6MLvFqKw0kbZ+4
         fpgsFKVCvgoZYsYCggQaNg4jmbMowuJJyueZ4nIDatVh/kvf0QnCkNAsk1SaHwUGOJyd
         hNqqPVL3xsEJjxq9J93taM3vVdiRKHSMi28ikLeR6I0j6VD/67bnrTIbfP2gsGfvqZOS
         XHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390330; x=1702995130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=r29u5DJmv6vdEsxs2p2MCqpmqxvqbRiWiguaMqCalSXI9LKjjapvJrSWFfUJfT6W9w
         fT6plWQo/u2XsoF2zwRP96n1R6Wel7OLownHjCJzZgItY19J2Yu8PdlIrWaYBp1ciWbq
         n9lPln2fkE69KcOE7aEtlC5bKQAE8BnnGk2wFpBjHCFz2MoaeMJ27PQ9khafrCZyJNMY
         6cPJ5LC4dR/7YBSu+qr972NE+r4a0RXRtGWtB275uI+sQiDiFjvlyT5j06pAAf2BdpRE
         vYY9hTfHgKvwhv3DpOaUDgDcpKjoZr40WbtkbmEGX9E/H/DfNUifkhGPZoKLxP8+I/Rr
         ei+g==
X-Gm-Message-State: AOJu0YwDsoD3Q10cjP67FlZROxecWsvYc9BWNfl/Mt+nXJWuTwcdLlzc
	0muSR6+14D6gz/seVQ8pRiFNnQ==
X-Google-Smtp-Source: AGHT+IGRkRQVaTR68B5qveU70mgfrGlXmlTMF+z308FUs0i5H1yAdurOHwLdhvMF64yVQEAU8ICGfg==
X-Received: by 2002:ac8:7dc6:0:b0:425:4043:29ff with SMTP id c6-20020ac87dc6000000b00425404329ffmr7750741qte.122.1702390330535;
        Tue, 12 Dec 2023 06:12:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id t22-20020ac85316000000b0041cb787ff41sm4082934qtn.67.2023.12.12.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:12:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD3UW-00CjJP-VZ;
	Tue, 12 Dec 2023 10:12:08 -0400
Date: Tue, 12 Dec 2023 10:12:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231212141208.GA3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212131008.k6s5xwjgolp6geps@localhost>

On Tue, Dec 12, 2023 at 02:10:08PM +0100, Joel Granados wrote:

> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 645ab5d290fe..0a8e03d5e7c5 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  	if (rc)
> >  		goto err_unlock;
> >  
> > +	if (hwpt->fault) {
> > +		void *curr;
> > +
> > +		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
> I'm hitting an error here when I try to attach to a hwpt that I created
> previously with the `IOMMU_HWPT_ALLOC_IOPF_CAPABLE` flag.
> 
> I get an -ENODEV from iopf_pasid_cookie_set which is triggered by
> dev->iommu->fault_param being 0x0.
> 
> I looked around and I see that the fault param gets set in
> iopf_queue_add_device which is called from iommu_dev_enable_feature
> only. Furthermore iommu_dev_enable_feature is only called in idxd and
> uacce drivers.
> 
> Questions:
> 1. Should iopf_queue_add_device get called from the
>    IOMMU_HWPT_ALLOC_IOPF_CAPABLE ioctl call? This make sense to me as
>    this is where the device and the IOPF are related from user space.

It probably needs to call the set feature thing in the short term.

In the medium term I would like the drivers to manage the iopf based
on domain attachment not explicit feature asks

> 2. This is not intended to work only with idxd and uacce. right?

It should work everywhere, I suspect Intel Team didn't hit this
because they are testing IDXD SIOV? Can you guys also test it as a PF
assignment?

Jason
