Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA851DB352
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261991; cv=none; b=cnTkRJ/04pO5i+/OpSwFKck8R8QPxEEQJEFs7uXH4SBBfuoOklUIEAp34bYD5YBIeJWo4iCUNLBFaIoojgNzAvQL4r0HURXyx9iXOg5w/nZsshe6OHA7M1v5eSwApI35utfW7wIc92uA4gd+3JhitifW9GCMTiXK+JE7+/rO2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261991; c=relaxed/simple;
	bh=ZsBt8lSxzA+AlE5/dHTYCGZPEvYSA2sH3m2oRztGLPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2x+IIg8LuiwPV64YkPMDKC8ziLzf4SWF3pYWtSax6OAufNfLBKJTlV6cXRSsWTpyBc2qQixfyG+LpLLD/FPjQJ21oiMWN1puowXl8WH3ORIDxzWS0utuqS2W21wIVaP9sBk0EEJxEnTsFM1ietlBAsJ8es7sX0Rz2o4cY9tIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nFlkyEs9; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nFlkyEs9"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 277D560B24
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 14:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hp8gWjGUv2Uz for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Oct 2024 14:33:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B85B60B29
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B85B60B29
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nFlkyEs9
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B85B60B29
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 14:33:08 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so14568106d6.2
        for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261987; x=1729866787; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=nFlkyEs9FcgcCZnBCcsrBQeKJReX7XiICW1RCn07dp5CpTMgV5W70znNzxo2W/9SlL
         706aF2mKdle9s27yrZgumxzJIc5fPSNRZrJToLbE6U71tRPSsLV21d42LBtDcO7FWF+M
         ZKRne0VbU64Q7Rt+H/oxJbWgFykmieM6VQY7rlnlM1BXWrZEhEEFajlifM47XgR8sBDI
         CBXWDZJRX6gjBWMbzHuJA7kfz1JnCuB1MjLlP92jiLt27tr2gJy3qIv8BqHfiYZzC+UC
         bofKQba8a7q6pIBApIGyw2F+hk5H0L61LPB7FejjkI2WP/2WHets2YBdsjx1XhoNoQm7
         +qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261987; x=1729866787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=bqhQmjsq0QLA9wRepl50Vz3bLVRyybRASZ6I7A7UxTHO13oNdlk3dLNVb6DHgBNi59
         eEghXFbmso/TC5j4hvosCSBlO9gWrYGL22BDBDBAQs+RtuEQLyyYxEe2oyR/mvHd92cb
         2lsu2FWkzIwDm9DtluErnLEmy3ZXzcg6X6JfR109q+DvX3GmXFhgTlUMuuZbFXZ1pDsE
         5QzMp0cKbFDiVPeoUT1gaXgGZ3OI2/efEfw4qe6mVp5uZkA91UnQtJpHc4SoOrv2fDXQ
         puz7pJ1Mg8/dw9/Ikl9e+hYaKZzhmrGxJW7sL3oISTYgFqw+/Ra+baVuZSRivf3Xd6ak
         9G2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmA3ngoZAAYb66TW3hKOiXrp9gy8RM/+RYY/kxf0vLlpMLqp4zSpKV91YMZfbISznEjUr5SCniyhAg+gDGxg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxao8az5R4ZPqi2hLh6POA2NUUNJNjxBDgdDsVWZxIVB7DAfkZ4
	M/sleSQwEyVXFVjazD7M055ATp+xAsSIdynIVR6maO2WgOR6yBxpMZznXaS2RD0=
X-Google-Smtp-Source: AGHT+IEUnvffc5zoOVV9FmS8JNociVSvHRxNtwPJIviTG5dQGue9og+yy0xqzK1+WW1GOz5SrBvicA==
X-Received: by 2002:a05:6214:4605:b0:6cb:e8d2:fef1 with SMTP id 6a1803df08f44-6cde15e2b1dmr56786036d6.39.1729261987343;
        Fri, 18 Oct 2024 07:33:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1179224sm7408316d6.64.2024.10.18.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:33:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1o2M-008F2Q-A5;
	Fri, 18 Oct 2024 11:33:06 -0300
Date: Fri, 18 Oct 2024 11:33:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241018143306.GN948948@ziepe.ca>
References: <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
 <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>

On Fri, Oct 18, 2024 at 09:58:37AM +0800, Baolu Lu wrote:
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > 
> > > Yes, you are right
> > >   I am using SRIOV vf and stall feature, so is_virtfn == true
> > > 
> > > Our ACC devices are fake pci endpoint devices which supports stall,
> > > And they also supports sriov
> > > 
> > > So I have to ignore the limitation.
> > I see, so that is more complicated.
> > 
> > Lu, what do you think about also checking if the PCI function has PRI
> > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> > 
> > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > fault?
> 
> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> a shared resource and current iommu subsystem is not ready to support
> enabling/disabling PRI on a VF without any impact on others.
> 
> In my understanding, it's fine to remove this limitation from the use
> case of non-PRI on SRIOV VFs. Perhaps something like below?
> 
> 	if (dev_is_pci(dev)) {
> 		struct pci_dev *pdev = to_pci_dev(dev);
> 		if (pdev->is_virtfn && pci_pri_supported(pdev))
> 			return -EINVAL;
> 	}

Makes sense to me

Thanks,
Jason
