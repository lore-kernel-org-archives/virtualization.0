Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123886643
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560690; cv=none; b=Fv2+TbHkqTYyQV+tOulwHD6bYEpgV/OMPNWgsegpRQZ8IO53waW8lZA5AyCQVXIYKybzUDvTKxbBCyZzNtMKPMADGwDOb+9FuwM8LEMmv4lAuULXhSSnGgh+ySUzsTeri+WjgmJZg9hhWqSOdcOR9eYHRHtzMRdXPXjWnZkrvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560690; c=relaxed/simple;
	bh=GAKoyrn5jaPJBZhMvzIPnR163kOxc9TRWI2BEHr/EOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipInR6XsegijSR+rjku3cSFfFJfP/SV4CqAm+1ockQ57JEhxWef4SPMzd8Eg2CWgEb+3LCN/0fr7OW4YbZz4amdzoQgYDvGSepR+q5Gz4zbGnbdmkgZYqChSai4zkWwH5p70ORJWBkVprZ+7Y180hEfcPqHxsgQiror77EPjTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TIXUcMqz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TIXUcMqz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EFB260616
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NIJjlQxdupg4 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 May 2024 14:24:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 760B660614
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 760B660614
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TIXUcMqz
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 760B660614
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:24:48 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-43df751b5b8so23450931cf.0
        for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560687; x=1717165487; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=TIXUcMqzEPHJ6InQp7kbch3YmDTAIhQ33EpW+T3he+BEWpcHbST/ZUoIHWZEZYbI39
         Q87P4eCjwFVe3+j0GKD0HN4n8VncNK1V+iJodF2cstA1xg3mRfczoUX1r3z4cG9ZwYWZ
         miVY7No4O4+tFfyh2ZpMu5YMxkU3b3RCawlJgOsurPwTINwbZpVHRcvOUQIdSuYhIxAK
         Pq4nX7NCJLotW5jmadTC6Y4yWZezrFmfeKvkECcLrrzYKJBEa9vRpWesHE6rfzDY2Ybw
         0zednJleq4vftk3GNR3Ag+UxAehN/i5IzJ4xtM0noGq7fR3cfPHiAPs388REeUpv9tJ/
         4dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560687; x=1717165487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=Yo+YsFlVsHwFuwUsZVRT3bNCd7Q5oWA8qEHHG3otE6dvpjun1qLVjuxBg6uLY4MOTd
         ckSIrbVJ/VWXEc3sZriTH6Iy0hT6FP4u3wkoDJKqNOVqx3BekYKGTjVayD3O0ORH3exU
         XjhtZNq5lOWfERJsnPDF6/sxVE48L2G0PK9+mojxH5l/X3Pqi9OvbhsMk2NnWZLLN9kV
         eE7EYYa5PcM2qPqJhFl1Bi+CVDpKjDs/wIElPjRoHvNGrCQfTlwHmGpfsuA6lCFRb/vB
         BUl1jLRIO8/0j35HrIoS2un29BvN7xUw5Qrw8vRMEEuZsNtZSppbPYH/x+afjUBwDRYW
         l1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXb4eiGpd4ahntoGYkTAbvnmts/ZyUNrzzpWcXb+P7NNQGyAkNcXeu8rN1hiCqjkssrqiCkIVoOy//WdG95VcLOudM7GiqvqWmcREFXFtm9SMhazgbnd1RqRg==
X-Gm-Message-State: AOJu0YwYN0CDJD5VdLKr4YWWGx/wkUuSCn06nTQuy73ckrv1u8Bp8fDY
	cs+eK8TXj+OAlBLkVvuolM/YiVEDTMDydcHZhdz7GtVEbNynU+CZAdaodd16RnM=
X-Google-Smtp-Source: AGHT+IHQjREFVeKjhgG/zBc9srfJFpq4/cK6ER06u+9Acna36n0WAlHDtLFo5xXKXDhG9YwoKONBbQ==
X-Received: by 2002:ac8:7d81:0:b0:439:d07d:e25f with SMTP id d75a77b69052e-43fafb16fa4mr46187801cf.16.1716560687135;
        Fri, 24 May 2024 07:24:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb183507asm8326431cf.56.2024.05.24.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:24:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVqg-001KtA-6F;
	Fri, 24 May 2024 11:24:46 -0300
Date: Fri, 24 May 2024 11:24:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240524142446.GP69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 03:39:54AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 10:19 AM
> > 
> > On 5/15/24 4:50 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>
> > >> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
> > >> *ucmd)
> > >>   		goto out_put_pt;
> > >>   	}
> > >>
> > >> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > >> +		struct iommufd_fault *fault;
> > >> +
> > >> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > >> +		if (IS_ERR(fault)) {
> > >> +			rc = PTR_ERR(fault);
> > >> +			goto out_hwpt;
> > >> +		}
> > >> +		hwpt->fault = fault;
> > >> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > >> +		hwpt->domain->fault_data = hwpt;
> > >> +	}
> > >
> > > this is nesting specific. why not moving it to the nested_alloc()?
> > 
> > Nesting is currently a use case for userspace I/O page faults, but this
> > design should be general enough to support other scenarios as well.
> 
> Do we allow user page table w/o nesting?
> 
> What would be a scenario in which the user doesn't manage the
> page table but still want to handle the I/O page fault? The fault
> should always be delivered to the owner managing the page table...

userspace always manages the page table, either it updates the IOPTE
directly in a nest or it calls iommufd map operations.

Ideally the driver will allow PRI on normal cases, although it will
probably never be used.

Jason
