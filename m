Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6D127E27
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348311; cv=none; b=F/bGRTv1lIEpHULQ4jb6TpuB5sP9wyVYflICjg4aIbF7vK+50deNu5fnhFnpj+Uq1H1CMRXaDE1Z770pL2DyK/P6OraznFmbhT1yh98FWLTXqfw68Xu9B+wXGwlox7Zi5R1Et5/aM70umrmtIqxAUbFrN/0/PtgxPAFM63QHt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348311; c=relaxed/simple;
	bh=GuvcFxhdmtaNUDGSQDu70t55Wy23Cyg3MTeGcgF4JWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GosZXbnQKNGpldIqnMTJbBL+aE/jbQguivRiWL0dkfgBMB/1Xn+B27xGyWjmmr0wz8RAEXFczChVoNDY10zozY5VKVfQnCs2z0Kd9aqx82wJ2uQqFUYExkepZJPpP45iUWuLnH+g10ZKvy/wdgS0mdiP3tqchw+u0uU9UqGbGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tx5Hd2Lg; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tx5Hd2Lg"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7C73845D7
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGiR0kEqomEG for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 13:38:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E73E4845D5
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E73E4845D5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Tx5Hd2Lg
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E73E4845D5
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:38:27 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-792b8d989e8so147757185a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348306; x=1715953106; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=Tx5Hd2Lg0KnZ48IhovVH9TDP77RTM731CYmGij/D64/xnz57ocIpODqN9YclRGHSfC
         6jh0btHsWDAtf5HZuvJusNE53dMg8S1nMUJsjtfzgVtm7/p9rMgZMSDVESe4cPk6xxkl
         OUAIfIPnVvzCpY3snziLRh8uJG0LnIz54vXYDoLrs7PD+m7Q00sxtlvVckOrnacgcNZn
         ex4hq/235/17lRzhMHBpNHIH2d7ydrynIZZV6zALHqc618watrLEU/Gz4Qilm7HhA7Ay
         +8DgnQxFbiVjY39m2DPudKdgq4vtG90sg3qbuQyDBWw2zsSRx2WEXDBIeqdp6oF9jvoA
         zjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348306; x=1715953106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=K7jzumM/5m/342EHfek4ApN16snbWXK1kUy2MvO0EgbljFOOtQiaEMyvugJ+z7ySY7
         waa5HovQPLPlPpM09V4TqQvgj5gzHRr+cViMk5xCAMKBFqwvNIhgnVxKHZrz2qAjo8Bl
         6dPD3Nfx93DoN74b8l9GCHno4KvRsz59pPku+ocqeVHrHmz7eIIDWj/UzS2cR+9AYl8A
         sF9piZvpb+FIyWPCiMOHJdJWjlD3Mk4wTxbzyhfNVuYg7XKZ/FZYSY+pZSCBEDDIVtU6
         j1RzsIJ/B0NWbC4vj0A5/0Fqi9KizkeYD1a3oRvtFu8RUv9kqi5GRgvMWyo9ZeC7Gsqm
         EUkw==
X-Forwarded-Encrypted: i=1; AJvYcCVqRskN1SA5Z/FIJx9sv4Pny4N3a/+uESGMO/mevPLAmHHan+A+Eb2Nsq8Fvd1l8DEcN9A9F+VoQ8CeLBNVatTrqqYa/4qJdl4t9vaEGXUy4lQQzvrCADZblA==
X-Gm-Message-State: AOJu0Yw8xnFgnsmVatzFwf+9nyjDMrjgu7cq9Cb6fVXTu2mQXLAM2Iq/
	eAnfypxcBo++oOT7Eg95x85csdF5j8CGq4INVDNBJB4oBc93ESNYCHuvMeqKWh4=
X-Google-Smtp-Source: AGHT+IH5GaGqzPheLxeZXdVies/UvcsF26XJUeHy3VXdO06NNUavLRZ+kOijshY6CSz7b+YpPsI2ug==
X-Received: by 2002:a05:620a:201c:b0:790:c67c:f53b with SMTP id af79cd13be357-792c6c59cacmr450700085a.18.1715348306561;
        Fri, 10 May 2024 06:38:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310848sm180141585a.110.2024.05.10.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QS8-006Co1-94;
	Fri, 10 May 2024 10:38:24 -0300
Date: Fri, 10 May 2024 10:38:24 -0300
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510133824.GW4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>

On Fri, May 10, 2024 at 11:14:20AM +0800, Baolu Lu wrote:
> On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> > > @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> > >   	if (group == &abort_group)
> > >   		goto err_abort;
> > > -	group->domain = get_domain_for_iopf(dev, fault);
> > > -	if (!group->domain)
> > > +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> > > +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> > > +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
> > That seems a bit weird looking?
> 
> Agreed.
> 
> > get_attach_handle_for_iopf(dev,
> >     (fault->prm.flags &
> >     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
> >     group);
> 
> The logic here is that it tries the PASID domain and if it doesn't
> exist, then tries the RID domain as well. I explained this in the commit
> message:
> 
> "
> ... if the pasid table of a device is wholly managed by user space,
> there is no domain attached to the PASID of the device ...
> "

Okay, it needs a comment in the code, and the RID fallback should be
based aroudn checking for a NESTING domain type which includes the
PASID table. (ie ARM and AMD not Intel)

We shouldn't just elevate a random PASID to the RID if it isn't
approprite..

Jason
